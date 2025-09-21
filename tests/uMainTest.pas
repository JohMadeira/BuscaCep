unit uMainTest;

interface

uses
  TestFramework, uMain, Vcl.Controls, FireDAC.Comp.Client,
  uCEPController, uCEPModel, uConexaoController, uCommon, uTestesCenarios;

type
  TTestMain = class(TfMain)
  public
    function MostrarMensagem(pTexto: string): Integer;
  end;

  TMockCEPController = class(TCEPController)
  private
    FLoteCep: TArray<TCep>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetLoteCep: TArray<TCep>;
    procedure SetLoteCep(const ACep: TCep);
  end;

  MainTest = class(TTestCase)
  private
    FForm: TTestMain;
    vCepController: TCEPController;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    { procedure MostrarMensagem }
    procedure MostrarMensagem;

    {procedure ValidaCampos}
    procedure TestValidaCampos_CEP_Valido;
    procedure TestValidaCampos_CEP_Invalido;
    procedure TestValidaCampos_Endereco_Valido;
    procedure TestValidaCampos_Endereco_Invalido;

    { procedure PreencherCampos }
    procedure TestPreencherCampos;

    { procedure ConsultaCEPBanco }
    procedure TestConsultaCEPBanco_Cep_Valido;
    procedure TestConsultaCEPBanco_Cep_Invalido;
    procedure TestConsultaCEPBanco_Endereco_Valido;
    procedure TestConsultaCEPBanco_Endereco_Invalido;

    { procedure ConsultaCEPWS }
    procedure TestConsultaCEPWS_Cep_Valido;
    procedure TestConsultaCEPWS_Cep_Invalido;
    procedure TestConsultaCEPWS_Endereco_Valido;
    procedure TestConsultaCEPWS_Endereco_Invalido;

    { procedure PgcBuscaChange }
    procedure TestPgcBuscaChange;
  end;

implementation

{ TTestMain }

function TTestMain.MostrarMensagem(pTexto: string): Integer;
begin
  Result := mrYes;
end;

{ TMockCEPController }

constructor TMockCEPController.Create;
begin
  inherited Create;
  SetLength(FLoteCep, 0);
end;

destructor TMockCEPController.Destroy;
begin
  inherited;
end;

function TMockCEPController.GetLoteCep: TArray<TCep>;
begin
  Result := FLoteCep;
end;

procedure TMockCEPController.SetLoteCep(const ACep: TCep);
begin
  SetLength(FLoteCep, 1);
  FLoteCep[0] := ACep;
end;

{ MainTest }

procedure MainTest.SetUp;
begin
  inherited;
  FForm := TTestMain.Create(nil);
  vCepController := TCEPController.Create;
  TConexaoController.getInstance().daoConexao.Create;
  TConexaoController.getInstance().daoConexao.getConexao().Connected := True;

end;

procedure MainTest.TearDown;
begin
  inherited;
  FForm.Free;
  vCepController.Free;
end;

procedure MainTest.MostrarMensagem;
var
  ResultValue: Integer;
begin
  ResultValue := FForm.MostrarMensagem('Teste de mensagem');
  CheckEquals(mrYes, ResultValue, 'Deveria retornar mrYes');
end;

procedure MainTest.TestValidaCampos_CEP_Valido;
begin
  FForm.pgcBusca.ActivePage := FForm.tabCEP;
  FForm.edtCepConsulta.Text := '12345678';
  FForm.pgcBusca.Tag := FForm.pgcBusca.ActivePageIndex;
  CheckTrue(FForm.ValidaCampos, 'Deveria ser válido para CEP com 8 dígitos');
end;

procedure MainTest.TestValidaCampos_CEP_Invalido;
begin
  FForm.pgcBusca.ActivePage := FForm.tabCEP;
  FForm.edtCepConsulta.Text := '123';
  FForm.pgcBusca.Tag := FForm.pgcBusca.ActivePageIndex;
  CheckFalse(FForm.ValidaCampos, 'Deveria ser inválido para CEP com menos de 8 dígitos');
end;

procedure MainTest.TestValidaCampos_Endereco_Valido;
begin
  FForm.pgcBusca.ActivePage := FForm.tabEndereco;
  FForm.edtUfConsulta.Text := 'RS';
  FForm.edtLocalidadeConsulta.Text := 'Porto Alegre';
  FForm.edtLogradouroConsulta.Text := 'Casemiro de Abreu';
  FForm.pgcBusca.Tag := FForm.pgcBusca.ActivePageIndex;
  CheckTrue(FForm.ValidaCampos, 'Deveria ser válido para endereço correto');
end;

procedure MainTest.TestValidaCampos_Endereco_Invalido;
begin
  FForm.pgcBusca.ActivePage := FForm.tabEndereco;
  FForm.edtUfConsulta.Text := 'S';
  FForm.edtLocalidadeConsulta.Text := 'RS';
  FForm.edtLogradouroConsulta.Text := 'A';
  FForm.pgcBusca.Tag := FForm.pgcBusca.ActivePageIndex;
  CheckFalse(FForm.ValidaCampos, 'Deveria ser inválido para endereço com campos curtos');
end;

procedure MainTest.TestPreencherCampos;
var
  ACep: TCep;
begin
  ACep := TCep.Create;
  try
    ACep.Cep := '12345678';
    ACep.Logradouro := 'Rua Teste';
    ACep.Complemento := 'Apto 1';
    ACep.Bairro := 'Centro';
    ACep.Localidade := 'Cidade';
    ACep.uf := 'RS';

    FForm.PreencherCampos(ACep);

    CheckEquals('12345678', FForm.edtCepRetorno.Text, 'CEP preenchido incorretamente');
    CheckEquals('Rua Teste', FForm.edtLogradouroRetorno.Text, 'Logradouro preenchido incorretamente');
    CheckEquals('Apto 1', FForm.edtComplemento.Text, 'Complemento preenchido incorretamente');
    CheckEquals('Centro', FForm.edtBairro.Text, 'Bairro preenchido incorretamente');
    CheckEquals('Cidade', FForm.edtLocalidadeRetorno.Text, 'Localidade preenchida incorretamente');
    CheckEquals('RS', FForm.edtUFRetorno.Text, 'UF preenchida incorretamente');
  finally
    ACep.Free;
  end;
end;

procedure MainTest.TestConsultaCEPBanco_Cep_Valido;
var
  ResultValue: Boolean;
begin
  ResultValue := FForm.ConsultaCEPBanco(TParams.CepValido, vCepController) = eBD;
  CheckTrue(ResultValue, 'ConsultaCEPBanco deveria retornar True');
end;

procedure MainTest.TestConsultaCEPBanco_Cep_Invalido;
var
  ResultValue: Boolean;
begin
  ResultValue := FForm.ConsultaCEPBanco(TParams.CepInvalido, vCepController) = eNotFound;
  CheckTrue(ResultValue, 'ConsultaCEPBanco deveria retornar NotFound');
end;

procedure MainTest.TestConsultaCEPBanco_Endereco_Valido;
var
  ResultValue: Boolean;
begin
  ResultValue := FForm.ConsultaCEPBanco(TParams.EnderecoValido, vCepController) = eBD;
  CheckTrue(ResultValue, 'ConsultaCEPBanco deveria retornar True');
end;

procedure MainTest.TestConsultaCEPBanco_Endereco_Invalido;
var
  ResultValue: Boolean;
begin
  ResultValue := FForm.ConsultaCEPBanco(TParams.EnderecoInvalido, vCepController) = eNotFound;
  CheckTrue(ResultValue, 'ConsultaCEPBanco deveria retornar NotFound');
end;

procedure MainTest.TestConsultaCEPWS_Cep_Valido;
var
  ResultValue: Boolean;
begin
  ResultValue := FForm.ConsultaCEPWS(TParams.CepValido, vCepController, eCEP) = eWS;
  CheckTrue(ResultValue, 'ConsultaCEPWS deveria retornar True');
end;

procedure MainTest.TestConsultaCEPWS_Cep_Invalido;
var
  ResultValue: Boolean;
begin
  ResultValue := FForm.ConsultaCEPWS(TParams.CepInvalido, vCepController, eCEP) = eNotFound;
  CheckTrue(ResultValue, 'ConsultaCEPWS deveria retornar NotFound');
end;

procedure MainTest.TestConsultaCEPWS_Endereco_Valido;
var
  ResultValue: Boolean;
begin
  ResultValue := FForm.ConsultaCEPWS(TParams.EnderecoValido, vCepController, eEndereco) = eWS;
  CheckTrue(ResultValue, 'ConsultaCEPWS deveria retornar True');
end;

procedure MainTest.TestConsultaCEPWS_Endereco_Invalido;
var
  ResultValue: Boolean;
begin
  ResultValue := FForm.ConsultaCEPWS(TParams.EnderecoInvalido, vCepController, eEndereco) = eNotFound;
  CheckTrue(ResultValue, 'ConsultaCEPWS deveria retornar NotFound');
end;

procedure MainTest.TestPgcBuscaChange;
begin
  FForm.edtCepConsulta.Text := '12345678';
  FForm.edtUfConsulta.Text := 'RS';
  FForm.edtLocalidadeConsulta.Text := 'Porto Alegre';
  FForm.edtLogradouroConsulta.Text := 'Rua Teste';

  FForm.pgcBusca.ActivePage := FForm.tabCEP;
  FForm.pgcBuscaChange(nil);

  CheckEquals(0, FForm.pgcBusca.Tag, 'pgcBusca.Tag deveria ser 0');
  CheckEquals('', FForm.edtUfConsulta.Text, 'UF deveria estar limpa');
  CheckEquals('', FForm.edtLocalidadeConsulta.Text, 'Localidade deveria estar limpa');
  CheckEquals('', FForm.edtLogradouroConsulta.Text, 'Logradouro deveria estar limpo');
  CheckEquals('', FForm.edtCepConsulta.Text, 'CEP deveria estar limpo');

  FForm.pgcBusca.ActivePage := FForm.tabEndereco;
  FForm.pgcBuscaChange(nil);

  CheckEquals(1, FForm.pgcBusca.Tag, 'pgcBusca.Tag deveria estar 1');

end;

initialization
  RegisterTest(MainTest.Suite);

end.
