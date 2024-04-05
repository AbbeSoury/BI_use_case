{{ config(materialized='table') }}

SELECT
    "Date du lundi" as "Date",
    "Catégorie lieu de vax", 
    "Nom de la catégorie", 
    "Nombre d'injection", 
    "Nombre d'injections total",
    "Ratio injection sur total",
    "Nombre d'injection cumulé par catégorie",
    "Nombre d'injection cumulé total",
    "Ratio injection cumulé sur total"
FROM {{ ref("int_vaccination_par_lieu")}}