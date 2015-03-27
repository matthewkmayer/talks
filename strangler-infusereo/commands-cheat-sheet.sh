# Demo all ruby code:
vagrant up
vagrant ssh

# ruby service up:
cd /vagrant/code/
ruby ruby-service.rb &

# cuke tests:
cucumber

# Demoing strangler:
killall ruby
# Flip feature toggle in ruby service

# run them both:
ruby ruby-service.rb & ./strangler &

# cucumber tests still work:
cucumber
