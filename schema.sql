-- Add primary and foreign keys to tables
-- Alter the data types

-- For countries table
--ALTER TABLE countries
--DROP CONSTRAINT countries_pkey;

ALTER TABLE countries 
ADD PRIMARY KEY (country_id),
ALTER COLUMN country_id TYPE SMALLINT,
ALTER COLUMN countries TYPE VARCHAR(20);

-- For years table 
-- Set year as varchar instead of int because some values are like this: 2019_share
--ALTER TABLE years
--DROP CONSTRAINT years_pkey;

ALTER TABLE years 
ADD PRIMARY KEY (year_id),
ALTER COLUMN year_id TYPE SMALLINT,
ALTER COLUMN year TYPE VARCHAR(35);

-- For re_or_not table
--ALTER TABLE re_or_not
--DROP CONSTRAINT re_or_not_pkey;

ALTER TABLE re_or_not
ADD PRIMARY KEY (re_or_not_id),
ALTER COLUMN re_or_not_id TYPE SMALLINT,
ALTER COLUMN re_or_not TYPE VARCHAR(20);

-- For tech_groups table
--ALTER TABLE tech_groups 
--DROP CONSTRAINT tech_groups_pkey;

ALTER TABLE tech_groups 
ADD PRIMARY KEY (group_tech_id),
ALTER COLUMN group_tech_id TYPE SMALLINT,
ALTER COLUMN group_tech TYPE VARCHAR(35);

-- For techs table
--ALTER TABLE techs
--DROP CONSTRAINT techs_pkey;

ALTER TABLE techs 
ADD PRIMARY KEY (tech_id),
ALTER COLUMN tech_id TYPE SMALLINT,
ALTER COLUMN tech TYPE VARCHAR(35);

-- For producer_types table
--ALTER TABLE producer_types
--DROP CONSTRAINT producer_types_pkey;

ALTER TABLE producer_types  
ADD PRIMARY KEY (producer_id),
ALTER COLUMN producer_id TYPE SMALLINT,
ALTER COLUMN producer TYPE VARCHAR(10);

-- For irena_installed_elect_capacities table
--ALTER TABLE irena_installed_elect_capacities
--DROP CONSTRAINT irena_installed_elect_capacities_pkey,
--DROP CONSTRAINT fk_irena_installed_elect_capacities_countries,
--DROP CONSTRAINT fk_irena_installed_elect_capacities_years,
--DROP CONSTRAINT fk_irena_installed_elect_capacities_re_or_not,
--DROP CONSTRAINT fk_irena_installed_elect_capacities_tech_groups,
--DROP CONSTRAINT fk_irena_installed_elect_capacities_techs,
--DROP CONSTRAINT fk_irena_installed_elect_producer_types;

ALTER TABLE irena_installed_elect_capacities  
ADD PRIMARY KEY (country_id, year_id, re_or_not_id, group_tech_id,
				 tech_id, producer_type_id),
ALTER COLUMN country_id TYPE SMALLINT,
ALTER COLUMN year_id TYPE SMALLINT,
ALTER COLUMN re_or_not_id TYPE SMALLINT,
ALTER COLUMN group_tech_id TYPE SMALLINT,
ALTER COLUMN tech_id TYPE SMALLINT,
ALTER COLUMN producer_type_id TYPE SMALLINT,
ALTER COLUMN electr_installed_capacity_mw TYPE INT,
ADD CONSTRAINT fk_irena_installed_elect_capacities_countries FOREIGN KEY(country_id)
REFERENCES countries(country_id),
ADD CONSTRAINT fk_irena_installed_elect_capacities_years FOREIGN KEY(year_id)
REFERENCES years(year_id),
ADD CONSTRAINT fk_irena_installed_elect_capacities_re_or_not FOREIGN KEY(re_or_not_id)
REFERENCES re_or_not(re_or_not_id),
ADD CONSTRAINT fk_irena_installed_elect_capacities_tech_groups FOREIGN KEY(group_tech_id)
REFERENCES tech_groups(group_tech_id),
ADD CONSTRAINT fk_irena_installed_elect_capacities_techs FOREIGN KEY(tech_id)
REFERENCES techs(tech_id),
ADD CONSTRAINT fk_irena_installed_elect_capacities_producer_types FOREIGN KEY(producer_type_id)
REFERENCES producer_types(producer_id);

-- Create index on the output for optimization
--DROP INDEX electr_installed_capacity_mw_index;

CREATE INDEX electr_installed_capacity_mw_index 
on irena_installed_elect_capacities (electr_installed_capacity_mw);

--EXPLAIN ANALYZE SELECT * from irena_installed_elect_capacities;

-- For bp_energy_consumption table
--ALTER TABLE bp_energy_consumption
--DROP CONSTRAINT bp_energy_consumption_pkey,
--DROP CONSTRAINT fk_bp_energy_consumption_year;

ALTER TABLE bp_energy_consumption  
ADD PRIMARY KEY (year_id),
ALTER COLUMN year_id TYPE SMALLINT,
ADD CONSTRAINT fk_bp_energy_consumption_years FOREIGN KEY(year_id)
REFERENCES years(year_id);

-- Create index on the outputs for optimization
--DROP INDEX China_EJ_input_equiv_index;
--DROP INDEX Germany_EJ_input_equiv_index;
--DROP INDEX USA_EJ_input_equiv_index;

CREATE INDEX China_EJ_input_equiv_index 
on bp_energy_consumption ("China_EJ_input_equiv");

CREATE INDEX Germany_EJ_input_equiv_index 
on bp_energy_consumption ("Germany_EJ_input_equiv");

CREATE INDEX USA_EJ_input_equiv_index 
on bp_energy_consumption ("USA_EJ_input_equiv");

--EXPLAIN ANALYZE SELECT * from bp_energy_consumption;

-- For bp_renewable_consumption table
ALTER TABLE bp_renewable_consumption  
ADD PRIMARY KEY (year_id),
ALTER COLUMN year_id TYPE SMALLINT,
ADD CONSTRAINT fk_bp_renewable_consumption_years FOREIGN KEY(year_id)
REFERENCES years(year_id);

-- Create index on the outputs for optimization
CREATE INDEX China_EJ_input_equiv_re_index 
on bp_renewable_consumption ("China_EJ_input_equiv");

CREATE INDEX Germany_EJ_input_equiv_re_index 
on bp_renewable_consumption ("Germany_EJ_input_equiv");

CREATE INDEX USA_EJ_input_equiv_re_index 
on bp_renewable_consumption ("USA_EJ_input_equiv");

-- For une_emission_goals table
ALTER TABLE une_emission_goals  
ADD PRIMARY KEY (country_id, year_id),
ALTER COLUMN country_id TYPE SMALLINT,
ALTER COLUMN year_id TYPE SMALLINT,
ADD CONSTRAINT fk_une_emission_goals_countries FOREIGN KEY(country_id)
REFERENCES countries(country_id),
ADD CONSTRAINT fk_une_emission_goals_years FOREIGN KEY(year_id)
REFERENCES years(year_id);

--The value column is a string instead of integer, so have to change it to varchar instead
ALTER TABLE une_emission_goals
ALTER COLUMN "value" TYPE VARCHAR;

-- Create index on the output for optimization
CREATE INDEX value_index 
on une_emission_goals("value");

-- For eia_co2_emission table
ALTER TABLE eia_co2_emission 
ADD PRIMARY KEY (year_id),
ALTER COLUMN year_id TYPE SMALLINT,
ADD CONSTRAINT fk_eia_co2_emission_years FOREIGN KEY(year_id)
REFERENCES years(year_id);

-- Create index on the outputs for optimization
CREATE INDEX china_emission_index 
on eia_co2_emission (china_emission);

CREATE INDEX germany_emission_index 
on eia_co2_emission (germany_emission);

CREATE INDEX usa_emission_index 
on eia_co2_emission (usa_emission);
