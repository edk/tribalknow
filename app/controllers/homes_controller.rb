class HomesController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    # respond_to do |format|
    #   if @home.save
    #     format.html { redirect_to @home, notice: 'Home was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @home }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @home.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    # respond_to do |format|
    #   if @home.update(home_params)
    #     format.html { redirect_to @home, notice: 'Home was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @home.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    # @home.destroy
    # respond_to do |format|
    #   format.html { redirect_to homes_url }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
end
