class Folder < ActiveRecord::Base
  belongs_to :user
  has_many :notes, dependent: :delete_all # destroy

  validates :name, :presence => true, :length => { :minimum => 2, :maximum => 50 }
end

# uniq validation scope
# protected attributes
# update_attributes, update_coulmn -> callback
# model default scope and custom scope with arguments