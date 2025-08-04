unit uCEPController;

interface

uses uCEPModel, SysUtils, uCommon, REST.Client, REST.Types, uCepComponente.Component,
     FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async, FireDAC.Stan.Param,
     System.Generics.Collections, DB;

type
  TCEPController = class
  private
    FCep: TCEP;
    FLoteCep: TObjectList<TCEP>;
    FConexao: TFDConnection;
    TextoResposta: string;
    FCepComponente: TCepComponente;
    procedure SalvarCEP(pCep: TCep);
  public
    function GetCep: TCEP;
    procedure SetCep(const Value: TCEP);
    function GetLoteCep: TObjectList<TCEP>;
    procedure SetLoteCep(const Value: TObjectList<TCEP>);
    constructor Create;
    destructor Destroy; override;
    function ConsultarCepBanco(pParams: TArray<string>): TFDMemTable;
    function ConsultarCepWSEndereco(pParams: TArray<string>; pConsulta: string; pTipoPesquisa: TTipoPesquisa): TFDMemTable;
    function RetornaResposta: string;
    property CepComponente: TCepComponente read FCepComponente;
  end;

implementation

{ TCEPController }

uses uDAOCep, uConexaoController;

function TCEPController.ConsultarCepBanco(pParams: TArray<string>): TFDMemTable;
var
  aux: integer;
begin
  FCepComponente := TCepComponente.Create(nil);
  try
    Result := TFDMemTable.Create(nil);
    Result.FieldDefs.Add('Cep', ftString, 10);
    Result.FieldDefs.Add('Logradouro', ftString, 100);
    Result.FieldDefs.Add('Complemento', ftString, 100);
    Result.FieldDefs.Add('Bairro', ftString, 100);
    Result.FieldDefs.Add('Localidade', ftString, 100);
    Result.FieldDefs.Add('Uf', ftString, 2);
    Result.CreateDataSet;
    Result.Open;
    SetLoteCep(CepComponente.ConsultaCEPBanco(pParams));
    if GetLoteCep <> nil then
      for aux := 0 to GetLoteCep.Count -1 do
        begin
          Result.Append;
          Result.FieldByName('Cep').AsString := GetLoteCep[aux].Cep;
          Result.FieldByName('Logradouro').AsString := GetLoteCep[aux].Logradouro;
          Result.FieldByName('Complemento').AsString := GetLoteCep[aux].Complemento;
          Result.FieldByName('Bairro').AsString := GetLoteCep[aux].Bairro;
          Result.FieldByName('Localidade').AsString := GetLoteCep[aux].Localidade;
          Result.FieldByName('Uf').AsString := GetLoteCep[aux].Uf;
          Result.Post;
        end;

  finally

  end;
end;

function TCEPController.ConsultarCepWSEndereco(pParams: TArray<string>; pConsulta: string; pTipoPesquisa: TTipoPesquisa): TFDMemTable;
var
  aux: integer;
begin
  FCepComponente := TCepComponente.Create(nil);
  try
    Result := TFDMemTable.Create(nil);
    Result.FieldDefs.Add('Cep', ftString, 10);
    Result.FieldDefs.Add('Logradouro', ftString, 100);
    Result.FieldDefs.Add('Complemento', ftString, 100);
    Result.FieldDefs.Add('Bairro', ftString, 100);
    Result.FieldDefs.Add('Localidade', ftString, 100);
    Result.FieldDefs.Add('Uf', ftString, 2);
    Result.CreateDataSet;
    Result.Open;
    SetLoteCep(CepComponente.ConsultaCEPWS(pParams, pConsulta, pTipoPesquisa));
    if GetLoteCep <> nil then
      for aux := 0 to GetLoteCep.Count -1 do
        begin
          Result.Append;
          Result.FieldByName('Cep').AsString := GetLoteCep[aux].Cep;
          Result.FieldByName('Logradouro').AsString := GetLoteCep[aux].Logradouro;
          Result.FieldByName('Complemento').AsString := GetLoteCep[aux].Complemento;
          Result.FieldByName('Bairro').AsString := GetLoteCep[aux].Bairro;
          Result.FieldByName('Localidade').AsString := GetLoteCep[aux].Localidade;
          Result.FieldByName('Uf').AsString := GetLoteCep[aux].Uf;
          Result.Post;
          SalvarCEP(GetLoteCep[aux]);
        end;

  finally

  end;
end;

constructor TCEPController.Create;
begin
  FCep := TCEP.Create;
  FCepComponente := TCepComponente.Create(nil);
  inherited Create;
end;

destructor TCEPController.Destroy;
begin
  FreeAndNil(FCepComponente);
  FreeAndNil(FCep);
  inherited;
end;

function TCEPController.GetCep: TCEP;
begin
  Result := FCep;
end;

function TCEPController.GetLoteCep: TObjectList<TCEP>;
begin
  Result := FLoteCep;
end;

function TCEPController.RetornaResposta: string;
begin
  Result := TextoResposta;
end;

procedure TCEPController.SalvarCEP(pCep: TCep);
var
  daoCEP: TDAOCep;
begin
  try
    daoCEP := TDAOCep.Create();
    daoCEP.salvarCEP(pCep);
  finally
    FreeAndNil(daoCEP);
  end;
end;

procedure TCEPController.SetCep(const Value: TCEP);
begin
  FCep := Value;
end;

procedure TCEPController.SetLoteCep(const Value: TObjectList<TCEP>);
begin
  FLoteCep := Value;
end;

end.
