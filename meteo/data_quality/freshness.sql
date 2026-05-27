SELECT
  'dwpnt_10min' AS table_name,
  TIMESTAMP_DIFF(TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR), MAX(date_time), MINUTE) AS data_freshness_minutes,
  MAX(date_time) as max_time
FROM
  `ch-odata-warehouse-433011`.`ch_meteo`.`dwpnt_10min`
UNION ALL
SELECT
  'rh_10min' AS table_name,
  TIMESTAMP_DIFF(TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR), MAX(date_time), MINUTE) AS data_freshness_minutes,
  MAX(date_time) as max_time
FROM
  `ch-odata-warehouse-433011`.`ch_meteo`.`rh_10min`
UNION ALL
SELECT
  'sunshine_10min' AS table_name,
  TIMESTAMP_DIFF(TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR), MAX(date_time), MINUTE) AS data_freshness_minutes,
  MAX(date_time) as max_time
FROM
  `ch-odata-warehouse-433011`.`ch_meteo`.`sunshine_10min`
UNION ALL
SELECT
  'temp_2m_10min' AS table_name,
  TIMESTAMP_DIFF(TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR), MAX(date_time), MINUTE) AS data_freshness_minutes,
  MAX(date_time) as max_time
FROM
  `ch-odata-warehouse-433011`.`ch_meteo`.`temp_2m_10min`
UNION ALL
SELECT
  'wind_10min' AS table_name,
  TIMESTAMP_DIFF(TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR), MAX(date_time), MINUTE) AS data_freshness_minutes,
  MAX(date_time) as max_time
FROM
  `ch-odata-warehouse-433011`.`ch_meteo`.`wind_10min`
UNION ALL
SELECT
  'precip_10min' AS table_name,
  TIMESTAMP_DIFF(TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR), MAX(date_time), MINUTE) AS data_freshness_minutes,
  MAX(date_time) as max_time
FROM
  `ch-odata-warehouse-433011`.`ch_meteo`.`precip_10min`
UNION ALL
SELECT
  'radiation_10min' AS table_name,
  TIMESTAMP_DIFF(TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR), MAX(date_time), MINUTE) AS data_freshness_minutes,
  MAX(date_time) as max_time
FROM
  `ch-odata-warehouse-433011`.`ch_meteo`.`radiation_10min`;