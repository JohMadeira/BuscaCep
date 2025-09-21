unit uConexaoControllerTest;

interface

uses
  TestFramework, uConexaoController, uDAOConexao, SysUtils;

type
  TConexaoControllerTest = class(TTestCase)
  published
    procedure TestGetInstance_Singleton;
    procedure TestDaoConexao_NotNil;
    procedure TestDaoConexao_AssignAndRead;
  end;

implementation

procedure TConexaoControllerTest.TestGetInstance_Singleton;
var
  Inst1, Inst2: TConexaoController;
begin
  Inst1 := TConexaoController.getInstance;
  Inst2 := TConexaoController.getInstance;
  CheckSame(Inst1, Inst2, 'getInstance deve retornar sempre a mesma instância');
end;

procedure TConexaoControllerTest.TestDaoConexao_NotNil;
var
  Inst: TConexaoController;
begin
  Inst := TConexaoController.getInstance;
  CheckNotNull(Inst.daoConexao, 'daoConexao deve ser criado junto com o controller');
end;

procedure TConexaoControllerTest.TestDaoConexao_AssignAndRead;
var
  Inst: TConexaoController;
  NewDAO: TDAOConexao;
begin
  Inst := TConexaoController.getInstance;
  NewDAO := TDAOConexao.Create;
  try
    Inst.daoConexao := NewDAO;
    CheckSame(NewDAO, Inst.daoConexao, 'daoConexao deve aceitar atribuição e retornar o mesmo objeto');
  finally
  end;
end;

initialization
  RegisterTest(TConexaoControllerTest.Suite);

end.