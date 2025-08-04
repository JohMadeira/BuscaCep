unit uDAOCep;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, uConexaoController,
  uCEPModel, SysUtils;

type
  TDAOCep = class
    private
    public
      function consultarCEP(pCep: string): TFDQuery;
      function consultarEndereco(pUf, pLocalidade, pLogradouro: string): TFDQuery;
      function salvarCEP(pCep: TCep): boolean;
  end;

implementation

function TDAOCep.consultarCEP(pCep: string): TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TConexaoController.getInstance().daoConexao.getQuery;
  try
    qQuery.Open('select * from CEP where cep = :pCep', [pCep]);
  finally
    Result := qQuery;
  end;
  if qQuery.RecordCount = 0 then
    Result := nil;
end;

function TDAOCep.consultarEndereco(pUf, pLocalidade, pLogradouro: string): TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TConexaoController.getInstance().daoConexao.getQuery;
  try
    qQuery.Open('select * from CEP where UPPER(UF) = UPPER(:pUf)' +
                ' and UPPER(Localidade) LIKE UPPER(:pLocalidade)' +
                ' and UPPER(Logradouro) LIKE UPPER(:pLogradouro)',
                [pUf, '%'+pLocalidade+'%', '%'+pLogradouro+'%']);
  finally
    Result := qQuery;
  end;
  if qQuery.RecordCount = 0 then
    Result := nil;
end;

function TDAOCep.salvarCEP(pCep: TCep): boolean;
var
  qQuery: TFDQuery;
  strTexto: string;
begin
  try
    qQuery := TConexaoController.getInstance().daoConexao.getQuery;
    qQuery.Connection.StartTransaction;
    strTexto := 'insert or replace into CEP (cep, logradouro, complemento, bairro, localidade, uf) ' +
                   'values (:pCep, :pLogradouro, :pComplemento, :pBairro, :pLocalidade, :pUf);';
    qQuery.ExecSQL(strTexto,
                   [StringReplace(pCep.Cep, '-', '', [rfReplaceAll]), pCep.Logradouro, pCep.Complemento, pCep.Bairro, pCep.Localidade, pCep.Uf]);
    qQuery.Connection.Commit;
    Result := True;
  except
    qQuery.Connection.Rollback;
    Result := False;
  end;
  FreeAndNil(qQuery);
end;

end.

