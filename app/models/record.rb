class Record < ActiveRecord::Base
  attr_accessible :file

  mount_uploader :file, RecordUploader

end
