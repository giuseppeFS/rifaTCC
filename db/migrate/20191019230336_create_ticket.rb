class CreateTicket < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
    	t.integer  :raffle_id
    	t.integer  :number
    	t.integer  :owner_id
    	t.datetime :purchase_date
    	t.float    :value

        t.timestamps
    end
  end
end
