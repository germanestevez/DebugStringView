unit FMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids,
  System.Actions, Vcl.ActnList, Vcl.Menus, System.ImageList, Vcl.ImgList, DKLang,
  Vcl.ExtCtrls, Vcl.CheckLst, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uProcessInformation, uTypes, uCaptureDebugString, uLog.Classes, uConfig.Classes, VCL.ExtDlgs,
  uFile.Classes, Vcl.Buttons,
  uRecursos, Vcl.Imaging.pngimage, Vcl.ToolWin, DKLangStorage;

type
  TFormMain = class(TForm)
    sbMain: TStatusBar;
    mmMain: TMainMenu;
    alMain: TActionList;
    actAbrir: TAction;
    actGuardar: TAction;
    actGuardarcomo: TAction;
    actSalir: TAction;
    actID: TAction;
    actFecha: TAction;
    actHora: TAction;
    actMensaje: TAction;
    actProcessId: TAction;
    Fichero1: TMenuItem;
    Abrir1: TMenuItem;
    Guardar1: TMenuItem;
    Guardarcomo1: TMenuItem;
    N1: TMenuItem;
    actSalir1: TMenuItem;
    Ver1: TMenuItem;
    Columns1: TMenuItem;
    Id1: TMenuItem;
    Fecha1: TMenuItem;
    Hora1: TMenuItem;
    ProcessId1: TMenuItem;
    Mensaje1: TMenuItem;
    actColorProceso: TAction;
    actAutoscroll: TAction;
    Autoscroll1: TMenuItem;
    Nmerodelnea1: TMenuItem;
    opciones1: TMenuItem;
    Fuentedeletra1: TMenuItem;
    Ayuda1: TMenuItem;
    actAyuda: TAction;
    actAcercaDe: TAction;
    Ayuda2: TMenuItem;
    Acercade1: TMenuItem;
    ilMain: TImageList;
    actActualizaciones: TAction;
    actListaProcesos: TAction;
    N2: TMenuItem;
    Listadeprocesos1: TMenuItem;
    DKLanguageController: TDKLanguageController;
    Actualizaciones1: TMenuItem;
    FontDialogView: TFontDialog;
    actColAutosize: TAction;
    Autowithcolumnas1: TMenuItem;
    actLimpiar: TAction;
    Limpiardebug1: TMenuItem;
    pnlOtros: TPanel;
    splOtros: TSplitter;
    pnlListaProcesos: TPanel;
    lblListaProcesos: TLabel;
    clbListaProcesos: TCheckListBox;
    splListaProcesos: TSplitter;
    pnlCentral: TPanel;
    mtMensajes: TFDMemTable;
    mtMensajesID: TIntegerField;
    mtMensajesFecha: TDateField;
    mtMensajesHora: TTimeField;
    mtMensajesProcessId: TIntegerField;
    mtMensajesNombre: TStringField;
    mtMensajesMensaje: TStringField;
    dsMensajes: TDataSource;
    actProcesssName: TAction;
    Captura1: TMenuItem;
    actPausar: TAction;
    actReanudar: TAction;
    pnlIDsProcs: TPanel;
    lblIdsProc: TLabel;
    lbIDsProcs: TListBox;
    Pausa1: TMenuItem;
    Reanudar1: TMenuItem;
    Courier1: TMenuItem;
    Courier2: TMenuItem;
    LucidaSans1: TMenuItem;
    LucidaSans2: TMenuItem;
    A3SansSerif1: TMenuItem;
    CascadiaMono1: TMenuItem;
    FiraCode1: TMenuItem;
    JetBrainsMono1: TMenuItem;
    SourceCodePro1: TMenuItem;
    erminal1: TMenuItem;
    erminal2: TMenuItem;
    FileSaveDialog: TFileSaveDialog;
    N4: TMenuItem;
    N3: TMenuItem;
    Slolosmensajesvisibles1: TMenuItem;
    actSoloVisibles: TAction;
    FileOpenDialog: TFileOpenDialog;
    Idiomas2: TMenuItem;
    pnlBotones: TPanel;
    btnInvertSelection: TButton;
    btnSelectNone: TButton;
    btnSelectAll: TButton;
    actSeleccionarTodos: TAction;
    actSeleccionarNinguno: TAction;
    InvertirSelecicon: TAction;
    mmLog: TMemo;
    dbgMensajes: TDBGrid;
    ImagePause: TImage;
    actBuscarActIniciar: TAction;
    pbProceso: TProgressBar;
    Buscaractualizacionesaliniciar1: TMenuItem;
    TimerUpdates: TTimer;
    pnlUpdate: TPanel;
    imgUpdate: TImage;
    lblNewVersion: TLabel;
    tbMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    imgClose: TImage;
    ToolButton10: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure actSalirExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actLimpiarExecute(Sender: TObject);
    procedure actListaProcesosExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure clbListaProcesosClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actFechaExecute(Sender: TObject);
    procedure actHoraExecute(Sender: TObject);
    procedure actPausarExecute(Sender: TObject);
    procedure actReanudarExecute(Sender: TObject);
    procedure clbListaProcesosClick(Sender: TObject);
    procedure actColorProcesoExecute(Sender: TObject);
    procedure actIDExecute(Sender: TObject);
    procedure CambiarFuenteFijaClick(Sender: TObject);
    procedure erminal2Click(Sender: TObject);
    procedure FontDialogViewApply(Sender: TObject; Wnd: HWND);
    procedure dbgMensajesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actGuardarExecute(Sender: TObject);
    procedure actGuardarcomoExecute(Sender: TObject);
    procedure sbMainClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure IdiomaClick(Sender: TObject);
    procedure actSoloVisiblesUpdate(Sender: TObject);
    procedure actSoloVisiblesExecute(Sender: TObject);
    procedure actAbrirExecute(Sender: TObject);
    procedure actAcercaDeExecute(Sender: TObject);
    procedure actSeleccionarTodosExecute(Sender: TObject);
    procedure actSeleccionarNingunoExecute(Sender: TObject);
    procedure InvertirSeleciconExecute(Sender: TObject);
    procedure lblListaProcesosDblClick(Sender: TObject);
    procedure actActualizacionesExecute(Sender: TObject);
    procedure TimerUpdatesTimer(Sender: TObject);
    procedure actBuscarActIniciarExecute(Sender: TObject);
    procedure pnlUpdateClick(Sender: TObject);
    procedure actAyudaExecute(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);

  private
    MsgIndex:integer;
    thCapture: TDebugStringThread;
    FPausado: boolean;
    FLog:ILog;
    FSave:ISaveDSToFile;
    FConfig:IConfig;
    FSavedFileName: TFileName;

    // ayudas ******************************************************************
    function GetHelpFileName:TFileName;

    // Menú de fichero *********************************************************
    // Grabar el fichero
    procedure InternalSaveFile(aFileName:TFileName);
    // fichero de configuración
    function GetConfigFileName:TFileName;

    // Procedimiento de log interno ********************************************
    procedure Log(const aMensaje:string);

    // Métodos iniciales y de configuracion ************************************
    procedure ConfigureVisualControls;
    procedure ConfigureActions;
    procedure IniData;

    // Actualizar en ejecución partes del programa *****************************
    procedure UpdateProcessList(const aProcessId:integer);
    procedure UpdateStatusBar;
    procedure UpdateCaption;

    // Configuracion ***********************************************************
    procedure RestoreConfiguration;
    procedure SaveConfiguration;

    // Languages/Idiomas *******************************************************
    procedure CambiarIdioma(aID:integer);
    procedure ScanLanguages;
    procedure FillLanguagesMenu(aMenuIdiomas:TMenuItem);

    // Procesos ****************************************************************
    procedure FilterMessagesByProcesses;
    function HayFiltroActivo:boolean;
    function GetColorPorProceso: boolean;
    // actualiza la lista de IDs de un proceso
    procedure InternalUpdateProcessIdList(const aProcessName:string);

    // Visualización de mensajes ***********************************************
    procedure MostrarOcultarColumna(Sender: TObject; aFieldName:string);
    procedure CambiarFuenteLetra(const aFuenteActual:string; const aFuenteNueva:string = string.Empty);

    // Proceso de captura y visualización **************************************
    procedure SetPausado(const Value: boolean);
    // Procedimiento para mostrar losmensajes que llegan desde debug
    procedure ProcSharedInfo(const aProcessId:Word; const aMensaje:string);
  public
    /// <summary> Si la captura de mensajes está pausada o no </summary>
    property Pausado:boolean read FPausado write SetPausado default False;
    /// <summary> Nombre del fichero (si ya se ha guardado) </summary>
    property SavedFileName:TFileName read FSavedFileName write FSavedFileName;
    /// <summary> Si tenemos activado la coloracion por proceso </summary>
    property ColorPorProceso:boolean read GetColorPorProceso;
  end;

var
  FormMain: TFormMain;

const
  TITLEAPP = 'DebugStringView';
  HELP_FILE = 'Help.pdf';
  AYUDA_FILE = 'Ayuda.pdf';


implementation

{$R *.dfm}

uses
  System.StrUtils, System.UITypes, FAcercaDe, ShellAPI, System.IOUtils,
  uUtils, uGridHelpers, uUpdates;

procedure TFormMain.Log(const aMensaje:string);
begin
  if not Assigned(FLog) then
    Exit;
  FLog.Log(aMensaje);
end;

 
procedure TFormMain.actAbrirExecute(Sender: TObject);
begin
  // Abrir un fichero de disco

  // Desactivar la capotura de mensajes

  // Rellenar procesos


end;

procedure TFormMain.actAcercaDeExecute(Sender: TObject);
begin
  with TFormAcercaDe.Create(nil) do begin
    ShowModal;
    Free;
  end;
end;

// NOTA: Si el sender es NIL, es que llega del Timer...
procedure TFormMain.actActualizacionesExecute(Sender: TObject);
begin
  // vuscar actualizaciones
  var upd := TFactoryUpdate.GetClass(TWebUpdateSearch{TDummyUpdateSearch});
  var res:TUpdatesResponse := upd.FindUpdates;
  if (res = TUpdatesResponse.urFindedUpdate) then begin
    // Opcion 1: mensaje
    pnlUpdate.Visible := True;
    lblNewVersion.Caption := Format(DKLangConstW('msgNewVersion'), [TBaseUpdateSearch(upd).VersionDescargada]);
    {
    // Opcion 2: pregunta al usuario
    if (MessageBox(0, PChar(Format(msg_Updates,[upd.GetVersionDescargada])), PChar(msgUpdatesTitle), MB_ICONINFORMATION or MB_YESNO) = idYes) then
      TBaseUpdateSearch(upd).OpenUpdateWeb;
    }
  end
  else begin
    // Si se ha llamadoexprésamente, sacamos mensaje
    if Assigned(Sender) then
      MessageBox(0, PChar(DKLangConstW('msgNoUpdates')), PChar(DKLangConstW('msgUpdatesTitle')), MB_ICONINFORMATION or MB_OK);
  end;
end;

procedure TFormMain.actAyudaExecute(Sender: TObject);
begin
  // La ayuda se muestra en Inglés o es Castellano
  Log('Language.ID=' + LangManager.LanguageID.ToString);
  var fName := GetHelpFileName;
  Log(fName);
  if FileExists(fName) then
    ShellExecute(HInstance, 'open', PChar(fName), nil, nil, SW_NORMAL);
end;

procedure TFormMain.actBuscarActIniciarExecute(Sender: TObject);
begin
  // Usa un timer
end;

procedure TFormMain.actColorProcesoExecute(Sender: TObject);
begin
  // colorear por prpoceso
  dbgMensajes.Invalidate;
end;

procedure TFormMain.InternalSaveFile(aFileName:TFileName);
begin

  var progress := TProcessProgress.Create(pbProceso, sbMain, 4);
  try
    // generar el objeto de grabación
    if not Assigned(FSave) then
      FSave := TFactorySave.GetClass(TSaveDSToFIle);
    progress.Ini;
    TSaveDSToFile(FSave).OnProgress := progress.Step;

    try
      // Nombre del fichero
      if (aFileName = String.Empty) then begin
        // // Uno por defecto y luego el dialogo
        FileSaveDialog.FileName := TSaveDSToFIle.GetFileName;

        var b := FileSaveDialog.Execute;
        if (not b) then begin
          Log('Grabación cancelada');
          Exit;
        end;
      end
      else begin
        FileSaveDialog.FileName := FSavedFileName;
      end;
      Log('Se va a grabar en el fichero: ' + FileSaveDialog.FileName);

      FSave.SetLog(FLog);
      FSave.SetDataset(mtMensajes);
      FSave.Save(FileSaveDialog.FileName);

      // Una vez guardado nos quedamos con el nombre del fichero
      FSavedFileName := FileSaveDialog.FileName;

    except
      on E:Exception do begin
        Log(DKLangConstW('err_guardarFichero') + E.Message);
        raise Exception.Create(DKLangConstW('err_guardarFichero') + sLineBreak + E.Message);
      end;
    end;
  finally
    progress.Fin;
    FreeAndNil(progress);
  end;
end;

procedure TFormMain.actGuardarcomoExecute(Sender: TObject);
begin
  InternalSaveFile(string.Empty);
  UpdateCaption;
end;

procedure TFormMain.actGuardarExecute(Sender: TObject);
begin
  InternalSaveFile(FSavedFileName);
  UpdateCaption;
end;

procedure TFormMain.MostrarOcultarColumna(Sender: TObject; aFieldName:string);
begin
  var col:TColumn := TGridHelper.GetColumnByFieldName(dbgMensajes, aFieldName);
  if Assigned(col) then
    col.Visible := TAction(Sender).Checked;
  TGridHelper.AutoajustarAnchoColumna(dbgMensajes, 'Mensaje');
end;

procedure TFormMain.pnlUpdateClick(Sender: TObject);
begin
  TWebUpdateSearch.OpenUpdateWeb;
  pnlUpdate.Visible := False;
end;

procedure TFormMain.actHoraExecute(Sender: TObject);
begin
  // Campo hora
  MostrarOcultarColumna(Sender, 'Hora');
end;


procedure TFormMain.actFechaExecute(Sender: TObject);
begin
  // Campo fecha
  MostrarOcultarColumna(Sender, 'Fecha');
end;

procedure TFormMain.actIDExecute(Sender: TObject);
begin
  MostrarOcultarColumna(Sender, 'ID');
end;

procedure TFormMain.actLimpiarExecute(Sender: TObject);
begin
  // limpiar los mensajes actuales
  mtMensajes.EmptyDataSet;
  // Limpiar la lista de procesos
  ListaProcesos.Clear;
  // Limpiar el componente de lista de procesos
  clbListaProcesos.Clear;
  // Limpiar el filtro si lo hay
  FilterMessagesByProcesses;
end;

procedure TFormMain.actListaProcesosExecute(Sender: TObject);
begin
  // Panel de Lista de procesos
  pnlOtros.Visible := actListaProcesos.Checked;
  // Ajustar el splitter
  splOtros.Left := splOtros.Left - pnlOtros.Width - 20;
  // Ajustar la columna de mensaje
  TGridHelper.AutoajustarAnchoColumna(dbgMensajes, 'Mensaje');
end;

procedure TFormMain.actPausarExecute(Sender: TObject);
begin
  // Pausar la captura
  Pausado := True;
end;

procedure TFormMain.actReanudarExecute(Sender: TObject);
begin
  // reanudar la captura
  Pausado := False
end;

procedure TFormMain.actSalirExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.InvertirSeleciconExecute(Sender: TObject);
begin
  // Invert selection
  TListboxUtils.ChangeSelection(clbListaProcesos, TSelType.stInvert);
  FilterMessagesByProcesses;
end;

procedure TFormMain.lblListaProcesosDblClick(Sender: TObject);
begin
  mmLog.Visible := not mmLog.Visible;
end;

procedure TFormMain.actSeleccionarNingunoExecute(Sender: TObject);
begin
  // unselect All
  TListboxUtils.ChangeSelection(clbListaProcesos, TSelType.stNone);
  FilterMessagesByProcesses;
end;

procedure TFormMain.actSeleccionarTodosExecute(Sender: TObject);
begin
  // SelectAll
  TListboxUtils.ChangeSelection(clbListaProcesos, TSelType.stAll);
  FilterMessagesByProcesses;
end;

procedure TFormMain.actSoloVisiblesExecute(Sender: TObject);
begin
  // Autocheck
end;

procedure TFormMain.actSoloVisiblesUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := HayFiltroActivo;
end;

procedure TFormMain.clbListaProcesosClickCheck(Sender: TObject);
begin
  FilterMessagesByProcesses;
end;

procedure TFormMain.ConfigureActions;
begin
  actReanudar.Enabled := Pausado;
  actPausar.Enabled := not Pausado;
end;

procedure TFormMain.ConfigureVisualControls;
begin
  // Títulos para la Columnas del grid
  UpdateCaption;
  // Panel de IDs (sólo debug) - no interesa
  pnlIDsProcs.Visible := False;
  splListaProcesos.Visible := False;
  pnlListaProcesos.Align := alClient;
  pnlUpdate.Visible := False;

  // Columna de mensaje
  TGridHelper.AutoajustarAnchoColumna(dbgMensajes, 'Mensaje');

end;

type
  TCustomDBGridCracker = class(TCustomDBGrid);

procedure TFormMain.dbgMensajesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  aColor:TColor;
begin

  // Imagen de pausado si es necesario
  if Pausado then begin
    // Dibujar la imagen en el canvas del DBGrid
    TDBGrid(Sender).Canvas.StretchDraw(TRect.Create(10, 10, 150, 150), ImagePause.Picture.Graphic);
    Exit;
  end;

  // Si no está activado, salimos...
  if not ColorPorProceso then
    Exit;

  if (gdSelected in State) or (gdRowSelected in State) then
    aColor := clHighlight // Color de fondo de la fila seleccionada
  else
    // aColor := clInfoBk;
    aColor := ListaProcesos.GetColorByName(TDBGrid(Sender).DataSource.DataSet.FieldByName('ProcessName').AsString);
  TGridHelper.DoColorLine(TDBGrid(Sender), Rect, aColor, Column.Field.AsString, Column.Field)
end;

procedure TFormMain.erminal2Click(Sender: TObject);
begin
  CambiarFuenteLetra(dbgMensajes.Font.Name, string.Empty);
end;

procedure TFormMain.CambiarFuenteLetra(const aFuenteActual:string; const aFuenteNueva:string = string.Empty);
begin
  var fName := AnsiReplaceText(aFuenteNueva, '&', string.empty);
  if (fName <> string.empty) then begin
    // ************ DBGRid ************************
    dbgMensajes.Font.Name := fName;
    dbgMensajes.TitleFont.Name := fName;
  end
  else begin
    FontDialogView.Font.Name := fName;
    var b := FontDialogView.Execute;
    if (not b) then
      Exit;
    // Asignar las propiedades de la fuente
    // ************ DBGrid ************************
    dbgMensajes.Font.Name := FontDialogView.Font.Name;
    dbgMensajes.Font.Size := FontDialogView.Font.Size;
    dbgMensajes.Font.Color := FontDialogView.Font.Color;
    dbgMensajes.Font.Style := FontDialogView.Font.Style;
  end;
end;

procedure TFormMain.CambiarFuenteFijaClick(Sender: TObject);
begin
  // Si ha pulsado el mismo, lo activamos y salimos...
  if not TMenuItem(Sender).Checked then begin
    TMenuItem(Sender).Checked := True;
    Exit;
  end;

  var fName := TMenuItem(Sender).Caption;
  CambiarFuenteLetra(dbgMensajes.Font.Name, fName);
end;

function TFormMain.HayFiltroActivo:boolean;
begin
  Result := False;
  try
    for var i := 0 to (clbListaProcesos.Count - 1) do begin
      if (not clbListaProcesos.Checked[i]) then begin
        Result := True;
        Break;
      end;
    end;
  finally
    Log('Hay Filtro: ' + BoolToStr(Result, True));
  end;
end;

procedure TFormMain.FilterMessagesByProcesses;
var
  sFiltro:string;
const
  INIFILTER = '(PROCESSNAME <> ''~♀6~'')';
  FILTERTEMPLATE = ' AND (%s <> %s)';
  FIELDNAME = 'PROCESSNAME';
begin
  try
    // Si no hay filtro, False y salimos...
    if not HayFiltroActivo then begin
      mtMensajes.Filtered := False;
      Exit;
    end;

    // Valor del filtro
    sFiltro := INIFILTER;
    for var i := 0 to (clbListaProcesos.Count - 1) do
      if (not clbListaProcesos.Checked[i]) then
        sFiltro := sFiltro + Format(FILTERTEMPLATE, [FIELDNAME, QuotedStr(clbListaProcesos.items[i])]);

    Log('Filtro= ' + sFiltro);

    // Activarlo
    mtMensajes.Filter := sFiltro;
    mtMensajes.Filtered := True;
  finally
    // Update statusbar
    UpdateStatusBar;
  end;
end;

procedure TFormMain.FontDialogViewApply(Sender: TObject; Wnd: HWND);
begin
  Log('ClassName=' + Sender.ClassName);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Pausado := True;
  SaveConfiguration;
  if thCapture.Started then
    thCapture.Terminate;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Log('+TFormMain.FormCreate');
  FSavedFileName := string.Empty;

  // Lista de procesos
  ListaProcesos := TProcessList.Create(FLog);
  // Arrancar la captura
  thCapture := TDebugStringThread.Create(ProcSharedInfo);
  thCapture.FreeOnTerminate := True;
  // Clase para log
  FLog := TFactoryLog.GetClass(TLogMemo);
  TLogMemo(FLog).Memo := mmLog;
  // Clave para configuraciones
  FConfig := TFactoryConfig.GetClass(TFileConfig);
  TFileConfig(FConfig).FileName := GetConfigFileName;

  Log('+TFormMain.FormCreate');
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  if Assigned(ListaProcesos) then
    FreeAndNil(ListaProcesos);
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  TGridHelper.AutoajustarAnchoColumna(dbgMensajes, 'Mensaje');  
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  // Inicalizar el Dataset
  IniData;
  // Controles visuales
  ConfigureVisualControls;
  // Configuracones relacionadas con las acciones
  ConfigureActions;
  // Multiidioma; Revisar ficeros en la carpetra LAnguages
  ScanLanguages;
  // Crear el menú de idiomas
  FillLanguagesMenu(Idiomas2);
  // Actualizar Statusbar
  UpdateStatusBar;
  // Recuperar configuraciones alamacenadas
  RestoreConfiguration;
end;

function TFormMain.GetColorPorProceso: boolean;
begin
  Result := actColorProceso.Checked;
end;

function TFormMain.GetConfigFileName: TFileName;
begin
  var fPath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(TPath.GetHomePath) + 'DebugStringView');
  ForceDirectories(fPath);
  var fName := ChangeFileExt(ExtractFileName(ParamStr(0)), '.cfg');
  Result := fPath + fName;
  Log('FConfigNAme=' + Result);
end;

function TFormMain.GetHelpFileName: TFileName;
begin
  var path := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Help');
  // Distingue entre Español/Inglés
  if LangManager.LanguageID=2057 then
    Result := path + HELP_FILE
  else
    Result := path + AYUDA_FILE;
  Log('Ayuda=' + Result);
end;

procedure TFormMain.CambiarIdioma(aID:integer);
begin
  var iIndex := aID;
  if iIndex<0 then iIndex := 0; // When there's no valid selection in cbLanguage we use the default language (Index=0)
  LangManager.LanguageID := LangManager.LanguageIDs[iIndex];
end;

procedure TFormMain.IdiomaClick(Sender: TObject);
begin
  // Usamos el TAG para detectar el idioma seleccionado. Se asignar al ecrear los elementos del menú
  var id:integer := TMenuItem(Sender).Tag;
  CambiarIdioma(id);
end;

procedure TFormMain.imgCloseClick(Sender: TObject);
begin
  pnlUpdate.Visible := False;
end;

procedure TFormMain.IniData;
begin
  MsgIndex := 0;
  mtMensajes.Open;
end;

// Procedimiento para mostrar losmensajes que llegan desde debug
procedure TFormMain.ProcSharedInfo(const aProcessId:Word; const aMensaje:string);
begin

  // Si está pausado, salimos...
  if Pausado then
    Exit;
  if not Assigned(thCapture) then
    Exit;

  Inc(MsgIndex);

  // crear la información del proceso y actualizar la lista
  UpdateProcessList(aProcessId);

  // ***************************  DBGRID ****************************************
  try
    mtMensajes.DisableControls;
    try
      var pName := ExtractFileName(TProcessUtils.GetProcessNameByPID(aProcessId));
      // Añadir el registro
      mtMensajes.Append;
      mtMensajesID.AsInteger := MsgIndex;
      mtMensajesFecha.AsString := DateToStr(Date);
      mtMensajesHora.AsString := TimeToStr(Time);
      mtMensajesProcessId.AsInteger := aProcessId;
      mtMensajesNombre.AsString := pName;
      mtMensajesMensaje.AsString := aMensaje;
      mtMensajes.Post;
    finally
      mtMensajes.EnableControls;
    end;
  except
    Log('ERROR al añadir (DBGrid)');
  end;

  UpdateStatusBar;
end;

procedure TFormMain.RestoreConfiguration;
begin
  if not FileExists(GetConfigFileName) then
    Exit;
  try
    // Cargar datos almacenados
    FConfig.RestoreConfig;
    // Añadir datos a guardar; Tamaños y ubicaciones
    Left := AssignIfNotEmpty(FConfig.GetItem('MainLeft'), Left);
    Top := AssignIfNotEmpty(FConfig.GetItem('MainTop'), Top);
    Width := AssignIfNotEmpty(FConfig.GetItem('MainWidth'), Width);
    Height := AssignIfNotEmpty(FConfig.GetItem('MainHeight'), Height);
    pnlOtros.Width := AssignIfNotEmpty(FConfig.GetItem('OtrosWidth'), pnlOtros.Width);
    // Estado de las acciones
    actSoloVisibles.Checked := StrToBoolDef(FConfig.GetItem('actSoloVisiblesChecked'), actSoloVisibles.Checked);
    actSoloVisiblesExecute(actSoloVisibles);
    actAutoscroll.Checked := StrToBoolDef(FConfig.GetItem('actAutoscrollChecked'), actAutoscroll.Checked);
    actListaProcesos.Checked := StrToBoolDef(FConfig.GetItem('actListaProcesosChecked'), actListaProcesos.Checked);
    actListaProcesosExecute(actListaProcesos);
    actColorProceso.Checked := StrToBoolDef(FConfig.GetItem('actColorProcesoChecked'), actColorProceso.Checked);
    actColorProcesoExecute(actColorProceso);
    // Estado de las columnas (visibles)
    actID.Checked := StrToBoolDef(FConfig.GetItem('actIDChecked'), actID.Checked);
    TGridHelper.GetColumnByFieldName(dbgMensajes, 'ID').Visible := actID.Checked;
    actFecha.Checked := StrToBoolDef(FConfig.GetItem('actFechaChecked'), actFecha.Checked);
    TGridHelper.GetColumnByFieldName(dbgMensajes, 'Fecha').Visible := actFecha.Checked;
    actHora.Checked := StrToBoolDef(FConfig.GetItem('actHoraChecked'), actHora.Checked);
    TGridHelper.GetColumnByFieldName(dbgMensajes, 'Hora').Visible := actHora.Checked;
    // Actualizaciones
    actBuscarActIniciar.Checked := StrToBoolDef(FConfig.GetItem('SearchUpInicio'), actBuscarActIniciar.Checked);


    // Fuente activa
    var fName := FConfig.GetItem('FontName');
    var item := TFontUtils.SetActiveFont(Fuentedeletra1, fName);
    if Assigned(item) then
      CambiarFuenteFijaClick(item);

  except
    raise Exception.Create(Format(DKLangConstW('errRestoreConfig1'), [GetConfigFileName]) + sLineBreak + DKLangConstW('errRestoreConfig2'));
  end;
end;

procedure TFormMain.SaveConfiguration;
begin
  try
    FConfig.Clear;
    // Añadir datos a guardar; Tamaños y ubicaciones
    FConfig.AddItem('MainLeft', Self.Left.ToString);
    FConfig.AddItem('MainWidth', Self.Width.ToString);
    FConfig.AddItem('MainHeight', Self.Height.ToString);
    FConfig.AddItem('MainTop', Self.Top.ToString);
    FConfig.AddItem('OtrosWidth', pnlOtros.Width.ToString);
    // Estado de las acciones
    FConfig.AddItem('actSoloVisiblesChecked', actSoloVisibles.Checked.ToString);
    FConfig.AddItem('actAutoscrollChecked', actAutoscroll.Checked.ToString);
    FConfig.AddItem('actListaProcesosChecked', actListaProcesos.Checked.ToString);
    FConfig.AddItem('actColorProcesoChecked', actColorProceso.Checked.ToString);
    // Estado de las columnas (visibles)
    FConfig.AddItem('actIDChecked', actID.Checked.ToString);
    FConfig.AddItem('actFechaChecked', actFecha.Checked.ToString);
    FConfig.AddItem('actHoraChecked', actHora.Checked.ToString);
    // Fuente activa
    FConfig.AddItem('FontName', TFontUtils.GetFontActive(Fuentedeletra1));
    // Actualizaciones
    FConfig.AddItem('SearchUpInicio', actBuscarActIniciar.Checked.ToString);

    // Grabar
    FConfig.SaveConfig;
  except
    raise Exception.Create(Format(DKLangConstW('errSaveConfig1'), [GetConfigFileName]) + sLineBreak + DKLangConstW('errSaveConfig2'));
  end;
end;

procedure TFormMain.sbMainClick(Sender: TObject);
begin
  UpdateStatusBar;
end;

procedure TFormMain.FillLanguagesMenu(aMenuIdiomas:TMenuItem);
var
  item:TMenuItem;
begin
  // Crear los elementos del menú a parttir de los ficheros en disco
  for var i := 0 to (LangManager.LanguageCount-1) do begin
    item := TMenuItem.Create(aMenuIdiomas);
    aMenuIdiomas.Add(item);
    item.AutoCheck := True;
    item.RadioItem := True;
    item.GroupIndex := 15;    // groupIndex único para los idiomas
    item.Caption := LangManager.LanguageNames[i];
    item.Tag := i;
    if (i = 0) then begin
      item.Caption := 'Español';
      item.Checked := True;  // 0 siempre es el Español
    end;
    item.OnClick := IdiomaClick;
    item.Hint := Format(DKLangConstW('msg_Idioma'), [item.Caption]);
  end;
end;

procedure TFormMain.ScanLanguages;
var
  i: Integer;
begin
  // Buscar los ficheros de idioma (.lng) que hay en el directorio de "Languages"
  var pathLang := IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + 'Languages';
  LangManager.ScanForLangFiles(pathLang, '*.lng', False);
  // Fill cbLanguage with available languages
  for i := 0 to LangManager.LanguageCount-1 do begin
    Log('Encontrado: ' + LangManager.LanguageNames[i]);
  end;
  Log('--------------------------------');
end;

procedure TFormMain.SetPausado(const Value: boolean);
begin
  FPausado := Value;
  dbgMensajes.Invalidate;
  ConfigureActions;
  UpdateStatusBar;
end;


procedure TFormMain.TimerUpdatesTimer(Sender: TObject);
begin
  TimerUpdates.Enabled := False;
  if actBuscarActIniciar.Checked then
    actActualizacionesExecute(nil);
end;

procedure TFormMain.InternalUpdateProcessIdList(const aProcessName:string);
begin
  var pInfo := ListaProcesos.GetProcessOject(aProcessName);
  if not Assigned(pInfo) then begin
    Log(Format('Error: No encontrado el proceso con nombre <%s>', [aProcessName]));
    Exit;
  end;
  //
  lbIDsProcs.Clear;  
  if Assigned(pInfo) then
    for var i := 0 to (pInfo.ProcessIdList.Count - 1) do
      lbIDsProcs.Items.Add(pInfo.ProcessIdList[i].ToString);
end;

procedure TFormMain.clbListaProcesosClick(Sender: TObject);
begin
  if (TListBox(Sender).ItemIndex < 0) then
    Exit;
  var pName := TListBox(Sender).Items[TListBox(Sender).ItemIndex];
  InternalUpdateProcessIdList(pName);

  ListaProcesos.Debug;
end;

procedure TFormMain.UpdateCaption;
begin
  Caption := TITLEAPP + '   (v.' + GetAppVersion(ParamStr(0)) + ') ';
  // Si tenemos nombre de fichero, se añade...
  if FSavedFileName <> string.Empty then
    Caption := Caption + '  -  ' + FSavedFileName;
end;

procedure TFormMain.UpdateProcessList(const aProcessId: integer);

  procedure InternalUpdateProcessCheckList(const aProcessName:string);
  begin
    var index := clbListaProcesos.Items.AddObject(aProcessName, ListaProcesos.GetProcessOject(aProcessName));
    clbListaProcesos.Checked[index] := True;
  end;

begin
  var pName:string := ExtractFileName(TProcessUtils.GetProcessNameByPID(aProcessId));
  var b := ListaProcesos.AddProcessByName(pName, aProcessId);
  if b then
    InternalUpdateProcessCheckList(pName);
  InternalUpdateProcessIdList(pName);
end;

procedure TFormMain.UpdateStatusBar;
begin
  // El 0 es el autohint

  // Panel de pausa
  sbMain.Panels[1].Text := IfThen(Pausado, DKLangConstW('msg_Pausado'), DKLangConstW('msg_Activo'));
  // líneas en pantalla
  sbMain.Panels[2].Text := mtMensajes.RecordCount.ToString + ' ' + DKLangConstW('msg_lineas');
  // Si hay filtro
  var b := HayFiltroActivo;
  sbMain.Panels[3].Text := IfThen(b, DKLangConstW('str_Filtered'), string.empty);
  // El 4 se usa para progressbar
  sbMain.Panels[4].Text := string.Empty;
end;

end.
