class VideoAttachmentsController < ApplicationController
  def create
    @video = VideoAsset.friendly.find(params[:video_id])
    att = @video.video_attachments.build(video_attachment_params)

    if att.save
      redirect_to video_path(@video)
    else
      flash[:notice] = att.errors.full_messages.join("<br/>".html_safe)
      redirect_to video_path(@video)
    end
  end

  def destroy
  end

  private
  def video_attachment_params
    params[:video_attachment].permit(:name, :description, :asset )
  end

end
