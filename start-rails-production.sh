cd ruby

sudo bash -c 'source /home/ec2-user/.rvm/scripts/rvm && rvm --default use 2.2.7 && gem install bundler'
sudo bash -c 'source /home/ec2-user/.rvm/scripts/rvm && rvm --default use 2.2.7 && bundle install'
sudo bash -c 'source /home/ec2-user/.rvm/scripts/rvm && rvm --default use 2.2.7 && rake RAILS_ENV=production db:drop db:create db:migrate db:seed'
sudo bash -c 'source /home/ec2-user/.rvm/scripts/rvm && rvm --default use 2.2.7 && rails server -d -p 8080 -b 0.0.0.0 -e production'
