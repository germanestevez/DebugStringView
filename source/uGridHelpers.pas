unit uGridHelpers;

interface

uses
  System.Types, System.Classes, Data.DB,
  VCL.StdCtrls, VCL.Graphics, VCL.Grids, VCL.DBGrids;

type
  /// <summary> Clase con funciones de ayuda a los Tstringgrid/DBGrid </summary>
  TGridHelper = class
    /// <summary> Alinear textoi en una ceklda (TStringGrid) </summary>
    class function Align(aCanvas:TCanvas; aRect:TRect; aText:string; aAlign: TAlignment):integer;
    /// <summary> Obtener la columna del grid (DBGrid) a partir del nombre del campo asignado </summary>
    class function GetColumnByFieldName(DBGrid: TDBGrid; const FieldName: string): TColumn;
    /// <summary> Colorear una fila de un TStringGrid/DbGrid  </summary>
    class procedure DoColorLine(sgGrid:TCustomGrid; aRect:TRect; aColor:TColor;  aText:string; aField:TField);
    /// <summary> Ajustar el ancho de la columna definida para que ocupe el espacio disponible </summary>
    class procedure AutoajustarAnchoColumna(aDBGrid: TDBGrid; aColumnaName:string);
  end;

implementation

{ TGridHelper }

class procedure TGridHelper.AutoajustarAnchoColumna(aDBGrid: TDBGrid; aColumnaName:string);
begin
  // Ajustar la columna de mensaje
  var iSize:integer := 0;
  for var i := 0 to (aDBGrid.Columns.Count - 1) do begin
    if (aDBGrid.Columns[i].Visible) and (aDBGrid.Columns[i].FieldName <> aColumnaName) then
      iSize := iSize + aDBGrid.Columns[i].Width + 2;
  end;

  // Encontra la columna de mensaje
  for var i := 0 to (aDBGrid.Columns.Count - 1) do
    if (aDBGrid.Columns[i].FieldName = aColumnaName) then
      aDBGrid.Columns[i].Width := aDBGrid.Width - iSize{las otras} - (16*2) {scrollbar};
end;

class procedure TGridHelper.DoColorLine(sgGrid:TCustomGrid{TStringGrid}; aRect:TRect; aColor:TColor; aText:string; aField:TField);
begin

  var p:integer := aRect.Left;
  var ACanvas:TCanvas;
  if (sgGrid is TStringGrid) then
    ACanvas := TStringGrid(sgGrid).Canvas
  else
    ACanvas := TDBGrid(sgGrid).Canvas;

  // color de fondo
  ACanvas.Brush.Color := aColor;
  ACanvas.FillRect(aRect);
  // color de fuente
  ACanvas.Font.Color := clBlack;

  // realizar el pintado del texto con color de fondo
  if (sgGrid is TStringGrid) then
    ACanvas.TextRect(aRect, p, aRect.Top+2, aText)
  else if (sgGrid is TDBGrid) then
    TDBGrid(sgGrid).DefaultDrawDataCell(aRect, aField, []);
end;

class function TGridHelper.GetColumnByFieldName(DBGrid: TDBGrid; const FieldName: string): TColumn;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns[i].FieldName = FieldName then
    begin
      Result := DBGrid.Columns[i];
      Exit;
    end;
  end;
end;

class function TGridHelper.Align(aCanvas:TCanvas; aRect: TRect; aText: string; aAlign: TAlignment):integer;
var
  WidthOfText: integer;
  WidthOfCell: integer;
begin
  WidthOfText := aCanvas.TextWidth(aText);
  WidthOfCell := aRect.Right - aRect.Left;
  if aAlign = TAlignment.taRightJustify then
    Result := aRect.Left + (WidthOfCell - WidthOfText) - 2
  else if aAlign = TAlignment.taCenter then
    Result := aRect.Left + ((WidthOfCell - WidthOfText) DIV 2) + 1
  else
    Result := aRect.Left + 2;
end;

end.
