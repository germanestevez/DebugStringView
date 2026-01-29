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
  uRecursos, Vcl.Imaging.pngimage, Vcl.ToolWin, DKLangStorage,
  uBookmarks.Classes, Vcl.StdActns;

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
    actVerToolbar: TAction;
    VerToolbar1: TMenuItem;
    actBMNuevo: TAction;
    actBMAnterior: TAction;
    actBMSiguiente: TAction;
    actBMEliminar: TAction;
    pmGrid: TPopupMenu;
    Limpiardebug2: TMenuItem;
    N5: TMenuItem;
    Coloresporproceso1: TMenuItem;
    N6: TMenuItem;
    Bookmarks1: TMenuItem;
    Nuevo1: TMenuItem;
    Siguiente1: TMenuItem;
    Anterior1: TMenuItem;
    Eliminar1: TMenuItem;
    mtMensajesBM: TIntegerField;
    pnlBookmarks: TPanel;
    lblBookmarks: TLabel;
    lbBookmarks: TListBox;
    FindDialog: TFindDialog;
    Bsqueda1: TMenuItem;
    actBuscar: TAction;
    actIrA: TAction;
    SearchFind1: TSearchFind;
    SearchFindNext1: TSearchFindNext;
    SearchFindFirst1: TSearchFindFirst;
    Buscar1: TMenuItem;
    N8: TMenuItem;
    IraID1: TMenuItem;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    pmBookmarks: TPopupMenu;
    Eliminar2: TMenuItem;
    N7: TMenuItem;
    actCopiarMensaje: TAction;
    actCopiarLinea: TAction;
    Copiarmensaje1: TMenuItem;
    Copiarlneacompleta1: TMenuItem;
    pmProcesos: TPopupMenu;
    actLimpiarProcesoLista: TAction;
    Eliminar3: TMenuItem;
    btnLimpiarProceso: TButton;
    actNuevo: TAction;
    ToolButton22: TToolButton;
    Limpiaresteproceso1: TMenuItem;
    actLimpiarProcesoGrid: TAction;
    Nuevacaptura1: TMenuItem;
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
    procedure actVerToolbarExecute(Sender: TObject);
    procedure actBMNuevoExecute(Sender: TObject);
    procedure lbBookmarksClick(Sender: TObject);
    procedure actBuscarExecute(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure FindDialogClose(Sender: TObject);
    procedure FindDialogShow(Sender: TObject);
    procedure actIrAExecute(Sender: TObject);
    procedure actPausarUpdate(Sender: TObject);
    procedure actReanudarUpdate(Sender: TObject);
    procedure actGuardarUpdate(Sender: TObject);
    procedure pmGridPopup(Sender: TObject);
    procedure pmGridClose(Sender: TObject);
    procedure actGuardarcomoUpdate(Sender: TObject);
    procedure actLimpiarUpdate(Sender: TObject);
    procedure actCopiarMensajeExecute(Sender: TObject);
    procedure actCopiarLineaExecute(Sender: TObject);
    procedure actBMEliminarExecute(Sender: TObject);
    procedure actBMEliminarUpdate(Sender: TObject);
    procedure actBMNuevoUpdate(Sender: TObject);
    procedure actLimpiarProcesoListaExecute(Sender: TObject);
    procedure actLimpiarProcesoListaUpdate(Sender: TObject);
    procedure actBMAnteriorUpdate(Sender: TObject);
    procedure actBMSiguienteUpdate(Sender: TObject);
    procedure actBMAnteriorExecute(Sender: TObject);
    procedure actBMSiguienteExecute(Sender: TObject);
    procedure clbListaProcesosContextPopup(Sender: TObject; MousePos: TPoint;  var Handled: Boolean);
    procedure actNuevoExecute(Sender: TObject);
    procedure actLimpiarProcesoGridExecute(Sender: TObject);
    procedure actLimpiarProcesoGridUpdate(Sender: TObject);

  private
    EstadoActualPausado:boolean;
    MsgIndex:integer;
    thCapture: TDebugStringThread;
    FLog:ILog;
    FSave, FOpen:ISaveLoadDSToFile;
    FConfig:IConfig;
    FSavedFileName: TFileName;
    FFicheroCargado: boolean;
    FListaBookmarks: TBookmarkListDSV;
    FGlobalStates: TGlobalStates;

    // ayudas ******************************************************************
    function GetHelpFileName:TFileName;

    // Menú de fichero *********************************************************
    // Grabar el fichero
    procedure InternalSaveFile(aFileName:TFileName);
    // Abrir un fichero de disco
    procedure InternalOpenFile;
    // fichero de configuración
    function GetConfigFileName:TFileName;

    // Procedimiento de log interno ********************************************
    procedure Log(const aMensaje:string);

    // Métodos iniciales y de configuracion ************************************
    procedure ConfigureVisualControls;
    procedure ConfigureActions;
    procedure IniData;

    // actualizar los menús con las ocpiones que llegan de configuracion
    procedure UpdateMenus;

    // Actualizar en ejecución partes del programa *****************************
    procedure UpdateProcessList(const aProcessId:integer; const pName:string); overload;
    procedure UpdateProcessList(const aProcessId: integer); overload;
    procedure UpdateStatusBar;
    procedure UpdateCaption;
    procedure UpdateBookMarksList;
    procedure InternalUpdateProcessCheckList(const aProcessName:string);

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
    procedure LimpiarProceso(const aProcessName:string);

    // Visualización de mensajes ***********************************************
    procedure MostrarOcultarColumna(Sender: TObject; aFieldName:string);
    procedure CambiarFuenteLetra(const aFuenteActual:string; const aFuenteNueva:string = string.Empty);

    // Proceso de captura y visualización **************************************
    procedure SetPausado(const Value: boolean);
    // Procedimiento para mostrar losmensajes que llegan desde debug
    procedure ProcSharedInfo(const aProcessId:Word; const aMensaje:string);
    // Añadir un proceso nuevo, cuando viene de la carga de un fichero...
    procedure AddProcessFromFile(const aProcessId:Word; const aProcessName, aMensaje: string; const aBookmark:integer=-1);
    function GetPausado: boolean;

    // permiten grabar/leer la lista de bookmarks al final del fichero (informacion extendida)
    procedure SaveBookmarks(TS:TStrings);
    procedure LoadBookmarks(TS:TStrings; const AIndex:integer);
  public
    /// <summary> Si la captura de mensajes está pausada o no </summary>
    property Pausado:boolean read GetPausado write SetPausado default False;
    /// <summary> Marcamos el flag de que hemos abierto un fichero </summary>
    property FicheroCargado:boolean read FFicheroCargado write FFicheroCargado default False;
    // limpiar datos de un proceso
    procedure DoLimpiarProceso(const aProcessName:string);
    /// <summary> Nombre del fichero (si ya se ha guardado) </summary>
    property SavedFileName:TFileName read FSavedFileName write FSavedFileName;
    /// <summary> Si tenemos activado la coloracion por proceso </summary>
    property ColorPorProceso:boolean read GetColorPorProceso;
    /// <summary> Lista de boormarks creados </summary>
    property ListaBookmarks:TBookmarkListDSV read FListaBookmarks;
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
  FSplash,
  System.Generics.Collections,
  System.StrUtils, System.UITypes, FAcercaDe, ShellAPI, System.IOUtils,
  uUtils, uGridHelpers, uUpdates, Clipbrd;

procedure TFormMain.Log(const aMensaje:string);
begin
  if not Assigned(FLog) then
    Exit;
  FLog.Log(aMensaje);
end;

 
procedure TFormMain.actAbrirExecute(Sender: TObject);
begin
  // Pasos previos
  // Avisar al usuario si hay cosas en pantalla que se van a perder
  if (MessageBox(0, PChar(DKLangConstW('msgOpenFile1') + sLineBreak + DKLangConstW('msgOpenFile2')), PChar(DKLangConstW('msgTitleOpen')), MB_ICONEXCLAMATION or MB_YESNO) = idNo) then
    Exit;

  // Desactivar acciones (captura, save,...)
  FGlobalStates := FGlobalStates + [gsFileLoaded, gsPaused];

  // Abrir un fichero de disco
  InternalOpenFile;
  // Nombre del fichero en el caption
  UpdateCaption;
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

procedure TFormMain.actBMAnteriorExecute(Sender: TObject);
begin
  // pendiente
end;

procedure TFormMain.actBMAnteriorUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (mtMensajes.Active) and (lbBookmarks.ItemIndex > 1);
end;

procedure TFormMain.actBMEliminarExecute(Sender: TObject);
begin
  // preguntar
  if (MessageBox(0, PChar(DKLangConstW('msgEliminarBM1')), PChar(DKLangConstW('msgEliminarBM2')), MB_ICONQUESTION or MB_YESNO) = idNo) then
    Exit;

  if (not mtMensajes.Active) then
    Exit;

  FGlobalStates := FGlobalStates + [gsBookmark];
  try
    // eliminarlo de la BD
    // 1) Guardar posicion actual
    var bm:TBookmark := mtMensajes.GetBookmark;

    mtMensajes.DisableControls;
    try
      // 2) Ir al que quiero borrar
      var index := lbBookmarks.ItemIndex;
      if (index < 0) then
        Exit;

      var str := lbBookmarks.Items[index];
      str := Trim(Copy(str, 1, 3));
      var numero := StrToIntDef(str, -1);

      if (index = -1) then
        raise Exception.Create(DKLangConstW('errBMNotFound'));

      var actual := ListaBookmarks.GetByNumero(numero);
      if not Assigned(actual) then
        Exit;

      try
        mtMensajes.GotoBookmark(actual);
      except
        on E:Exception do begin
          MessageDlg(DKLangConstW('errBMNotFound1') + sLineBreak + DKLangConstW('errBMNotFound2'), mtError, [mbOK], 0);
        end;
      end;

      // 3) Borrarlo
      mtMensajes.Edit;
      mtMensajesBM.Clear;
      mtMensajes.Post;

      // 4) Eliminar de la lista interna
      ListaBookmarks.DeleteByNumero(numero);

      // 5) Volver a la posicion guardada
      mtMensajes.GotoBookmark(bm);
    finally
      mtMensajes.EnableControls;
    end;

    // Actualizar la lista
    UpdateBookMarksList;
  finally
    FGlobalStates := FGlobalStates - [gsBookmark];
  end;
end;

procedure TFormMain.actBMEliminarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (mtMensajes.Active) and (lbBookmarks.ItemIndex <> -1);
end;

procedure TFormMain.actBMNuevoExecute(Sender: TObject);
var
  str:string;
begin
  if not mtMensajes.Active then
    Exit;

  FGlobalStates := FGlobalStates + [gsBookmark];
  try
    var varID := mtMensajesID.AsInteger;
    var bm := mtMensajes.GetBookmark;

    var b := InputQuery(DKLangConstW('msgCrearbm'), DKLangConstW('msgDesc1'), str);
    if not b then
      Exit;
    // Añadirlo
    var i:integer := ListaBookmarks.Count + 1;
    ListaBookmarks.Add(i, varID, str, bm);

    // Añadirlo al Dataset
    mtMensajes.Edit;
    mtMensajesBM.AsInteger := i;
    mtMensajes.Post;

    UpdateBookMarksList;
  finally
    FGlobalStates := FGlobalStates - [gsBookmark];
  end;
end;

procedure TFormMain.actBMNuevoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (mtMensajes.Active) {and (lbBookmarks.ItemIndex <> -1)};
end;

procedure TFormMain.actBMSiguienteExecute(Sender: TObject);
begin
// pendiente
end;

procedure TFormMain.actBMSiguienteUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (mtMensajes.Active) and (lbBookmarks.ItemIndex >= 0) and (lbBookmarks.Count > lbBookmarks.ItemIndex+1);
end;

procedure TFormMain.actBuscarActIniciarExecute(Sender: TObject);
begin
  // Usa un timer
end;

procedure TFormMain.actBuscarExecute(Sender: TObject);
begin
  var b := FindDialog.Execute;
  if not b then
    Exit;
end;

procedure TFormMain.actColorProcesoExecute(Sender: TObject);
begin
  // colorear por prpoceso
  dbgMensajes.Invalidate;
end;

procedure TFormMain.actCopiarLineaExecute(Sender: TObject);
begin
  // copiar la línea completa al portapapeles
  if mtMensajes.Active then
    if not mtMensajes.IsEmpty then
      Clipboard.AsText := mtMensajesID.AsString + ' ' +
                          mtMensajesFecha.AsString + ' ' +
                          mtMensajesHora.AsString + ' ' +
                          mtMensajesProcessId.AsString + ' ' +
                          mtMensajesNombre.AsString + ' ' +
                          mtMensajesMensaje.AsString;
end;

procedure TFormMain.actCopiarMensajeExecute(Sender: TObject);
begin
  // copiar el mensaje al portapapeles
  if mtMensajes.Active then
    if not mtMensajes.IsEmpty then
      Clipboard.AsText := mtMensajesMensaje.AsString;
end;

procedure TFormMain.InternalOpenFile;
begin
  var progress := TProcessProgress.Create(pbProceso, sbMain, 4);
  try
    var b := FileOpenDialog.Execute;
    if not b then begin
      Log('Lectura del fichero cancelada');
      Exit;
    end;

    // Limpiar elcontenido actual
    actLimpiarExecute(nil);
    // inicializar indice y dataset
    IniData;

    try
      // generar el objeto lectura
      if not Assigned(FOpen) then
        FOpen := TFactoryLoad.GetClass(TLoadDSFromFile);
      progress.Ini;
      TLoadDSFromFile(FOpen).OnProgress := progress.Step;
      TLoadDSFromFile(FOpen).LoadExtendedInfo := LoadBookmarks;

      Log('Se va a leer en el fichero: ' + FileOpenDialog.FileName);

      FOpen.SetLog(FLog);
      FOpen.SetDataset(mtMensajes);
      TLoadDSFromFile(FOpen).OnAddItem := AddProcessFromFile;
      FOpen.Open(FileOpenDialog.FileName);

      // Una vez cargado nos quedamos con el nombre del fichero
      FSavedFileName := FileOpenDialog.FileName;

      // Rellenar el proceso...

      // Marcamos el flag de que hemos abierto un fichero
      FFicheroCargado := True;

    except
      on E:Exception do begin
        Log(DKLangConstW('err_leerFichero') + E.Message);
        raise Exception.Create(DKLangConstW('err_leerFichero') + sLineBreak + E.Message);
      end;
    end;

  finally
    progress.Fin;
    FreeAndNil(progress);
  end;
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
    TSaveDSToFile(FSave).Version := GetAppVersion(ParamStr(0));
    TSaveDSToFile(FSave).SaveExtendedInfo := SaveBookmarks;

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

procedure TFormMain.actGuardarcomoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := not (gsFileLoaded in FGlobalStates);
end;

procedure TFormMain.actGuardarExecute(Sender: TObject);
begin
  InternalSaveFile(FSavedFileName);
  UpdateCaption;
end;

procedure TFormMain.actGuardarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := not (gsFileLoaded in FGlobalStates);
end;

procedure TFormMain.MostrarOcultarColumna(Sender: TObject; aFieldName:string);
begin
  var col:TColumn := TGridHelper.GetColumnByFieldName(dbgMensajes, aFieldName);
  if Assigned(col) then
    col.Visible := TAction(Sender).Checked;
  TGridHelper.AutoajustarAnchoColumna(dbgMensajes, 'Mensaje');
end;

procedure TFormMain.pmGridClose(Sender: TObject);
begin
  FGlobalStates := FGlobalStates - [gsPopupMenu];
end;

procedure TFormMain.pmGridPopup(Sender: TObject);
begin
  FGlobalStates := FGlobalStates + [gsPopupMenu];
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

procedure TFormMain.actIrAExecute(Sender: TObject);
var
  str:string;
  b:boolean;
begin
  b := False;
  EstadoActualPausado := Pausado;
  Pausado := True;
  try
    // ir a una deterinada línea
    b := InputQuery(DKLangConstW('msgIrACaption'), DKLangConstW('msgIrAMsg'), str);
    if not b then
      Exit;
    // Añadirlo
    var i:integer := StrToIntDef(str, -1);

    if (i = -1) then
      Exit;

    // Ir a ese elemento (si lo encuentra)
    var sBusqueda: string := '(ID=' + i.ToString + ')';

    mtMensajes.First;
    b := mtMensajes.LocateEx(sBusqueda,  [lxoCaseInsensitive, lxoCaseInsensitive, lxoFromCurrent]);

    if (not b) then
      sbMain.Panels[0].Text := DKLangConstW('msg_NoEncontrado');

  finally
    // si lo ha encontrado lo dejamos pausado
    if (not b) then
      Pausado := EstadoActualPausado;
  end;
end;

procedure TFormMain.actLimpiarExecute(Sender: TObject);
begin
  // inicializar contadores
  MsgIndex := 0;
  // limpiar los mensajes actuales
  mtMensajes.EmptyDataSet;
  // Limpiar la lista de procesos
  ListaProcesos.Clear;
  // Limpiar la lista de bookmarks
  ListaBookmarks.Clear;
  UpdateBookMarksList;
  // Actualizar las listas en pantalla
  clbListaProcesos.Clear;
  // Limpiar el filtro si lo hay
  FilterMessagesByProcesses;
end;

procedure TFormMain.actLimpiarProcesoGridExecute(Sender: TObject);
begin
  // Pause
  FGlobalStates := FGlobalStates + [gsPaused];
  try
    // Limpiar datos del proceso
    var procName := mtMensajesNombre.AsString;
    // (1) Limpiar los mensajes
    DoLimpiarProceso(ProcName);
    // restaurar si había filtro activado
    FilterMessagesByProcesses;
  finally
    FGlobalStates := FGlobalStates - [gsPaused]
  end;
end;

procedure TFormMain.actLimpiarProcesoGridUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (not (gsFileLoaded in FGlobalStates)) and (mtMensajes.Active);
end;

procedure TFormMain.actLimpiarProcesoListaExecute(Sender: TObject);
begin
  // Pause
  FGlobalStates := FGlobalStates + [gsPaused];
  try
    // Limpiar datos del proceso
    var procName := clbListaProcesos.Items[clbListaProcesos.ItemIndex];
    // (1) Limpiar los mensajes
    DoLimpiarProceso(ProcName);
    // restaurar si había filtro activado
    FilterMessagesByProcesses;
  finally
    FGlobalStates := FGlobalStates - [gsPaused]
  end;
end;


procedure TFormMain.DoLimpiarProceso(const aProcessName:string);
begin
  // (1) Borrar las entradas
  LimpiarProceso(aProcessName);
  var index := ListaProcesos.GetIndexByName(aProcessName);
  // (2) Borrarlo de la lista
  if (index <> -1) then
    ListaProcesos.Delete(index);
  // (3) Buscarlo en la lista de procesos y eliminarlo
  index := clbListaProcesos.Items.IndexOf(aProcessName);
  if (index <> -1) then
    clbListaProcesos.Items.Delete(Index);
end;


procedure TFormMain.actLimpiarProcesoListaUpdate(Sender: TObject);
begin
  // si no hay nada seleccionado o no hay nada en la lista (deshabilitar)
  TAction(Sender).Enabled := (clbListaProcesos.Items.Count > 0) and (clbListaProcesos.ItemIndex <> -1);
  if (btnLimpiarProceso.Caption <> string.Empty) then
    btnLimpiarProceso.Caption := string.Empty;
end;

procedure TFormMain.actLimpiarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (not (gsFileLoaded in FGlobalStates)) and (mtMensajes.Active);
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

procedure TFormMain.actNuevoExecute(Sender: TObject);
begin
  // Preguntar al usuario si quiere continuar
  if (MessageBox(0, PChar(DKLangConstW('msgNuevo1') + sLineBreak + DKLangConstW('msgNuevo2')), PChar(DKLangConstW('msgTitleNuevo')), MB_ICONQUESTION or MB_YESNO) = idNo) then
    Exit;

  // Limpiar todo, borar todo y empezar de nuevo
  actLimpiar.Execute;
  IniData;
end;

procedure TFormMain.actPausarExecute(Sender: TObject);
begin
  // Pausar la captura
  Pausado := True;
end;

procedure TFormMain.actPausarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (not (gsFileLoaded in FGlobalStates)) and
                             (not Pausado);
end;

procedure TFormMain.actReanudarExecute(Sender: TObject);
begin

  // estamos con un fichero abierto de disco?
  if (gsFileLoaded in FGlobalStates) then begin
    // Avisar al usuario de que lo que hay en pantalla se borrará
    if (MessageBox(0, PChar(DKLangConstW('msgReanudar1') + sLineBreak + DKLangConstW('msgReanudar2')), PChar(DKLangConstW('msgTitleReanudar')), MB_ICONEXCLAMATION or MB_YESNO) = idNo) then
      Exit;

    // Limpiar los mensajes y renicializar todo
    actLimpiarExecute(nil);
    FSavedFileName := string.Empty;
    FGlobalStates := FGlobalStates - [gsFileLoaded];

    // actualizar el titulo
    UpdateCaption;
  end;

  // reanudar la captura
  Pausado := False
end;

procedure TFormMain.actReanudarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (gsFileLoaded in FGlobalStates) or (Pausado);
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

procedure TFormMain.lbBookmarksClick(Sender: TObject);
begin
  // max. 99 bookmarks
  if ListaBookmarks.Count = 99 then
    raise Exception.Create(DKLangConstW('errLimiteBookmarks'));
  var index := TListBox(Sender).ItemIndex;
  if (index < 0) then
    Exit;

  var str := TListBox(Sender).Items[index];
  str := Trim(Copy(str, 1, 3));
  var numero := StrToIntDef(str, -1);

  if (numero = -1) then
    raise Exception.Create(DKLangConstW('errBMNotFound'));

  var bm := ListaBookmarks.GetByNumero(Numero);
  try
    mtMensajes.GotoBookmark(bm);
  except
    on E:Exception do begin
      MessageDlg(DKLangConstW('errBMNotFound1') + sLineBreak + DKLangConstW('errBMNotFound2'), mtError, [mbOK], 0);
    end;
  end;
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

procedure TFormMain.actVerToolbarExecute(Sender: TObject);
begin
  // ver/ocultar toolbar
  tbMain.Visible := actVerToolbar.Checked;
end;

procedure TFormMain.clbListaProcesosClickCheck(Sender: TObject);
begin
  FilterMessagesByProcesses;
end;

procedure TFormMain.clbListaProcesosContextPopup(Sender: TObject;  MousePos: TPoint; var Handled: Boolean);
var
  idx: Integer;
begin
  // Item más cercano
  idx := clbListaProcesos.ItemAtPos(MousePos, True);
  if idx <> -1 then begin
    clbListaProcesos.ItemIndex := idx;
    clbListaProcesos.SetFocus; // Opcional: asegura que el ListBox tenga el foco
  end
  else
  begin
    // Si clicas en zona vacía, opcionalmente cancela el popup
    Handled := True;
  end;
end;

procedure TFormMain.ConfigureActions;
begin
  actReanudar.Enabled := Pausado;
  actPausar.Enabled := not Pausado;
end;

procedure TFormMain.ConfigureVisualControls;
begin
  // Panel de IDs (sólo debug) - no interesa
  pnlIDsProcs.Visible := False;
  pnlListaProcesos.Align := alClient;
  pnlUpdate.Visible := False;
  splListaProcesos.Top := pnlBookmarks.Top + 20;
  splListaProcesos.Visible := True;

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
  if (Pausado) and (not (gsFileLoaded in FGlobalStates)) then begin
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
  TGridHelper.DoColorLine(TDBGrid(Sender), Rect, aColor, Column.Field.AsString, Column.Field);

  if Column.FieldName = 'BM' then
    if Column.Field.AsString <> string.Empty then begin
      TDBGrid(Sender).Canvas.Brush.Color := clRed;
      TDBGrid(Sender).Canvas.Rectangle(Rect);
      TDBGrid(Sender).Canvas.Pen.Color := clRed;
      TDBGrid(Sender).DefaultDrawDataCell(Rect, Column.Field, []);
    end;
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
    // Log('Hay Filtro: ' + BoolToStr(Result, True));
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
    dbgMensajes.LockDrawing;
    mtMensajes.DisableControls;
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
      dbgMensajes.UnlockDrawing;
      mtMensajes.EnableControls;
    end;
  finally
    // Update statusbar
    UpdateStatusBar;
  end;
end;

procedure TFormMain.FindDialogClose(Sender: TObject);
begin
  // Restauramos el estado
  Pausado := EstadoActualPausado;
end;

procedure TFormMain.FindDialogFind(Sender: TObject);
var
  b:boolean;
  lOptions:TFDDataSetLocateOptions;
begin
  // Buscando texto en los mensajes
  if (gsFirstSearch in FGlobalStates) then
    mtMensajes.First;

  try
    var sBusqueda: string := '(Mensaje like ' + QuotedStr('%' + Trim(FindDialog.FindText) + '%') + ') OR ' +
                             '(ProcessName like ' + QuotedStr('%' + Trim(FindDialog.FindText) + '%') + ') OR ' +
                             '(ProcessId like ' + QuotedStr('%' + Trim(FindDialog.FindText) + '%') + ')';

    // Opciones para busqueda hacia adelante y atrás
    if (frDown in TFindDialog(Sender).Options) then
      lOptions := [lxoCaseInsensitive, lxoCaseInsensitive, lxoFromCurrent]
    else
      lOptions := [lxoCaseInsensitive, lxoCaseInsensitive, lxoFromCurrent, lxoBackward];

    b := mtMensajes.LocateEx(sBusqueda, lOptions);

    if (not b) then
      sbMain.Panels[0].Text := DKLangConstW('msg_NoEncontrado');

    Log('Encontado=' + BoolToStr(b, True));
  finally
    FGlobalStates := FGlobalStates - [gsFirstSearch];
  end;
end;

procedure TFormMain.FindDialogShow(Sender: TObject);
begin
  // Nos quedamos con el estado al iniciar la busqueda
  EstadoActualPausado := Pausado;
  FGlobalStates := FGlobalStates + [gsFirstSearch];
  Pausado := True;
end;

procedure TFormMain.FontDialogViewApply(Sender: TObject; Wnd: HWND);
begin
  Log('ClassName=' + Sender.ClassName);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Pausado := True;
  SaveConfiguration;
  if thCapture.Started then begin
    thCapture.Terminate;
  end;
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
  // Lista de bookmarks
  FListaBookmarks := TBookmarkListDSV.Create;
  // Clave para configuraciones
  FConfig := TFactoryConfig.GetClass(TFileConfig);
  TFileConfig(FConfig).FileName := GetConfigFileName;
  // Asignar extensión de fichero a esta aplicación
  AsignarExtension('.dsvlog', 'DebugStringView', ParamStr(0));

  Log('+TFormMain.FormCreate');
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  if Assigned(ListaProcesos) then
    FreeAndNil(ListaProcesos);
  FreeAndNil(FListaBookmarks);
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  TGridHelper.AutoajustarAnchoColumna(dbgMensajes, 'Mensaje');  
end;

procedure TFormMain.FormShow(Sender: TObject);

  procedure Ocultar;
  begin
    AlphaBlendValue := 100;
    AlphaBlend := True;
  end;
  procedure Visualizar;
  begin
    AlphaBlendValue := 255;
    AlphaBlend := False;
  end;

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
  // Actualizar opciones de menús (idiomas,...)
  UpdateMenus;
  // Títulos para la Columnas del grid
  UpdateCaption;


  Ocultar;
  try
    var FormSplash := TFormSplash.Create(nil);
    FormSplash.ShowModal;
    FormSplash.Free;
  finally
    Visualizar;
  end;
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

function TFormMain.GetPausado: boolean;
begin
  Result := (gsPaused in FGlobalStates);
end;

procedure TFormMain.CambiarIdioma(aID:integer);
begin
  var iIndex := aID;
  if aID<0 then
    iIndex := 0; // When there's no valid selection in cbLanguage we use the default language (Index=0)
  LangManager.LanguageID := iIndex {LangManager.LanguageIDs[iIndex]};
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
  SavedFileName := string.Empty;
  FicheroCargado := False;
  FGlobalStates := [];
end;


// Añadir un elemento nuevo al Grid
procedure TFormMain.AddProcessFromFile(const aProcessId: Word; const aProcessName, aMensaje: string; const aBookmark:integer=-1);
begin

  Inc(MsgIndex);

  // crear la información del proceso y actualizar la lista
  UpdateProcessList(aProcessId, aProcessName);

  // ***************************  DBGRID ****************************************
  try
    mtMensajes.DisableControls;
    try
      // Añadir el registro
      mtMensajes.Append;
      mtMensajesID.AsInteger := MsgIndex;
      mtMensajesFecha.AsString := DateToStr(Date);
      mtMensajesHora.AsString := TimeToStr(Time);
      mtMensajesProcessId.AsInteger := aProcessId;
      mtMensajesNombre.AsString := aProcessName;
      mtMensajesMensaje.AsString := aMensaje;
      if (aBookmark <> -1) then
        mtMensajesBM.AsInteger := aBookmark;
      mtMensajes.Post;
    finally
      mtMensajes.EnableControls;
    end;
  except
    Log('ERROR al añadir (DBGrid)');
  end;

  UpdateStatusBar;
end;

// Procedimiento para mostrar losmensajes que llegan desde debug
procedure TFormMain.ProcSharedInfo(const aProcessId:Word; const aMensaje:string);
begin
  // Si está pausado, salimos...
  if Pausado or (gsFileLoaded in FGlobalStates) or (gsPopupMenu in FGlobalStates) or (gsBookmark in FGlobalStates) then
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
    actVerToolbar.Checked := StrToBoolDef(FConfig.GetItem('actVerToolbarChecked'), actVerToolbar.Checked);
    actVerToolbarExecute(actVerToolbar);
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
    // Idioma selecciona
    var idioma:integer;
    try
      idioma := AssignIfNotEmpty(FConfig.GetItem('Idioma'), 1033);
    except
      idioma := 1033;
    end;
    LangManager.LanguageID := idioma;

    // Fuente activa
    var fName := FConfig.GetItem('FontName');
    var item := TFontUtils.SetActiveFont(Fuentedeletra1, fName);
    if Assigned(item) then
      CambiarFuenteFijaClick(item);

  except
    raise Exception.Create(Format(DKLangConstW('errRestoreConfig1'), [GetConfigFileName]) + sLineBreak + DKLangConstW('errRestoreConfig2'));
  end;
end;

procedure TFormMain.UpdateMenus;
begin

  for var i := 0 to (Idiomas2.Count - 1) do begin
    if (Integer(Idiomas2.Items[i].Tag) = Integer(LangManager.LanguageID)) then begin
      Idiomas2.Items[i].Checked := True;
      Exit;
    end;
  end;
end;

procedure TFormMain.LimpiarProceso(const aProcessName: string);
var
  listaIds:TList<integer>;
begin
  // No activo
  if (not mtMensajes.Active) then begin
    Log('El dataset de mensajes no está activo');
    Exit;
  end;

  listaIds := TList<integer>.Create;
  try

    // Buscar el proceso en la lista
    var pi:TProcessInfo := ListaProcesos.GetProcessOject(aProcessName);
    if not Assigned(pi) then begin
      Log(Format('Error, no se ha encontrado el proceso [%S]', [aProcessName]));
      Exit;
    end
    else begin
      // obtener la lista de Ids
      Log('Lista de IDs ------------------------------------');
      for var i := 0 to (pi.ProcessIdList.Count - 1) do begin
        Log('   ' + pi.ProcessIdList[i].ToString);
        listaIds.Add(pi.ProcessIdList[i]);
      end;
    end;

    var sFiltro:string := string.Empty;
    // Habilitar un filtro para encontrar los registros con PROCESSID = 1234
    for var i := 0 to (listaIds.Count - 1) do begin
      if (i > 0) then
        sFiltro := sFiltro + ' AND ';
      sFiltro := sFiltro + Format('(PROCESSID = %d)', [listaIDs[i]]);
    end;
    Log(' Filtro=' + sFiltro);

    dbgMensajes.LockDrawing;
    mtMensajes.DisableControls;
    try
      mtMensajes.Filter := sFiltro;
      mtMensajes.Filtered := True; // Activar el filtro

      try
        // Si hay registros en la tabla que cumplen con el filtro, eliminarlos
        mtMensajes.First; // Posicionarse en el primer registro visible según el filtro
        while not mtMensajes.Eof do
          mtMensajes.Delete; // Eliminar el registro actual

      finally
        // Desactivar el filtro y limpiar por si lo necesitas más tarde
        mtMensajes.Filtered := False;
        mtMensajes.Filter := '';
      end;
    finally
      dbgMensajes.UnlockDrawing;
      mtMensajes.EnableControls;
    end;
  finally
    FreeAndNil(listaIds);
  end;
end;

procedure TFormMain.LoadBookmarks(TS:TStrings; const AIndex:integer);
begin
  Log('Se van a leer los bookmarks del fichero');
  for var i := AIndex to (TS.Count - 1) do begin
    var str := TS[i];
    var bm:TBookmarkDSV := TBookmarkDSV.Create(0, 0, '', nil);
    bm.FromString(str);

    Log('Bookmark -> ID=' + bm.ID.ToString + '  - Numero=' + bm.Numero.ToString + ' - Desc=' + bm.Descripcion);

    Log(bm.ToString);

    // Añadir el nuevo bookmark
    FGlobalStates := FGlobalStates + [gsBookmark];
    try
      var sBusqueda: string := '(ID=' + bm.ID.ToString + ')';
      mtMensajes.First;
      var b := mtMensajes.LocateEx(sBusqueda,  [lxoCaseInsensitive, lxoCaseInsensitive, lxoFromCurrent]);

      if b then begin
        Log('ENCONTRADO!!');
        var book := mtMensajes.GetBookmark;

        // Añadirlo
        var j:integer := ListaBookmarks.Count + 1;
        ListaBookmarks.Add(j, bm.ID, bm.Descripcion, book);

        // Añadirlo al Dataset
        mtMensajes.Edit;
        mtMensajesBM.AsInteger := j;
        mtMensajes.Post;

        UpdateBookMarksList;

      end
      else
        Log('NO ENCONTRADO!!!');
    finally
      FGlobalStates := FGlobalStates - [gsBookmark];
    end;
  end;

  // Añadirlo y crear el bookmark

end;

procedure TFormMain.SaveBookmarks(TS:TStrings);
begin
  if (ListaBookmarks.Count = 0) then
    Exit;
  // añadir al final los bookmarks
  for var i := 0 to (ListaBookmarks.Count - 1) do begin
    var bm := TBookmarkDSV(ListaBookmarks.Objects[i]);
    var str := bm.ToString;
    TS.Add(Str);
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
    FConfig.AddItem('actVerToolbarChecked', actVerToolbar.Checked.ToString);
    FConfig.AddItem('actColorProcesoChecked', actColorProceso.Checked.ToString);
    // Estado de las columnas (visibles)
    FConfig.AddItem('actIDChecked', actID.Checked.ToString);
    FConfig.AddItem('actFechaChecked', actFecha.Checked.ToString);
    FConfig.AddItem('actHoraChecked', actHora.Checked.ToString);
    // Fuente activa
    FConfig.AddItem('FontName', TFontUtils.GetFontActive(Fuentedeletra1));
    // Actualizaciones
    FConfig.AddItem('SearchUpInicio', actBuscarActIniciar.Checked.ToString);
    // Idioma selecciona
    FConfig.AddItem('Idioma', LangManager.LanguageID.ToString);

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
    item.Tag := LangManager.LanguageIDs[i]{i};
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
  if (Value) then
    FGlobalStates := FGlobalStates + [gsPaused]
  else
    FGlobalStates := FGlobalStates - [gsPaused];
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

procedure TFormMain.UpdateBookMarksList;
begin
  lbBookmarks.Clear;
  for var i := 0 to (ListaBookmarks.Count - 1) do begin
    var obj := TBookmarkDSV(ListaBookmarks.Objects[i]);
    lbBookmarks.Items.Add(Format('%.2d',[obj.Numero, 2]) + ' - ' + obj.Descripcion);
  end;
end;

procedure TFormMain.UpdateCaption;
var
  DateCreate, DateWrite, DateAccess:TDateTime;
begin
  // fechaHoras del fichero
  TFileUtils.GetExeFileDateTimes(DateCreate, DateWrite, DateAccess);

  Self.Caption := TITLEAPP + '   (v.' + GetAppVersion(ParamStr(0)) + ' - ' + FormatDateTime('dd/mm/yyyy', DateWrite)  + ') ';
  // Si tenemos nombre de fichero, se añade...
  if FSavedFileName <> string.Empty then
    Caption := Caption + '  -  ' + FSavedFileName;
end;

procedure TFormMain.InternalUpdateProcessCheckList(const aProcessName:string);
begin
  var index := clbListaProcesos.Items.AddObject(aProcessName, ListaProcesos.GetProcessOject(aProcessName));
  clbListaProcesos.Checked[index] := True;
end;


procedure TFormMain.UpdateProcessList(const aProcessId: integer; const pName:string);
begin
  var b := ListaProcesos.AddProcessByName(pName, aProcessId);
  if b then
    InternalUpdateProcessCheckList(pName);
  InternalUpdateProcessIdList(pName);
end;


procedure TFormMain.UpdateProcessList(const aProcessId: integer);
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

