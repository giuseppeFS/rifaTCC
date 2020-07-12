class CreateRaffle < ActiveRecord::Migration[5.1]
  def change
    create_table   :raffles do |t|
    	t.integer  :institution_id
        t.integer  :user_id
    	t.integer  :category_id
        t.string   :delivery
        t.string   :condition
        t.string   :title
    	t.text     :description
    	t.float    :unit_value
        t.float    :goal_value
    	t.datetime :draw_date
    	t.string   :prize
        t.string   :prize_description
    	t.integer  :status # 1 = Ativo, 2 = Aguardando Sorteio, 3 = Encerrado, 4 = Aguardando entrega, 5 = Cancelada

        t.timestamps
    end
  end
end
