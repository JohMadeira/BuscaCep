unit uCepComponenteTest;

interface

uses
  TestFramework, uCepComponente.Component, uCEPModel, System.Generics.Collections, System.Classes, SysUtils, FireDAC.Comp.Client;

type
  TCepComponenteTest = class(TTestCase)
  private
    FCepComponente: TCepComponente;
  public
    property CepComponente: TCepComponente read FCepComponente;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestConsultaCEPBanco_Cep_Valido;
    procedure TestConsultaCEPBanco_Cep_Invalido;
    procedure TestConsultaCEPBanco_Endereco_Valido;
    procedure TestConsultaCEPBanco_Endereco_Invalido;
    procedure TestConsultaCEPWS_JSON_Valido;
    procedure TestConsultaCEPWS_JSON_Invalido;
    procedure TestConsultaCEPWS_XML_Valido;
    procedure TestConsultaCEPWS_XML_Invalido;
    procedure TestConsultaCEPWS_Endereco_JSON_Valido;
    procedure TestConsultaCEPWS_Endereco_JSON_Invalido;
    procedure TestConsultaCEPWS_Endereco_XML_Valido;
    procedure TestConsultaCEPWS_Endereco_XML_Invalido;
  end;

implementation

uses
  System.JSON, uCommon;

{ TCepComponenteTest }

procedure TCepComponenteTest.SetUp;
begin
  FCepComponente := TCepComponente.Create(nil);
end;

procedure TCepComponenteTest.TearDown;
begin
  FCepComponente.Free;
end;

procedure TCepComponenteTest.TestConsultaCEPBanco_Cep_Valido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['94814090', '', '', ''];
  ResultList := FCepComponente.ConsultaCEPBanco(Params);
  try
    CheckEquals(1, ResultList.Count, 'Deveria retornar um resultado');
  finally
    ResultList.Free;
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPBanco_Cep_Invalido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['00000000', '', '', ''];
  ResultList := FCepComponente.ConsultaCEPBanco(Params);
  try
    CheckNull(ResultList, 'Não deveria retornar resultado');
  finally
    ResultList.Free;
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPBanco_Endereco_Valido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['', 'RS', 'PORTO ALEGRE', 'CASEMIRO DE ABREU'];
  ResultList := FCepComponente.ConsultaCEPBanco(Params);
  try
    CheckTrue(ResultList.Count > 0, 'Deveria retornar um resultado');
  finally
    ResultList.Free;
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPBanco_Endereco_Invalido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['', 'TT', 'CIDADE TESTE', 'RUA TESTE'];
  ResultList := FCepComponente.ConsultaCEPBanco(Params);
  try
    CheckNull(ResultList, 'Não deveria retornar resultado');
  finally
    ResultList.Free;
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPWS_JSON_Valido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['94814090', '', '', ''];
  ResultList := FCepComponente.ConsultaCEPWS(Params, 'json', eCEP);
  try
    CheckTrue(ResultList <> nil, 'Deveria retornar um resultado');
  finally
    ResultList.Free;
    FreeAndNil(FCepComponente);
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPWS_JSON_Invalido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['00000000', '', '', ''];
  ResultList := FCepComponente.ConsultaCEPWS(Params, 'json', eCEP);
  try
    CheckTrue(ResultList = nil, 'Não deveria retornar resultado');
  finally
    ResultList.Free;
    FreeAndNil(FCepComponente);
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPWS_XML_Valido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['94910170', '', '', ''];
  ResultList := FCepComponente.ConsultaCEPWS(Params, 'xml', eCep);
  try
    CheckTrue(ResultList <> nil, 'Deveria retornar um resultado');
  finally
    ResultList.Free;
    FreeAndNil(FCepComponente);
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPWS_XML_Invalido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['00000000', '', '', ''];
  ResultList := FCepComponente.ConsultaCEPWS(Params, 'xml', eCep);
  try
    CheckTrue(ResultList = nil, 'Não deveria retornar resultado');
  finally
    ResultList.Free;
    FreeAndNil(FCepComponente);
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPWS_Endereco_JSON_Valido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['', 'RS', 'PORTO ALEGRE', 'DOMINGOS'];
  ResultList := FCepComponente.ConsultaCEPWS(Params, 'json', eEndereco);
  try
    CheckTrue(ResultList <> nil, 'Deveria retornar um resultado');
  finally
    ResultList.Free;
    FreeAndNil(FCepComponente);
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPWS_Endereco_JSON_Invalido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['', 'TT', 'CIDADE TESTE', 'RUA TESTE'];
  ResultList := FCepComponente.ConsultaCEPWS(Params, 'json', eEndereco);
  try
    CheckTrue(ResultList = nil, 'Não deveria retornar resultado');
  finally
    ResultList.Free;
    FreeAndNil(FCepComponente);
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPWS_Endereco_XML_Valido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['', 'RS', 'PORTO ALEGRE', 'DOMINGOS'];
  ResultList := FCepComponente.ConsultaCEPWS(Params, 'xml', eEndereco);
  try
    CheckTrue(ResultList <> nil, 'Deveria retornar um resultado');
  finally
    ResultList.Free;
    FreeAndNil(FCepComponente);
  end;
end;

procedure TCepComponenteTest.TestConsultaCEPWS_Endereco_XML_Invalido;
var
  Params: TArray<string>;
  ResultList: TObjectList<TCep>;
begin
  Params := ['', 'TT', 'CIDADE TESTE', 'RUA TESTE'];
  ResultList := FCepComponente.ConsultaCEPWS(Params, 'xml', eEndereco);
  try
    CheckTrue(ResultList = nil, 'Não deveria retornar resultado');
  finally
    ResultList.Free;
    FreeAndNil(FCepComponente);
  end;
end;

initialization
  RegisterTest(TCepComponenteTest.Suite);

end.