class NotesController < ApplicationController
  def create
    @path = params[:path]
    @note = Note.create(:path=>params[:path], :title=>'Your title', :content=>'Your content')
  end

  def update
    @note = Note.find params[:id]

    respond_to do |format|
      if @note.update_attributes(doc_params)
        format.json { respond_with_bip(@note) }
      else
        format.json { respond_with_bip(@note) }
      end
    end
  end

  def destroy
  end

  private

  def doc_params
    params.require(:note).permit(*policy(@note||Note).permitted_attributes)
  end
end
