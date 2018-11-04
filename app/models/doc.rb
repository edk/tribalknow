class Doc < ApplicationRecord
  serialize :data

  def self.config_filename
    Rails.root.join('config/docs_config.yml')
  end

  def self.config
    @config ||= YAML.load_file(config_filename) if File.exists?(config_filename)
    @config || {}
  end

  def to_s
    "Doc"
  end
end
