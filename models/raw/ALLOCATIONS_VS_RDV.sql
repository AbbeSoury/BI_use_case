{{ config(materialized='table') }}
select
    ID_CENTRE,
    DATE_DEBUT_SEMAINE,
    CODE_REGION,
    NOM_REGION,
    CODE_DEPARTEMENT,
    NOM_DEPARTEMENT,
    COMMUNE_INSEE,
    NOM_CENTRE,
    NOMBRE_UCD,
    DOSES_ALLOUEES,
    RDV_PRIS
from {{ source('raw','ALLOCATIONS_VS_RDV')}}