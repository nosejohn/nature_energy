clear
import delimited "\Users\jkim3888\Documents\unequal_outage_data_redacted.csv", clear
drop date_stata
gen date_stata = date(date, "YMD")
format date_stata %td
xtset anonymized_zip_id date_stata

*** Main Model
xtreg ln_customers_duration heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary, fe vce(cluster anonymized_zip_id)

*** ALTERNATIVE DEPENDENT VARIABLES
** Number of affected customers
xtreg ln_customers_affected heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary, fe vce(cluster anonymized_zip_id)

** System Average Interruption Duration Index (SAIDI)
xtreg ln_saidi heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary, fe vce(cluster anonymized_zip_id)

** STATE specific results for the zip code daily fixed effects model
** CALIFORNIA
xtreg ln_customers_duration heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary if state=="CA", fe vce(cluster anonymized_zip_id)

** GEORGIA
xtreg ln_customers_duration heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary if state=="GA", fe vce(cluster anonymized_zip_id)

** TEXAS
xtreg ln_customers_duration heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary if state=="TX", fe vce(cluster anonymized_zip_id)



** County-Fixed Effects Model
***  Using outage intensity as Dependent Variable (DV)
reghdfe ln_customers_duration total_customers_served heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary  per_nonwhite ln_median_hhi population_density per_old per_electricity tree perland_substation distance_to_nearest_substation  per_built_1950_1969 per_built_1970_1989 per_built_1990_2009 per_built_after_2010 perland_water perland_hospital perland_nurse coastal urban  , absorb(i.date_stata i.anonymized_county) vce(cluster anonymized_zip_id)

*** Using the number of affected customers as DV
reghdfe ln_customers_affected total_customers_served heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary  per_nonwhite ln_median_hhi population_density per_old per_electricity tree perland_substation distance_to_nearest_substation  per_built_1950_1969 per_built_1970_1989 per_built_1990_2009 per_built_after_2010 perland_water perland_hospital perland_nurse coastal urban  , absorb(i.date_stata i.anonymized_county) vce(cluster anonymized_zip_id)

*** Using SAIDI as DV
reghdfe ln_saidi total_customers_served heavy_ppt1 cold heat heavy_snow_fall  fire_binary strong_wind cyclone_binary  per_nonwhite ln_median_hhi population_density per_old per_electricity tree perland_substation distance_to_nearest_substation  per_built_1950_1969 per_built_1970_1989 per_built_1990_2009 per_built_after_2010 perland_water perland_hospital perland_nurse coastal urban  , absorb(i.date_stata i.anonymized_county) vce(cluster anonymized_zip_id)



*** checking whether race interacted with extreme weather events have significant effect
**precipitation
xtreg ln_customers_duration heavy_ppt1 ppt_non_white cold heat heavy_snow_fall fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 ppt_non_white cold heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 ppt_non_white cold heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 ppt_non_white cold heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

**** COLD
xtreg ln_customers_duration heavy_ppt1  cold cold_non_white heat heavy_snow_fall fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold cold_non_white heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold cold_non_white heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold cold_non_white heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

*** HEAT
xtreg ln_customers_duration heavy_ppt1  cold heat heat_non_white heavy_snow_fall fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold heat heat_non_white heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold heat heat_non_white heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold heat heat_non_white heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

*** SNOW
xtreg ln_customers_duration heavy_ppt1  cold heat heavy_snow_fall snow_non_white fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat heavy_snow_fall snow_non_white fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat  heavy_snow_fall snow_non_white fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold  heat  heavy_snow_fall snow_non_white fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

** FIRE
xtreg ln_customers_duration heavy_ppt1  cold heat heavy_snow_fall fire_non_white fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat heavy_snow_fall fire_non_white fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat  heavy_snow_fall fire_non_white fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold  heat  heavy_snow_fall fire_non_white fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

** WIND
xtreg ln_customers_duration heavy_ppt1  cold heat heavy_snow_fall fire_binary strong_wind strong_wind_non_white cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat heavy_snow_fall fire_binary strong_wind strong_wind_non_white  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat  heavy_snow_fall fire_binary strong_wind strong_wind_non_white  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold  heat  heavy_snow_fall fire_binary strong_wind strong_wind_non_white  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

*** Cyclone
xtreg ln_customers_duration heavy_ppt1  cold heat heavy_snow_fall fire_binary strong_wind cyclone_non_white cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat heavy_snow_fall fire_binary strong_wind cyclone_non_white cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat  heavy_snow_fall fire_binary strong_wind cyclone_non_white cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold  heat  heavy_snow_fall fire_binary strong_wind cyclone_non_white cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)


*** checking whether income interacted with extreme weather events have significant effect
**precipitation
xtreg ln_customers_duration heavy_ppt1 ppt_income cold heat heavy_snow_fall fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 ppt_income cold heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 ppt_income cold heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 ppt_income cold heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

**** COLD
xtreg ln_customers_duration heavy_ppt1  cold cold_income heat heavy_snow_fall fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold cold_income heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold cold_income heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold cold_income heat heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

*** HEAT
xtreg ln_customers_duration heavy_ppt1  cold heat heat_income heavy_snow_fall fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold heat heat_income heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold heat heat_income heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold heat heat_income heavy_snow_fall fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

*** SNOW
xtreg ln_customers_duration heavy_ppt1  cold heat heavy_snow_fall snow_income fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat heavy_snow_fall snow_income fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat  heavy_snow_fall snow_income fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold  heat  heavy_snow_fall snow_income fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

** FIRE
xtreg ln_customers_duration heavy_ppt1  cold heat heavy_snow_fall fire_income fire_binary strong_wind  cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat heavy_snow_fall fire_income fire_binary strong_wind  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat  heavy_snow_fall fire_income fire_binary strong_wind  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold  heat  heavy_snow_fall fire_income fire_binary strong_wind  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

** WIND
xtreg ln_customers_duration heavy_ppt1  cold heat heavy_snow_fall fire_binary strong_wind strong_wind_income cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat heavy_snow_fall fire_binary strong_wind strong_wind_income  cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat  heavy_snow_fall fire_binary strong_wind strong_wind_income  cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold  heat  heavy_snow_fall fire_binary strong_wind strong_wind_income  cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)

*** Cyclone
xtreg ln_customers_duration heavy_ppt1  cold heat heavy_snow_fall fire_binary strong_wind cyclone_income cyclone_binary, fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat heavy_snow_fall fire_binary strong_wind cyclone_income cyclone_binary if state == "CA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1  cold  heat  heavy_snow_fall fire_binary strong_wind cyclone_income cyclone_binary if state == "GA", fe vce(cluster anonymized_zip_id)

xtreg ln_customers_duration heavy_ppt1 cold  heat  heavy_snow_fall fire_binary strong_wind cyclone_income cyclone_binary if state == "TX", fe vce(cluster anonymized_zip_id)




