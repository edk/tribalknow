class Ahoy::Store < Ahoy::DatabaseStore
  def visit_model
    Visit
  end
end

Ahoy.cookie_options = { same_site: :lax }

Ahoy.geocode = false
