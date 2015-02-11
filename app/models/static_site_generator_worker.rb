
class StaticSiteGeneratorWorker
  include Sidekiq::Worker

  def perform tenant_id
    Tenant.current_id = tenant_id
    tenant = Tenant.current
    docset = Docset.new name: tenant.site_title, base_path: Rails.root.join("docs/tmp/#{tenant.site_title}.docset")
    site = StaticSiteGenerator.new docset
    site.render_all_to_file
    site.finish

    zip_path = docset.zip_path
    dir_path = docset.base_path
    File.unlink(zip_path) if File.exist?(zip_path)
    `(cd #{dir_path}/.. ; zip -q9r #{zip_path} #{dir_path})`
  end
end
