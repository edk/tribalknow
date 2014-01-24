class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Userstamp
  around_filter :scope_current_tenant

  private
  def current_tenant
    current_tenant ||= Tenant.find_by domain: request.domain
    current_tenant ||= Tenant.find_by subdomain: request.subdomain
    current_tenant ||= Tenant.default_tenant
  end
  helper_method :current_tenant

  def scope_current_tenant
    Tenant.current_id = current_tenant.id
    yield  # == running the action
  ensure
    Tenant.current_id = nil
  end
end

