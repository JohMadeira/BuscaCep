unit uDAOConexao;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Async, FireDAC.Stan.Param,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  System.SysUtils, IniFiles, Forms;

type
  TDAOConexao = class
      private
        FConexao: TFDConnection;
        FDriver: TFDPhysSQLiteDriverLink;
      public
        function getConexao: TFDConnection;
        function getQuery: TFDQuery;
        constructor Create;
        destructor Destroy; override;
  end;

implementation

{ TDAOConexao }

constructor TDAOConexao.Create;
var
  iniFile: TIniFile;
begin
  inherited Create;

  iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\DB\Config.ini');

  FDriver := TFDPhysSQLiteDriverLink.Create(nil);
  Fdriver.DriverID :=  iniFile.ReadString('Banco', 'DriverId', '');

  FConexao := TFDConnection.Create(nil);
  FConexao.DriverName := iniFile.ReadString('Banco', 'DriverName', '');
  FConexao.Params.Values['Database'] := ExtractFilePath(Application.ExeName)  + '\DB\' + iniFile.ReadString('Banco','Database', '');
  FConexao.LoginPrompt := False;
  FConexao.TxOptions.AutoCommit := False;

  iniFile.Free;
end;

destructor TDAOConexao.Destroy;
begin
  inherited;
  FreeAndNil(FDriver);
  FreeAndNil(FConexao);
end;

function TDAOConexao.getConexao: TFDCOnnection;
begin
  result := FConexao;
end;

function TDAOConexao.getQuery: TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TFDQuery.Create(nil);
  qQuery.Connection := FConexao;

  Result := qQuery;
end;


end.
