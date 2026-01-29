program DebugStringView;

uses
  Vcl.Forms,
  FMain in 'FMain.pas' {FormMain},
  uCaptureDebugString in 'uCaptureDebugString.pas',
  uProcessInformation in 'uProcessInformation.pas',
  uGridHelpers in 'uGridHelpers.pas',
  uUtils in 'uUtils.pas',
  uTypes in 'uTypes.pas',
  uLog.Classes in 'uLog.Classes.pas',
  uFile.Classes in 'uFile.Classes.pas',
  uConfig.Classes in 'uConfig.Classes.pas',
  FAcercaDe in 'FAcercaDe.pas' {FormAcercaDe},
  uRecursos in 'uRecursos.pas',
  uUpdates in 'uUpdates.pas',
  uBookmarks.Classes in 'uBookmarks.Classes.pas',
  FSplash in 'FSplash.pas' {FormSplash};

{$R *.res}
{$R *.dkl_const.res}

begin
  Application.Initialize;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
