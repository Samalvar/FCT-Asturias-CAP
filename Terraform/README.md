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

### Objetivo del ejercicio
En el fichero main.tf del directorio Azure dispones de un script de Terraform que te permitirá desplegar una máquina virtual en Azure.
En el fichero main.tf del directorio GCP dispones de un script de Terraform que te permitirá desplegar una máquina virtual en Google Cloud.

+ El primero de los objetivos de este ejercicio es que comparéis ambos script y veáis las diferencias y semajanzas entre ellos. Fijaros, especialmente en el lenguaje empleado, las semejanzas entre ambos scripts y las diferencias de implementación. 
+ ¿Cual de los scripts os parece más sencillo? ¿Y más "didáctico"?