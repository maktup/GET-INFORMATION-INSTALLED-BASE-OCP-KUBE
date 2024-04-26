#!/bin/bash

# *********************************************************************** 
# * - DESCRIPCION: Shell para obtener información de la base instalada  *   
#                  en los entornos: OPENSHIFT/KUBERNETES                *
# * - EJECUCION:   SHELL    								   	 							          *
# * - AUTOR:       Guerra Arnaiz, Cesar Ricardo  		  	 			          *
# * - FECHA:       26/04/2024			      										            *
# * - VERSION:     2.0									   	    							          *
# ***********************************************************************

clear

vCURRENT_DATE=`date +%Y%m%d%H%M%S`
vTRANSACTION="$vCURRENT_DATE - [INFO]": 
vWAIT_TIME=4
vDATE_LOG=`date +%Y%m%d`

echo "${vTRANSACTION} ******************** [START] ********************"
echo "${vTRANSACTION} EXECUTING SCRIPT..."
echo ""
 
echo "${vTRANSACTION}> [COMMAND #1]: ¿QUE 'PLATAFORMA / S.O / CLOUD' SE TIENE INSTALADA?" 
cat /etc/*release
echo ""
uname -r
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #2]: ¿QUE VERSIÓN DE 'OPENSHIFT / KUBERNETES' SE TIENE INSTALADA?"
oc version
echo ""
kubectl version
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #3]: ¿CUANTOS 'NODOS' TIENEN ACTIVOS?"
oc get nodes -o wide
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #4]: ¿CUANTA 'CPU/MEMORIA' SE TIENE ASIGNADO & EN USO POR CADA 'VIRTUAL MACHINE'?"
kubectl top node --use-protocol-buffers
echo ""
oc adm top node --use-protocol-buffers
echo ""
oc get nodes -o=custom-columns=NODE:.metadata.name,CPU:.status.capacity.cpu,MEMORY:.status.capacity.memory
echo ""
oc get nodes -o=custom-columns=NODE:.metadata.name,CPU:.status.capacity.cpu,MEMORY:.status.capacity.memory --no-headers | awk '{printf "%s\t%s\t%.2fMi\n", $1, $2, $3/1024/1024}'
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #5]: ¿CUANTO 'STORAGE' (PV) & QUE TIPO SE TIENE UTILIZANDO EN EL CLUSTER?"
oc get pv -o custom-columns=NAME:.metadata.name,CAPACITY:.spec.capacity.storage,CLAIM:.spec.claimRef.name,STATUS:.status.phase,USED:.status.capacity.storage
echo ""
oc get pv -o custom-columns=NAME:.metadata.name,STORAGE_CLASS:.spec.storageClassName
echo ""  
echo ""

echo "${vTRANSACTION}> [COMMAND #6]: ¿CUANTAS CAPACIDADES DE 'CLOUD-PAK' TIENE INSTALADO?"
oc get operators 
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #7]: ¿CUANTAS INSTANCIAS DE: 'MQ' SE TIENE INSTALADO?"
kubectl get QueueManagers --all-namespaces   
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #8]: ¿CUANTAS INSTANCIAS DE: 'IBM APP CONNECT' SE TIENE INSTALADO?"
kubectl get Dashboard --all-namespaces
echo ""
kubectl get IntegrationServer --all-namespaces
echo ""
kubectl get IntegrationRuntime --all-namespaces
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #9]: ¿CUANTAS INSTANCIAS DE: 'IBM API CONNECT' & COMPONENTES SE TIENE INSTALADO?"
kubectl get apic --all-namespaces
echo ""
kubectl get APIConnectCluster --all-namespaces
echo ""
kubectl get AnalyticsCluster --all-namespaces
echo ""
kubectl get GatewayCluster --all-namespaces
echo ""
kubectl get ManagementCluster --all-namespaces
echo ""
kubectl get PortalCluster --all-namespaces
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #10]: ¿CUANTAS INSTANCIAS DE: 'EVENT-STREAMS' SE TIENE INSTALADO?"
kubectl get EventStreams --all-namespaces 
echo ""
echo ""

echo "${vTRANSACTION}> [COMMAND #11]: ¿CUANTO STORAGE (PV) SE TIENE ASIGNADO POR CADA NODO INSTALADO?"
#OBTENIENDO: NODOS, PVC, etc
kubectl get pods --all-namespaces --no-headers -o custom-columns=NODE:.spec.nodeName,NAMESPACE:.metadata.namespace,POD:.metadata.name,PVC:.spec.volumes[*].persistentVolumeClaim.claimName | \
while IFS=' ' read -r vNODE vNAMESPACE vPOD vPVC ; do
    #Verificar si vPVC no es "<none>"
    if [ "$vPVC" != "<none>" ]; then
        #echo "===> vPVC: $vNODE"
        
        # OBTENIENDO: PV
        vPV=$(oc get pvc "$vPVC" -o=jsonpath='{.spec.volumeName}' -n "$vNAMESPACE" 2>/dev/null)
        #echo "===> vPV: $vPV"
        
        if [ -n "$vPV" ]; then
            # OBTENIENDO: CAPACIDAD
            vPV_DETAILS=$(oc get pv "$vPV" -o jsonpath='{.spec}' 2>/dev/null)
            #echo "===> vPV_DETAILS: $vPV_DETAILS"
            
            if [ -n "$vPV_DETAILS" ]; then
                vCAPACIDAD=$(echo "$vPV_DETAILS" | jq -r '.capacity.storage // "-"')
                #echo "===> vCAPACIDAD: $vCAPACIDAD"
                
                #IMPRIME REPORTE
                echo "NODE: $vNODE \t CAPACITY: $vCAPACIDAD" 
            fi 
        fi 
    fi 
done
echo ""
echo ""

echo "${vTRANSACTION} ******************** [FINISH] ********************"




