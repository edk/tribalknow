# Be sure to restart your server when you modify this file.

#Tribalknow::Application.config.session_store :cookie_store, key: '_tribalknow_session'

Tribalknow::Application.config.session_store :active_record_store, same_site: :lax, secure: Rails.env.production?
