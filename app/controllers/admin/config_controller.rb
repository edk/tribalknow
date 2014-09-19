class Admin::ConfigController < ApplicationController
  def index
    @app_configs = AppConfig.paginate(:page=>params[:page])
  end

  def create
    @app_config = AppConfig.new params[:app_config].permit(:key,:value)
    if @app_config.save
    else
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @app_config = AppConfig.find(params[:id])

    respond_to do |format|
      if @app_config.update_attributes(config_params[:app_config])
        format.json { respond_with_bip(@app_config) }
      else
        format.json { respond_with_bip(@app_config) }
      end
    end
  end

  def destroy
    @app_config = AppConfig.find(params[:id])
    @rv = @app_config.destroy

    respond_to do |format|
      format.js
    end
  end

  private
  def config_params
    params.permit! # because we don't know the keys ahead of time.
  end
end
