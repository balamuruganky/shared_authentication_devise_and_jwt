docker-compose run web yarn install --check-files && bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed

