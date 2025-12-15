-- ENVIO DE REPORTES DESDE LIBRA PARA TABLERO FINANCIERO

PKALRTJOB.SET_PROPIEDAD('INICIALIZAR_INFORMES_ADJUNTOS', 'S');
PKALRTJOB.ADD_ADJUNTO_GI('RD_ALM_011', 'DEVTA_' || TO_CHAR(SYSDATE, 'DDMMYYYY_HH24MI') || '.xls', '01', '002', 'JREINOSO', '', 'EXCELXML', ''); 
COMMIT;
PKALRT.GRABAR_COLA_ALERTAS(p_numero_alerta => 9998);


-----------------------------------------------



UPDATE alrt_alertas SET procedimiento_ejecutar = 'PKALRTJOB.SET_PROPIEDAD(''INICIALIZAR_INFORMES_ADJUNTOS'', ''S'');
PKALRTJOB.ADD_ADJUNTO_GI(''BOL_FIN_004_ETL'', ''ETL-FLUJO-CAJA.xlsx'', ''17'', ''004'', ''EMERCADO'', ''P3208'', ''EXCELXML'', 568918);
commit;' WHERE numero_alerta = 4009; -- SE ADCIIONA MAS ARCHIVOS
UPDATE alrt_alertas SET procedimiento_ejecutar = procedimiento_ejecutar ||'
PKALRTJOB.ADD_ADJUNTO_GI(''BOL_FIN_004_ETL'', ''ETL-MAYOR-DET-PROVEEDOR.xlsx'', ''17'', ''004'', ''EMERCADO'', ''P3209'', ''EXCELXML'', 569017);
PKALRTJOB.ADD_ADJUNTO_GI(''BOL_PROVEEDORES_ETL'', ''ETL-MAESTRO-PROVEEDORES.xlsx'', ''17'', ''004'', ''EMERCADO'', ''P3210'', ''EXCELXML'', 569044);
PKALRTJOB.ADD_ADJUNTO_GI(''BOL_CXC_ETL'', ''ETL-CARTERA_CXC.xlsx'', ''17'', ''004'', ''EMERCADO'', ''P3228'', ''EXCELXML'', 572948);
PKALRTJOB.ADD_ADJUNTO_GI(''BI_CORP_GASTOS'', ''ETL_Gastos.xlsx'', ''17'', ''004'', ''DLOBO'', ''P3158'', ''EXCELXML'', 569168);
PKALRTJOB.ADD_ADJUNTO_GI(''BI_CORP_DIM_GASTOS'', ''ETL_CentroCosto.xlsx'', ''17'', ''004'', ''DLOBO'', ''P3161'', ''EXCELXML'', 569170);
PKALRTJOB.ADD_ADJUNTO_GI(''FI_CARTERA_VENC_PROV_ETL'', ''ETL-CARTERA-VENC-PROV-CXP.xlsx'', ''17'', ''004'', ''EMEERCADO'', ''P3212'', ''EXCELXML'', 569273);
 commit;
 ' WHERE numero_alerta = 4009;

PKALRT.GRABAR_COLA_ALERTAS(p_numero_alerta => 4009, p_asunto_alerta=>'[BI CORP] - DATOS TABLERO FINANCIERO', p_notificar_mail_to => 'ETL.suco@gmail.com', p_notificar_mail_cc => 'daniel.lobo@promedical.com.bo, EDGAR.MERCADO@promedical.com.bo, marcelo.osinaga@promedical.com.bo', p_texto_alerta_html_clob => '<h3><br>Saludos:<br/>
<br>Adjunto los archivos con los datos para el tablero finanaciero, hasta fecha '||TO_CHAR(CURRENT_DATE, 'DD-MM-YYYY HH24:MI:SS') ||
' <br/></h3>');

UPDATE alrt_alertas SET procedimiento_ejecutar = NULL WHERE numero_alerta=4009;
commit;


---------------------------

decode(HISTORICO_DETALLADO_COSTE.EMPRESA, '004',decode(SUBSTR(HISTORICO_DETALLADO_COSTE.CENTRO_COSTE,1,2),'03','PROMEDICAL DIST','02','SUIPHAR','01','PROCAPS','00','GENERAL','04','VITAL CARE','05','GRUNENTHAL','06','CLINICAL SPECIALTIES','07','HERSIL REPRES.','08','HERSIL SA','SIN UEN'),'')