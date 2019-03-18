class ApplicationMailer < ActionMailer::Base
  default from: 'dummySMTPLogger@gmail.com'
  layout 'mailer'
end
