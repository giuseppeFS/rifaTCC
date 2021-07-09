class CreateRaffleStatus < ActiveRecord::Migration[6.1]
  def change
    create_table :raffle_statuses do |t|
      # 1 = Ativo, 2 = Aguardando Sorteio, 3 = Encerrado, 4 = Aguardando entrega, 5 = Cancelada
      t.string :description
      t.timestamps
    end
  end
end
