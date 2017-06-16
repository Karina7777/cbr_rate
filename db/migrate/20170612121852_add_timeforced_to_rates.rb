class AddTimeforcedToRates < ActiveRecord::Migration[5.0]
  def change
    add_column :rates, :forced_till, :datetime
  end
end
