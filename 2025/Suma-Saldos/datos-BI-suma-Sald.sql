


-- LLAMADO DE PROGRAMA
DECLARE
  v_informe VARCHAR2(300);
BEGIN
  IF :B1.TIPO_LISTADO = 'COMPARATIVO' THEN
    v_informe := 'fi_c_mbalco.xdo/fi_c_mbalco_H';
  ELSIF :B1.TIPO_LISTADO = 'SALDOS' THEN
   v_informe := 'fi_c_mbalco2.xdo/fi_c_mbalco2H';
  ELSIF :B1.TIPO_LISTADO = 'APERTURA'  THEN
    v_informe := 'fi_c_mbalsa.xdo/fi_c_mbalsa_V';
  ELSIF :B1.TIPO_LISTADO = 'CENTROS' THEN
    v_informe := 'fi_c_mbalrac.xdo/fi_c_mbalrac_V';
  ELSIF :B1.TIPO_LISTADO = 'ACENTROS' THEN
    v_informe := 'fi_c_mbalracc.xdo/fi_c_mbalracc_V';
  ELSE
    IF :B1.TIPO_RUPTURA = 'N' THEN
      v_informe := 'fi_c_mbalra.xdo/fi_c_mbalra_V';
    ELSIF :B1.TIPO_RUPTURA IN ('P','PA')   THEN
      v_informe := 'fi_c_mbalra_perac.xdo/fi_c_mbalra_perac_V';
    END IF;
  END IF;
  PKPANTALLAS.SET_VARIABLE_ENV('IMP_INFORME', v_informe);
END;