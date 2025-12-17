CREATE OR REPLACE PROCEDURE PROC_GENERA_EXCEL_BALANCE AS
BEGIN
  -- 1. Configuración de sesión (del log)
  EXECUTE IMMEDIATE 'ALTER SESSION SET TIME_ZONE = ''-04:00''';
  PKPANTALLAS.SET_EMPRESA_USUARIO(p_empresa => '004', p_usuario => 'EMERCADO', p_perfil => '1SISTEMAS');
  PKPANTALLAS.SET_IDIOMA_USUARIO_VALIDADO(p_idioma => 23);
  PKPANTALLAS.SET_VARIABLE_INT(p_variable => 'PKIDIOMAS.REG_FALLOS_TRADUCCION', p_valor => 'N');

  -- 2. Carga del programa
  PKPANTALLAS.CARGA_DATOS_PROGRAMA(
    p_programa                  => 'C_MBALRA',
    p_usuario                   => 'EMERCADO',
    p_empresa                   => '004',
    p_prueba_fallos             => 'N',
    p_idioma                    => 23,
    p_lista_valores_contextual  => 'S',
    p_enviar_excel              => 'S',
    p_seleccionar_campos_excel  => 'S',
    p_enviar_grafico            => 'N'
  );

  -- 3. Parámetros basados en el nuevo Excel (periodos 0-6, ejercicio 2024)
  IMP.SET_PARAMETRO('TIPOS_PERIODO', 'MES');
  IMP.SET_PARAMETRO('PERIODO_DESDE', '0');
  IMP.SET_PARAMETRO('PERIODO_HASTA', '6');
  IMP.SET_PARAMETRO('EJERCICIO', '2024');
  IMP.SET_PARAMETRO('GRUPO_BALANCE', '0401');
  IMP.SET_PARAMETRO('NIVEL', '4');
  IMP.SET_PARAMETRO('MAYORES', 'S');
  IMP.SET_PARAMETRO('TODOS_NIVELES', 'S');
  IMP.SET_PARAMETRO('INT_EXT', 'A');
  IMP.SET_PARAMETRO('TIPO_LISTADO', 'NORMAL');
  IMP.SET_PARAMETRO('FECHA_BALANCE', '15/12/2025');
  IMP.SET_PARAMETRO('TIPO_RUPTURA', 'N');
  IMP.SET_PARAMETRO('ESTADO', 'BOL');

  -- 4. Configuración de salida a archivo Excel
  IMP.SET_PARAMETRO('DISPOSITIVO_SALIDA', 'FILE');
  IMP.SET_PARAMETRO('DESTINO', 'c_mbalra_emercado_' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '.xlsx');  -- Nombre dinámico
  IMP.SET_PARAMETRO('TIPO_FICHERO', 'ENHANCEDSPREADSHEET');
  IMP.SET_PARAMETRO('IMPRESION_ASINCRONA', 'S');
  IMP.SET_PARAMETRO('INFORME', 'fi_c_mbalra.xdo');

  -- Parámetros P_LIBRA_ (del log)
  IMP.SET_PARAMETRO('P_LIBRA_USUARIO', 'EMERCADO');
  IMP.SET_PARAMETRO('P_LIBRA_CODIGO_EMPRESA', '004');
  IMP.SET_PARAMETRO('P_LIBRA_IDIOMA_USUARIO', '23');
  -- Agregar el resto según log si es necesario

  -- 5. Ejecución
  IMP.EJECUTAR_INFORME;

  -- 6. Limpieza
  IMP.DELETE_PARAMETRO_INT('P_LIBRA_USUARIO');
  -- Eliminar otros P_LIBRA_

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
