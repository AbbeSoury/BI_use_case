{{ config(materialized='table') }}

SELECT
	CODE_COMMUNE_INSEE as "Code INSEE",
    NOM_COMMUNE_COMPLET as "Ville",
	CODE_POSTAL as "Code postal",
    CODE_COMMUNE as "Code ville",
	LATITUDE,
	LONGITUDE,
    NOM_DEPARTEMENT as "Département",
	CODE_DEPARTEMENT as "Code département",
	CODE_REGION as "Code région",
	NOM_REGION as "Région"
FROM {{ source('raw', 'DIM_FRANCE_REG_DPT_ZIP') }}