{{ config(materialized='table') }}
select
    date_reference as "Date de dernière MAJ", 
    semaine_injection as "Date injection", 
    code_categorie as "Catégorie lieu de vax", 
    libelle_categorie as "Nom de la catégorie", 
    effectif_inj_categorie as "Nombre d'injection", 
    effectif_inj_toutes_categories as "Nombre d'injection toute catégorie"
FROM {{ source('raw', 'VACCINATION_PAR_LIEU') }}