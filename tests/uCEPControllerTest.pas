unit uCEPControllerTest;

interface

uses
  TestFramework, uCEPController, uCEPModel, uCepComponente.Component, uCommon,
  System.Generics.Collections, FireDAC.Comp.Client, System.SysUtils;

type
  TCEPControllerTest = class(TTestCase)
  private
    FController: TCEPController;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestConsultarBanco_CEP_Valido;
    procedure TestConsultarBanco_CEP_Invalido;
    procedure TestConsultarBanco_Endereco_Valido;
    procedure TestConsultarBanco_Endereco_Invalido;

    procedure TestConsultarWS_CEP_Valido_JSON;
    procedure TestConsultarWS_CEP_Valido_XML;
    procedure TestConsultarWS_CEP_Invalido;
    procedure TestConsultarWS_Endereco_Valido_JSON;
    procedure TestConsultarWS_Endereco_Valido_XML;
    procedure TestConsultarWS_Endereco_Invalido;
  end;

implementation

{ TCEPControllerTest }

uses uTestesCenarios;

procedure TCEPControllerTest.SetUp;
begin
  FController := TCEPController.Create;
end;

procedure TCEPControllerTest.TearDown;
begin
  FController.Free;
end;

procedure TCEPControllerTest.TestConsultarBanco_CEP_Valido;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarBanco(TParams.CepValido);
  try
    CheckTrue(MemTable.RecordCount > 0, 'Deveria retornar pelo menos um registro');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarBanco_CEP_Invalido;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarBanco(TParams.CepInvalido);
  try
    CheckTrue(MemTable.RecordCount = 0, 'Não deveria retornar registros');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarBanco_Endereco_Valido;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarBanco(TParams.EnderecoValido);
  try
    CheckTrue(MemTable.RecordCount > 0, 'Deveria retornar pelo menos um registro');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarBanco_Endereco_Invalido;
var
  Params: TArray<string>;
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarBanco(TParams.EnderecoInvalido);
  try
    CheckTrue(MemTable.RecordCount = 0, 'Não deveria retornar registros');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarWS_CEP_Valido_JSON;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarWS(TParams.CepValido, 'json', eCep);
  try
    CheckTrue(MemTable.RecordCount > 0, 'Deveria retornar pelo menos um registro');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarWS_CEP_Valido_XML;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarWS(TParams.CepValido, 'xml', eCep);
  try
    CheckTrue(MemTable.RecordCount > 0, 'Deveria retornar pelo menos um registro');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarWS_CEP_Invalido;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarWS(TParams.CepInvalido, 'json', eCep);
  try
    CheckTrue(MemTable.RecordCount = 0, 'Não deveria retornar registros');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarWS_Endereco_Valido_JSON;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarWS(TParams.EnderecoValido, 'json', eEndereco);
  try
    CheckTrue(MemTable.RecordCount > 0, 'Deveria retornar pelo menos um registro');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarWS_Endereco_Valido_XML;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarWS(TParams.EnderecoValido, 'xml', eEndereco);
  try
    CheckTrue(MemTable.RecordCount > 0, 'Deveria retornar pelo menos um registro');
  finally
    MemTable.Free;
  end;
end;

procedure TCEPControllerTest.TestConsultarWS_Endereco_Invalido;
var
  MemTable: TFDMemTable;
begin
  MemTable := FController.ConsultarWS(TParams.EnderecoInvalido, 'xml', eEndereco);
  try
    CheckTrue(MemTable.RecordCount = 0, 'Não deveria retornar registros');
  finally
    MemTable.Free;
  end;
end;

initialization
  RegisterTest(TCEPControllerTest.Suite);

end.
