# GTMAuditR
De los creadores de <a href="https://analisis-web.es/audita-ga-con-r/">Audita tu configuración de Google Analytics con R</a> y de <a href="https://analisis-web.es/r-adobe-analytics/">Usa R para auditar tu instalación de Adobe Analytics</a> ....
<h2 style="text-align: center;"><span style="color: #ff6600;"><strong>Audita tu configuración de Google Tag Manager con R</strong></span></h2>
Porque sí. Porque lo andabas buscando y aquí está. Porque en el mundo en el que vivimos ya hay pocas implementaciones que no dependan de GTM y si no automatizamos la tarea nos vamos a volver locos echando horas entre etiquetas, activadores y variables

En esta ocasión e intentado hacerlo un poco mas fácil ( no sé si lo habré conseguido) No vais a necesitar buscar ids de cuentas ni de contenedores ya que el propio script os va a guiar para conseguirlo.
<h2 style="text-align: center;"><strong><span style="color: #ff6600;">¿Qué obtendrás tras ejecutar el script auditor de GTM?</span></strong></h2>
Después de poner en acción el script tendrás disponible en tu disco duro un archivo de Excel con cuatro pestañas:
<ol>
 	<li><strong>Workspaces:</strong> con los espacios de trabajo que estas utilizando.</li>
 	<li><strong>Variables:</strong> detalle de las variables que estas utilizando con detalle de Nombre, tipo y parámetros de cada una de ellas</li>
 	<li><strong>Etiquetas:</strong> listado de las etiquetas que tienes, el tipo, si están pausadas y un detalle muy bueno... <strong>el ID del activador que tiene asociado.</strong> De forma que en tu documento final de auditoría lo puedas asociar sin problema. La verdad es que esto lo podría haber simplificado poniendo los nombres de los activadores en lugar de los ID, lo dejo para una segunda versión.</li>
 	<li><strong>Triggers (activadores):</strong> como habrás supuesto ya... un listado con los activadores (id y nombre), los parámetros asociados...</li>
</ol>
Con todo eso espero que puedas hacer un buen documento, ya que te has ahorrado un buen rato  recorriendo  la interfaz de GTM...
<h2 style="text-align: center;"><strong><span style="color: #ff6600;">¿Cómo funciona el script auditor de GTM?</span></strong></h2>
Para empezar a usarlo debes tener unas consideraciones previas. Lo primero es que te instales las siguientes librerías:
<ul>
 	<li><strong>openxlsx</strong>: que controla la creación del fichero final.</li>
 	<li><strong>svDialogs:</strong> es la que utilizo para que te pregunte que cuentas quieres usar.</li>
 	<li><strong>googleTagManageR: </strong>El corazón del script. Con esta librería accedemos a la API de GTM y surge la magia.</li>
 	<li><strong>dplyr: </strong>con la que manejamos las tablas y los dataframes...</li>
</ul>
Una vez instaladas las librerías podemos empezar a jugar. Lo primero que va a pasar cuando lo ejecutes es que tendrás que pasr todo el proceso de autorizar tu cuenta ( o la que quieras usar) para ver los datos. Una vez autorizado el script te irá mostrando ventanas para preguntarte:
<ol>
 	<li>Cuenta de GTM que quieres usar</li>
 	<li>Contenedor que quieres ver.</li>
 	<li>Espacio de trabajo (workspace) que quieres ver</li>
</ol>
NO te preocupes, va a ser fácil, solo tienes que leer con atención y todo saldrá bien.

Después de preguntarte todas esas cosas ya tendrá toda la información necesaria para sacar los datos que necesita y devolverte el maravilloso Excel que estabas esperando.

En fin, ya puedes disfrutarlo y...

&nbsp;
