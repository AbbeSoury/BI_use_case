{{ config(materialized='table') }}

WITH int_centres_vaccination AS (
    SELECT
        ID,
        TRIM(UPPER("Centre")) as "Centre",
        "Numéro voie",
        "Nom voie",
        "Code postal",
        "Code INSEE",
        "Ville",
        "Latitude",
        "Longitude",
        SIREN,
        "Code APE",
        "Agence santé",
        "Accessibilite",
        CASE WHEN "Ouvert lundi" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert lundi",
        CASE WHEN "Ouvert mardi" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert mardi",
        CASE WHEN "Ouvert mercredi" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert mercredi",
        CASE WHEN "Ouvert jeudi" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert jeudi",
        CASE WHEN "Ouvert vendredi" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert vendredi",
        CASE WHEN "Ouvert samedi" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert samedi",
        CASE WHEN "Ouvert dimanche" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert dimanche",
        CASE WHEN "Ouvert lundi" = 'fermé' AND "Ouvert mardi" = 'fermé' AND "Ouvert mercredi" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert debut semaine",
        CASE WHEN "Ouvert jeudi" = 'fermé' AND "Ouvert vendredi" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert fin semaine",
        CASE WHEN "Ouvert samedi" = 'fermé' AND "Ouvert dimanche" = 'fermé' THEN 0 ELSE 1 END AS "Ouvert weekend",
        "Date fermeture centre",
        "Date ouverture centre",
        CASE WHEN "Site résa" IS NOT NULL AND "Site résa" NOT IN ('RIEN','RIen','Sans RDV') THEN 1 ELSE 0 END AS "Résa web",
        CASE WHEN "Site résa" LIKE '%octolib%' THEN 1 ELSE 0 END AS "Réservable sur Doctolib",
        CASE
            WHEN POSITION('.fr' IN "Site résa") > 0 THEN LEFT("Site résa", POSITION('.fr' IN "Site résa") + 2)
            WHEN POSITION('.com' IN "Site résa") > 0 THEN LEFT("Site résa", POSITION('.com' IN "Site résa") + 3)
        ELSE "Site résa"
        END AS "Site résa court",
        "Site résa",
        "Téléphone",
        "Téléphone 2",
        "Modalité",
        "Consultation pré vax",
        "Répondeur",
        "Type de centre"
    FROM {{ ref('stg_centres_vaccination') }}
)
SELECT
    *
FROM int_centres_vaccination