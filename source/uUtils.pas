unit uUtils;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.Generics.Collections, System.UITypes, System.Math, VCL.CheckLst, VCL.Menus, VCL.ComCtrls;

type
  /// <summary> Clase con utilidades para trabajar con colores </summary>
  TColorUtils = class
    /// <summary> Generar un color  aleatorio </summary>
    class function GenerarColorAleatorio:TColor;
    /// <summary> Generar una lista con 100 colores aleatorios </summary>
    class procedure GenerarColoresAleatorios(var ListaColores: TList<TColor>; aNumber:integer=100);
    /// <summary> Modificar un clor para convertirlo a tonos "pastel" </summary>
    class function ConvertirAPastel(Color: TColor; Factor: Double): TColor;
    /// <summary> Aumentar el brillo a un color dado </summary>
    class function AumentarBrillo(Color: TColor; Factor: Double {1.5}): TColor;
  end;

  /// <summary> Utilidades sobre strings </summary>
  TStringUtils = class
    class function PadRight(const Input: string; Length: Integer): string;
  end;


  TSelType = (stAll, stNone, stInvert);
  /// <summary> Clase para gestionar las operacoines de selección en u TCheckListBox (all, None, Invert)  </summary>
  TListboxUtils = class
    class procedure ChangeSelection(aListbox:TCheckListbox; aSelectionType:TSelType);
  end;

  /// <summary> Clase con funcionas para fuentes de letra </summary>
  TFontUtils = class
    class function GetFontActive(aMenuItem:TMenuItem):string;
    class function SetActiveFont(aMenuItem:TMenuItem; aFontName:string):TMenuItem;
  end;

  /// <summary> procedimiento para un progreso </summary>
  TProgressProc = procedure (const iStep, iTotal:integer) of object;

  /// <summary> Gestiona la visualización de un progressbar (opcional dentro de un panel del Statusbar) </summary>
  TProcessProgress = class
  private
    FPanelIndex:integer;
    FProgressbar:TProgressbar;
    FStatusbar:TStatusbar;
  public
    constructor Create (aProgressbar:TProgressbar; aStatusbar:TStatusbar=nil; const iPanel:integer=0);
    procedure Ini;
    procedure Step(const iStep, iTotal:integer);
    procedure Fin;
  end;

// version del programa en formato String
function GetAppVersion(AExeName:string=''; FormatoCorto:Boolean=False): string;
// Comprueba el valor nulo antes de asignarlo
function AssignIfNotEmpty(aValue:Variant; aDefaultValue:Variant): Variant;
// compara 2 versiones de programa almacenas en formato string
// 1  -> primera mayor    // -1 -> segunda mayor    // 0  -> versiones iguales
function CompareVersions(const Version1, Version2: string): Integer;



implementation

uses
  CommCtrl, Forms, System.StrUtils;

function AssignIfNotEmpty(aValue:Variant; aDefaultValue:Variant): Variant;
begin
  Result := aDefaultValue;
  if aValue <> string.Empty then
    Result := aVAlue;
end;

class function TStringUtils.PadRight(const Input: string; Length: Integer): string;
begin
  if Length > System.Length(Input) then
    Result := Input + StringOfChar(' ', Length - System.Length(Input))
  else
    Result := Input;
end;

class function TColorUtils.ConvertirAPastel(Color: TColor; Factor: Double): TColor;
var
  R, G, B: Byte;
begin
  R := GetRValue(Color);
  G := GetGValue(Color);
  B := GetBValue(Color);

  R := Min(255, Trunc((R + 255) / Factor));
  G := Min(255, Trunc((G + 255) / Factor));
  B := Min(255, Trunc((B + 255) / Factor));

  Result := RGB(R, G, B);
end;

class function TColorUtils.AumentarBrillo(Color: TColor; Factor: Double {1.5}): TColor;
var
  R, G, B: Byte;
begin
  R := GetRValue(Color);
  G := GetGValue(Color);
  B := GetBValue(Color);

  R := Min(255, Round(R * Factor));
  G := Min(255, Round(G * Factor));
  B := Min(255, Round(B * Factor));

  Result := RGB(R, G, B);
end;

class function TColorUtils.GenerarColorAleatorio:TColor;
begin
  Randomize; // Inicializa el generador de números aleatorios
  Result := RGB(Random(256), Random(256), Random(256));
end;

class procedure TColorUtils.GenerarColoresAleatorios(var ListaColores: TList<TColor>; aNumber:integer=100);
begin
  for var i := 1 to aNumber do
    ListaColores.Add(TColorUtils.GenerarColorAleatorio);
end;

// 1  -> primera mayor
// -1 -> segunda mayor
// 0  -> versiones iguales
function CompareVersions(const Version1, Version2: string): Integer;
var
  Parts1, Parts2: TArray<string>;
  I, Num1, Num2: Integer;
begin
  Parts1 := Version1.Split(['.']);
  Parts2 := Version2.Split(['.']);

  // Completar si alguno tiene menos...
  for i := Length(Parts1) to 3 do begin
    SetLength(Parts1, i+1);
    Parts1[i] := '0';
  end;
  for i := Length(Parts2) to 3 do begin
    SetLength(Parts2, i+1);
    Parts2[i] := '0';
  end;

  // comparar
  for I := 0 to Min(Length(Parts1), Length(Parts2)) - 1 do  begin
    Num1 := StrToIntDef(Parts1[I], 0);
    Num2 := StrToIntDef(Parts2[I], 0);

    if Num1 > Num2 then
      Exit(1)
    else if Num1 < Num2 then
      Exit(-1);
  end;

  if Length(Parts1) > Length(Parts2) then
    Exit(1)
  else if Length(Parts1) < Length(Parts2) then
    Exit(-1);

  Result := 0; // Las versiones son iguales
end;

// version del programa en formato String
function GetAppVersion(AExeName:string=''; FormatoCorto:Boolean=False): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  Result := '';
  if (AExeName = '') then begin
    AExeName := ParamStr(0);
  end;
  VerInfoSize := GetFileVersionInfoSize(PChar(AExeName), Dummy);
  if VerInfoSize = 0 then Exit;
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(AExeName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    // Si no es formato corto, añadimos los 2 ultimos
    if (not FormatoCorto) then begin
      Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
      Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
    end;
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

{ TListboxUtils }

class procedure TListboxUtils.ChangeSelection(aListbox: TCheckListbox; aSelectionType: TSelType);
begin
  for var i := 0 to (aListbox.Count - 1) do
    case aSelectionType of
      stAll:    aListbox.Checked[i] := True;
      stNone:   aListbox.Checked[i] := False;
      stInvert: aListbox.Checked[i] := not aListbox.Checked[i];
    end;
end;

{ TFontUtils }

class function TFontUtils.GetFontActive(aMenuItem: TMenuItem): string;
begin
  Result := string.Empty;
  for var i := 0 to (aMenuItem.Count - 1) do
    if (aMenuItem[i].Checked) then
      Result := aMenuItem[i].Caption;
end;

class function TFontUtils.SetActiveFont(aMenuItem: TMenuItem; aFontName: string):TMenuItem;
begin
  Result := nil;
  for var i := 0 to (aMenuItem.Count - 1) do
    if (aMenuItem[i].Caption = aFontName) or (aMenuItem[i].Caption = AnsiReplaceText(aFontName, '&', '')) then begin
      aMenuItem[i].Checked := True;
      Result := aMenuItem[i];
      Break;
    end;
end;

{ TProcessProgress }

constructor TProcessProgress.Create(aProgressbar:TProgressbar; aStatusbar:TStatusbar; const iPanel:integer);
begin
  inherited Create;
  FPanelIndex := iPanel;
  FProgressbar := aProgressbar;
  FStatusbar := aStatusbar;
end;

procedure TProcessProgress.Fin;
begin
  FProgressBar.Visible := False;
end;

procedure TProcessProgress.Ini;
var
  PanelRect: TRect;
begin
  if Assigned(FStatusbar) then begin
    // Recolocar
    FProgressBar.Parent := FStatusBar;
    FStatusBar.Perform(SB_GETRECT, FPanelIndex, LPARAM(@PanelRect)); // Obtener las coordenadas del n panel
    FProgressBar.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right - PanelRect.Left - 1, PanelRect.Bottom - PanelRect.Top);
  end;
  FProgressBar.Min := 0;
  FProgressBar.Max := 100;
  FProgressBar.Position := FProgressBar.Min;
  FProgressBar.Visible := True;
end;

procedure TProcessProgress.Step(const iStep, iTotal: integer);
begin
  FProgressBar.Max := iTotal;
  FProgressBar.Position := Min(iStep, FProgressBar.Max);   // modo paranoico
  Application.ProcessMessages;
end;

end.
