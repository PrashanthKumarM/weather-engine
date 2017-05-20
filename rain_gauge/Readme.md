# Rain Gauge

This is a Python Flask application which serves as the Data Ingestor service. Its use is limited to getting the parameters from the API and forming the data URL. This then passes on the data to the storm prediction service and writes a new key to the registry.

# Development Setup

Install Flask in your local machine. Follow: http://flask.pocoo.org/docs/0.11/installation/ and inside the repository follow these commands:

`export FLASK_APP=application.py`
`flask run`

This should run flask in http://localhost:5000/

# Setup in EC2

Currently the EC2 instance has flask installed and ready to use. We use the "gunicorn" as the server to interface with nginx.

To deploy a new version simply `git pull` inside the repository and run `sudo netstat -nlp | grep :80`.
Note the process id and do `kill -p <process_id>` then run `gunicorn application:app -b localhost:8000`.
Do a `sudo service nginx restart` to restart the nginx service. Your new version of code is deployed now.