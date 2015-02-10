
require 'sqlite3'
require 'render_anywhere'

class StaticSitesController < ApplicationController

  def show
    docset = Docset.new name: Tenant.current.site_title, base_path: Rails.root.join("docs/tmp/#{Tenant.current.site_title}.docset")
    site = StaticSiteGenerator.new docset
    site.render_all_to_file
    site.finish

    # zip, send_data

    render text: 'ok'
  end
  
end
