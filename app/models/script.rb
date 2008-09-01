class Script < ActiveRecord::Base
  belongs_to :user
  validates_associated :user
  validates_presence_of :name
  
  def self.per_page
    10
  end  
end
