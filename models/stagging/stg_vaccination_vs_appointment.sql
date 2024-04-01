{{ config(materialized='table') }}

SELECT
    id_centre as "ID",
    date_debut_semaine as "Date",
    code_region as "Code région",
    nom_region as "Région",
    code_departement as "Code département",
    nom_departement as "Département",
    commune_insee as "Code INSEE",
    nom_centre as "Centre",
    nombre_ucd as "Nombre de flacons",
    doses_allouees as "Doses reçues",
    rdv_pris as "Nombre de RDV"
FROM {{ source('raw', 'ALLOCATIONS_VS_RDV') }}