unit uFile.Classes;

interface

uses
  System.IOUtils, System.SysUtils,
  VCL.StdCtrls, Data.DB,
  uLog.Classes, uUtils;

type
  /// <summary> Interface para Gracbar datos a fichero </summary>
  IFile = interface
    procedure Save(const aFileName:TFileName);
  end;

  /// <summary> Interface para grabar Datasets a fichero </summary>
  ISaveDSToFile = interface(IFile)
    procedure SetLog(aLog:ILog);
    procedure SetDataset(aDataset:TDataset);
  end;

  /// <sumsummary clase base para guardar Datasets a fichero </summary>
  TSaveDSToFileBase = class(TInterfacedObject, IFIle, ISaveDSToFile)
    procedure SetLog(aLog:ILog); virtual; abstract;
    procedure SetDataset(aDataset:TDataset); virtual; abstract;
    procedure Save(const aFileName:TFileName); virtual; abstract;
  end;
  TClassDSSaveToFileBase = class of TSaveDSToFileBase;

  /// <summary> Clase "dummy" </summary>
  TSaveDSToFileDummy = class(TSaveDSToFileBase, IFile)
    procedure Save(const aFileName:TFileName); override;
  end;

  /// <summary> Clase para guardar datasets a fichero </summary>
  TSaveDSToFile = class(TSaveDSToFileBase, ISaveDSToFile, IFile)
  private
    FDataset:TDataset;
    FLog: ILog;
    FOnProgress: TProgressProc;
    /// <summary> Validaciones antes de guardar </summary>
    procedure Validate(const aFileName:TFileName);
  public
    /// <summary> Obtener el tamaño aprox. del fichero de salida </summary>
    class function GetDataSetSize(aDataSet:TDataSet): Integer;
    /// <summary> Obtener el nombre de fichero propuesto de salida </summary>
    class function GetFileName: TFileName;
    procedure SetDataset(aDataset:TDataset); override;
    procedure SetLog(aLog:ILog); override;
    /// <summary> Procedimiento de grabación a disco </summary>
    procedure Save(const aFileName:TFileName); override;
    /// <summary> Evento para seguir el progreso de la grabación </summary>
    property OnProgress:TProgressProc read FOnProgress write FOnProgress;
  end;

  /// <summary> Class factory </summary>
  TFactorySave = class
    class function GetClass(aClassFileSave:TClassDSSaveToFileBase):ISaveDSToFile;
  end;

const
  LOGFILE_EXTENSION = 'dsvlog';

implementation

uses
  System.StrUtils, System.Classes, Math, DKLang,
  VCL.Dialogs;

{ TFactorySave }

class function TFactorySave.GetClass(aClassFileSave:TClassDSSaveToFileBase):ISaveDSToFile;
begin
  Result := aClassFileSave.Create;
end;

{ TSaveDSToFileDummy }

procedure TSaveDSToFileDummy.Save(const aFileName: TFileName);
begin
  // dummy = nop
end;

{ TSaveDSToFIle }

class function TSaveDSToFIle.GetDataSetSize(aDataSet:TDataSet): Integer;
var
  TotalSize: Integer;
  i: Integer;
  str:string;
begin
  Result := 0;
  var ds:TDataset := aDataset;
  if (not ds.Active) or (ds.IsEmpty) then
    Exit;

  for i := 0 to (ds.FieldCount - 1) do
    Str := Str + DupeString(' ', ds.Fields[i].DisplayWidth);

  TotalSize := Length(Str) * ds.RecordCount;
  Result := TotalSize;
end;


procedure TSaveDSToFIle.SetDataset(aDataset:TDataset);
begin
  FDataset := aDataset;
end;

procedure TSaveDSToFile.SetLog(aLog: ILog);
begin
  FLog := aLog;
end;

procedure TSaveDSToFile.Validate(const aFileName:TFileName);
var
  deleted:boolean;
begin
  deleted := True;
  // Si existe, lo borramos
  if FileExists(aFileName) then
    deleted := DeleteFile(aFileName);

  if not deleted then
    raise Exception.Create(Format(DKLangConstW('err_NoSePuedeBorrar'),[aFileNAme]));

  if not Assigned(FDataset) then
    raise Exception.Create(DKLangConstW('err_SinDatosAsignado'));
end;

class function TSaveDSToFIle.GetFileName: TFileName;
begin
  Result := 'DSV_All_' + FormatDateTime('yyyymmdd_hhnnss', now);
end;

procedure TSaveDSToFIle.Save(const aFileName:TFileName);
var
  index:integer;

  procedure CallbackStep(const aDataset:TDataset; const aIndex:integer);
  begin
    var iMax := Min(aDataset.RecordCount, 100);

    var iTotal := aDataset.RecordCount;
    var iDelta := Max(1, (iTotal/iMax));

    if ((aIndex MOD Trunc(iDelta)) = 0) then
      if Assigned(FOnProgress) then begin
        FOnProgress(Trunc(aIndex/iDelta), iMax);
      end;
  end;

begin
  Index := 0;
  Validate(aFileName);

  var TS:TStrings := TStringList.Create;
  try
    var ds:TDataset := FDataset.GetClonedDataSet(True);
    try
      var bm := ds.GetBookmark;
      try
        FDataset.First;
        while not ds.eof do begin
          Inc(index);
          var str:string;
          for var i := 0 to (ds.FieldCount - 1) do begin
            FLog.Log('Campo=' + ds.Fields[i].FieldName + '  - DisplayWidth=' + ds.Fields[i].DisplayWidth.ToString);
            if (ds.Fields[i].FieldName = 'Mensaje') then begin
              Str := Str + Trim(ds.Fields[i].AsString);
            end
            else begin
              var w := ds.Fields[i].DisplayWidth;
              str := str + TStringUtils.PadRight(ds.Fields[i].AsString, w);
            end;
          end;

          CallbackStep(ds, index); // progreso de la grabacion

          // Añadir a la lista
          TS.Add(Str);
          Str := string.Empty;
          ds.Next;
        end;

        try
          // Grabar fichero
          TS.SaveToFile(ChangefileExt(aFileName, 'log'));
        except
          on E:Exception do begin
            raise Exception.Create(DKLangConstW('err_Save') + sLineBreak + E.Message);
          end;
        end;
      finally
        ds.GotoBookmark(bm)
      end;
    finally
      FreeAndNil(ds);
    end;
  finally
    FreeAndNil(TS);
  end;
end;

end.
