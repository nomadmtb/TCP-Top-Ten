class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.references :user, index: true
      t.datetime :scan_date
      t.string :ip_address
      t.string :status
      t.string :elapsed
      t.string :domain_name_ptr

      t.timestamps
    end
  end
end
