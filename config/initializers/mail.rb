require "smtp_tls"

ActionMailer::Base.smtp_settings = {
  :address => "host",
  :port => 587,
  :authentication => :plain,
  :user_name => 'user',
  :password => 'password'
}

