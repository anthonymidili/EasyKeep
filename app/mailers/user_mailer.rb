class UserMailer < ActionMailer::Base
  default :from => ENV['DEVISE_MAILER_SENDER']

  def invoice_ready_to_view(user, invoice)
    @user = user
    @invoice = invoice
    mail(:to => "#{user.name} <#{user.email}>", :subject => 'Invoice ready to view')
  end
end
