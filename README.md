# DebugStringView

<center>![logo](https://neftali.clubdelphi.com/wp-content/uploads/Logo1b.png)</center>

## Introducción
Esta aplicación le permite monitorizar la salida de depuración en su sistema local. Mostrará aquellos mensajes que se generen utilizando la API de Windows OutputDebugString.

![pantalla principal](https://neftali.clubdelphi.com/wp-content/uploads/Captura_2025-03-26-08_50_49-1024x617.png)

## Licencia
Se distribuye bajo licencia  GPL 3.0.
Puede usarla y modificarla líbremente.

## Ejecución
Además del código fuente la aplicación se distribuye en un fichero ZIP. No requiere instalación y basta con descomprimirla y ejecutarla.
Se puede descargar la versión compilada (fichero ZIP que incluye la verión de 32 y 64 bits) [desde la web de la aplicación](https://neftali.clubdelphi.com/debugstringview/).
[https://neftali.clubdelphi.com/debugstringview/](https://neftali.clubdelphi.com/debugstringview/)

## Código fuente
El código fuente de la aplicación está disponible en este repositorio.  
Está compilada con [Embarcadero Delphi 12.3](https://www.embarcadero.com/es/products/delphi)  
Utiliza para el multiidioma [los componentes DKLang](https://github.com/yktoo/dklang.git)  

## Características
 - Permite guardar el contenido de la captura en ficheros con extensión (*.dsvlog).
 - Filtrado rápido de mensajes por procesos (utiliza el nombre del proceso), incluyendo N procesos con diferente ProcessID, pero el mismo nombre.
 - Posibilidad de colorear la salida de mensajes por proceso (mejor y más clara visualización para el usuario).
 - Ocultar y mostrar columnas según lo que interese (más información o más espacio)
 - Avance automático a medida que van apareciendo los mensajes de forma que siempre se visualizan los últimos mensajes enviados a la consola.
 - Panel de “Lista de procesos” que nos muestra los procesos (ProcessName – nombre del proceso) que están enviando mensajes a la consola.
 - Permite el cambio rápido de la fuente de letra utilizada en la visualización con las fuentes monoespaciadas más habituales. También la opción de acceder a la pantalla de propiedades y cambiar el resto de características.
 - La aplicación es multiidioma y fácilmente ampliable con más ficheros de idioma sin necesidad de cambios en la aplicación (carga de idioma dinámica).
 - Comprobación de actualizaciones disponible y automática al entrar en la aplicación.
 - Columnas personalizables.

## Multiidioma
La aplicación trabaja con múltiples idiomas, que además que cargan de forma dinámica. Se pueden incorporar más idiomas de forma fácil (y sin recompilar) y la aplicación los reconocerá y los incorporará al menú de forma automática una vez que se ejecute.
La aplicación busca en la carpera “Languages” ficheros de idiomas.

![multiidioma](https://neftali.clubdelphi.com/wp-content/uploads/web_multiidioma.png)

**¿Quieres ayudar con una traducción?**

En la ayuda del programa están las instrucciones necesarias para generar nuevas traducciones. Si te animas, basta con descargar el fichero original de la traducción y una vez generada una nueva traducción la puedes añadir directamente al directorio de Languages incluido con la aplicación. Además, si me la envías la incluiré en la siguiente versión.
