unit uBookmarks.Classes;

interface

uses
  Data.DB,
  System.Classes;

type
  /// <summary> elemento de bookmark individual </summary>
  TBookmarkDSV = class
  private
    FNumero: integer;
    FID: integer;
    FDescripcion: string;
    FBook: TBookmark;
  public
    constructor Create(const ANumero, AId:integer; const ADesc:string; bm:TBookmark);

    function ToString:string; override;
    function FromString(const sBM:string):TBookmarkDSV;

    property Numero:integer read FNumero write FNumero;
    property ID:integer read FID write FID;
    property Descripcion:string read FDescripcion write FDescripcion;  // descripcion por parte del usuario
    property Book:TBookmark read FBook write FBook; // bookmark real
  end;

  /// <summary> Lista de bookmarjks creados </summary>
  TBookmarkListDSV = class(TStringList)
  public
    /// <summary> Añadir un nuevo bookmark </summary>
    procedure Add(const ANumero, AId:integer; const ADesc:string; ABookmark:TBookmark); reintroduce;
    /// <summary> Borrar un elemento de la lista </summary>
    procedure DeleteByNumero(ANumero:integer);
    /// <summary> Obtener el objeto completo a partir del índice </summary>
    function Get(const ANUmero:integer):TBookmarkDSV; reintroduce;
    /// <summary> Obtener el Tbookmark a partir del índice </summary>
    function GetByNumero(ANumero:integer):TBookmark;
    /// <summary> Limpia la lista de bookmarks </summary>
    procedure Clear; override;

    constructor Create;
  end;


implementation

uses
  System.SysUtils;

{ TBookmarkDSV }

constructor TBookmarkDSV.Create(const ANumero, AId: integer; const ADesc: string; bm:TBookmark);
begin
  inherited Create;
  FNumero := ANumero;
  FID := AId;
  FDescripcion := ADesc;
  FBook := bm;
end;

function TBookmarkDSV.ToString(): string;
begin
  Result := '//' + '~' + FNumero.ToString + '~' + FID.ToString + '~' + FDescripcion;
end;

function TBookmarkDSV.FromString(const sBM: string): TBookmarkDSV;
begin
  Result := Self;
  var TS:TStrings := TStringList.Create;
  try
    TS.Delimiter := '~';
    TS.StrictDelimiter := True;
    TS.DelimitedText := sBM;
    // extraer los valores
    FNumero := TS[1].ToInteger;
    FID := TS[2].ToInteger;
    FDescripcion := TS[3];
  finally
    FreeAndNil(TS);
  end;
end;

{ TBookmarkListDSV }

procedure TBookmarkListDSV.Add(const ANumero, AId: integer; const ADesc: string; ABookmark:TBookmark);
begin
  var bm := TBookmarkDSV.Create(ANumero, AId, ADesc, ABookmark);
  AddObject(ANumero.ToString, bm);
end;

procedure TBookmarkListDSV.Clear;
begin
  for var i := 0 to (Self.Count - 1) do begin
    if Assigned(Self.Objects[i]) then begin
      Self.Objects[i].Free;
      Self.Objects[i] := nil;
    end;
  end;
  inherited Clear;
end;

constructor TBookmarkListDSV.Create;
begin
  inherited;
  Duplicates := dupIgnore;
  Sorted := True;
  OwnsObjects := True;
end;

procedure TBookmarkListDSV.DeleteByNumero(ANumero:integer);
var
  index:integer;
begin
  var b := Find(ANumero.ToString, index);
  if (b) then begin
    // Objects[index].Free;            // se libera automaticamente
    TStringList(Self).Delete(index);
  end;
end;

function TBookmarkListDSV.Get(const ANumero: integer): TBookmarkDSV;
var
  index:integer;
begin
  Result := nil;
  if Find(ANumero.ToString, index) then
    Result := TBookmarkDSV(Objects[Index]);
end;

function TBookmarkListDSV.GetByNumero(ANumero: integer): TBookmark;
var
  index:integer;
begin
  Result := nil;
  var b := Find(ANumero.ToString, index);
  if (b) then
    Result := TBookmarkDSV(Objects[index]).FBook;
end;

end.
