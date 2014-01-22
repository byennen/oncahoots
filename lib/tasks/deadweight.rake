begin
  require 'deadweight'
rescue LoadError
end

require 'deadweight'

Deadweight::RakeTask.new do |dw|
  dw.stylesheets = ["/assets/layout.css.scss", "/assets/screen.css.scss"]
  dw.pages = ["/static/about", "/static/clubs", "/static/college", "/static/communication", "/static/events", "/static/index", "/static/lowdown", "/static/members",
              "/static/money", "/static/network", "/static/photos", "/static/running-club", "/static/search", "/static/search-detail", "/static/settings"]
end
