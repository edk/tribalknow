# An adapter class to encapsulate the operations needed
# to communicate with the remote transcoding server.
class TranscodeRemote < ApplicationRecord
  belongs_to :video_asset

  def key
    ENV['TRANSCODING_SERVER_API_KEY']
  end

  def transcoding_server
    ENV['TRANSCODING_SERVER_URL']
  end

  def enable_logging?
    true
  end

  def disable_ssl_verification?
    ENV['TRANSCODING_SERVER_DISABLE_VERIFY'].present?
  end

  def queue_new_job
    connect do |conn|
      # build up the payload
      fqdn = ENV['FQDN'] || 'http://127.0.0.1:3000'
      callback_url = [fqdn.gsub(/\/$/,''), "videos/#{video_asset.id}/update_status"].join('/')
      data = { name: video_asset.name, video_asset_id: video_asset.id,
               video_asset_secret: video_asset.secret.value,
               callback_url:  callback_url}
      
      %w[asset_file_name asset_content_type asset_file_size].each do |a|
        data[a.to_sym] = video_asset.send(a)
      end

      resp = conn.post do |req|
        req.url [transcoding_server.to_s.gsub(/\/$/,''), 'api/transcode_jobs'].join('/')
        req.body = data.to_json
      end

      if resp.success?
        # parse body, get the job id, so we can check up on it periodically and know when it's complete.
        response_hash = JSON.parse(resp.body)
        self.status   = resp.status
        self.response = resp.body
        self.job_id   = response_hash["id"].to_i
      else
        self.status   = resp.status
        self.response = resp.body
        nil
      end
    end
  end

  def query_job_status
    connect do |conn|
      resp = conn.get [transcoding_server, "api/transcode_jobs/#{video_asset.id}"].join('/')
      if resp.success?
        resp_hash = JSON.parse(resp.body)
        self.status = resp.status
        self.response = resp.body
        resp_hash["aasm_state"] == "completed"
      else
        self.status   = resp.status
        self.response = resp.body
        nil
      end
    end
  end

  protected
  def secret
    video_asset.secret.value
  end

  def connect
    begin
      options = { :url => transcoding_server }
      options.merge!( :ssl => { :verify => false } ) if disable_ssl_verification?
      conn = Faraday.new options do |faraday|
        faraday.request  :url_encoded               # form-encode POST params
        faraday.response :logger if enable_logging? # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter
        faraday.headers['Content-Type']  = 'application/json'
        faraday.headers['Accept']        = 'application/json'
        faraday.headers['Authorization'] = ActionController::HttpAuthentication::Token.encode_credentials(key)
      end
      yield conn
    rescue Faraday::ClientError
      self.response = { error: $!.to_s }
      nil
    end
  end

end
