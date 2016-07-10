
class Admin::AnalyticsController < ApplicationController
  def index
    @stats = []
    @stats << ['User signups by week', User.group_by_week(:created_at).count, :column_chart, {label: 'Number of signups'}]
    @stats << ['User Logins',
                [
                  { name: 'Manual login', data: Ahoy::Event.where(name: 'sessions#create').group_by_day(:time).count },
                  { name: 'Oauth login', data: Ahoy::Event.where(name: 'omniauth-login-ok').group_by_day(:time).count },
                ],
               :line_chart, { stacked: true } ]
    puts @stats.last.inspect
    @stats << ['Usage by country', Visit.group(:country).count, :geo_chart]
    @stats << ['Top Searches',
               Ahoy::Event.where(name: 'searches#index').group(:properties).count.inject({}) {|m, (k,v)| m[k["q"]] = v ; m  },
               :pie_chart, {label: 'Search Term'} ]
  end
end

