class Folder < ActiveRecord::Base
  belongs_to :user, inverse_of: :folders
  has_many :notes, inverse_of: :folder, dependent: :delete_all # destroy

  validates :name, :presence => true, :length => { :minimum => 2, :maximum => 50 }
end

# uniq validation scope
# protected attributes
# update_attributes, update_coulmn -> callback
# model default scope and custom scope with arguments