module DashboardHelper
  def admin_or_all_users
    if params[:all_users]
      link_to 'Show only admin users', developer_dashboard_path
    else
      link_to 'Show all users', all_users_path(:all_users)
    end
  end

  def logo_or_default
    if current_company.logo.present?
      image_tag current_company.logo_url(:thumb)
    else
      image_tag 'business-shop.png'
    end
  end
end
