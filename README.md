# Swiss Odata Warehouse

Swiss covernment institutions provide various data products that can be used freely. The structure in which this data is provided often does not match the needs of the consumer.

## Swiss Meteo Data
### Sunshine duration
This data product allows the consumer to get a view of the average duration of sunshine at the measurement points over the last 10 minutes. However it does not allow historical data access and must therefore be scraped every 10 minutes and data be retained in a secondary location.

The repository provides a blueprint for a CloudRun function and schedule to scrape data form the API and load it into BigQuery to be historized.
