unit uConexaoController;

interface

uses SysUtils, uDAOConexao;

type
  TConexaoController = class
    private
      FConexao: TDAOConexao;
      constructor Create;
      destructor Destroy; override;
    public
      property daoConexao : TDAOConexao read FConexao write FConexao;
      class function getInstance : TConexaoController;

   end;

implementation

var
  Conexao: TConexaoController;

{ TConexaoController }

constructor TConexaoController.Create;
begin
  inherited Create;
  FConexao := TDAOConexao.Create;
end;

destructor TConexaoController.Destroy;
begin
  inherited;
  FreeAndNil(FConexao);
end;

class function TConexaoController.getInstance: TConexaoController;
begin
  if Conexao = nil then
    Conexao := TConexaoController.Create;

  Result := Conexao;
end;

initialization
  Conexao := nil;

finalization
  if Conexao <> nil then
    Conexao.Free;

end.
