{{ config(materialized='table') }}

SELECT
    code_region as "Code région",
    region as "Région",
    departement as "Département",
    id_centre as "ID",
    nom_centre as "Centre",
    rang_vaccinal as "Rang dose",
    date_debut_semaine as "Date",
    nb as "Nombre de RDV",
    nb_rdv_cnam as "Nombre de RDV via CNAM",
    nb_rdv_rappel as "Nombre de rappel vaccin"
FROM {{ source('raw', 'PRISE_RDV_PAR_CENTRE') }}