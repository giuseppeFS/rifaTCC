# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'net/http'
require 'net/https' # for ruby 1.8.7
require 'json'
require 'csv'

#CSV.foreach(File.join(Rails.root, 'app', 'assets', 'cep.csv'), {headers: true, :col_sep => ";"}) do |row|
#  begin
#    ZipcodeRange.create(row.to_hash)
#  rescue 
#  end
#end

#module BRPopulate
#  def self.states
#    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
#    JSON.parse http.get('/celsodantas/br_populate/master/states.json').body
#  end
#
#  def self.capital?(city, state)
#    city["name"] == state["capital"]
#  end
#
#  def self.populate
#    states.each do |state|
#      region_obj = Region.find_or_create_by(:name => state["region"])
#      state_obj = State.new(:acronym => state["acronym"], :name => state["name"], :region => region_obj)
#      state_obj.save
#
#      state["cities"].each do |city|
#        c = City.new
#        c.name = city["name"]
#        c.state = state_obj
#        c.capital = capital?(city, state)
#        c.save
#        puts "Adicionando a cidade #{c.name} ao estado #{c.state.name}"
#      end
#    end
#  end
#end

# BRPopulate.populate

puts 'Iniciando'


#
# Importa base de usuarios
#
CSV.foreach(File.join(Rails.root, 'app', 'assets', 'user.csv'), {headers: true, :col_sep => ";"}) do |row|
  begin
    puts row.to_hash
    u = User.create(row.to_hash)
    puts u.errors.full_messages 
  rescue StandardError => e
   puts "Rescued: #{e.inspect}"
  end
end

#
# Importa base de instituições
#
CSV.foreach(File.join(Rails.root, 'app', 'assets', 'intitution.csv'), {headers: true, :col_sep => ";"}) do |row|
  begin
    puts row.to_hash
    i = Institution.create(row.to_hash)
    puts i.errors.full_messages 
  rescue StandardError => e
   puts "Rescued: #{e.inspect}"
  end
end

#
# Importa base de categorias
#
CSV.foreach(File.join(Rails.root, 'app', 'assets', 'categories.csv'), {headers: true, :col_sep => ";"}) do |row|
  begin
    puts row.to_hash
    c = Category.create(row.to_hash)
    puts c.errors.full_messages 
  rescue StandardError => e
   puts "Rescued: #{e.inspect}"
  end
end

#
# Cria base de status da rifa
#
RaffleStatus.create(:description => 'Aberto');
RaffleStatus.create(:description => 'Sorteado');
RaffleStatus.create(:description => 'Aguardando entrega');
RaffleStatus.create(:description => 'Aguardando saque');
RaffleStatus.create(:description => 'Cancelado');

#
# Cria base de status do ticket
#
TicketStatus.create(:description => 'open');
TicketStatus.create(:description => 'on_hold_session');
TicketStatus.create(:description => 'waiting_payment');
TicketStatus.create(:description => 'finished');

#
# Cria base de condições de premio
#
Condition.create(:name => "Novo");
Condition.create(:name => "Semi-novo");
Condition.create(:name => "Usado");
Condition.create(:name => "Restaurado");

#
# Cria base de entrega de premio
#
DeliveryType.create(:name => "Correios");
DeliveryType.create(:name => "Receber na instituição");
DeliveryType.create(:name => "Email/Telefone");
DeliveryType.create(:name => "Outros/Entrar em contato");

#
# Importa base de rifas
#
CSV.foreach(File.join(Rails.root, 'app', 'assets', 'raffle.csv'), {headers: true, :col_sep => ";"}) do |row|
  begin
    puts row.to_hash
    r = Raffle.create(row.to_hash)
    puts r.errors.full_messages 
  rescue StandardError => e
   puts "Rescued: #{e.inspect}"
  end
end

#
# Cria tickets para as rifas importadas
#
begin
raffles = Raffle.all

raffles.each do |r|
  t = []

  r.tickets_number.times do |i|
    t2 = Ticket.create(raffle_id: r.id, number: i+1)
    puts t2.errors.full_messages 
    t << t2
  end

end
rescue StandardError => e
  puts "Rescued Ticket: #{e.inspect}"
end

Admin.create(:email => 'institucional@rifaamiga.com', :password => '123456')