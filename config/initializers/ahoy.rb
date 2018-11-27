class Ahoy::Store < Ahoy::DatabaseStore
  def visit_model
    Visit
  end
end

Ahoy.geocode = false
