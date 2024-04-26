## GET INFORMATION ABOUT INSTALLED BASE IN OPENSHIFT - KUBERNETES: 

**GITHUB**: *[https://github.com/maktup/GET-INFORMATION-INSTALLED-BASE-OCP-KUBE.git](https://github.com/maktup/GET-INFORMATION-INSTALLED-BASE-OCP-KUBE.git "https://github.com/maktup/GET-INFORMATION-INSTALLED-BASE-OCP-KUBE.git")*

## 1. CONTEXT:
For those of us who work with clients that manage containerized environments (**OPENSHIFT/KUBERNETES**), it is very important to have the complete details of said environments, to know information about:** OS, ENVIRONMENT, PLATFORM, EXACT VERSIONS, CAPABILITIES**, etc.


## 2. EXECUTION:
The execution would be as follows:

    $chmod 777 *.sh
    $ dos2unix *.sh
    $ sed -i 's/\r$//' *.sh
    $sh ./Script_Main.sh

**IMPORTANT: ** The **Script_Main.sh** Shell will internally call the Shell: **Script_getBaseInstalled.sh** to execute through Backgound and generate the Report called: **ReporteCluster.txt **(an example is shared to see how it looks).

![alt text](https://github.com/maktup/GET-INFORMATION-INSTALLED-BASE-OCP-KUBE/blob/main/IMAGENES/Imagen1.jpg?raw=true)

![alt text](https://github.com/maktup/GET-INFORMATION-INSTALLED-BASE-OCP-KUBE/blob/main/IMAGENES/Imagen2.jpg?raw=true)

![alt text](https://github.com/maktup/GET-INFORMATION-INSTALLED-BASE-OCP-KUBE/blob/main/IMAGENES/Imagen3.jpg?raw=true)

![alt text](https://github.com/maktup/GET-INFORMATION-INSTALLED-BASE-OCP-KUBE/blob/main/IMAGENES/Imagen4.jpg?raw=true)
 

This will speed up and minimize the number of times that the **Operations** person has to execute in **PRODUCTION**, it will only be enough to execute **1 Shell** and share the generated report file with us, to obtain all the information on the cluster carrier.

