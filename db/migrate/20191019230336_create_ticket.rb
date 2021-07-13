class CreateTicket < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
    	t.integer  :raffle_id
      t.integer  :user_id
      t.integer  :ticket_status_id, default: 1 # open, on_hold_session, waiting_payment, finished
      t.integer  :number, unique: true
    	t.datetime :purchase_date
      t.timestamps
    end
  end
end
