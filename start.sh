#!/bin/sh
echo "Bundle check..."
bundle check || bundle install

echo "Initializing database..."
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate

echo "Migrating & seeding..."
bundle exec rake db:seed

rm tmp/* -Rf

bundle exec rails s -b 0.0.0.0