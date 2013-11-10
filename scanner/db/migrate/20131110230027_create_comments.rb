class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :scan, index: true
      t.references :user, index: true
      t.datetime :comment_date
      t.text :comment

      t.timestamps
    end
  end
end
