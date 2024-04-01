{{ config(materialized='table') }}

SELECT
    int_vaccination_vs_appointment."Centre",
    int_centres_vaccination."Ville",
    int_centres_vaccination."Code postal",
    reg_dep_ville."Département",
    reg_dep_ville."Région",
    int_centres_vaccination."Latitude",
    int_centres_vaccination."Longitude",
    CASE
        WHEN "Site résa" LIKE '%octolib%' THEN 'Doctolib'
        WHEN "Site résa" LIKE '%maiia%' THEN 'Maiia'
        WHEN "Site résa" LIKE '%keldoc%' THEN 'Keldoc'
        WHEN "Site résa" LIKE '%prevana%' THEN 'Prevana'
        WHEN "Site résa" LIKE '%medicran%' THEN 'Medicran'
        WHEN "Site résa" LIKE '%rdvasos%' THEN 'SOS Médecin'
        WHEN "Site résa" LIKE '%urldefense%' THEN 'Armée'
        WHEN "Site résa" LIKE '%medecins7sur7%' THEN 'Médecins 7/7'
        WHEN "Site résa" IN ('RIEN','RIen','Sans RDV') THEN 'Sans réservation'
        WHEN "Site résa" IS NULL THEN 'Sans réservation'
        ELSE 'Etablissement de santé'
    END AS "Plateforme réservation",
    int_vaccination_vs_appointment."Doses reçues",
    int_vaccination_vs_appointment."Nombre de RDV",
    int_vaccination_vs_appointment."Date" AS "Date vax"
FROM {{ ref('int_vaccination_vs_appointment') }}

LEFT JOIN {{ ref('int_centres_vaccination') }}
    ON int_vaccination_vs_appointment."ID" = int_centres_vaccination."ID"
LEFT JOIN {{ ref('reg_dep_ville') }}
    ON int_centres_vaccination."Code postal" = reg_dep_ville."Code postal"


GROUP BY
    int_vaccination_vs_appointment."Centre",
    int_centres_vaccination."Ville",
    int_centres_vaccination."Code postal",
    reg_dep_ville."Département",
    reg_dep_ville."Région",
    int_centres_vaccination."Latitude",
    int_centres_vaccination."Longitude",
    "Plateforme réservation",
    int_vaccination_vs_appointment."Doses reçues",
    int_vaccination_vs_appointment."Nombre de RDV",
    int_vaccination_vs_appointment."Date"