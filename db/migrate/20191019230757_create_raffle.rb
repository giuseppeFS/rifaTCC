class CreateRaffle < ActiveRecord::Migration[5.1]
  def change
    create_table   :raffles do |t|
    	  t.integer  :institution_id
        t.integer  :user_id
    	  t.integer  :category_id
        t.integer  :condition_id
        t.integer  :delivery_type_id
        t.string   :title
    	  t.text     :description
        t.string   :prize
        t.text     :prize_description
    	  t.float    :unit_value
        t.integer  :tickets_number
        t.integer  :tickets_sold
    	  t.datetime :draw_date
    	  t.integer  :status # 1 = Ativo, 2 = Aguardando Sorteio, 3 = Encerrado, 4 = Aguardando entrega, 5 = Cancelada
        t.timestamps
    end
  end
end
