class ContentFixup < ApplicationRecord
  validates :name, uniqueness: true

  def self.apply(text:)
    rv = text.to_s.dup
    ContentFixup.all.each do |cf|
      rv = rv.gsub(%r/#{cf.from_regex}/, cf.to_string.to_s)
    end
    rv
  end
end
