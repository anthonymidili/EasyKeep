class UserMailer < ActionMailer::Base
  default from: ENV['DEVISE_MAILER_SENDER']

  def invoice_ready_notice(invoice)
    @invoice = invoice
    mail(to: "#{@invoice.account.user.name} <#{@invoice.account.user.email}>", subject: 'Invoice ready to view')
  end
end
