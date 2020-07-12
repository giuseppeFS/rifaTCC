class CreateAccountEntry < ActiveRecord::Migration[5.1]
  def change
    create_table :account_entries do |t|
    	t.integer :wallet_id
    	t.float :value
    	t.string :type
    	t.boolean :approved
    	t.timestamps
    end
  end
end
