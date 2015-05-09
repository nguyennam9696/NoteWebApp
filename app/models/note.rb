class Note < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :content
  validates_length_of :content, :maximum => 150

end
