unit uFile.Classes;

interface

uses
  System.IOUtils, System.SysUtils, System.Classes,
  VCL.StdCtrls, Data.DB,
  uLog.Classes, uUtils, uTypes;

type
  TOnAddItem = procedure (const aProcessId: Word; const aProcessName, aMensaje: string; const aBookmark:integer=-1) of object;

  /// <summary> Interface para Gracbar datos a fichero </summary>
  IFile = interface
    procedure Save(const aFileName:TFileName);
    procedure Open(const aFileName:TFileName);
  end;

  /// <summary> Interface para grabar Datasets a fichero </summary>
  ISaveLoadDSToFile = interface(IFile)
    procedure SetLog(aLog:ILog);
    procedure SetDataset(aDataset:TDataset);
  end;

  /// <summary> clase base para guardar Datasets a fichero </summary>
  TSaveDSToFileBase = class(TInterfacedObject, IFIle, ISaveLoadDSToFile)
    procedure SetLog(aLog:ILog); virtual; abstract;
    procedure SetDataset(aDataset:TDataset); virtual; abstract;
    procedure Save(const aFileName:TFileName); virtual; abstract;
    procedure Open(const aFileName:TFileName); virtual; abstract;
  end;
  TClassDSSaveToFileBase = class of TSaveDSToFileBase;

  /// <summary> Clase "dummy" </summary>
  TSaveDSToFileDummy = class(TSaveDSToFileBase, IFile)
    procedure Save(const aFileName:TFileName); override;
  end;

  TSaveExtendedInfo = procedure (TS:TStrings) of object;

  /// <summary> Clase para guardar datasets a fichero </summary>
  TSaveDSToFile = class(TSaveDSToFileBase, ISaveLoadDSToFile, IFile)
  private
    FDataset:TDataset;
    FLog: ILog;
    FOnProgress: TProgressProc;
    FVersion: string;
    FSaveExtendedInfo: TSaveExtendedInfo;
    /// <summary> Validaciones antes de guardar </summary>
    procedure Validate(const aFileName:TFileName);
    procedure SaveCabecera(TS:TStrings);
  public
    /// <summary> Obtener el tamaño aprox. del fichero de salida </summary>
    //---class function GetDataSetSize(aDataSet:TDataSet): Integer;
    /// <summary> Obtener el nombre de fichero propuesto de salida </summary>
    class function GetFileName: TFileName;
    procedure SetDataset(aDataset:TDataset); override;
    procedure SetLog(aLog:ILog); override;
    /// <summary> Procedimiento de grabación a disco </summary>
    procedure Save(const aFileName:TFileName); override;
    /// <summary> Evento para seguir el progreso de la grabación </summary>
    property OnProgress:TProgressProc read FOnProgress write FOnProgress;
    //
    property Version: string read FVersion write FVersion;

    // permite llamar para añadir información extra al final del fichero (deberia ir con // al inicio)
    property SaveExtendedInfo:TSaveExtendedInfo read FSaveExtendedInfo write FSaveExtendedInfo;
  end;

  /// <summary> Class factory </summary>
  TFactorySave = class
    class function GetClass(aClassFileSave:TClassDSSaveToFileBase):ISaveLoadDSToFile;
  end;

  /// <summary> clase base para recuperar mensajes desde fichero a Datasets </summary>
  TLoadDSFromFileBase = class(TInterfacedObject, IFIle, ISaveLoadDSToFile)
    procedure SetLog(aLog:ILog); virtual; abstract;
    procedure SetDataset(aDataset:TDataset); virtual; abstract;
    procedure Save(const aFileName:TFileName); virtual; abstract;
    procedure Open(const aFileName:TFileName); virtual; abstract;
  end;
  TClassDSLoadFromFileBase = class of TLoadDSFromFileBase;

  /// <summary> Clase "dummy" </summary>
  TLoadDSToFileDummy = class(TLoadDSFromFileBase, IFile)
    procedure Open(const aFileName:TFileName); override;
  end;

  TLoadExtendedInfo = procedure (TS:TStrings; const AIndex:integer) of object;

  /// <summary> Clase para guardar datasets a fichero </summary>
  TLoadDSFromFile = class(TLoadDSFromFileBase, ISaveLoadDSToFile, IFile)
  private
    FDataset:TDataset;
    FLog: ILog;
    FOnProgress: TProgressProc;
    FOnAddItem: TOnAddItem;
    FVersion: Currency;
    FLoadExtendedInfo: TLoadExtendedInfo;
    /// <summary> Validaciones antes de guardar </summary>
    procedure Validate(const aFileName:TFileName);
  public
    /// <summary> Obtener el tamaño aprox. del fichero de salida </summary>
    //---class function GetDataSetSize(aDataSet:TDataSet): Integer;
    /// <summary> Obtener el nombre de fichero propuesto de salida </summary>
    class function GetFileName: TFileName;
    procedure SetDataset(aDataset:TDataset); override;
    procedure SetLog(aLog:ILog); override;
    // permite llamar para leer información extra al final del fichero (deberia ir con // al inicio)
    property LoadExtendedInfo:TLoadExtendedInfo read FLoadExtendedInfo write FLoadExtendedInfo;
    /// <summary> Procedimiento de grabación a disco </summary>
    procedure Open(const aFileName:TFileName); override;
    // Versión del fichero cargado
    property Version: Currency read FVersion;
    /// <summary> Evento para seguir el progreso de la grabación </summary>
    property OnProgress:TProgressProc read FOnProgress write FOnProgress;
    /// <summary> Evento al añadir un elemento </summary>
    property OnAddItem:TOnAddItem read FOnAddItem write FOnAddItem;
  end;

  /// <summary> Class factory para la lectura </summary>
  TFactoryLoad = class
    class function GetClass(aClassFileLoad:TClassDSLoadFromFileBase):ISaveLoadDSToFile;
  end;

const
  LOGFILE_EXTENSION = 'dsvlog';

implementation

uses
  System.StrUtils, Math, DKLang,
  VCL.Dialogs;

{ TFactorySave }

class function TFactorySave.GetClass(aClassFileSave:TClassDSSaveToFileBase):ISaveLoadDSToFile;
begin
  Result := aClassFileSave.Create;
end;

{ TSaveDSToFileDummy }

procedure TSaveDSToFileDummy.Save(const aFileName: TFileName);
begin
  // dummy = nop
end;

{ TSaveDSToFIle }
{
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
}

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
  Result := 'DSV_All_' + FormatDateTime('yyyymmdd_hhnnss', now) + '.' + LOGFILE_EXTENSION;
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
        SaveCabecera(TS);

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

        // Permite grabar información extra al final del fichero...
        if Assigned(FSaveExtendedInfo) then begin
          // Marca de info. extendida
          TS.Add('~~ExtendedInfo~~');
          FSaveExtendedInfo(TS);
        end;

        try
          // Grabar fichero
          TS.SaveToFile(aFileName);
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

procedure TSaveDSToFile.SaveCabecera(TS:TStrings);
begin
  TS.Add('// Fichero generado por DebugStringView');
  TS.Add('// Version ' + Self.Version);
  TS.Add('// ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', now));
end;

{ TLoadDSFromFile }

{
class function TLoadDSFromFile.GetDataSetSize(aDataSet: TDataSet): Integer;
begin
  //
end;
}

class function TLoadDSFromFile.GetFileName: TFileName;
begin
  // ?¿?¿?¿?¿
end;

procedure TLoadDSFromFile.Open(const aFileName: TFileName);
var
  sLinea:string;

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

  function CalculateFileVersion(AContent:TStrings):currency;
  begin
    Result := 1.1;  // inicial
    if (AContent.Count < 2) then  // no lleva la info minima de version
      Exit;
    if not AnsiContainsText(AContent[1], '// Version') then    // no lleva la info minima
      Exit;
    var str := Trim(AnsiReplaceText(AContent[1], '// Version', ''));
    str := Copy(Str, 1, 3);      // por ahora asuminos 1 sólo número en cada elemento!!!!!!
    Str := AnsiReplaceText(Str, '.', ',');
    Result := StrToFloat(Str);
  end;

begin
  Validate(aFileName);

  var TS:TStrings := TStringList.Create;
  try
    FDataset.DisableControls;
    try
      FDataset.First;

      // Cargar el fichero
      TS.LoadFromFile(aFileName);

      // var fVersion:currency := CalculateFileVersion(TS);
      FVersion := CalculateFileVersion(TS);
      var j:integer;
      for j := 0 to (TS.Count - 1) do begin
        sLinea := TS[j];
        // Marca de informacion extendida
        if (AnsiCompareText(TS[j], '~~ExtendedInfo~~') = 0) then
          Break;
        // los comentarios nos los saltamos...
        if (Length(sLinea) >= 2) then
          if (sLinea[1]='/') and (sLinea[2]='/') then
            Continue;

        var Init:integer := 1;   // indice inicial
        // Extraer la info.
        var bm:String;
        if (fVersion > 1.1)  then begin
          bm := Trim(Copy(sLinea,  {1}Init, 10));
          Init := Init + 10;
        end
        else
          bm := '-1';
        var sID     := Trim(Copy(sLinea, {11}Init, 10));    Init := Init + 10;
        var sFecha  := Trim(Copy(sLinea, {21}Init, 10));    Init := Init + 10;
        var sHora   := Trim(Copy(sLinea, {31}Init, 10));    Init := Init + 10;
        var pId     := Trim(Copy(sLinea, {41}Init, 10));    Init := Init + 10;
        var pName   := Trim(Copy(sLinea, {51}Init, 50));    Init := Init + 50;
        var Mensaje := Trim(Copy(sLinea, {101}Init, Length(sLinea)));

        if Assigned(FOnAddItem) then
          FOnAddItem(pId.ToInteger, pName, Mensaje, StrToIntDef(bm, -1));
      end;

      // cargar la info. extendida que hay al final
      if Assigned(FLoadExtendedInfo) then
        FLoadExtendedInfo(TS, j+1);
    finally
      FDataset.EnableControls;
    end;
  finally
    FreeAndNil(TS);
  end;
end;

procedure TLoadDSFromFile.SetDataset(aDataset: TDataset);
begin
  FDataset := aDataset;
end;

procedure TLoadDSFromFile.SetLog(aLog: ILog);
begin
  FLog := aLog;
end;

procedure TLoadDSFromFile.Validate(const aFileName: TFileName);
begin
  // Si no existe, error
  if not FileExists(aFileName) then
    raise Exception.Create(Format('Error, no se puede leer el fichero seleccionado <%s>',[aFileName]));
end;

{ TLoadDSToFileDummy }

procedure TLoadDSToFileDummy.Open(const aFileName: TFileName);
begin
  // dummy = nop
end;

{ TFactoryLoad }

class function TFactoryLoad.GetClass(aClassFileLoad: TClassDSLoadFromFileBase): ISaveLoadDSToFile;
begin
  Result := aClassFileLoad.Create;
end;

end.
