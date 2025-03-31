unit uLog.Classes;

interface

uses
  System.IOUtils, System.SysUtils, DKLang,
  VCL.StdCtrls;

type
  // interface para clases de Log
  ILog = interface
    procedure Log(const aMensaje:string);
  end;

  // Clazse base (abstarcat) no usar
  TBaseLog = class(TInterfacedObject, ILog)
    procedure Log(const aMensaje:string); virtual; abstract;
  end;
  TClassLog = class of TBaseLog;

  // Clase dummy (n debe hacer nada)
  TDummyMemo = class(TBaseLog, ILog)
    procedure Log(const aMensaje:string); override;
  end;

  // clase para LOG a memo
  TLogMemo = class(TBaseLog, ILog)
  private
    FMemo:TMemo;
  public
    procedure Log(const aMensaje:string); override;
    property Memo:TMemo read FMemo write FMemo;
  end;

  // Clase para log a disco
  TFileMemo = class(TBaseLog, ILog)
  private
    FPath:TFileName;
  public
    procedure Log(const aMensaje:string); override;
    property Path:TFileName read FPath write FPath;
  end;

  TFactoryLog = class
    class function GetClass(aClassLog:TClasslog):ILog;
  end;

implementation

{ TLogMemo }

procedure TLogMemo.Log(const aMensaje: string);
begin
  if not Assigned(FMemo) then
    raise Exception.Create(Format(DKLangConstW('errMemo'), [ClassName]));
  FMemo.Lines.Add(aMensaje);
end;

{ TDummyMemo }

procedure TDummyMemo.Log(const aMensaje: string);
begin
  // dummy = nop
end;

{ TFileMemo }

procedure TFileMemo.Log(const aMensaje: string);
begin
  if not (FPath = string.empty) then
    raise Exception.Create(Format(DKLangConstW('errPath'), [ClassName]));

  TFile.AppendAllText(FPath, aMensaje, TEncoding.UTF8)
end;

{ TFactoryLog }

class function TFactoryLog.GetClass(aClassLog: TClasslog): ILog;
begin
  Result := aClassLog.Create;
end;

end.
