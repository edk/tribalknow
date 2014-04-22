# recorder.js and libmp3lame-js
#   http://nusofthq.com/blog/recording-mp3-using-only-html5-and-javascript-recordmp3-js/
#     https://github.com/akrennmair/libmp3lame-js
#     https://github.com/mattdiamond/Recorderjs
#   https://github.com/nusofthq/Recordmp3js
# 


class MultimediaController < ApplicationController
  
  def index
    @multimedia = Multimedia.paginate(:page=>params[:page])
  end
  
  def show
  end

  def new
    
  end
  def create
  end
  
  def edit
  end
  def update
  end
  
  def destroy
  end
  
end
