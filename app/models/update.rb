class Update < ActiveRecord::Base
  attr_accessible :body
  belongs_to :updateable, polymorphic: true

end
