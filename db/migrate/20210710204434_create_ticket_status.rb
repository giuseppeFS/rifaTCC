class CreateTicketStatus < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_statuses do |t|
      # open, on_hold_session, waiting_payment, finished
      t.string :description
      t.timestamps
    end
  end
end
