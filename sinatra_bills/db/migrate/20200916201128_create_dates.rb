class CreateDates < ActiveRecord::Migration
  def change
    create_table :dates do |t|

      t.timestamps null: false
    end
  end
end
