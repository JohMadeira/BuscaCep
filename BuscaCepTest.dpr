{$APPTYPE CONSOLE}
program DUnitTestProject;

uses
  TestFramework,
  TextTestRunner,
  uMainTest in 'tests\uMainTest.pas',
  uMain in 'src\View\uMain.pas' {fMain},
  uCommon in 'src\Common\uCommon.pas',
  uCEPController in 'src\Controller\uCEPController.pas',
  uConexaoController in 'src\Controller\uConexaoController.pas',
  uCEPModel in 'src\Model\uCEPModel.pas',
  uCepComponente.Component in 'src\Component\uCepComponente.Component.pas',
  uCepComponente.Intf in 'src\Component\uCepComponente.Intf.pas',
  uDAOCep in 'src\DAO\uDAOCep.pas',
  uDAOConexao in 'src\DAO\uDAOConexao.pas',
  uCEPControllerTest in 'tests\uCEPControllerTest.pas',
  uConexaoControllerTest in 'tests\uConexaoControllerTest.pas',
  uCepComponenteTest in 'tests\uCepComponenteTest.pas',
  uTestesCenarios in 'tests\uTestesCenarios.pas';

begin
  TextTestRunner.RunRegisteredTests;
  ReadLn;
end.