class Script < ActiveRecord::Base
  belongs_to :user
  
  validates_associated  :user
  validates_presence_of :name
  validates_length_of   :name, :within => 1..40
  
  def self.per_page
    10
  end
  
  def before_validation
    self.name = name.gsub(/\s/, '_').gsub(/[^_a-zA-Z0-9]/, "-") if attribute_present?('name')
  end
end
