class ApplicationController < ActionController::Base

  include Pundit
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  # include Userstamp
  around_action :scope_current_tenant
  include PublicActivity::StoreController

  before_action :set_paper_trail_whodunnit
  # skip_after_action :warn_about_not_setting_whodunnit # even though i'm setting it, the warning continues.
  after_action :track_action

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def current_tenant
    if Tenant.multi_tenant?
      current_tenant ||= Tenant.find_by subdomain: request.subdomain
    else
      current_tenant ||= Tenant.default_tenant
    end
  end
  helper_method :current_tenant

  def scope_current_tenant
    Tenant.current_id = current_tenant.try(:id)

    if current_tenant.nil? && !request.subdomain.blank?
      flash[:notice] = "Unknown subdomain #{request.subdomain}"
      canonical_landing = "#{request.protocol}#{request.host.split('.')[-2..-1].join('.')}"
      redirect_to canonical_landing
      return
    end

    yield
  ensure
    Tenant.current_id = nil
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to request.headers["Referer"] || root_path
  end

  def track_action
    skip_tracking = %w[homes#index sessions#new]
    action = "#{controller_name}##{action_name}"
    unless skip_tracking.include? action
      ahoy.track action, request.filtered_parameters
    end
  end

end

