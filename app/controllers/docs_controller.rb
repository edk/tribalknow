# static, pregenerated documentation is placed under the Rails.root (e.g. Rails.root + '/docs')
# From there a meta doc object needs to be created which stores the base path of multiple types of docs (e.g. project/master)
# Each supported doctype is created when DocMetadata#sync is called which regenerates the list of doc objects.
# All doc objects store the path (full and relative from rails root) and the show action of this controller
# renders the appropriate layout and code for that doctype

class DocsController < ApplicationController
  # layout 'application', :except=>:show

  def index
    # list available docs sets
    @all_docs = DocMetadata.all
  end

  def show
    if DocMetadata.route(params[:path], self)
      return
    else
      flash[:info] = "#{params[:path]} not found."
      redirect_to docs_path
    end
  end

  def create
    # ???
  end

  def destroy
    # ???
  end

end
