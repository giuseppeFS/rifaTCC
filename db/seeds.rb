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

user_list = [
  [
   '09240456988',
   'Giuseppe Ferrarini',
   'giuseppe@gmail.com',
   '123456',
   'Rodovia Antonio Alceu Zielonka',
   '1812',
   'Esquina',
   'Planta Deodoro',
   '83304305',
   '41',
   '36733548',
   '41',
   '992220072'
   ],
   [
    '99999999999',
    'Miguelito Irregular',
    'miguelito@gmail.com',
    '123456',
    'Rua Mario Pecanha',
    '1012',
    '',
    'Centro',
    '80530000',
    '41',
    '33333333',
    '41',
    '999223344'
    ],
    [
      '99999999998',
      'Joao Peçanha',
      'peçanha@gmail.com',
      '123456',
      'Rua Antonio Carmo',
      '872',
      '',
      'Novo mundo',
      '86589712',
      '41',
      '3567890',
      '41',
      '999999999'
      ],
      [
        '99999999997',
        'Roberta Alves',
        'robertaA@gmail.com',
        '123456',
        'Alameda Paris',
        '12',
        '',
        'Boqueirao',
        '87463648',
        '41',
        '3567890',
        '41',
        '999999999'
        ],
        [
          '99999999996',
          'Roberta Alves',
          'robertaA@gmail.com',
          '123456',
          'Alameda Paris',
          '12',
          '',
          'Boqueirao',
          '87463648',
          '41',
          '3567890',
          '41',
          '999999999'
        ]
      ]

      user_list.each do | 
        cpf,
        name,
        email,
        password,
        address,
        number,
        complement,
        neighborhood,
        zipCode,
        ddd_phone,
        phone_number,
        ddd_cellphone,
        cellphone_number |

        User.create ({
          :cpf => cpf,
          :name => name,
          :email => email,
          :password => password,
          :address => address,
          :number => number,
          :complement => complement,
          :neighborhood => neighborhood,
          :zipCode => zipCode,
          :ddd_phone => ddd_phone,
          :phone_number => phone_number,
          :ddd_cellphone => ddd_cellphone,
          :cellphone_number => cellphone_number
          })

      end

      institutions_list = [
        [
          '53129587000108',
          'hc@hospital.com.br',
          '123456',
          'Hospital de Clinicas LTDA',
          'Hospital de Clinicas',
          'Rua XV de novembro',
          'Proximo ao terminal',
          'Centro',
          '805600',
          '41',
          '33349857',
          '41',
          '987564367',
          237,
          4563,
          234565,
          '405 - Sem fins lucrativos',
          10,
          true
          ],
          [
            '17593461000118',
            'casadeauxilio@insitucional.com.br',
            '123456',
            'Casa de Auxilio LLC',
            'Casa de Auxilio',
            'Avenida Candido de Abreu',
            'Proximo ao Muller',
            'Centro Civico',
            '8053000',
            '41',
            '32435678',
            '41',
            '9845906745',
            403,
            7836,
            78497,
            '405 - Sem fins lucrativos',
            10,
            false
            ],
            [
              '17593461000118',
              'institutoore@insitucional.com.br',
              '123456',
              'Instituto ORE LLC',
              'Instituto ORE',
              'Rua Goberto Mariano',
              '',
              'Hugo Lange',
              '8053000',
              '41',
              '32435678',
              '41',
              '9845906745',
              403,
              7836,
              78497,
              '405 - Sem fins lucrativos',
              10,
              false
              ],
              [
                '17593461000118',
                'AABC@insitucional.com.br',
                '123456',
                'AABC ONG',
                'AABC',
                'Rua Floriano Peixoto',
                '',
                'Merces',
                '8053000',
                '41',
                '32435678',
                '41',
                '9845906745',
                403,
                7836,
                78497,
                '405 - Sem fins lucrativos',
                10,
                false
                ],
              ]

              institutions_list.each do |
                cnpj,
                email,
                password,
                corporate_name,
                social_reason,
                address,
                number,
                complement,
                neighborhood,
                zipCode,
                ddd_phone,
                phone_number,
                ddd_phone2,
                phone_number2,
                bank_number,
                agency_number,
                account_number,
                qualification,
                rating,
                status
                |

                institution = Institution.create({
                  :cnpj => cnpj,
                  :email => email,
                  :password => password,
                  :corporate_name => corporate_name,
                  :social_reason => social_reason,
                  :address => address,
                  :number => number,
                  :complement => complement,
                  :neighborhood => neighborhood,
                  :zipCode => zipCode,
                  :ddd_phone => ddd_phone,
                  :phone_number => phone_number,
                  :ddd_phone2 => ddd_phone2,
                  :phone_number2 => phone_number2,
                  :bank_number => bank_number,
                  :agency_number => agency_number,
                  :account_number => account_number,
                  :qualification => qualification,
                  :rating => rating,
                  :status => status
                  })

              end

              Admin.create(:email => 'rifaamiga@institucional.com', :password => '123456')