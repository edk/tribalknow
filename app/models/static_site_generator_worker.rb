
class StaticSiteGeneratorWorker
  include Sidekiq::Worker


  # producer
  def self.trigger tenant_id
    puts "class trigger"
    StaticSiteGeneratorWorker.perform_async(tenant_id)
  end

  # include Debounce
  # debounce_class_method :trigger


  # consumer of the job.
  def perform tenant_id
    accepting_new_jobs = $redis.setnx "generating_docset", Time.now.to_i
    puts accepting_new_jobs

    if !accepting_new_jobs 
      $redis.setnx "new_docset_request", Time.now.to_i

      if stale?
        puts "assume prev job died, doing heavy lifting anyway"
        run_job tenant_id
      else
        puts "already in progress, skipping"
      end

    else
      puts "starting new job"
      run_job tenant_id
    end

  end

  def stale?
    time_start = $redis.get "generating_docset"
    time_diff  = Time.now.to_i - time_start.to_i
    time_threshold = 20.seconds
    time_diff > time_threshold
  end

  def run_job tenant_id
    puts "doing heavy lifting"
    StaticSiteGenerator.generate(tenant_id)
    # sleep 10
    puts "done!"
    if $redis.get("new_docset_request")
      $redis.del "new_docset_request"
      StaticSiteGeneratorWorker.trigger tenant_id
    end
    $redis.del "generating_docset" # lowering ready flag
  end
end

