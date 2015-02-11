
class StaticSiteGeneratorWorker
  include Sidekiq::Worker

  def perform tenant_id
    StaticSiteGenerator.generate(tenant_id)
  end
end
