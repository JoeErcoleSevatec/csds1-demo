set RAILS_ENV=development
cd ruby

sudo bash -c 'source /home/ec2-user/.rvm/scripts/rvm && rvm --default use 2.2.7 && gem install bundler'
sudo bash -c 'source /home/ec2-user/.rvm/scripts/rvm && rvm --default use 2.2.7 && bundle install'

sudo bash -c 'source /home/ec2-user/.rvm/scripts/rvm && rvm --default use 2.2.7 && rake db:drop && rake db:create && rake db:migrate && rake db:seed'
sudo bash -c 'source /home/ec2-user/.rvm/scripts/rvm && rvm --default use 2.2.7 && rails server -d -p 8080 -b 0.0.0.0'
