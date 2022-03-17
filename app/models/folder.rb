class Folder < ActiveRecord::Base
  belongs_to :user
  has_many :notes, dependent: :delete_all

  validates :name, :presence => true, :length => { :minimum => 2, :maximum => 50 }
end
