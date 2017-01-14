class Api::BaseController < ApplicationController
  include ApiHelper

  skip_before_action :authenticate_user!
  before_action :authenticate_api

  protected

    def authenticate_api
      if AppConfig[:api_key] != params[:api_key] || params[:api_key].blank?
        render :text => "Sorry, you don't have access.", :status => 403
        return
      end
    end

end
