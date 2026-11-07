# Validación documentada

Este documento resume la evaluación de la tesis. Su preparación para el repositorio no constituye una nueva ejecución ni sustituye registros originales. No incluye imágenes ni informes completos.

## Diseño

Se construyeron secuencialmente un escenario manual y otro automatizado desde una base común, separada del laboratorio de implementación. Se combinaron consultas locales, pruebas funcionales, registros de IIS y escaneos Nessus no autenticados con Basic Network Scan y rango declarado de puertos 80 y 443.

La configuración se identifica como IisSeguro.ps1 y los datos como laboratorio.psd1.

## Comprobaciones

| Categoría | Comprobación |
|---|---|
| Aprovisionamiento | Características de Windows y estado DSC |
| Cabeceras | Configuración y ausencia de Server y X-Powered-By en respuestas examinadas |
| Directorios | Configuración y rechazo del listado con subestado 403.14 |
| TRACE | Regla de denegación y rechazo con subestado 404.6 |
| Protocolos | Valores de Schannel y comprobaciones correspondientes |
| Identidades | ApplicationPoolIdentity, asociación del sitio y autenticación anónima |
| Reaplicación | Operaciones por recurso y conformidad posterior |

## Resultados

De once recomendaciones seleccionadas, diez cumplieron y una se clasificó como no aplicable en ambos escenarios. No quedaron recomendaciones incumplidas o inconclusas. El cumplimiento y la cobertura fueron de 100.00 % sobre las diez aplicables, no sobre la seguridad integral del servidor.

SSL 2.0 fue no aplicable por las condiciones de soporte de la plataforma, no por una desactivación realizada mediante DSC.

La reaplicación posterior al reinicio procesó 19 recursos sin operaciones de establecimiento y mantuvo InDesiredState=True. No se introdujeron desviaciones deliberadas para evaluar recuperación.

## Hallazgos conservados

- Plugin 42873: suite DES-CBC3-SHA en ambos escenarios.
- Plugin 51192: condición de confianza de la cadena del certificado.
- Plugin 57582: certificado autofirmado no reconocido por el escáner.

No se descartaron como falsos positivos. No se documentó corrección seguida de reescaneo ni se demostró explotación. Los conjuntos generales de plugins correspondieron a actualizaciones diferentes; las ejecuciones no fueron completamente idénticas.

## Interpretación

Ambos procedimientos alcanzaron los requisitos aplicables. El modelo aportó representación y comprobación de estados administrados, sin demostrar superioridad de seguridad. El análisis fue descriptivo, sin réplicas independientes suficientes para inferencia estadística.

Los respaldos se conservan por separado. Este resumen no constituye evidencia independiente de ejecución ni sustituye los capítulos 4 y 5.
