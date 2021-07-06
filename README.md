# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  - 2.7.2

* Rails version
  - 6.1

* Database postgreSQL
  - 1.2.3

* System dependencies
  - git clone 
  - cd test-backend-rails
  - npm install bundle

* Configuration Database
  1. sudo-su postgres
  2. psql
  3. CREATE ROLE name_user WITH SUPER LOGIN;
  4. ALTER USER name_user WITH PASSWORD 'passsword_user';
  5. CREATE DATABASE name_data_base;
  6. \q
  7. exit

* Configuration
  1. install rvm -> https://rvm.io/
  2. Select ruby version with rvm use 2.7.2
  3. Create a gemset and selected
  4. Run bundle install
  5. rails db:create
  6. rails db:migrate

* Configuration encripted keys
  1. Open the encripted -> EDITOR=vi bin/rails credentials:edit
  2. GITHUB- More information -> https://docs.github.com/es/developers/apps/authenticating-with-github-apps
    - app_id:
    - app_scret:
    - username_github:
    - authorization_github:
    - access_token:
  3. TWITTER- More information -> https://developer.twitter.com/en/portal/projects-and-apps
    - twitter_consumer_key:
    - twitter_consumer_secret:
    - twitter_access_token:
    - twitter_access_token_secret:

* Configuration for Docker
  - We need install in terminal or console these commands
    1. Create the network for the local machine
      - docker network create local-net
    2. Install yarn
      - docker exec test-backend-rails_web_1 yarn install
    3. Configurate the postgres database
      - docker exec test-backend-rails_db_1 psql -U postgres -c "CREATE ROLE samaya WITH SUPERUSER LOGIN; "
      - docker exec test-backend-rails_db_1 psql -U postgres -c "ALTER USER samaya WITH PASSWORD 'samaya'; "
      - docker exec test-backend-rails_db_1 psql -U postgres -c "CREATE DATABASE samaya; "
    4. Generate the migrations for rails
      - docker exec test-backend-rails_web_1 rails db:migrate

* ...
