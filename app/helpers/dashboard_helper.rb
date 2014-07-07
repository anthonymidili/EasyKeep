module DashboardHelper
  def admin_or_all_users
    if params[:all_users]
      link_to 'Show only admin users', developer_dashboard_path
    else
      link_to 'Show all users', all_users_path(:all_users)
    end
  end
end
