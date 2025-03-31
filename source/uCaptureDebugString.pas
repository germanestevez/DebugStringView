{
Info. extracted from:
   https://stackoverflow.com/questions/11226669/delphi-hook-bypass-catch-all-the-outputdebugstring-from-the-system-into-my-app
   https://stackoverflow.com/questions/28510135/capturing-outputdebugstring-calls-on-a-server-written-in-delphi
}
unit uCaptureDebugString;

interface

uses
  Classes, WinAPI.Windows, Forms, StdCtrls, SysUtils, utypes;

const
  _SYNCHRONIZE = SYNCHRONIZE;     // Ppor errores relacionados con la clase Thread (se hace un lio)

type
  PDbWinBuffer = ^DbWinBuffer;
  DbWinBuffer = record
    dwProcessId: DWORD;
    data: array[0..(4096-sizeof(DWORD))-1] of AnsiChar;
  end;

  /// <summary> Clase derivada de tthread para capturar los mensajes enviados </summary>
  TDebugStringThread = class(TThread)
    private
      ErrsMess: String;
      SharedMessage: string;
      SharedProcessId: integer;
      procSharedInfo:TProcSharedInfo;
    protected
      procedure Execute; override;
      procedure DoShowData;
      procedure DoShowErrors;
    public
      function IsTerminated:boolean;
     constructor Create(aProcSharedInfo:TProcSharedInfo);
  end;

implementation

constructor TDebugStringThread.Create(aProcSharedInfo:TProcSharedInfo);
begin
  procSharedInfo := aProcSharedInfo;
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TDebugStringThread.DoShowData;
begin
  if Assigned(procSharedInfo) then
    procSharedInfo(SharedProcessId, SharedMessage);
end;

procedure TDebugStringThread.DoShowErrors;
begin
 ErrsMess := '';
end;

procedure TDebugStringThread.Execute;
var
  SharedMem: Pointer;
  SharedFile: THandle;
  WaitingResult: DWORD;
  DataReadyEvent: THandle;
  BufferReadyEvent: THandle;
  SecurityAttributes: SECURITY_ATTRIBUTES;
  SecurityDescriptor: SECURITY_DESCRIPTOR;
  SharedMemory : Pointer;
  TempString : String;
  SharedBuffer: PDbWinBuffer;
begin
  ErrsMess := '';

  SecurityAttributes.nLength := SizeOf(SECURITY_ATTRIBUTES);
  SecurityAttributes.bInheritHandle := True;
  SecurityAttributes.lpSecurityDescriptor := @SecurityDescriptor;

  if not InitializeSecurityDescriptor(@SecurityDescriptor, SECURITY_DESCRIPTOR_REVISION) then
    Exit;

  if not SetSecurityDescriptorDacl(@SecurityDescriptor, True, nil, False) then
    Exit;

  // Event: buffer ready
  BufferReadyEvent := OpenEvent(EVENT_ALL_ACCESS, FALSE, 'DBWIN_BUFFER_READY');
  if BufferReadyEvent = 0 then begin
    BufferReadyEvent := CreateEvent(nil, FALSE, TRUE, 'DBWIN_BUFFER_READY');
    if BufferReadyEvent = 0 then begin
      ErrsMess := SysErrorMessage(GetLastError);
      Exit;
    end;
  end;

  // Event: data ready
  DataReadyEvent := OpenEvent(_SYNCHRONIZE, FALSE, 'DBWIN_DATA_READY');
  if DataReadyEvent = 0 then begin
    DataReadyEvent := CreateEvent(nil, FALSE, FALSE, 'DBWIN_DATA_READY');
    if DataReadyEvent = 0 then begin
      ErrsMess := SysErrorMessage(GetLastError);
    end;
  end;

  // Shared memory
  SharedFile := OpenFileMapping(FILE_MAP_READ, FALSE, 'DBWIN_BUFFER');
  if SharedFile = 0 then begin
    SharedFile := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(DbWinBuffer), 'DBWIN_BUFFER');
    if SharedFile = 0 then begin
      ErrsMess := SysErrorMessage(GetLastError);
      Exit;
    end;
  end;

  SharedMem := MapViewOfFile(SharedFile, FILE_MAP_READ,  0, 0, 512);
  if not Assigned(SharedMem) then begin
    ErrsMess := SysErrorMessage(GetLastError);
    Synchronize(DoShowErrors);
    Exit;
  end;

  SharedMemory := MapViewOfFile(SharedFile, SECTION_MAP_READ, 0, 0, 1024);
  if not Assigned(SharedMemory) then begin
    ErrsMess := SysErrorMessage(GetLastError);
    Synchronize(DoShowErrors);
  end;

  SharedBuffer := PDbWinBuffer(MapViewOfFile(SharedFile, SECTION_MAP_READ, 0, 0, 0));

  while (not Terminated) and (not Application.Terminated) do begin
    SetEvent(BufferReadyEvent);
    WaitingResult := WaitForSingleObject(DataReadyEvent, INFINITE);

    case WaitingResult of
      WAIT_TIMEOUT: Continue;
      WAIT_OBJECT_0:
        begin
          try
            SharedProcessId := SharedBuffer^.dwProcessId;
            TempString := '';
            SharedMessage := TempString + String(PAnsiChar(SharedMem) + SizeOf(DWORD));
            Synchronize(DoShowData);
          finally
            //
          end;
        end;

      WAIT_FAILED: Continue;
    end;
  end;

   UnmapViewOfFile(SharedMem);
   CloseHandle(SharedFile);
end;

function TDebugStringThread.IsTerminated: boolean;
begin
  Result := TDebugStringThread.CheckTerminated;
end;

end.
