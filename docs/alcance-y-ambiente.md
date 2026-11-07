# Alcance y ambiente

## Ambiente de referencia

- Windows Server 2022 previamente instalado.
- Windows PowerShell 5.1 y DSC v1.1.
- WebAdministrationDsc 4.2.1, versión fijada en el código.
- Archivo de datos: configuration-data/laboratorio.psd1.
- Nodo: localhost.
- Ámbito IIS: MACHINE/WEBROOT/APPHOST.
- Grupo administrado: DefaultAppPool.

## Recursos

Con los datos suministrados se generan 19 recursos:

| Finalidad | Cantidad |
|---|---:|
| Características Windows | 5 |
| Propiedades y colecciones de directorios, cabeceras y TRACE | 4 |
| Grupo de aplicaciones | 1 |
| Identidad de autenticación anónima | 1 |
| Valores de Registro de protocolos | 8 |

SSL 3.0, TLS 1.0 y TLS 1.1 se declaran con Enabled=0 y DisabledByDefault=1; TLS 1.2 con Enabled=1 y DisabledByDefault=0. Se aplica a la rama Server de Schannel. No se modifican ramas Client, SSL 2.0, TLS 1.3 ni suites de cifrado.

## Identidades

Se administra DefaultAppPool y userName de autenticación anónima en el ámbito indicado. No se declara expresamente la asociación de Default Web Site al grupo ni la habilitación de autenticación anónima; estas condiciones se verificaron complementariamente. No se modifican las listas de control de acceso del contenido ni se demuestra aislamiento completo entre aplicaciones.

## Fuera de alcance

No se incluyen creación de máquinas virtuales, instalación del sistema operativo, certificados, enlaces HTTPS, reglas de firewall, pruebas funcionales ni metaconfiguración para establecer ApplyAndAutoCorrect.

## Independencia y límites

La separación de datos y declaraciones evita instrucciones específicas de un fabricante de hardware o hipervisor. No elimina dependencias de Windows y módulos ni demuestra portabilidad mediante ensayos en múltiples plataformas.

No se afirma seguridad integral, cumplimiento completo del benchmark, ahorro de tiempo ni recuperación de desviaciones deliberadas.
