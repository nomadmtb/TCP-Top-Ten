class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # If a user is deleted, all of the associated data is too!
  has_many :scans, :dependent => :destroy
  has_many :comments, :dependent => :destroy

end
