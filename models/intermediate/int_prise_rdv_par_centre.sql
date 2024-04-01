{{ config(materialized='table') }}

WITH int_prise_rdv_par_centre AS (
    SELECT
        	"Code région",
        	"Région",
        	"Département",
        	ID,
            COALESCE(TRY_TO_NUMBER("ID"), 0) AS "ID_clean",
            TRIM(UPPER("Centre")) as "Centre",
            CASE WHEN "ID_clean" = 0 THEN "Centre" ELSE CAST("ID_clean" AS VARCHAR) END as "Key",
            "Rang dose",
            "Date",
            "Nombre de RDV",
            "Nombre de RDV via CNAM",
            "Nombre de rappel vaccin"

    FROM {{ ref('stg_prise_rdv_par_centre') }}
)
SELECT
    *
FROM int_prise_rdv_par_centre