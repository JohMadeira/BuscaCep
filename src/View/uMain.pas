unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, uCommon, Vcl.ComCtrls, Vcl.Menus, uCEPController, uCEPModel,
  FireDAC.Comp.Client, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TfMain = class(TForm)
    GroupBox1: TGroupBox;
    pgcBusca: TPageControl;
    tabCEP: TTabSheet;
    rdgRetorno: TRadioGroup;
    Label1: TLabel;
    edtUfConsulta: TEdit;
    Label2: TLabel;
    edtLocalidadeConsulta: TEdit;
    Label3: TLabel;
    edtLogradouroConsulta: TEdit;
    GroupBox2: TGroupBox;
    MainMenu1: TMainMenu;
    Opes1: TMenuItem;
    Opes2: TMenuItem;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox3: TGroupBox;
    mmoJSON: TMemo;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnConsulta: TSpeedButton;
    tabEndereco: TTabSheet;
    edtCepConsulta: TEdit;
    AbreFrameTeste1: TMenuItem;
    GroupBox4: TGroupBox;
    DBGrid1: TDBGrid;
    dsDataSource: TDataSource;
    edtCepRetorno: TDBEdit;
    edtLogradouroRetorno: TDBEdit;
    edtComplemento: TDBEdit;
    edtLocalidadeRetorno: TDBEdit;
    edtBairro: TDBEdit;
    edtUFRetorno: TDBEdit;
    procedure btnConsultaClick(Sender: TObject);
    procedure Opes2Click(Sender: TObject);
    procedure pgcBuscaChange(Sender: TObject);
  private
    { Private declarations }
    MemTable: TFDMemTable;
    function MostrarMensagem(pTexto: string): Integer;
    function ValidaCampos: boolean;
    procedure PreencherCampos(pCep: TCep);
    function PesquisaEndereco(pCepController: TCEPController; pParams: TArray<string>): boolean;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.btnConsultaClick(Sender: TObject);
var
  vCepController: TCEPController;
  vParams: TArray<string>;
  vTipoPesquisa: TTipoPesquisa;
begin
  vTipoPesquisa := TTipoPesquisa(pgcBusca.Tag);
  if ValidaCampos then
    begin
      vCepController := TCEPController.Create;
      vParams := [edtcepConsulta.Text, edtUFconsulta.Text, edtLocalidadeconsulta.Text, edtLogradouroconsulta.Text];
      try
        MemTable := TFDMemTable.Create(nil);
        MemTable := vCepController.ConsultarCepBanco(vParams);
        if vCepController.GetLoteCep <> nil then
          begin
            if MostrarMensagem('CEP encontrado na base de dados local.' + #13#10+ 'Deseja exibir os dados da base ou atualizá-lo com o WebService?') = mrNo then
              MemTable := vCepController.ConsultarCEPWSEndereco(vParams, LowerCase(rdgRetorno.Items[rdgRetorno.ItemIndex]), vTipoPesquisa);
          end
        else
          MemTable := vCepController.ConsultarCEPWSEndereco(vParams, LowerCase(rdgRetorno.Items[rdgRetorno.ItemIndex]), vTipoPesquisa);

        if vCepController.GetLoteCep = nil then
          begin
            MessageDlg('CEP não encontrado em nenhuma base de dados', mtError, [mbOk], 0);
            Exit;
          end;
        DBGrid1.DataSource.DataSet := MemTable;
        DBGrid1.DataSource.DataSet.First;
        PreencherCampos(vCepController.GetLoteCep[0]);

        mmoJSON.Lines.Text := vCepController.CepComponente.Response;
      finally
        FreeAndNil(vCepController);
      end;
    end
  else
    MessageDlg('Erro: Campos com valores inválidos.' + #13#10 + 'Os campos de Logradouro e Localidade devem possuir no mínimo 3 caracteres, e a UF, 2',
      mtError, [mbOk], 0);
end;

function TfMain.MostrarMensagem(pTexto: string): Integer;
var
  MsgForm: TForm;
  Btn: TButton;
  I: Integer;
begin
  MsgForm := CreateMessageDialog(pTexto, mtWarning, [mbYes, mbNo]);
  try
    MsgForm.Caption := 'Confirmação';
    MsgForm.AutoSize := True;

    for I := 0 to MsgForm.ComponentCount - 1 do
    begin
      if MsgForm.Components[I] is TButton then
      begin
        Btn := TButton(MsgForm.Components[I]);
        if Btn.ModalResult = mrYes then
          Btn.Caption := 'Exibir'
        else if Btn.ModalResult = mrNo then
          Btn.Caption := 'Atualizar';
      end;
    end;

    Result := MsgForm.ShowModal;
  finally
    MsgForm.Free;
  end;
end;

procedure TfMain.Opes2Click(Sender: TObject);
var
  aux: integer;
begin
  for aux := 0 to fMain.ComponentCount -1 do
    if fMain.Components[aux] is TEdit then
      TEdit(fMain.Components[aux]).Clear
    else if fMain.Components[aux] is TMemo then
      TMemo(fMain.Components[aux]).Clear;
end;

function TfMain.PesquisaEndereco(pCepController: TCEPController; pParams: TArray<string>): boolean;
begin
  MemTable := TFDMemTable.Create(nil);
  MemTable := pCepController.ConsultarCepBanco(pParams);
  if pCepController.GetLoteCep <> nil then
    begin
      if MostrarMensagem('CEP encontrado na base de dados local.' + #13#10+ 'Deseja exibir os dados da base ou atualizá-lo com o WebService?') = mrNo then
        MemTable := pCepController.ConsultarCEPWSEndereco(pParams, LowerCase(rdgRetorno.Items[rdgRetorno.ItemIndex]), eCEp);
    end
  else
    MemTable := pCepController.ConsultarCEPWSEndereco(pParams, LowerCase(rdgRetorno.Items[rdgRetorno.ItemIndex]), eCep);

  if pCepController.GetLoteCep = nil then
    begin
      MessageDlg('CEP não encontrado em nenhuma base de dados', mtError, [mbOk], 0);
      Result := False;
      Exit;
    end;
  DBGrid1.DataSource.DataSet := MemTable;
  DBGrid1.DataSource.DataSet.First;
  PreencherCampos(pCepController.GetLoteCep[0]);
end;

procedure TfMain.pgcBuscaChange(Sender: TObject);
begin
  if pgcBusca.ActivePage = tabCEP then
    edtCepConsulta.Clear
  else
    begin
      edtUfConsulta.Clear;
      edtLocalidadeConsulta.Clear;
      edtLogradouroConsulta.Clear;
    end;
  pgcBusca.Tag := pgcBusca.ActivePageIndex;
end;

procedure TfMain.PreencherCampos(pCep: TCep);
begin
  edtCEPRetorno.Text := pCep.Cep;
  edtLogradouroRetorno.Text := pCep.Logradouro;
  edtComplemento.Text := pCep.Complemento;
  edtBairro.Text := pCep.Bairro;
  edtLocalidadeRetorno.Text := pCep.Localidade;
  edtUFRetorno.Text := pCep.uf;
end;

function TfMain.ValidaCampos: boolean;
begin
  Result := True;
  if pgcBusca.ActivePage = tabCEP then
    Result := (Length(edtCepConsulta.Text) = 8);
  if pgcBusca.ActivePage = tabEndereco then
    if (Length(edtLogradouroConsulta.Text) < 3) or
       (Length(edtLocalidadeConsulta.Text) < 3) or
       (Length(edtUfConsulta.Text) <> 2) then
      Result := False;
end;

end.
