# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://easykeep.herokuapp.com'

SitemapGenerator::Sitemap.create do
  add '/users/sign_in'
  add '/users/sign_out'
  add '/users/password'
  add '/users/password/new'
  add '/users/password/edit'
  add '/users/cancel'
  add '/users'
  add '/users/sign_up'
  add '/users/edit'
  add '/users/invitation/accept'
  add '/users/invitation/remove'
  add '/users/invitation'
  add '/users/invitation/new'

  add '/company/quarterly_report'
  add '/company/yearly_report'
  add '/company/search_invoices'
  add '/company/about'
  add '/company/delete_user/:id'
  add '/company'
  add '/company/new'
  add '/company/edit'

  add '/accounts/:account_id/invite_customer'
  add '/accounts'
  add '/accounts/new'
  add '/accounts/:id/edit'
  add '/accounts/:id'

  add '/services/invoice'
  add '/services'
  add '/services/:id/edit'
  add '/services/:id'

  add '/invoices/add_services'
  add '/invoices/remove_services'
  add '/invoices/:id/invoice_ready'
  add '/invoices/:invoice_id/payments'
  add '/invoices/:invoice_id/payments/new'
  add '/invoices/:invoice_id/payments/:id/edit'
  add '/invoices/:invoice_id/payments/:id'
  add '/invoices'
  add '/invoices/:id/edit'
  add '/invoices/:id'

  add '/about'

# Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
