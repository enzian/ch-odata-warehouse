curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-lufttemperatur-10min/ch.meteoschweiz.messwerte-lufttemperatur-10min_en.csv > file.csv
iconv -f Windows-1252 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.temp_2m_10min trimmed.csv
