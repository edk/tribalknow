module SearchHelper

  def render_search_results search
    results = ""
    debugger
    search.results.each do |result|
      results += render_topic(result)    if result.is_a?(Topic)
      results += "<br>"
      results += render_question(result) if result.is_a?(Question)
      results += "<br>"
      results += render_answer(result)   if result.is_a?(Answer)
      results += "<br>"
    end
    results
  end

  def render_topic result
    results = "#{result.name} is a topic"
  end
  def render_question result
    results = "#{result.title} is a question"
  end
  def render_answer result
    results = "#{result.id} is a answer"
  end
  def render_topical
    results += "<li>"
    results += "<div class='row search_results'>"
    results += "<div class='small-2 columns'>"
    results += "<% result %> need to report the # of answers.  not in schema yet"
    results += "</div>"
    results += "<div class='small-10 columns'>"
    results += "<h3> <%= result.try(:title) %> </h5>"
    results += "<div class='text'><%= raw result.text %> </div>"
    results += "<div class='row'>"
    results += "<div class='small-8 columns'>"
    results += "<div class='tags'> "
    results += "<% result.tags.each do |t| %>"
    results += "<%= <a href=''> <span class='label radius'> #{t}</span> </a>.html_safe %>"
    results += "<% end %>"
    results += "</div>"
    results += "</div>"
    results += "<div class='small-4 columns text-right'>"
    results += "asked <%= l(result.updated_at, format: :civilian) %>"
    results += "<%= result.creator.try(:name) %>"
    results += "</div>"
    results += "</div>"
    results += "</div>"
    results += "<div class='small-2 columns'>"
    results += "</div>"
    results += "</div> "
    results += "</li>"
  end
end
