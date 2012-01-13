# Be sure to restart your server when you modify this file.

ContactOTron::Application.config.session_store :cookie_store,
  key: '_contact-o-tron_session'
  secure: Rails.env.production?,
  http_only: true
