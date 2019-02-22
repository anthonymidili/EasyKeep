CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.development?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', ''),
        aws_secret_access_key: ENV.fetch('AWS_SECRET_KEY', '')
    }
    config.storage = :fog
    config.fog_directory = ENV['S3_BUCKET_NAME']

    # To let CarrierWave work on heroku
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  elsif Rails.env.test? || Rails.env.cucumber?
    # For testing, upload files to local `tmp` folder.
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end
end
