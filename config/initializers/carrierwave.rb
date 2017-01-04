CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
        # Configuration for Amazon S3 should be made available through an Environment variable.
        # For local installations, export the env variable through the shell OR
        # if using Passenger, set an Apache environment variable.
        #
        # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
        #
        # $ heroku config:add S3_KEY=your_s3_access_key S3_SECRET=your_s3_secret S3_REGION=eu-west-1 S3_ASSET_URL=http://assets.example.com/ S3_BUCKET_NAME=s3_bucket/folder

        # Configuration for Amazon S3
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
