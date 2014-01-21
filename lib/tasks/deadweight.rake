begin
  require 'deadweight'
rescue LoadError
end

require 'deadweight'

Deadweight::RakeTask.new do |dw|
  dw.stylesheets = ["/assets/layout.css.sass", "/assets/screen.css.sass"]
  dw.pages = ["/static/about", "/static/clubs", "/static/college", "/static/communication", "/static/events", "/static/index", "/static/lowdown", "/static/members",
              "/static/money", "/static/network", "/static/photos", "/static/running-club", "/static/search", "/static/search-detail", "/static/settings"]
end
