class Comment < ActiveRecord::Base

  # Comments belong to both a user and scan.
  belongs_to :scan
  belongs_to :user

end
