# Weather Engine

Prediction of weather is a complex process where one has to consider various factors from previous data to variables in the current scenario. Nowadays weather forecast is an essential information for all people as it defines their day. There are several techniques to get a forecast but the software casing of it is still a confusing and arduous task. Weather engine is exactly what it sounds like, it is a weather prediction engine based on a micro-service architecture. There are 4 services:

1. Anemometer - The API gateway , a Ruby on Rails application
2. Rain Gauge - The Data Ingestor , a Python Flask application
3. Weather Ballon - The Storm Predictor , a Spark application
4. Satellite - The registry , a Node JS application (Under Construction)

The data is stored in Mysql Database and Redis is used for persistence storage. The registry solely revolves around the Redis and every application writes identifyable keys to redis as and when their work is done. The weather ballon or the storm predictor here is just a non implemented process. It is upto the person using it to implement their own algorithms necessary for prediction. The UI in anemometer is easily variable and the satellite too. The data I have picked to use is from NEXRAD. That can be varied in the Rain Gauge microservice. In all nature, this is a truly configurable engine which can be deployed in AWS and load balanced by nginx.

# Application Workflow

The UI for all is present in the anemometer app. But the actual processing takes place in the microservices. The app takes in a station and a time for processing data and passes it on to the data ingestor application which forms the URL and fetches data. This is then passed on the storm prediction and clustering app which will predict the storm based on the data. The result will then be posted to redis from which the gateway can pick up and present it to the user. In every application, the step completion is recorded in the redis with a unique identifier. The registry simply pulls in the keys, segregates based on the identifiers and will be able to present the status. Currently the data ingestor and API gateway are fully connected and functional. The storm predictor is available but not connected. The redis has not been used as the registry has not been built. The app can form the data url with User authentication based on Authlogic.
