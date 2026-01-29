unit FSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TFormSplash = class(TForm)
    imgSplash: TImage;
    TimerSplash: TTimer;
    procedure TimerSplashTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSplash: TFormSplash;

implementation

{$R *.dfm}


procedure TFormSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AlphaBlend := True;
  for var i := 0 to 8 do begin
    AlphaBlendValue := 255 - (i * 31);
    sleep(100);
  end;

  Action := caFree;
end;

procedure TFormSplash.TimerSplashTimer(Sender: TObject);
begin
  Close;
end;

procedure TFormSplash.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

end.
