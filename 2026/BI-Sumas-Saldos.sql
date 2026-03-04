
SELECT hss.empresa, hss.ejercicio,  sum(hss.acumulado_debe ) debe, sum(hss.acumulado_haber ) haber
from hechos_sumas_saldos hss
WHERE hss.empresa ='004'
group by empresa , ejercicio
