class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :body

      t.timestamps
    end
  end
end
