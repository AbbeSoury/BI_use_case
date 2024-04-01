{{ config(materialized='table') }}

SELECT
    int_centres_vaccination."ID",
    int_centres_vaccination."Centre",
    int_centres_vaccination."Ville",
    int_centres_vaccination."Latitude",
    int_centres_vaccination."Longitude",
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
    END AS "Editeur",
    SUM(int_prise_rdv_par_centre."Nombre de RDV") AS "Total RDV",
    int_prise_rdv_par_centre."Date"
FROM {{ ref('int_centres_vaccination') }}
LEFT JOIN {{ ref('int_prise_rdv_par_centre') }} 
    ON  int_centres_vaccination."ID" = int_prise_rdv_par_centre."ID_clean"
GROUP BY
    int_centres_vaccination."ID",
    int_centres_vaccination."Centre",
    int_centres_vaccination."Ville",
    int_centres_vaccination."Latitude",
    int_centres_vaccination."Longitude",
    "Editeur", 
    int_prise_rdv_par_centre."Date"