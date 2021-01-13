-- Join tables together
--irena_installed_elect_capacities
SELECT countries.countries AS "country", years.year AS "year", re_or_not.re_or_not AS "re_or_not",
tech_groups.group_tech AS "group_tech", techs.tech AS "tech", producer_types.producer AS "producer",
irena_installed_elect_capacities.electr_installed_capacity_mw AS "electri_installed_capacity_mw"
FROM irena_installed_elect_capacities
INNER JOIN countries
on irena_installed_elect_capacities.country_id = countries.country_id
INNER JOIN years
on irena_installed_elect_capacities.year_id = years.year_id
INNER JOIN re_or_not
on irena_installed_elect_capacities.re_or_not_id = re_or_not.re_or_not_id
INNER JOIN tech_groups
on irena_installed_elect_capacities.group_tech_id = tech_groups.group_tech_id
INNER JOIN techs
on irena_installed_elect_capacities.tech_id = techs.tech_id
INNER JOIN producer_types
on irena_installed_elect_capacities.producer_type_id = producer_types.producer_id;

--bp_energy_consumption & bp_renewable_consumption & eia_co2_emission
SELECT (SELECT "year" FROM years WHERE years.year_id = bp_energy_consumption.year_id),
bp_energy_consumption."China_EJ_input_equiv" AS "china_ej_input_equiv",
bp_energy_consumption."Germany_EJ_input_equiv" AS "germany_ej_input_equiv",
bp_energy_consumption."USA_EJ_input_equiv" AS "usa_ej_input_equiv",
bp_renewable_consumption."China_EJ_input_equiv" AS "china_ej_input_equiv_re",
bp_renewable_consumption."Germany_EJ_input_equiv" AS "germany_ej_input_equiv_re",
bp_renewable_consumption."USA_EJ_input_equiv" AS "usa_ej_input_equiv_re",
eia_co2_emission.china_emission AS "china_emission", 
eia_co2_emission.germany_emission AS "china_emission",
eia_co2_emission.usa_emission AS "usa_emission"
FROM bp_energy_consumption
INNER JOIN bp_renewable_consumption
ON bp_energy_consumption.year_id = bp_renewable_consumption.year_id
INNER JOIN eia_co2_emission
ON bp_energy_consumption.year_id = eia_co2_emission.year_id;

--une_emission_goals
SELECT (SELECT "year" FROM years WHERE years.year_id = une_emission_goals.year_id), 
(SELECT countries FROM countries WHERE countries.country_id = une_emission_goals.country_id), "value"
FROM une_emission_goals;
