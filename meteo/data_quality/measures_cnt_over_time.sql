SELECT
    metric_name,
    date_time,
    COUNT(*) as measures_cnt

FROM (
  SELECT
    'dwpnt_10min' AS metric_name,
    date_time
  FROM
    `ch-odata-warehouse-433011`.`ch_meteo`.`dwpnt_10min`
  UNION ALL
  SELECT
    'rh_10min' AS metric_name,
    date_time
  FROM
    `ch-odata-warehouse-433011`.`ch_meteo`.`rh_10min`
  UNION ALL
  SELECT
    'sunshine_10min' AS metric_name,
    date_time
  FROM
    `ch-odata-warehouse-433011`.`ch_meteo`.`sunshine_10min`
  UNION ALL
  SELECT
    'temp_2m_10min' AS metric_name,
    date_time
  FROM
    `ch-odata-warehouse-433011`.`ch_meteo`.`temp_2m_10min`
  UNION ALL
  SELECT
    'wind_10min' AS metric_name,
    date_time
  FROM
    `ch-odata-warehouse-433011`.`ch_meteo`.`wind_10min`
  UNION ALL
  SELECT
    'precip_10min' AS metric_name,
    date_time
  FROM
    `ch-odata-warehouse-433011`.`ch_meteo`.`precip_10min`
  UNION ALL
  SELECT
    'radiation_10min' AS metric_name,
    date_time
  FROM
    `ch-odata-warehouse-433011`.`ch_meteo`.`radiation_10min`)

GROUP BY date_time, metric_name