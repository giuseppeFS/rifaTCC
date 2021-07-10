class CreateTicket < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
    	t.integer  :raffle_id
      t.integer  :user_id
    	t.integer  :number
    	t.datetime :purchase_date
      t.timestamps
    end
  end
end
