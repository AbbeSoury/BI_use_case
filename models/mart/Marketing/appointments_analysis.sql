{{ config(materialized='table') }}

SELECT
    int_prise_rdv_par_centre."Centre",
    int_prise_rdv_par_centre."ID_clean" AS "ID",
    int_prise_rdv_par_centre."Code région",
    int_prise_rdv_par_centre."Région",
    int_prise_rdv_par_centre."Département",
    CASE
        WHEN int_centres_vaccination."Site résa" LIKE '%octolib%' THEN 'Doctolib'
        WHEN int_centres_vaccination."Site résa" LIKE '%maiia%' THEN 'Maiia'
        WHEN int_centres_vaccination."Site résa" LIKE '%keldoc%' THEN 'Keldoc'
        WHEN int_centres_vaccination."Site résa" LIKE '%prevana%' THEN 'Prevana'
        WHEN int_centres_vaccination."Site résa" LIKE '%medicran%' THEN 'Medicran'
        WHEN int_centres_vaccination."Site résa" LIKE '%rdvasos%' THEN 'SOS Médecin'
        WHEN int_centres_vaccination."Site résa" LIKE '%urldefense%' THEN 'Armée'
        WHEN int_centres_vaccination."Site résa" LIKE '%medecins7sur7%' THEN 'Médecins 7/7'
        WHEN int_centres_vaccination."Site résa" IN ('RIEN','RIen','Sans RDV') THEN 'Sans réservation'
        WHEN int_centres_vaccination."Site résa" IS NULL THEN 'Sans réservation'
        ELSE 'Etablissement de santé'
    END AS "Plateforme réservation",
    int_prise_rdv_par_centre."Rang dose",
    int_prise_rdv_par_centre."Date",
    int_prise_rdv_par_centre."Nombre de RDV",
    CASE
        WHEN int_centres_vaccination."Site résa" LIKE '%octolib%' THEN int_prise_rdv_par_centre."Nombre de RDV"
        ELSE 0
    END AS "Nombre de RDV Doctolib",
    int_prise_rdv_par_centre."Nombre de RDV via CNAM",
    int_prise_rdv_par_centre."Nombre de rappel vaccin"
FROM {{ ref('int_prise_rdv_par_centre') }}
LEFT JOIN {{ ref('int_centres_vaccination') }}
    ON int_prise_rdv_par_centre."ID_clean" = int_centres_vaccination."ID"
GROUP BY
    int_prise_rdv_par_centre."Centre",
    int_prise_rdv_par_centre."ID_clean",
    int_prise_rdv_par_centre."Code région",
    int_prise_rdv_par_centre."Région",
    int_prise_rdv_par_centre."Département",
    int_centres_vaccination."Site résa", 
    int_prise_rdv_par_centre."Rang dose",
    int_prise_rdv_par_centre."Date",
    int_prise_rdv_par_centre."Nombre de RDV",
    int_prise_rdv_par_centre."Nombre de RDV via CNAM",
    int_prise_rdv_par_centre."Nombre de rappel vaccin"