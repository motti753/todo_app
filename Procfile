web: bundle exec puma -t 5:5 -p ${PORT:-3100} -e ${RACK_ENV:-development}
web: bundle exec puma -C config/puma.rb
release: bundle exec rake db:migrate