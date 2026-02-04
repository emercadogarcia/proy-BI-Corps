-- REVISAR DATOS CxP
SELECT 
    empresa , codigo_proveedor ,
    YEAR(fecha_factura) AS anio,
    COUNT(*) AS total_registros, -- Opcional: para ver cuántas facturas hay por fecha
    sum(importe ) ttl_imp 
FROM 
    base_bi.hechos_cxp
WHERE YEAR(fecha_factura) IN (2024,2025)
GROUP BY 
    empresa,codigo_proveedor , anio-- Agrupamos por los tres para mantener el detalle diario

-- *************************************************
SELECT 
    empresa , 
    YEAR(fecha_factura) AS anio,
    COUNT(*) AS total_registros, -- Opcional: para ver cuántas facturas hay por fecha
    sum(importe ) ttl_imp 
FROM 
    base_bi.hechos_cxp
WHERE YEAR(fecha_factura) IN (2024,2025)
GROUP BY 
    empresa, anio
 -- *************************************************
delete from base_bi.hechos_cxp;
commit;
