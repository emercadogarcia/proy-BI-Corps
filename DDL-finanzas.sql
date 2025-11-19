-- Definicion de datos de finanazas
-- 1. Histórico detallado de costo - BOL_FIN_002***.XLS
-- Campo requeridos ?? ==> No Habilitar
 
-- 2. Balance suma y saldos
-- Reporte nativo de libra     ==> No Habilitar
 
3. FLUJO DE CAJA: .MAYOR BANCO.xls 
Campos requeridos: CODIGO ENTIDAD, NOMBRE ENTIDAD,FECHA,ASIENTO,LINEA,CUENTA.CONCEPTO,SIGNO, IMPORTE,DOCUMENTO,USUARIO,ENTIDAD,CODIGO CONCEPTO
 
create table hechos_flujo_caja (
id integer,
empresa varchar2(5),
codigo_entidad varchar2(15),
nombre_entidad varchar2(500),
fecha_asiento date ,
numero_asiento_borrador number(12),
numero_linea_borrador number(9),
codigo_cuenta varchar2(15),
concepto varchar2(100),
signo varchar2(1),
importe number(19,4),
documento varchar2(100),
usuario varchar2(10),
entidad varchar2(2),
codigo_concepto varchar2(4)
created_at datetime,
updated_at datetime
 );


4. Mayor_Detallado_proveedores.xlsx
Campos requeridos: Asiento, Documento, importe, Codigo proveedor

create table hechos_mayor_det_prov (
id integer,
empresa varchar2(5),
codigo_proveedor varchar2(15),
nombre_proveedor varchar2(500),
asiento number(12),
documento varchar2(100),
importe number(19,4),
created_at datetime,
updated_at datetime
 );
 

5. CXC: Reporte de cartera paso 2
Campos requeridos: Fecha factura, Fecha vencimiento, Numero Factura, Saldo, Importe, código Cliente

create table hechos_CXC (
id integer,
empresa varchar2(5),
codigo_cliente varchar2(15),
**** nombre_entidad varchar2(500),
asiento number(12),
fecha_factura date,
fecha_vencimiento date,
numero_factura | documento varchar2(100),
importe number(19,4),
saldo NUMBER(19,4),
created_at datetime,
updated_at datetime
 );


6. CXP: sitcarpa_isoliz
Reporte nativo de libra
Campos requeridos: Fecha,Fecha Factura, Fecha Vencimiento, Codigo proveedor, importe



-- 7. Maestro Clientes  (ya se tiene en el BI CORPS es necesario nuevamente enviar?)
-- Campos requeridos ??  ==> No Habilitar

8. Maestro Proveedores.
Campos requeridos ??
    Campos requeridos ?? Codigo, Nombre,Nit, Razon Social, Ciudad, Departamento

create table dim_proveedores (
id integer,
empresa varchar2(5),
codigo_proveedor varchar2(15),
nombre_proveedor varchar2(500),
razon_social varchar2(500),
nif VARCHAR2(50),
departamento varchar2(50)
ciudad varchar2(50)
created_at datetime,
updated_at datetime
 );