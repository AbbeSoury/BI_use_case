{{ config(materialized='table') }}
select
    date_reference, 
    semaine_injection, 
    code_categorie, 
    libelle_categorie, 
    effectif_inj_categorie, 
    effectif_inj_toutes_categories, 
    part_categorie, 
    effectif_cumu_inj_categorie, 
    Effectif_cumu_inj_ttes_categorie, 
    part_cumu_categorie, 
    categorie, 
    date
from {{ source('raw','VACCINATION_PAR_LIEU')}}