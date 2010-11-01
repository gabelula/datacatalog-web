class CreateLocationTranslation < ActiveRecord::Migration
  def self.up
    Location.create_translation_table! :name => :string
  end

  def self.down
    Location.drop_translation_table!
  end
end
