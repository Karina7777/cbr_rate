class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.string :symbol
      t.float :rate

      t.timestamps
    end
  end
end
