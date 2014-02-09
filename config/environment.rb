# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
    :user_name =>           ENV["SENDGRID_USERNAME"],
    :password =>            ENV["SENDGRID_PASSWORD"],
    :domain =>              ENV['SENDGRID_DOMAIN'],
    :address =>             ENV['SENDGRID_ADDRESS'],
    :port =>                ENV['SMTP_PORT'],
    :authentication =>      ENV['SMTP_AUTHENTICATION'],
    :openssl_verify_mode => ENV['SMTP_OPENSSL_VERIFY_MODE']
}

# Initialize the rails application
HouseKeeping::Application.initialize!
