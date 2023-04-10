class ApplicationMailer < ActionMailer::Base
  require 'dotenv'
  Dotenv.load

  default from: ENV['SENDER_ADDRESS']
  layout "mailer"
end
