# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Huntr::Application.initialize!

# Set up ActionMailer (for Devise confirmation).
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => ENV['GMAIL_USERNAME'],
  :password             => ENV['GMAIL_PASSWORD'],
  :authentication       => 'plain',
  :enable_starttls_auto => true }