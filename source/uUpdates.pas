unit uUpdates;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

const
  URL_UPDATES = 'https://neftali.clubdelphi.com/aplicaciones/DebugStringView/Updates/DebugStringView.cfg';
  DOWN_URL = 'https://neftali.clubdelphi.com/debugstringview/';

  NOVERSION = '0.0.0.0';

type
  TUpdatesResponse = (urNotfound, urNewest, urFindedUpdate);

  // interface para actualizaciones
  IUpdateSerach = interface
    function FindUpdates:TUpdatesResponse;
    function GetVersionActual: string;
    function GetVersionDescargada: string;
  end;

  /// <summary> Clase base para buscar actualizaciones de la aplicacion </summary>
  TBaseUpdateSearch = class(TInterfacedObject, IUpdateSerach)
  private
    function GetVersionActual: string;
    function GetVersionDescargada: string; virtual; abstract;
  private
    function InternalCalculate:TUpdatesResponse;
  public
    class procedure OpenUpdateWeb; virtual; abstract;
    /// <summary> Buscar actaulizaciones a partir de la version del programa </summary>
    function FindUpdates:TUpdatesResponse;
    /// <summary> Version actual del programa </summary>
    property VersionActual:string read GetVersionActual;
    /// <summary> Version consultada del programa (para actualizar) </summary>
    property VersionDescargada:string read GetVersionDescargada;
  end;
  TClassUpdate = class of TBaseUpdateSearch;

  /// <summary> Clase dummy </summary>
  TDummyUpdateSearch = class (TBaseUpdateSearch, IUpdateSerach)
  protected
    function GetVersionDescargada: string; override;
  public
    class procedure OpenUpdateWeb; override;
  end;

  /// <summary> Clase para buscar actualizaciones del programa en la web (http) </summary>
  TWebUpdateSearch = class (TBaseUpdateSearch, IUpdateSerach)
  private
    FVersionDescargada:string;
    procedure DescargarFichero(const URL, Destino: string; out aSize:integer);
    function GetVersionDescargada: string; override;
  public
    class procedure OpenUpdateWeb; override;
  end;

  TFactoryUpdate = class
    class function GetClass(aClassUpdate:TClassUpdate):IUpdateSerach;
  end;


implementation

uses
  System.IOUtils, IniFiles, uUtils, ShellAPI, DKLang;

{ TUpdateSearch }

function TWebUpdateSearch.GetVersionDescargada: string;
var
  aSize:integer;
begin
  // Ya calculada
  if (FVersionDescargada <> string.empty) then begin
    Result := FVersionDescargada;
    Exit;
  end;


  Result := NOVERSION;
  // buscar el fichero
  var dest := TPath.GetTempFileName;
  DescargarFichero(URL_UPDATES, dest, aSize);
  // SUPOSICION (para nuestrro caso):
  // si es correcto tendrá menos de 100 bytes   (mientras no se añadan más cosas)
  // si es incorrecto, tendrá más de 100000 bytes
  if (aSize < 1000) then begin
    try
      // Encontrado, hay que ver si tiene algo "con senido" o no
      var iniF := TIniFile.Create(dest);
      try
        Result := IniF.ReadString('Config', 'version', '0.0.0.0');
      finally
        FreeAndNil(iniF);
      end;
    except
      on E:Exception do begin
        raise Exception.Create(DKLangConstW('errcalcularVer') + sLineBreak + E.Message);
      end;
    end;
  end;
  FVersionDescargada := Result;
end;

class procedure TWebUpdateSearch.OpenUpdateWeb;
begin
  ShellExecute(HInstance, 'open', PChar(DOWN_URL), nil, nil, SW_NORMAL);
end;

procedure TWebUpdateSearch.DescargarFichero(const URL, Destino: string; out aSize:integer);
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  FileStream: TFileStream;
begin
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);

  try
    RESTClient.BaseURL := URL;
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method := rmGET;

    RESTRequest.Execute;

    if RESTResponse.StatusCode = 200 then
    begin
      FileStream := TFileStream.Create(Destino, fmCreate);
      try
        FileStream.WriteBuffer(RESTResponse.RawBytes[0], Length(RESTResponse.RawBytes));
        aSize := Length(RESTResponse.RawBytes);
      finally
        FileStream.Free;
      end;
    end
    else
      raise Exception.Create(Format(DKLangConstW('errDownload'), [RESTResponse.StatusText]));
  finally
    RESTClient.Free;
    RESTRequest.Free;
    RESTResponse.Free;
  end;
end;

{ TBaseUpdateSearch }

function TBaseUpdateSearch.FindUpdates: TUpdatesResponse;
begin
  Result := InternalCalculate;
end;

function TBaseUpdateSearch.GetVersionActual: string;
begin
  Result := GetAppVersion(ParamStr(0));
end;

function TBaseUpdateSearch.InternalCalculate: TUpdatesResponse;
begin
  Result := urNotfound;
  var i := CompareVersions(VersionActual, VersionDescargada);
  if (i >= 0) then         // mayor la actual
    Result := urNewest
  else if (i < 0) then   // Mayor la descargada
    Result := urFindedUpdate;
end;

{ TDummyUpdateSearch }

function TDummyUpdateSearch.GetVersionDescargada: string;
begin
  Result := '1.1';
end;

class procedure TDummyUpdateSearch.OpenUpdateWeb;
begin
  ShellExecute(HInstance, 'open', PChar(DOWN_URL), nil, nil, SW_NORMAL);
end;

{ TFactoryUpdate }

class function TFactoryUpdate.GetClass(aClassUpdate: TClassUpdate): IUpdateSerach;
begin
  Result := aClassUpdate.Create;
end;

end.
