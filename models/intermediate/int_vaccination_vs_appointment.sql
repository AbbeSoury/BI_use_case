{{ config(materialized='table') }}

WITH int_vaccination_vs_appointment AS (
    SELECT
            ID,
            "Date",
            "Code région",
            "Région",
            "Code département",
            "Département",
            "Code INSEE",
            TRIM(UPPER("Centre")) as "Centre",
            "Nombre de flacons",
            "Doses reçues",
            "Nombre de RDV",
            ROUND("Doses reçues"/ NULLIF("Nombre de flacons",0),0) as "Doses par flacon"

    FROM {{ ref('stg_vaccination_vs_appointment') }}
)
SELECT
    *
FROM int_vaccination_vs_appointment