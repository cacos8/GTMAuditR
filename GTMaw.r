#cargar e instalar librerias
#library(googleAuthR)
library(openxlsx)
library(svDialogs)
library(googleTagManageR)
library(dplyr)
#autenticacion
gtm_auth()
#recuperamos y elegimos la cuenta
cuentas<-gtm_accounts_list()
#elegir cuenta

res <- dlg_list(cuentas$name, multiple = TRUE)$res
if (!length(res)) {
  cat("You cancelled the choice\n")
} else {
  cat("You selected:\n")
  print(res)
}
id_cuenta<-filter(cuentas,name==res)
name_cuenta<-id_cuenta$name
id_cuenta<-id_cuenta$accountId
n_cuentas<-nrow(cuentas)

#elegir contenedores
contenedores<-gtm_containers_list(id_cuenta)
res <- dlg_list(contenedores$name, multiple = TRUE)$res
if (!length(res)) {
  cat("You cancelled the choice\n")
} else {
  cat("You selected:\n")
  print(res)
}
id_contenedor<-filter(contenedores,name==res)
name_contenedor<-id_contenedor$name
id_contenedor<-id_contenedor$containerId
n_contenedores<-nrow(contenedores)
#workspaces
workspaces<-gtm_workspaces_list(id_cuenta, id_contenedor)
res <- dlg_list(workspaces$name, multiple = TRUE)$res
if (!length(res)) {
  cat("You cancelled the choice\n")
} else {
  cat("You selected:\n")
  print(res)
}
id_wp<-filter(workspaces,name==res)
name_wp<-id_wp$name
id_wp<-id_wp$workspaceId
n_wp<-nrow(workspaces)

variables<-gtm_variables_list(id_cuenta, id_contenedor, id_wp)
etiquetas<-gtm_tags_list(id_cuenta, id_contenedor, id_wp)
triggers<-gtm_triggers_list(id_cuenta, id_contenedor, id_wp)
n_variables<-nrow(variables)
n_etiquetas<-nrow(etiquetas)
n_triggers<-nrow(triggers)





#estilo para cabeceras en excel
hs <- createStyle(fontColour = "#ffffff", fgFill = "#f39531", fontSize="14",
                  halign = "left", valign = "center", textDecoration = "Bold",wrapText = FALSE)
texto<- "Auditoría realizada por @analisisweb https://analisis-web.es"
timestamp() -> date
#Crea el objeto excel
archivo<-createWorkbook()
texto_vista<- name_contenedor
texto_time <-date

#addWorksheet(archivo, sheetName = "contenedores", gridLines = TRUE)
#writeData(archivo, "contenedores", contenedores, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
#writeData(archivo, "contenedores", name_contenedor, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
#writeData(archivo, "contenedores", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
#addStyle(archivo, "contenedores", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)

workspaces<-select(workspaces, workspaceId,name)
colnames(workspaces)<-c("id","Nombre")
addWorksheet(archivo, sheetName = "workspaces", gridLines = TRUE)
writeData(archivo, "workspaces", workspaces, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
writeData(archivo, "workspaces", name_contenedor, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
writeData(archivo, "workspaces", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
addStyle(archivo, "workspaces", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)

variables<-select(variables,name,type,parameter)
colnames(variables)<-c("Nombre","Tipo","Parámetros")
addWorksheet(archivo, sheetName = "variables", gridLines = TRUE)
writeData(archivo, "variables", variables, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
writeData(archivo, "variables", texto_vista, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
writeData(archivo, "variables", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
addStyle(archivo, "variables", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)

etiquetas<-select(etiquetas,name,type,firingTriggerId,tagFiringOption,paused)
colnames(etiquetas)<-c("Nombre","Tipo","Activador que lo dispara","Firing Option","Pausado?")
addWorksheet(archivo, sheetName = "etiquetas", gridLines = TRUE)
writeData(archivo, "etiquetas", etiquetas, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
writeData(archivo, "etiquetas", texto_vista, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
writeData(archivo, "etiquetas", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
addStyle(archivo, "etiquetas", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)



triggers<-select(triggers,triggerId,name,type,parameter,customEventFilter)
colnames(triggers)<-c("triggerID","Nombre","Tipo","parametro","customEventFilter")
addWorksheet(archivo, sheetName = "triggers", gridLines = TRUE)
writeData(archivo, "triggers", triggers, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
writeData(archivo, "triggers", texto_vista, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
writeData(archivo, "triggers", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
addStyle(archivo, "triggers", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)

#crea nombre de archivo
nombreArchivo <- paste0("GTmAW-",name_contenedor,".xlsx")


print(nombreArchivo)
saveWorkbook(archivo, nombreArchivo, overwrite = TRUE) ## save to working directory

