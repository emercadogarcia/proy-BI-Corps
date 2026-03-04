JSON válido con 20 nodos y 19 conexiones. Para importarlo:

n8n → menú ≡ → Import from File → selecciona el JSON

---
# 🗺️ Mapa del Workflow Importado

| # | Nodo | Tipo | Descripción |
|---|------|------|------------|
| 1 | Gmail Trigger | Nativo | Polling cada minuto |
| 2 | JS — Validador + MD5 | Code Node | Calcula hash, valida extensión y tamaño |
| 3 | PG — Buscar Config ETL | Postgres | Consulta `etl_config` |
| 4 | JS — Verificar Config + Duplicados | Code Node | Frena si ya fue procesado |
| 5 | PG — Iniciar Log ETL | Postgres | Inserta registro `RUNNING` |
| 6 | JS — Parser Universal CSV | Code Node | Auto-delimitador, BOM, parseo |
| 7 | JS — Limpiador Dinámico | Code Node | Mapping, monedas, fechas ISO |
| 8 | JS — Generador UPSERT | Code Node | Queries con `BEGIN/COMMIT` |
| 9 | JS — Splitter de Lotes | Code Node | Un ítem por lote de 100 filas |
| 10 | PG — Ejecutar UPSERT | Postgres | `output[1]` va al Error Handler |
| 11 | JS — Agregador de Resultados | Code Node | Consolida conteos |
| 12 | PG — Log SUCCESS | Postgres | Actualiza `etl_logs` |
| 13 | Rechazados | Code | Procesa registros inválidos |
| 14 | Rechazados | Postgres | Inserta en `etl_rejected` |
| 15 | Gmail Labels | Code | Determina etiqueta destino |
| 16 | Gmail | Gmail Node | Mueve a `/etl/processed` o `/etl/rejected` |
| 17 | ROLLBACK | — | Ruta de error |
| 18 | Log ERROR | Postgres | Actualiza estado ERROR |
| 19 | Email notificación | Gmail | Envía alerta |
| 20 | Label | Gmail | Mueve correo a `/etl/rejected` |

---

# ⚙️ Configuración Obligatoria Antes de Activar

Debes reemplazar los siguientes valores:

- `GMAIL_CREDENTIAL_ID` → ID de tu credencial **Gmail OAuth2** en n8n  
- `POSTGRES_CREDENTIAL_ID` → ID de tu credencial **PostgreSQL** en n8n  
- `admin@bicorp.com` → Correo receptor de alertas  
- `Timezone America/Bogota` → Ajustar según tu zona horaria  

---

Checklist ejecutivo antes de go-live:

- ✅ Credenciales validadas  
- ✅ Tablas `etl_config`, `etl_logs`, `etl_rejected` creadas  
- ✅ Labels `/etl/processed` y `/etl/rejected` existentes en Gmail  
- ✅ Prueba con archivo controlado  

Listo para producción. 🚀