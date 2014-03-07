class UserMailer < ActionMailer::Base
  default :from => ENV['SENDGRID_DOMAIN']

  def invoice_ready_to_view(invoice)
    @user = invoice.account.user
    @invoice = invoice
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => 'Invoice ready to view')
  end
end
