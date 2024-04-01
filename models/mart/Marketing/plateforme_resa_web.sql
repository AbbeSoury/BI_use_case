{{ config(materialized='table') }}

SELECT DISTINCT
    stg_centres_vaccination."Centre",
    CASE
        WHEN stg_centres_vaccination."Site résa" LIKE '%octolib%' THEN 'Doctolib'
        WHEN stg_centres_vaccination."Site résa" LIKE '%maiia%' THEN 'Maiia'
        WHEN stg_centres_vaccination."Site résa" LIKE '%keldoc%' THEN 'Keldoc'
        WHEN stg_centres_vaccination."Site résa" LIKE '%prevana%' THEN 'Prevana'
        WHEN stg_centres_vaccination."Site résa" LIKE '%medicran%' THEN 'Medicran'
        WHEN stg_centres_vaccination."Site résa" LIKE '%rdvasos%' THEN 'SOS Médecin'
        WHEN stg_centres_vaccination."Site résa" LIKE '%urldefense%' THEN 'Armée'
        WHEN stg_centres_vaccination."Site résa" LIKE '%medecins7sur7%' THEN 'Médecins 7/7'
        WHEN stg_centres_vaccination."Site résa" IN ('RIEN','RIen','Sans RDV') THEN 'Sans réservation'
        WHEN stg_centres_vaccination."Site résa" IS NULL THEN 'Sans réservation'
        ELSE 'Etablissement de santé'
    END AS "Editeur",
    stg_centres_vaccination."Latitude",
    stg_centres_vaccination."Longitude",
    reg_dep_ville."Département",
    reg_dep_ville."Région"

FROM {{ ref('stg_centres_vaccination') }}

LEFT JOIN {{ ref('reg_dep_ville') }}
    ON stg_centres_vaccination."Code postal" = reg_dep_ville."Code postal"