unit uConfig.Classes;

interface

uses
  System.IOUtils, System.SysUtils, System.Generics.Collections, System.IniFiles,
  VCL.StdCtrls;

type
  /// <summary> interface para las clases de configuracion </summary>
  IConfig = interface
    /// <summary> Grabar la configuración </summary>
    procedure SaveConfig;
    /// <summary> Restaurar la configuración </summary>
    procedure RestoreConfig;
    /// <summary> añadir un elemento de configuración </summary>
    procedure AddItem(AConfigName:string; AValue:Variant);
    /// <summary> Obtener una configuración a partir del nombre </summary>
    function GetItem(AConfigName: string):Variant;
    /// <summary> Limpiar las configuraciones almacenadas (en memoria) </summary>
    procedure Clear;
  end;

  TConfigItem = TPair<string, Variant>;
  /// <summary> Clase base para implementar clases de configuración (abstacta) </summary>
  TBaseConfig = class(TInterfacedObject, IConfig)
  private
    FItems:TList<TConfigItem>;
  protected
    property Items:TList<TConfigItem> read FItems write FItems;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure SaveConfig; virtual; abstract;
    procedure RestoreConfig; virtual; abstract;
    procedure AddItem(AConfigName:string; AValue:Variant); virtual; abstract;
    function GetItem(AConfigName: string):Variant; virtual; abstract;
    procedure Clear; virtual; abstract;
  end;
  TClassConfig = class of TBaseConfig;

  /// <summary> Clase dummy </summary>
  TDummyConfig = class(TBaseConfig, IConfig)
    procedure SaveConfig; override;
    procedure RestoreConfig; override;
    procedure AddItem(AConfigName:string; AValue:Variant); override;
    function GetItem(AConfigName: string):Variant; override;
    procedure Clear; override;
  end;

  /// <summary> Clase que implementa la grabación de la configuración en fichero </summary>
  TFileConfig = class(TBaseConfig, IConfig)
  private
    FIniFile:TInifile;
    FFileName: TFileName;
    procedure SetFileName(const Value: TFileName);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure SaveConfig; override;
    procedure RestoreConfig; override;
    procedure AddItem(AConfigName:string; AValue:Variant); override;
    function GetItem(AConfigName: string):Variant; override;
    procedure Clear; override;
    property FileName:TFileName read FFileName write SetFileName;
  end;

  /// <summary> Clase para implementar la garbación de la configuración en el registro de windows </summary>
  TRegistryConfig = class(TBaseConfig, IConfig)
    // pendiente de crear
    // pendient todo
  end;

  /// <summary> Factory class </summary>
  TFactoryConfig = class
    class function GetClass(aClassConfig:TClassConfig):IConfig;
  end;


implementation

uses
  System.Variants, System.Classes, DKLang;

{ TBaseConfig }

constructor TBaseConfig.Create;
begin
  inherited;
  FItems := TList<TConfigItem>.Create;
end;

destructor TBaseConfig.Destroy;
begin
  FreeAndNil(FItems);
end;

{ TDummyConfig }

procedure TDummyConfig.AddItem(AConfigName: string; AValue: Variant);
begin
  // Nothing to do
end;

procedure TDummyConfig.Clear;
begin
  // Nop
end;

function TDummyConfig.GetItem(AConfigName: string): Variant;
begin
  // nop
  Result := string.Empty;
end;

procedure TDummyConfig.RestoreConfig;
begin
  // Nothing to do
end;

procedure TDummyConfig.SaveConfig;
begin
  // Nothing to do
end;

{ TFileConfig }

procedure TFileConfig.AddItem(AConfigName: string; AValue: Variant);
begin
  // No existe
  if GetItem(AConfigName)='nop' then
    Items.Add(TConfigItem.Create(AConfigName, AValue));
end;

procedure TFileConfig.Clear;
begin
  Items.Clear;
end;

constructor TFileConfig.Create;
begin
  inherited Create;

end;

destructor TFileConfig.Destroy;
begin
  FreeAndNil(FIniFile);
  inherited;
end;

function TFileConfig.GetItem(AConfigName: string): Variant;
begin
  Result := 'nop';
  for var i := 0 to (FItems.Count - 1) do
    if FItems[i].Key = AConfigName then begin
      Result := FItems[i].Value;
      Break;
    end;
end;

procedure TFileConfig.RestoreConfig;
begin
  if (FIniFile.FileName = string.Empty) then
    raise Exception.Create(DKLangConstW('err_FilenameNotAssigned'));

  var tsValues:TStrings := TStringList.Create;
  FIniFile.ReadSection('Config', tsValues);
  try

    for var i := 0 to (tsValues.Count - 1) do begin
      var sValue := FIniFile.ReadString('Config', tsValues[i], string.Empty);
      FItems.Add(TConfigItem.Create(tsValues[i], sValue));
    end;
  finally
    FreeAndNil(tsValues);
  end;
end;

procedure TFileConfig.SaveConfig;
var
  aValue:string;
begin
  if (FIniFile.FileName = string.Empty) then
    raise Exception.Create(DKLangConstW('Err_FilenameNotAssigned'));

  for var i := 0 to (FItems.Count - 1) do begin
    aValue := VarToStrDef(FItems[i].Value, string.Empty);
    FIniFile.WriteString('Config', VarToStr(FItems[i].Key), aValue);
  end;
  FIniFile.UpdateFile;
end;

procedure TFileConfig.SetFileName(const Value: TFileName);
begin
  FFileName := Value;
  if not Assigned(FIniFile) then
    FIniFile := TInifile.Create(FFileName);
end;

{ TFactoryConfig }

class function TFactoryConfig.GetClass(aClassConfig: TClassConfig): IConfig;
begin
  Result := aClassConfig.Create;
end;

end.
