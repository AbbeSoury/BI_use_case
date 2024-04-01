{{ config(materialized='table') }}
select
    CODE_DEPARTEMENT,
    DEPARTEMENT,
    RAISON_SOCIALE,
    LIBELLE_PUI,
    FINESS,
    TYPE_DE_VACCIN,
    NB_UCD,
    NB_DOSES,
    DATE
from {{ source('raw','STOCK')}}