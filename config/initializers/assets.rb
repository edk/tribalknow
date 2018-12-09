# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w(
  devise/sessions.js
  accounts.js answers.js autocomplete.js docs.js homes.js
  questions.js searches.js topics.js users.js videos.js
  welcome.js
  )
  # # Precompile additional assets.
  # # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( mdedit.js mdedit.css dropzone-basic.css)
  # config.assets.precompile += %w( vendor/modernizr.js autocomplete.js accounts.js autocomplete.js
  #   docs.js homes.js questions.js topics.js users.js welcome.js admin/users.js admin/apporve_users.js admin/config.js
  #   devise/sessions.js searches.js videos.js )