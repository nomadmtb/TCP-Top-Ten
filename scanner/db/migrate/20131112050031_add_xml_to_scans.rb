class AddXmlToScans < ActiveRecord::Migration
  def change
    add_column :scans, :xml, :text
  end
end
