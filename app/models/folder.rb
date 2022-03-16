class Folder < ActiveRecord::Base
  belongs_to :user
  has_many :notes

  validates :name, :presence => true, :length => { :minimum => 2, :maximum => 50 }
end
