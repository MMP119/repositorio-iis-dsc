# repositorio-iis-dsc

Modelo académico de aprovisionamiento y endurecimiento de Microsoft Internet Information Services (IIS) sobre Windows Server 2022 mediante Windows PowerShell Desired State Configuration (DSC) v1.1.

## Estructura

- `configurations/IisSeguro.ps1`: configuración principal.
- `configuration-data/laboratorio.psd1`: datos no sensibles del ambiente.
- `docs/alcance-y-ambiente.md`: ambiente y límites.
- `docs/validacion.md`: resumen de la evaluación de la tesis.

## Prerrequisitos

Windows Server 2022 previamente instalado, Windows PowerShell 5.1, DSC v1.1 y WebAdministrationDsc 4.2.1 disponible. Ejecutar con privilegios administrativos en laboratorio y conservar un punto de recuperación.

## Compilación y aplicación local

Desde la raíz del repositorio, en Windows PowerShell 5.1, ejecutar las instrucciones siguientes después de preparar las dependencias. Son instrucciones de uso, no un nuevo registro de ejecución.

```powershell
. ./configurations/IisSeguro.ps1
IisSeguro -ConfigurationData ./configuration-data/laboratorio.psd1 -OutputPath ./artifacts -ErrorAction Stop
Start-DscConfiguration -Path ./artifacts -Wait -Verbose -ErrorAction Stop
Get-DscConfigurationStatus
Test-DscConfiguration -Detailed
```

Cargar la definición y compilar no configura por sí mismo el servidor. Los cambios de protocolos pueden requerir reiniciar componentes que utilizan Schannel. En la investigación se realizó un reinicio controlado antes de completar las verificaciones. Planificar esta operación y comprobar la disponibilidad posterior.

## Reaplicación

```powershell
Start-DscConfiguration -Path ./artifacts -Wait -Verbose -ErrorAction Stop
Get-DscConfigurationStatus
Test-DscConfiguration -Detailed
```

Complementar la conformidad DSC con consultas y pruebas funcionales. No demuestra por sí sola cumplimiento integral de CIS ni seguridad integral.

## Alcance

Se administran componentes de IIS, cabeceras, directorios, TRACE, identidades y protocolos de Schannel en la rama Server. No se instalan Windows Server ni máquinas virtuales. No se declaran certificados, enlaces HTTPS, firewall, suites de cifrado ni metaconfiguración de autocorrección periódica.

Los datos identifican localhost, el ámbito de servidor y DefaultAppPool. Revisar el impacto antes de adaptar la solución. No aplicar en producción sin evaluar compatibilidad, permisos y recuperación.

## Documentación y evidencias

Los documentos de docs explican la solución y resumen la evaluación. Capturas, transcripciones e informes se conservan por separado. No se incluye una batería de pruebas automatizadas ni se sustituyen las evidencias de los capítulos 4 y 5.

## Licencia y seguridad

Consultar LICENSE. No publicar credenciales, claves privadas ni material sensible.
