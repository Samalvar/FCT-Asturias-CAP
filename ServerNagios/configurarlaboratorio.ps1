# menú básico de configuración del laboratorio
clear-host
write-host "#############################"
write-host ""
write-host "            Menu             "
write-host ""
write-host "1. Instalar Azure Porwer Shell"
write-host "2. Conectar al tenant de azure"
write-host "3. Instalar y configurar el laboratorio"
write-host "4. Salir"
write-host "#############################"
$opc = Read-Host "Tu opcion: "
write-host ""
write-host "Has seleccionado la opcion [$opc]"

if($opc -ne 0  -or $opc -ge 4){
switch($opc){
  1 {write-host "Instalando Azure Powershell en tu Powershell..." -ForegroundColor Cyan
     Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

  }
  2 {write-host "Conectando con el Tenant de Azure - Cloud Austiria ..." -ForegroundColor Cyan
     Connect-AzAccount -TenantId 41ab59d4-05c4-4f27-b1b3-304baaf3c44a
 
  }
  3 {write-host "Instalando el laboratorio .... " -ForegroundColor Cyan
    
    write-host "Comprobando la conexion al Tenant de Cloud Austiria ..." -ForegroundColor Yellow

    $tenantId = (Get-AzContext).Tenant.Id
    if($tenantId -eq "41ab59d4-05c4-4f27-b1b3-304baaf3c44a")
    {
        write-host "Estas conectado al tenant correcto" -ForegroundColor Green
    }
    else
    {
        write-host "No estas conectado al tenant correcto" -ForegroundColor Magenta
        Connect-AzAccount -TenantId 41ab59d4-05c4-4f27-b1b3-304baaf3c44a
        echo ""
        write-host "Conexion correcta" -ForegroundColor Green
    }
    
    $deploymentName = Read-Host "Introduce un nombre para tu despliegue (Usa un nombre descriptivo - Ejemplo: DespliegueSamu): "

    $value=  Read-Host "Introduce las iniciales de tu nombre (Ejemplo APR de Alvaro Pena Ruiz): "

    (Get-Content .\resources\parameters.json) | ForEach-Object { $_ -replace "xxx","$value" } | Set-Content .\resources\parameters.json
    
    write-host "Iniciales actualizadas en el fichero parameters.json .... " -ForegroundColor Cyan
    write-host "Desplegando la infraestructura del laboratorio .... " -ForegroundColor Yellow

    $templateFile = ".\resources\template.json"
    $parameterFile=".\resources\parameters.json"

    New-AzResourceGroupDeployment `
        -Name $deploymentName `
        -ResourceGroupName MonitoringPOC `
        -TemplateFile $templateFile `
        -TemplateParameterFile $parameterFile

  }
  4 {write-host "fin" -ForegroundColor Red
      exit
  }

}

}
