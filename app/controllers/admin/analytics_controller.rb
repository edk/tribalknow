
class Admin::AnalyticsController < ApplicationController
  def index
    @stats = []
    @stats << ['User signups by week', User.group_by_week(:created_at).count, :column_chart]
    @stats << ['Usage by country', Visit.group(:country).count, :geo_chart]
    @stats << ['Top Searches',
               Ahoy::Event.where(name: 'searches#index').group(:properties).count.inject({}) {|m, (k,v)| m[k["q"]] = v ; m  },
               :pie_chart]
  end
end

