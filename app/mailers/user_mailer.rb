class UserMailer < ActionMailer::Base
  default :from => ENV['SENDGRID_DOMAIN']

  def invoice_ready_notice(invoice)
    @invoice = invoice
    mail(:to => "#{@invoice.account.user.name} <#{@invoice.account.user.email}>", :subject => 'Invoice ready to view')
  end
end
