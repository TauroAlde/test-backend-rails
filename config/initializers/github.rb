Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.application.credentials.app_id, Rails.application.credentials.app_scret
end
