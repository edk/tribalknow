
require 'sqlite3'

class StaticSitesController < ApplicationController

  def show
    docset = Docset.new name: Tenant.current.site_title, base_path: Rails.root.join("docs/tmp/#{Tenant.current.site_title}.docset")
    StaticSiteGenerator.generate(Tenant.current.id) if !File.exist?(docset.zip_path)
    send_file docset.zip_path, disposition: 'attachment', type: 'application/zip'
  end

end
