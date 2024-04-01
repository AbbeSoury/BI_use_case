{{ config(materialized='table') }}
select
    CODE_REGION,
    REGION,
    DEPARTEMENT,
    ID_CENTRE,
    NOM_CENTRE,
    RANG_VACCINAL,
    DATE_DEBUT_SEMAINE,
    NB,
    NB_RDV_CNAM,
    NB_RDV_RAPPEL
from {{ source('raw','PRISE_RDV_PAR_CENTRE')}}