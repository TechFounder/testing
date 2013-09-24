class AddCompanyIdToVehicles < ActiveRecord::Migration
  def change
  	add_column :vehicles, :company_id, :integer
    add_index :vehicles, :company_id
  end
end
