# Desplegando recursos con Terraform

Bienvenido al universo de la Infraestructura como código IaC. 

### ¿Qué es Terraform?
Terraform es un software de infraestructura como código (infrastructure as code) desarrollado por HashiCorp. Permite a los usuarios definir y configurar la infraestructura de un centro de datos en un lenguaje de alto nivel, generando un plan de ejecución para desplegar la infraestructura en un amplio catálogo de proveedores de servicio. La infraestructura se define utilizando la sintaxis de configuración de HashiCorp denominada HashiCorp Configuration Language (HCL).​

HashiCorp también mantiene el repositorio de configuraciones Terraform Module Registry, lanzado en 2017 durante la conferencia HashiConf.10​

### Recursos de interés 
Para que los mires/guardes/consultes cuando gustes o necesites. También os dejaré enlaces a determinados recursos:

+ [Visual Studio Code](https://code.visualstudio.com/)
+ [Documentación de Terraform / Hashicorp](https://www.terraform.io/)
+ [Repositorio de Terraform en GitHub](https://github.com/hashicorp/terraform)

### Requisitos principales del laboratorio:
+ Tener instalado Visual Studio Code
+ Tener instalado Terraform - [Instalador de Terraform](https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_windows_amd64.zip). Revisar como incorporar el ejecutable al path del sistema. Una vez instalado terraform de forma correcta deberías de poder lanzar terraform desde la terminal (git bash) y debería mostraros todos los comandos existentes en terraform.
+ Tener instalado AZURE CLI - [Instalación de Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)

### Objetivo del ejercicio
En el fichero main.tf del directorio Azure dispones de un script de Terraform que te permitirá desplegar una máquina virtual en Azure.
En el fichero main.tf del directorio GCP dispones de un script de Terraform que te permitirá desplegar una máquina virtual en Google Cloud.

+ El primero de los objetivos de este ejercicio es que comparéis ambos script y veáis las diferencias y semajanzas entre ellos. Fijaros, especialmente en el lenguaje empleado, las semejanzas entre ambos scripts y las diferencias de implementación. 
+ ¿Cual de los scripts os parece más sencillo? ¿Y más "didáctico"?