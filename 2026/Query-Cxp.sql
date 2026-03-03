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





-- comparar este filtro que se pone en el where en oracle para un reporte, el cual se debe comparar con el segundo para validar si funcionaria con los mismo datos.
(
    FACTURAS_VENTAS.EMPRESA = FACTURAS_SUSTITUCIONES.EMPRESA(+)
    and FACTURAS_VENTAS.EJERCICIO = FACTURAS_SUSTITUCIONES.EJERCICIO(+)
    and FACTURAS_VENTAS.NUMERO_SERIE = FACTURAS_SUSTITUCIONES.NUMERO_SERIE(+)
    and FACTURAS_VENTAS.NUMERO_FACTURA = FACTURAS_SUSTITUCIONES.NUMERO_FACTURA(+)
    AND FACTURAS_VENTAS.EMPRESA = CLIENTES.CODIGO_EMPRESA
    AND FACTURAS_VENTAS.CLIENTE = CLIENTES.CODIGO_RAPIDO
    AND FACTURAS_VENTAS.NUMERO_FACTURA = V_FACTURAS_VENTAS_LIN.NUMERO_FACTURA
    AND FACTURAS_VENTAS.NUMERO_SERIE = V_FACTURAS_VENTAS_LIN.NUMERO_SERIE_FRA
    AND FACTURAS_VENTAS.ORGANIZACION_COMERCIAL = V_FACTURAS_VENTAS_LIN.ORGANIZACION_COMERCIAL
    AND FACTURAS_VENTAS.EJERCICIO = V_FACTURAS_VENTAS_LIN.EJERCICIO_FACTURA
    and V_FACTURAS_VENTAS_LIN.EMPRESA = ARTICULOS.CODIGO_EMPRESA
    and V_FACTURAS_VENTAS_LIN.ARTICULO = ARTICULOS.CODIGO_ARTICULO
    AND FACTURAS_VENTAS.EMPRESA = '004'
)
AND (FACTURAS_VENTAS.NUMERO_SERIE <> 'CAN')
AND FACTURAS_SUSTITUCIONES.NUMERO_SERIE_CAN IS NULL
AND V_FACTURAS_VENTAS_LIN.NUMERO_ALBARAN = ALBARAN_VENTAS_LIN.NUMERO_ALBARAN
AND V_FACTURAS_VENTAS_LIN.SUB_ALBARAN = ALBARAN_VENTAS_LIN.SUB_ALBARAN
AND V_FACTURAS_VENTAS_LIN.NUMERO_SERIE = ALBARAN_VENTAS_LIN.NUMERO_SERIE
AND V_FACTURAS_VENTAS_LIN.NUMERO_LINEA_ALBARAN = ALBARAN_VENTAS_LIN.NUMERO_LINEA_ALBARAN
AND V_FACTURAS_VENTAS_LIN.EJERCICIO = ALBARAN_VENTAS_LIN.EJERCICIO


-- Segundo filtro en el where para las query
albaran_ventas.numero_albaran = albaran_ventas_lin.numero_albaran
AND albaran_ventas.numero_serie = albaran_ventas_lin.numero_serie
AND albaran_ventas.ejercicio = albaran_ventas_lin.ejercicio
AND albaran_ventas.sub_albaran = albaran_ventas_lin.sub_albaran
AND albaran_ventas.organizacion_comercial = albaran_ventas_lin.organizacion_comercial
AND albaran_ventas.empresa = albaran_ventas_lin.empresa
AND clientes.codigo_empresa = albaran_ventas.empresa
AND clientes.codigo_rapido = albaran_ventas.cliente
AND albaran_ventas.empresa = :EMPRESA_ACTIVA
and ARTICULOS.CODIGO_ARTICULO = ALBARAN_VENTAS_LIN.ARTICULO
and ARTICULOS.CODIGO_EMPRESA = ALBARAN_VENTAS_LIN.EMPRESA
AND FACTURAS_VENTAS.NUMERO_FACTURA = ALBARAN_VENTAS.NUMERO_FACTURA
AND albaran_ventas.empresa = facturas_VENTAS.EMPRESA
AND albaran_ventas.ejercicio = facturas_ventas.ejercicio
AND FACTURAS_VENTAS.NUMERO_SERIE = ALBARAN_VENTAS.NUMERO_SERIE_FRA
AND (FACTURAS_VENTAS.NUMERO_SERIE <> 'CAN')
AND V_FACTURAS_VENTAS_LIN.NUMERO_ALBARAN = ALBARAN_VENTAS_LIN.NUMERO_ALBARAN
AND V_FACTURAS_VENTAS_LIN.SUB_ALBARAN = ALBARAN_VENTAS_LIN.SUB_ALBARAN
AND V_FACTURAS_VENTAS_LIN.NUMERO_SERIE = ALBARAN_VENTAS_LIN.NUMERO_SERIE
AND V_FACTURAS_VENTAS_LIN.NUMERO_LINEA_ALBARAN = ALBARAN_VENTAS_LIN.NUMERO_LINEA_ALBARAN
AND V_FACTURAS_VENTAS_LIN.EJERCICIO = ALBARAN_VENTAS_LIN.EJERCICIO





(select PRECIO_CONSUMO
    from precios_listas
    WHERE codigo_articulo = ARTICULOS.CODIGO_ARTICULO
    AND codigo_empresa = FACTURAS_VENTAS.EMPRESA
    AND organizacion_comercial = FACTURAS_VENTAS.ORGANIZACION_COMERCIAL
    and numero_lista='01'
    AND fecha_validez = (
        SELECT MAX(pl.fecha_validez)
        FROM precios_listas pl
        WHERE pl.codigo_empresa = precios_listas.codigo_empresa
            AND pl.organizacion_comercial = precios_listas.organizacion_comercial
            AND pl.numero_lista = precios_listas.numero_lista
            AND pl.codigo_articulo = precios_listas.codigo_articulo
            AND pl.fecha_validez <= V_FACTURAS_VENTAS_LIN.FECHA_PEDIDO
            AND pl.tipo_cadena = precios_listas.tipo_cadena
            AND pl.divisa = precios_listas.divisa )
)