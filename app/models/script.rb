class Script < ActiveRecord::Base
  belongs_to :user

  validates_associated    :user

  validates_presence_of   :name
  validates_length_of     :name, :within => 1..40
  validates_uniqueness_of :name, :scope => :user_id, :message => 'already exists'

  validates_length_of     :description, :within => 0..200

  def self.per_page
    10
  end

  def belongs_to?(user)
    self.user == user
  end

  def before_validation
    self.name = name.gsub(/\s/, '_').gsub(/[^_a-zA-Z0-9]/, "-") if attribute_present?('name')
  end
end
