class CreateRawScans < ActiveRecord::Migration
  def change
    create_table :raw_scans do |t|
      t.references :scan, index: true
      t.text :raw_xml

      t.timestamps
    end
  end
end
