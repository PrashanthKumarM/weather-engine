from flask import Flask
from flask import request
from datetime import datetime
import boto
import urllib
import json
import redis
import os

app = Flask(__name__)

redis_url = os.getenv('REDISTOGO_URL', 'redis://redis:6379')
conn = redis.from_url(redis_url)

@app.route('/')
def data_ingest():

    station = request.args.get('stations')
    time = request.args.get('date')
    redis_key = request.args.get('redis_key')
    weather_date = datetime.strptime(time, '%m/%d/%Y %I:%M %p')
    s3_connection = boto.connect_s3(anon=True)
    return_url = "https://aws.amazon.com/noaa-big-data/nexrad/"
    s3_bucket = s3_connection.get_bucket('noaa-nexrad-level2',validate=False)
    timestamp = str(weather_date.year)+"/"+str("%02d"%weather_date.month)+"/"+str(weather_date.day)
    print('Data Injestor Invoked!!!')
    urls = ["http://noaa-nexrad-level2.s3.amazonaws.com/"+key.name for key in s3_bucket.get_all_keys(prefix=timestamp)]
    conn.sadd(redis_key, "Data URLs Generated, JSON prepared to send Gateway")
    conn.sadd(redis_key, "Data sent to Storm clustering in mesos")
    print os.popen('/usr/spark-2.0.2/bin/spark-submit --class src.main.scala.com.sga.sparkwordcount.SparkWordCount --master mesos://54.215.213.130 /app/sparkstormclustering-0.0.1-SNAPSHOT.jar '+urls[0]).read()
    conn.sadd(redis_key, "Storm clustering over in mesos")
    return json.dumps(urls)

if __name__ == "__main__":
    app.run()