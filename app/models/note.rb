class Note < ActiveRecord::Base
  belongs_to :folder
  validates :name, :presence => true, :length => { :minimum => 2, :maximum => 50 }, :uniqueness => { :case_sensitive => false }
  validates :content, :presence => true, :length => { :maximum => 500 }
end
