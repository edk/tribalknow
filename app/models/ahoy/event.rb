module Ahoy
  class Event < ApplicationRecord
    include Ahoy::Properties

    self.table_name = "ahoy_events"

    belongs_to :visit
    belongs_to :user, optional: true
  end
end
