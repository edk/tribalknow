module ActivityHelper
  def extract_activity(activity)
    activity = GlobalID::Locator.locate activity[1]["obj"]
  end

  def show_whodunnit(activity)
    if activity && activity[1] && activity[1]["whodunnit"]
      t = Time.parse(activity[1]["at"])
      time_ago = " #{time_ago_in_words(t)} ago" if t
      actors = []
      what = []

      activity[1]["whodunnit"].each do |who|
        suffix = who["action"].last == 'e' ? 'd' : 'ed'
        what << "#{who["action"]}#{suffix}"

        actors << who["who"]
      end
      "#{actors.uniq.sort.join(', ')} #{what.uniq.sort.join(', ')}#{time_ago}"
    end
  end

end
