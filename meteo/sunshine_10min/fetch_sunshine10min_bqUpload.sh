curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-sonnenscheindauer-10min/ch.meteoschweiz.messwerte-sonnenscheindauer-10min_de.csv > file.csv
iconv -f Windows-1250 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.sunshine_10min_staging trimmed.csv

bq query \
    --use_legacy_sql=false \
    '
MERGE `ch_meteo.sunshine_10min` T
USING `ch_meteo.sunshine_10min_staging` S
ON T.wigos_id = S.wigos_id AND T.date_time = S.date_time
WHEN NOT MATCHED THEN
  INSERT ROW'

bq query \
    --use_legacy_sql=false \
    'DELETE `ch_meteo.sunshine_10min_staging` WHERE true'
