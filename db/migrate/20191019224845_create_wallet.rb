class CreateWallet < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
    	t.integer  :user_id
    	t.float    :balance
    	t.float    :blocked_balance

    	t.timestamps
    end
  end
end
