/* consultar datos de grupo balance y sumas saldo*/

SELECT dgbc.*
FROM base_bi.dim_grupo_balance_ccont AS dgbc
WHERE ejercicio =2025 
GROUP BY empresa, grupo_balance, centro_contable
2025== 20 MILLONES

SELECT empresa, ejercicio, SUM(COALESCE(hss.acumulado_debe, 0)) AS sum_debe,
SUM(COALESCE(hss.acumulado_haber, 0)) AS sum_Haber
FROM base_bi.hechos_sumas_saldos AS hss
where hss.codigo_cuenta like '4%'
GROUP BY empresa, ejercicio 

2025== 20 MILLONES

empresa, grupo_balance, centro_contable
ejercicio, mes





--- inner join
SELECT 
    dgbc.empresa,
    dgbc.grupo_balance,
    dgbc.centro_contable,
    dgbc.d_centro_contable,    -- Aquí puedes agregar otros campos de dgbc si los necesitas
    hss.empresa          AS hss_empresa,          -- para comparar/visualizar
    hss.grupo_balance    AS hss_grupo_balance,
    hss.centro_contable  AS hss_centro_contable,
    hss.acumulado_debe,         ---campo compl.
    hss.acumulado_haber
FROM base_bi.dim_grupo_balance_ccont AS dgbc
INNER JOIN base_bi.hechos_sumas_saldos AS hss
    ON  dgbc.empresa        = hss.empresa
    AND dgbc.grupo_balance  = hss.grupo_balance
    AND dgbc.centro_contable = hss.centro_contable
ORDER BY 
    dgbc.empresa, dgbc.grupo_balance, dgbc.centro_contable
LIMIT 100;   




/* LEFT JOIN */
SELECT 
    dgbc.empresa,
    dgbc.grupo_balance,
    dgbc.centro_contable,
    hss.centro_contable  AS hss_centro_contable,    -- Otros campos de dgbc...
    hss.acumulado_debe,         -- campo compl.
    hss.acumulado_haber
    CASE 
        WHEN hss.empresa IS NULL THEN 'Sin hechos asociados' 
        ELSE 'Tiene hechos' 
    END AS estado_hechos
FROM base_bi.dim_grupo_balance_ccont AS dgbc
LEFT JOIN base_bi.hechos_sumas_saldos AS hss
    ON  dgbc.empresa        = hss.empresa
    AND dgbc.grupo_balance  = hss.grupo_balance
    AND dgbc.centro_contable = hss.centro_contable
ORDER BY 
    dgbc.empresa, dgbc.grupo_balance, dgbc.centro_contable
LIMIT 100;

-- EJEMPLO 2
SELECT
    dgbc.empresa,
    COUNT(*) AS centros_sin_movimiento
FROM base_bi.dim_grupo_balance_ccont dgbc
LEFT JOIN base_bi.hechos_sumas_saldos hss
    ON  dgbc.empresa = hss.empresa
    AND dgbc.grupo_balance = hss.grupo_balance
    AND dgbc.centro_contable = hss.centro_contable
WHERE hss.empresa IS NULL
GROUP BY dgbc.empresa
ORDER BY centros_sin_movimiento DESC;





SELECT * 
FROM base_bi.dim_grupo_balance_ccont
WHERE estado <> 'ECU' AND (empresa = '003')

delete FROM base_bi.dim_grupo_balance_ccont AS dgbc
WHERE grupo_balance <> '0401' AND (empresa = '004')






