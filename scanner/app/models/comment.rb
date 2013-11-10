class Comment < ActiveRecord::Base
  belongs_to :scan
  belongs_to :user
end
