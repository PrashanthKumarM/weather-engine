# Anemometer

The rails backend providing the API endpoints to the weather predicting app

# Development Setup

Make sure you have ruby version ruby 2.2.4p230 installed and rails version 4.2.6.

Check the database.yml for correct database credentials.

Run `bundle install`
Run `rake db:create`
Run `rake db:migrate`
Run `rails s` to start the server

visit http://localhost:3000 to view.

# Continuous Integration and Deployment

This app has a Travis CI integration for Continuous Integration and Continuous Deployment. Travis CI just installs the needed dependencies and runs test scripts. Integration tests are in RSpec and Unit tests are in selenium. Once a feature has been completed and merged to master, the Travis CI runs the script and does a `cap production deploy` which deploys the code in production. Capistrano pulls in the latest version of code and places it in the "current" folder inside the server. The server is interfaced with nginx.

# Contents

This app contains the API and the UI interfaces. All the UI is based on Bootstrap, jQuery and CSS3 with SCSS translation.