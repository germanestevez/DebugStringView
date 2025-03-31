unit FAcercaDe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  uUtils, Vcl.Imaging.pngimage, DKLang;

type
  TFormAcercaDe = class(TForm)
    pnlCentral: TPanel;
    pnlBoton: TPanel;
    btnCerrar: TButton;
    imgInfo: TImage;
    lblTitulo: TLabel;
    lblVersion: TLabel;
    llblWeb: TLabel;
    lblCopyRight: TLabel;
    llblGithub: TLabel;
    lblTexto: TLabel;
    imgIcon: TImage;
    DKLanguageController: TDKLanguageController;
    procedure btnCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure llblGithubClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  ShellAPI;

procedure TFormAcercaDe.btnCerrarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormAcercaDe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TFormAcercaDe.FormShow(Sender: TObject);
begin
  // Version
  lblVersion.Caption := DKLangConstW('LBL_VERSION') + GetAppVersion(ParamStr(0));
end;

procedure TFormAcercaDe.llblGithubClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(TLinkLabel(Sender).Caption), nil, nil, SW_NORMAL);
end;

end.
