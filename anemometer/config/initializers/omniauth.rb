OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '306440530979-h2pm0ams9ugr4l7vq5ulhbt1tqd8p9oa.apps.googleusercontent.com', 'MwcwAFwrKTNYcE2Ywd7AwGGJ', {skip_jwt: true, client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end