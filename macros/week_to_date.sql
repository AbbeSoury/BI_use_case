{% macro get_monday_from_year_week(year_week_string) %}
    -- This macro calculates the date of the Monday for a given year and week number in Snowflake.
    -- The input is a string in the format 'YYYY-WW'.
    DATEADD(
        DAY,
        1 - EXTRACT(DOW_ISO FROM TO_DATE(SPLIT_PART({{ year_week_string }}, '-', 1) || '-01-01', 'YYYY-MM-DD')),
        TO_DATE(SPLIT_PART({{ year_week_string }}, '-', 1) || '-01-01', 'YYYY-MM-DD')
    ) + (SPLIT_PART({{ year_week_string }}, '-', 2)::INTEGER - 1) * 7
{% endmacro %}