class VideosController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :update_status
  protect_from_forgery :except => [:update_status]

  def index
    @published_videos = VideoAsset.published.paginate(:page=>params[:page], :per_page=> 3*9 )
    if current_user.admin?
      @draft_videos = VideoAsset.unpublished
    else
      @draft_videos = VideoAsset.unpublished.where(creator_id: current_user.id)
    end
  end

  def show
    @video = VideoAsset.friendly.find(params[:id])
  end

  def new
    @video = VideoAsset.new
    @video.name = "New Video"
    @video.save!
    redirect_to edit_video_path(@video)
  end

  def create
    @video = VideoAsset.new(video_params)

    respond_to do |format|
      if @video.save
        @video.draft_id = @video.id
        # NotifyHipchat.call(type: action_name.to_sym, object: @video, user: current_user, url: polymorphic_url(@video)) if params[:notify][:notify] == '1'
        format.html { redirect_to videos_path, notice: 'Video was successfully created.' }
        format.json { render json: @video.as_json.merge(draft_id: @video.id, location: video_path(@video)), status: :created, location: video_path(@video) }
      else
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @video = VideoAsset.friendly.find(params[:id])
  end

  def update
    @video = VideoAsset.friendly.find(params[:id])
    @video.draft_id = @video.id

    if @video.name != params[:video_asset][:name]
      @video.slug = nil # friendly-id: clearing out the slug makes the friendly id get regenerated.
    end

    respond_to do |format|
      if @video.update(video_params)
        if @video.asset? && !@video.asset.exists?(:thumb) && @video.draft?
          @video.submit!
        end
        format.html { redirect_to videos_path, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @video = VideoAsset.friendly.find(params[:id])

    if @video.creator == current_user
      if @video.destroy
        flash.now[:notice] = "Deleted #{@video.name}!"
      else
        flash.now[:alert] = "Error deleting #{@video.name}! #{@video.errors.full_messages}"
        @video = nil
      end
      # redirect_to videos_path
    else
      flash.now[:alert] = "You are not allowed to delete videos that you don't own"
      @video = nil
      # redirect_to videos_path
    end
  end

  def info
    video = VideoAsset.find(params[:id])
    if video.submitted?
      begin
        if video.check_status!
          video.complete!
          video.save(validate: false)
          @completed = true
          return
        end
      rescue
        video.transcode_jobs.create response: "Internal error checking status #{$!}."
      end
    end

    @video_info = "#{video.name} uploaded at #{l(video.created_at, format: :civilian)}"
    jobs = video.transcode_jobs
    @job_info = jobs.map { |job|
      resp_str = begin
        json = JSON.parse(job.response)
        json["error"] || json.slice(* %w[id name asset_file_name asset_content_type asset_file_size])
      rescue
        job.response
      end
      "#{resp_str} at #{job.created_at}"
    }.reverse
  end

  def trigger
    @video = VideoAsset.find(params[:id])
    @video.submit!
    @success = !@video.failed?
  end

  def update_status
    @video = VideoAsset.find(params[:id])
    if !@video.secret  || @video.secret.value != params[:video_asset_secret]
      respond_to do |format|
        format.any(:html, :json) { render json: @video.id, status: :unauthorized}
      end
      return
    end

    job = @video.transcode_jobs.create params.permit(:response, :status)
    if job.status == 201
      @video.complete!
    else
      @video.fail!
    end
    respond_to do |format|
      format.any(:html, :json) { render json: @video, status: :ok}
    end
  end

  private
  def video_params
    params[:video_asset][:tag_list] = params[:video_asset].delete(:tags)
    params[:video_asset].permit(:name, :description, :tag_list, :thumbnail,
                                :asset, :draft, :draft_id, :date) # notify isn't in the video_asset hash, but it's leaking in from the manual js setting
  end

end
