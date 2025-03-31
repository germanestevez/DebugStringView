unit uRecursos;

interface

// NOTA: Se hacen a través del proyecto:     Project /  DKLang - Edit project constants

{
resourcestring
  // columnas y campos
  title_ID = 'ID';
  title_Fecha = 'Fecha';
  title_hora = 'Hora';
  title_ProcessId = 'ProcessId';
  title_Nombre = 'Nombre';
  title_Mensaje = 'Mensaje';
  // operaciones de la aplicacion
  err_guardarFichero = 'Error al guardar el fichero; ';
  msg_Pausado = 'Pausado';
  msg_Activo = 'Activo';
  msg_lineas = 'líneas';
  errrestoreConfig = 'Error al restaurar la configuración del fichero <%s>' + sLineBreak + 'Eliminelo y ejecute de nuevo la aplicación.';
  errSaveConfig = 'Error al guardar la configuración en el fichero <%s>.' + sLinebreak +
                  'Puede ser debido a un error en el programa o a falta de permisos para escribir en el fichero.';
  msg_Idioma = 'Cambiar el idioma de la aplicación a [%s]';
  str_Filtered = 'Filtrado';
  msg_Updates1 = 'Se ha encontrado una versión más reciente de la aplicación <%s>.';
  msg_Updates2 = '¿Desea abrir la página web para descargarla?';
  msgUpdatesTitle = 'Buscar actualizaciones';
  msgNewVersion = 'Existe una actualización disponible <%s>. Pulse aquí para ir a la página de descarga.';

resourcestring
  _errcalcularVer = 'Error al consultar si hay nuevas versiones del programa.' + sLineBreak + '%s';
  _errDownload = 'Error al descargar el fichero: %s';

resourcestring
  _LBL_VERSION = 'Versión ';

resourcestring
  _errPath = 'Error, debe asignar un [path] para poder utlizar esta clase <%s>';
  _errMemo = 'Error, debe asignar un [memo] para poder utlizar esta clase <%s>';

resourcestring
  _err_NoSePuedeBorrar = 'Error, el fichero <%s> no se ha podido borrar.';
  _err_SinDatosAsignado = 'Error, la fuente da datos <dataset> no está asignado.';
  _err_Save = 'Error al guardar el fichero.' + sLineBreak + '%s';


resourceString
  _err_FilenameNotAssigned = 'No está asignado el nombre para el fichero de configuración.';

}
implementation

end.
