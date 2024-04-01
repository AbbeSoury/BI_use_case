{{ config(materialized='table') }}

WITH int_stock AS (
    SELECT
        	"Code département",
            "Département",
            "Etablissement",
            "Nom pharmacie",
            "Code finess",
            REPLACE("Vaccin", 'P<e9>diatrique', 'Pédiatrique') AS "Vaccin",
            "Nombre de flacons",
            "Doses disponibles",
            ROUND("Doses disponibles" / NULLIF("Nombre de flacons", 0), 0) AS "Doses par flacon",
            "Date"

    FROM {{ ref('stg_stock') }}
)
SELECT
    *
FROM int_stock