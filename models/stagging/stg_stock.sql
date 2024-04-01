{{ config(materialized='table') }}

SELECT
    code_departement as "Code département",
    departement as "Département",
    raison_sociale as "Etablissement",
    libelle_pui as "Nom pharmacie",
    finess as "Code finess",
    type_de_vaccin as "Vaccin",
    nb_ucd as "Nombre de flacons",
    nb_doses as "Doses disponibles",
    date as "Date"
FROM {{ source('raw', 'STOCK') }}