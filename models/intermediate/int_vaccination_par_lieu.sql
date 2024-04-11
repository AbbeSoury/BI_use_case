{{ config(materialized='table') }}

WITH Total_Injections_By_Date AS (
    SELECT
        "Date injection" AS week_year,
        SUM("Nombre d'injection") AS "Nombre d'injections total"
    FROM {{ ref('stg_vaccination_par_lieu') }}
    GROUP BY "Date injection"
),
Monday_Dates AS (
    SELECT
        week_year,
        {{ get_monday_from_year_week('week_year') }} AS "Date du lundi"
    FROM Total_Injections_By_Date
)

SELECT
    v."Date de dernière MAJ", 
    v."Date injection" AS "Date injection semaine", 
    m."Date du lundi",
    v."Catégorie lieu de vax", 
    v."Nom de la catégorie", 
    v."Nombre d'injection", 
    t."Nombre d'injections total",
    v."Nombre d'injection" / NULLIF(t."Nombre d'injections total", 0) AS "Ratio injection sur total",
    SUM(v."Nombre d'injection") OVER (PARTITION BY v."Catégorie lieu de vax" ORDER BY v."Date injection") AS "Nombre d'injection cumulé par catégorie",
    SUM(t."Nombre d'injections total") OVER (ORDER BY v."Date injection") AS "Nombre d'injection cumulé total",
    "Nombre d'injection cumulé par catégorie" / NULLIF("Nombre d'injection cumulé total", 0) AS "Ratio injection cumulé sur total"
FROM {{ ref("stg_vaccination_par_lieu") }} v
LEFT JOIN Total_Injections_By_Date t ON v."Date injection" = t.week_year  
LEFT JOIN Monday_Dates m ON v."Date injection" = m.week_year
GROUP BY
    v."Date de dernière MAJ", 
    v."Date injection", 
    m."Date du lundi",
    v."Catégorie lieu de vax", 
    v."Nom de la catégorie", 
    v."Nombre d'injection", 
    t."Nombre d'injections total"