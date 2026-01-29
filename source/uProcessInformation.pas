unit uProcessInformation;

interface

uses
  System.Generics.Collections,
  VCL.Graphics,
	Classes, windows, Forms, StdCtrls, SysUtils,
  uLog.Classes;

type
  TProcessInfo = class;
  TIdList = TList<DWORD>;
  /// <summary> Utilidades sobre procesos </summary>
  TProcessUtils = class
    class function GetHandleByProcessID(aProcessId: DWORD):THandle;
    class function GetProcessNameByPID(aProcessId: DWORD): string;
  end;

  /// <summary> Lista de procesos </summary>
  TProcessList = class(TStringList)
  private
    FLog: ILog;
  published
    constructor Create(aLog:ILog=nil); reintroduce;
    function AddProcessByName(const aProcessName:string; const aProcessId:DWORD):boolean;
    function GetProcessOject(const aProcessName:string):TProcessInfo;
    function GetColorByName(aProcessName:string):TColor;
    function GetIndexByName(aProcessName:string):Integer;
    procedure Debug;
    /// <summary> Objeto de log </summary>
    property Log:ILog read FLog write FLog;
  end;

/// <summary> Objeto para almacenar info. necesaria de u proceso </summary>
  TProcessInfo = class
  private
    // FProcessId: Word;
    FProcessName: string;
    FCreationDate: TDateTime;
    FProcessIdList: TIdList;
    FColor: TColor;
    FLog: ILog;
    /// <summary> Añadir un nuevo  proceso a partir desummary; Si ya existe lo ignora </sumary>
    procedure AddProcessId(const aProcessId: DWORD);
  public
    constructor Create(const aProcessName:string; const aProcessId:DWORD; aLog:ILog=nil);
    destructor Destroy; override;
    procedure Debug;
    // Lista de ID's de todos los procesos con el mismo nombre
    property ProcessIdList:TIdList read FProcessIdList;
    /// <summary> Nombre de la aplicación asociada a un ProcessId </summary>
    property ProcessName:string read FProcessName;
    /// <summary> Fecha de creacion (aplicación asociada a un ProcessId) </summary>
    property CreationDate:TDateTime read FCreationDate;
    /// <summary> Color asociado a un proceso </summary>
    property Color:TColor read FColor write FColor;
    /// <summary> propiedad para implementar posibilidad de Log es este objeto </summary>
    property Log:ILog read FLog write FLog;
  end;

var
  ListaProcesos:TProcessList;


implementation

uses
  uUTils,
  PsAPI, tlhelp32, ShellAPi;

{ TProcessInfo }

procedure TProcessInfo.AddProcessId(const aProcessId: DWORD);
begin
  if (FProcessIdList.IndexOf(aProcessId) = -1) then
    FProcessIdList.Add(aProcessId);
end;

constructor TProcessInfo.Create(const aProcessName:string; const aProcessId: DWORD; aLog:ILog=nil);
begin
  inherited Create;
  FLog := aLog;
  FProcessName := aProcessName;
  FColor := TColorUtils.ConvertirAPastel(TColorUtils.GenerarColorAleatorio, 1.5);
  FProcessIdList := TIdList.Create;
  AddProcessId(aProcessId);
end;

procedure TProcessInfo.Debug;
begin
  if not Assigned(FLog) then
    Exit;

  FLog.Log('   ProcessName: ' + FProcessName);
  FLog.Log('   Color      : ' + IntToStr(FColor));
  FLog.Log('   ProcessId''s: ');
  for var i := 0 to (FProcessIdList.Count - 1) do
    FLog.Log('        >' + FProcessIdList[i].ToString);
  FLog.Log('····················································')
end;

destructor TProcessInfo.Destroy;
begin
  if Assigned(FProcessIdList) then
    FreeAndNil(FProcessIdList);
end;


{ TProcessList }

function TProcessList.AddProcessByName(const aProcessName:string; const aProcessId:DWORD):boolean;
begin
  Result := False;
  var index:integer;
  // Existe ?
  var b := Self.Find(aProcessName, index);
  if (not b) then begin
    // Crear el objeto
    var pInfo := TProcessInfo.Create(aProcessName, aProcessId, FLog);
    AddObject(aProcessName, pInfo);
    Result := True;   // se ha añadido, no existía
  end
  else begin
    // si ya existe, añadirle el ProcessId
    var pInfo:TProcessInfo := GetProcessOject(aProcessName);
    pInfo.AddProcessId(aProcessId);
  end;
end;

constructor TProcessList.Create(aLog:ILog=nil);
begin
  inherited Create;

  Duplicates := dupIgnore;
  Sorted := True;
  OwnsObjects := True;

  FloG := aLog;
end;

procedure TProcessList.Debug;
begin
  if not Assigned(FLog) then
    Exit;
  FLog.Log('Lista de procesos--------------');
  for var j := 0 to (Count - 1) do begin
    FLog.Log(Strings[j]);
    TProcessInfo(Objects[j]).Debug;
  end;
end;

function TProcessList.GetColorByName(aProcessName: string): TColor;
var
  index:integer;
begin
  Result := -1;
  var b := Find(aProcessName, index);
  if not b then
    Exit;
  var pInfo:TProcessInfo := TProcessInfo(Objects[index]);
  if Assigned(pInfo) then
    Result := pInfo.Color;
end;

function TProcessList.GetIndexByName(aProcessName: string): Integer;
var
  index:integer;
begin
  Result := -1;
  var b := Find(aProcessName, index);
  if not b then
    Exit;
  Result := index;
end;

function TProcessList.GetProcessOject(const aProcessName:string): TProcessInfo;
var
  index:integer;
begin
  Result := nil;
  var b:boolean := Self.Find(aProcessName, index);
  if b then
    Result := TProcessInfo(Objects[index]);
end;

{ TProcessUtils }

class function TProcessUtils.GetHandleByProcessID(aProcessId: DWORD):THandle;
begin
  Result := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, AProcessID);
  if Result = 0 then
    RaiseLastOSError;
end;

class function TProcessUtils.GetProcessNameByPID(aProcessId: DWORD): string;
var
  hSnapshot: THandle;
  pe32: TProcessEntry32;
begin
  Result := '';
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then
    Exit;

  pe32.dwSize := SizeOf(TProcessEntry32);
  if Process32First(hSnapshot, pe32) then
  begin
    repeat
      if pe32.th32ProcessID = aProcessId then
      begin
        Result := pe32.szExeFile;
        Break;
      end;
    until not Process32Next(hSnapshot, pe32);
  end;
  CloseHandle(hSnapshot);
end;

end.
