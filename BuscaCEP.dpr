program BuscaCEP;

uses
  Vcl.Forms,
  uMain in 'src\View\uMain.pas' {fMain},
  uCEPController in 'src\Controller\uCEPController.pas',
  uCEPModel in 'src\Model\uCEPModel.pas',
  uCepComponente.Component in 'src\Component\uCepComponente.Component.pas',
  uCepComponente.Intf in 'src\Component\uCepComponente.Intf.pas',
  uConexaoController in 'src\Controller\uConexaoController.pas',
  uDAOCep in 'src\DAO\uDAOCep.pas',
  uDAOConexao in 'src\DAO\uDAOConexao.pas',
  uCommon in 'src\Common\uCommon.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Slate Classico');
  Application.CreateForm(TfMain, fMain);
  TConexaoController.getInstance().daoConexao.Create;
  TConexaoController.getInstance().daoConexao.getConexao().Connected := True;

  Application.Run;
end.
