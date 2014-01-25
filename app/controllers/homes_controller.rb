class HomesController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
  end

  def todo
  end

end
