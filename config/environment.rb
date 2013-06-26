# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
    :user_name => ENV["SENDGRID_USERNAME"],
    :password => ENV["SENDGRID_PASSWORD"],
    :domain => "house-keeping.herokuapp.com",
    :address => "smtp.sendgrid.net",
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}

# Initialize the rails application
HouseKeeping::Application.initialize!
