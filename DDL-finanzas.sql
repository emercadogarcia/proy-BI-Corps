-- Definicion de datos de finanazas
-- 1. Histórico detallado de costo - BOL_FIN_002***.XLS
-- Campo requeridos ?? ==> No Habilitar
 
-- 2. Balance suma y saldos
-- Reporte nativo de libra     ==> No Habilitar
 
/* 3. FLUJO DE CAJA: .MAYOR BANCO.xls 
Campos requeridos: CODIGO ENTIDAD, NOMBRE ENTIDAD,FECHA,ASIENTO,LINEA,CUENTA, CONCEPTO,SIGNO, IMPORTE,DOCUMENTO,USUARIO,ENTIDAD,CODIGO CONCEPTO

Filtros para los datos de cuentas:
Codigo_cuenta: BOL => 111005 .. 111010 */

CREATE TABLE hechos_flujo_caja (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(5) NOT NULL,
    codigo_entidad VARCHAR(15),
    nombre_entidad VARCHAR(500),
    fecha_asiento DATE,
    numero_asiento_borrador BIGINT,         -- hasta 12 dígitos
    numero_linea_borrador INT,              -- hasta 9 dígitos
    codigo_cuenta VARCHAR(15),
    concepto VARCHAR(100),
    signo CHAR(1),                          -- usa CHAR(1) si es fijo
    importe DECIMAL(19,4) ,
    documento VARCHAR(100),
    usuario VARCHAR(10),
    entidad VARCHAR(2),
    codigo_concepto VARCHAR(4),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);
  -- se podria complementar  
    INDEX idx_empresa_cuenta (empresa, codigo_cuenta),
    INDEX idx_fecha_asiento (fecha_asiento),
    INDEX idx_codigo_entidad (codigo_entidad)



/* 4. Mayor_Detallado_proveedores.xlsx
Campos requeridos: Asiento, Documento, importe, Codigo proveedor
Filtros para los datos de cuentas:
Codigo_cuenta: BOL => 220505 .. 221001 */

CREATE TABLE hechos_mayor_det_prov (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa V ARCHAR(5) NOT NULL,
    codigo_proveedor VARCHAR(15) NOT NULL,
    asiento BIGINT,
    documento VARCHAR(100),
    importe DECIMAL(19,4) ,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
  -- se podria complementar  
    INDEX idx_empresa_proveedor (empresa, codigo_proveedor),
    INDEX idx_asiento (asiento)
 

/* 5. CXC: Reporte de cartera paso 2
Campos requeridos: Fecha factura, Fecha vencimiento, Numero Factura, Saldo, Importe, código Cliente
 */
CREATE TABLE hechos_cxc (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(5) NOT NULL,
    codigo_cliente VARCHAR(15),
    fecha_factura DATE,
    fecha_vencimiento DATE,
    documento VARCHAR(100),
    importe DECIMAL(19,4),
    saldo DECIMAL(19,4) ,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
  -- Se podria implementar  
    INDEX idx_empresa_cliente (empresa, codigo_cliente),
    INDEX idx_fecha_vencimiento (fecha_vencimiento)


/* 6. CXP: sitcarpa_isoliz
Reporte nativo de libra
Campos requeridos: Fecha, Fecha Factura, Fecha Vencimiento, Codigo proveedor, importe
 */
CREATE TABLE hechos_cxp (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(5) NOT NULL,
    codigo_proveedor VARCHAR(15) NOT NULL,
    fecha DATE,  --fecha asiento
    fecha_factura DATE,
    fecha_vencimiento DATE,
    documento VARCHAR(100),
    importe DECIMAL(19,4),
    created_at DATETIME ,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- 7. Maestro Clientes  (ya se tiene en el BI CORPS es necesario nuevamente enviar?)
-- Campos requeridos ??  ==> No Habilitar

/* 8. Maestro Proveedores.
   Campos requeridos: Codigo, Nombre,Nit, Razon Social, Ciudad, Departamento
 */
CREATE TABLE dim_proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(5) NOT NULL,
    codigo_proveedor VARCHAR(15) NOT NULL,
    nombre_proveedor VARCHAR(500),
    razon_social VARCHAR(500),
    nif VARCHAR(50),
    cod_dpto VARCHAR(5),
    departamento VARCHAR(50),
    cod_ciudad VARCHAR(5),
    ciudad VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
  -- Se podria implementar  
    UNIQUE KEY uk_empresa_prov (empresa, codigo_proveedor),
    INDEX idx_nif (nif)



/** QUERY Que se agrego a la vista VA_PROVEEDORES para enviar los datos */
D_PROV = SELECT lvprov.nombre FROM provincias lvprov WHERE lvprov.provincia = va_proveedores.provincia AND lvprov.estado = va_proveedores.estado
D_DPTO = SELECT p.nombre FROM comunidades_autonomas p WHERE p.comunidad_autonoma = va_proveedores.reservadoa01 and p.estado=va_proveedores.estado

/**** TABLA SUMAS Y SALDOS del reporte de BI */ 

CREATE TABLE hechos_sumas_saldos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(5) NOT NULL,
    codigo_cuenta VARCHAR(15),
    ejercicio DECIMAL(4,0),
    mes DECIMAL(3,0),
    tipo_periodo VARCHAR(5),
    grupo_balance VARCHAR(15), /* CODIGO_GRUPO */
    centro_contable VARCHAR(4), /*caracter_asiento */
    acumulado_debe DECIMAL(19,4),
    acumulado_haber DECIMAL(19,4),  
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
/*** TABLA GRUPO BALANCE Y CENTRO CONTABLE*/

CREATE TABLE dim_grupo_balance_ccont(
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(5) NOT NULL,
    grupo_balance VARCHAR(15), /* CODIGO_GRUPO */
    d_grupo_balance VARCHAR(500),
    centro_contable VARCHAR(4), /*caracter_asiento */
    d_centro_contable varchar(500),
    estado VARCHAR(4),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

