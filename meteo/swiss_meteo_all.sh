# dewpoint 10min
curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-taupunkt-10min/ch.meteoschweiz.messwerte-taupunkt-10min_en.csv > file.csv
iconv -f Windows-1252 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.dwpnt_10min trimmed.csv

# precip 10min
curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-niederschlag-10min/ch.meteoschweiz.messwerte-niederschlag-10min_en.csv > file.csv
iconv -f Windows-1252 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.precip_10min trimmed.csv

# radiation 10min
curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-globalstrahlung-10min/ch.meteoschweiz.messwerte-globalstrahlung-10min_en.csv > file.csv
iconv -f Windows-1252 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.radiation_10min trimmed.csv

# rh 10min
curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-luftfeuchtigkeit-10min/ch.meteoschweiz.messwerte-luftfeuchtigkeit-10min_en.csv > file.csv
iconv -f Windows-1252 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.rh_10min trimmed.csv

# sunshine 10min
curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-sonnenscheindauer-10min/ch.meteoschweiz.messwerte-sonnenscheindauer-10min_de.csv > file.csv
iconv -f Windows-1252 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.sunshine_10min trimmed.csv

# temp 2m 10min
curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-lufttemperatur-10min/ch.meteoschweiz.messwerte-lufttemperatur-10min_en.csv > file.csv
iconv -f Windows-1252 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.temp_2m_10min trimmed.csv

# wind 10min
curl https://data.geo.admin.ch/ch.meteoschweiz.messwerte-windgeschwindigkeit-kmh-10min/ch.meteoschweiz.messwerte-windgeschwindigkeit-kmh-10min_en.csv > file.csv
iconv -f Windows-1252 -t UTF-8 file.csv > file-utf8.csv
cat file-utf8.csv | tail -n +2 | head -n -4 > trimmed.csv
bq load --quote=\" --source_format=CSV --field_delimiter=";" --ignore_unknown_values --max_bad_records=10 ch_meteo.wind_10min trimmed.csv
