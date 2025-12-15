/* para consultar datos */

-- CXC
SELECT hc.empresa, COUNT(*) cant
FROM base_bi.hechos_cxc AS hc
group by hc.empresa 


-- CXP
SELECT hc.empresa, COUNT(*) cant
FROM base_bi.hechos_cxp AS hc
group by hc.empresa 

-- gastos

SELECT hc.empresa, COUNT(*) cant
FROM base_bi.hechos_gastos AS hc
group by hc.empresa 


-- hechos_mayor_det_prov
SELECT mdp.empresa, COUNT(*) cant
FROM base_bi.hechos_mayor_det_prov AS mdp
group by mdp.empresa 


-- hechos_flujo_caja

SELECT fc.empresa, COUNT(*) cant
FROM base_bi.hechos_flujo_caja AS fc
group by fc.empresa 

-- dim_proveedores
SELECT pr.empresa, COUNT(*) cant
FROM base_bi.dim_proveedores AS pr
group by pr.empresa 

-- DIM_GASTOS ==> dim_centrocosto
SELECT cc.empresa, COUNT(*) cant
FROM base_bi.dim_centrocosto AS cc
group by cc.empresa 
