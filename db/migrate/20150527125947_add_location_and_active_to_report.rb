class AddLocationAndActiveToReport < ActiveRecord::Migration
  def change
    add_column :reports, :location, :string
    add_column :reports, :active, :boolean
  end
end
