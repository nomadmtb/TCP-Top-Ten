class CreateOpenPorts < ActiveRecord::Migration
  def change
    create_table :open_ports do |t|
      t.references :scan, index: true
      t.integer :port
      t.string :service

      t.timestamps
    end
  end
end
