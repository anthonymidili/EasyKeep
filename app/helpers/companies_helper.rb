module CompaniesHelper
  # display the company logo or the default example logo
  def logo_or_default
    if current_company.logo.present?
      image_tag current_company.logo_url(:thumb)
    else
      image_tag 'default_logo.png', class: 'resize_photo'
    end
  end
end
