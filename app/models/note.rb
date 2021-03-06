class Note < ActiveRecord::Base
  belongs_to :folder, inverse_of: :notes
  validates :name, :presence => true, :length => { :minimum => 2, :maximum => 50 }
  validates :content, :presence => true, :length => { :maximum => 500 }
end


# inverse_of