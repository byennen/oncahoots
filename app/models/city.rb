class City < ActiveRecord::Base
  # attr_accessible :title, :body

  def slug
  	name.parameterize
  end
end
