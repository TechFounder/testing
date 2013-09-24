class AddCompanyIdToCompanyUsers < ActiveRecord::Migration
  def change
    add_column :company_users, :company_id, :integer
    add_index :company_users, :company_id
  end
end
