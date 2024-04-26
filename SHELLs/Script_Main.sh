#!/bin/bash

# ********************************************************* 
# * - DESCRIPCION: Shell gatillador del Script principal  *
# * - EJECUCION:   SHELL    								   	 					*
# * - AUTOR:       Guerra Arnaiz, Cesar Ricardo  		  	 	*
# * - FECHA:       26/04/2024			      									*
# * - VERSION:     2.0									   	    					*
# *********************************************************
clear

vCURRENT_DATE=`date +%Y%m%d%H%M%S`
vTRANSACTION="$vCURRENT_DATE - [INFO]": 
vWAIT_TIME=4
vDATE_LOG=`date +%Y%m%d`

vNOMBRE_SHELL=Script_getBaseInstalada.sh
vNOMBRE_REPORTE=ReporteCluster.txt

echo "${vTRANSACTION}> INICIO DE EJECUCIÓN DE SCRIPT: [${vNOMBRE_SHELL}], ESPERAR UNOS SEGUNDOS HASTA EL TERMINO EL PROCESAMIENTO."

#EJECUTANDO SCRIPT: 
./${vNOMBRE_SHELL} > ${vNOMBRE_REPORTE} 2>&1

echo "${vTRANSACTION}> EJECUCIÓN DE SCRIPT COMPLETADO, VALIDAR EL ARCHIVO GENERADO EJECUTANDO EL COMANDO: [cat ${vNOMBRE_REPORTE}]."
