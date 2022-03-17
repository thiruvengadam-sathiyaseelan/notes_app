class Folder < ActiveRecord::Base
  belongs_to :user
  has_many :notes, dependent: :destroy

  validates :name, :presence => true, :length => { :minimum => 2, :maximum => 50 }, :uniqueness => { :case_sensitive => false }
end
