class Location < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  acts_as_nested_set

  def self.global
    find_by_name! "latin_america"
  end

  def self.countries
    global.children
  end
end
