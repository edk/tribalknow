class DomainRedirectorMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      return @app.call(env) unless ENV["USE_DOMAIN_MIDDLEWARE"] == "true" && env["REQUEST_METHOD"] == "GET"

      request = Rack::Request.new(env)

      default_fqdn = ENV['DEFAULT_FQDN'].presence || Tenant.default_tenant&.fqdn
      request_hostname = request.hostname

      if default_fqdn.present? && request_hostname.present? && request_hostname != default_fqdn && !Tenant.exists?(fqdn: request_hostname) && request_hostname != "localhost"
        redirect_url = ActionDispatch::Http::URL.full_url_for({host: default_fqdn, protocol: request.scheme, port: request.port, path: request.fullpath})
        return [301, {'Location' => redirect_url, 'Content-Type' => request.content_type}, ['Moved Permanently']]
      else
        @app.call(env)
      end

    rescue
      @app.call(env)
    end
  end
end
