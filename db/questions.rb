# What 3 towns have the highest population of citizens that are 65 years and older?
TownHealthRecord.select('town').where('id < 352').order('population_greater_than_65_2005 DESC').limit(3)

# What 3 towns have the highest population of citizens that are 19 years and younger?
TownHealthRecord.select('town').where('id < 352').order('population_0_to_19_2005 DESC').limit(3)

# What 5 towns have the lowest per capita income?
TownHealthRecord.select('town').where('id < 352').order('per_capita_income_2000').limit(5)

# Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
TownHealthRecord.select('town, percent_teen_births_2005_to_2008').where("percent_teen_births_2005_to_2008 IS NOT NULL AND town NOT IN ('Boston', 'Becket', 'Beverly')").order('percent_teen_births_2005_to_2008 DESC').limit(1)

# Omitting Boston, what town has the highest percentage of teen births
TownHealthRecord.select('town').where("town != 'Boston' AND infant_mortality_rate_per_thousand_2005_to_2008 IS NOT NULL").order('infant_mortality_rate_per_thousand_2005_to_2008 DESC').limit(1)

# Of the 5 towns with the highest per capita income, which one has the highest number of people below the poverty line
TownHealthRecord.select('town').where("id<352 AND per_capita_income_2000 > (SELECT per_capita_income_2000 FROM town_health_records WHERE id < 352 ORDER BY per_capita_income_2000 DESC OFFSET 5 LIMIT 1)").order('persons_below_poverty_2000 DESC').limit(1)

# Of the towns that start with the letter b, which has the highest population?
TownHealthRecord.select('town').where("town LIKE 'B%'").order('total_population_2005 DESC').limit(1)

# Of the 10 towns with the highest percent publicly financed prenatal care, are any of them also in the top 10 for total infant deaths?
TownHealthRecord.select('town').where("id < 352 AND town IN (SELECT town FROM town_health_records WHERE id < 352 ORDER BY percent_publicly_financed_prenatal_care_2005_to_2008 DESC LIMIT 10) AND town IN (SELECT town FROM town_health_records WHERE id < 352 ORDER BY total_infant_deaths_2005_to_2008 DESC LIMIT 10)")

# Which town has the highest percentage multiple births
TownHealthRecord.select('town').where('percent_multiple_births_2005_to_2008 IS NOT NULL').order('percent_multiple_births_2005_to_2008 DESC').limit(1)

# What is the percent adequacy of prenatal care in that town?
TownHealthRecord.select('percent_adequacy_pre_natal_care').where('percent_multiple_births_2005_to_2008 IS NOT NULL').order('percent_multiple_births_2005_to_2008 DESC').limit(1)

# Excluding towns that start with W, how many towns are part of this data?
TownHealthRecord.select("Count(town)").where("id < 352 AND town NOT LIKE 'W%'")

# How many towns have a lower per capita income than that of Boston
TownHealthRecord.select("Count(town)").where("id < 352 AND per_capita_income_2000 < (SELECT per_capita_income_2000 FROM town_health_records WHERE town = 'Boston')")
