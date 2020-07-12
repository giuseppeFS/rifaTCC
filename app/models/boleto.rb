class String
	def mod10
		len = self.length-1
		sum = 0
		mult = 2
		
		len.downto(0) {|i| 
			sum += (mult * self[i,1].to_i).digit_sum
			mult = mult == 2 ? 1 : 2
		}
		mod = 10 - (sum % 10)
		mod == 10 ? 0 : mod
	end
	
	def mod11
		len = self.length-1
		sum = 0
		mult = 2
		
		len.downto(0) {|i| 
			sum += (mult * self[i,1].to_i)
			mult = mult == 9 ? 2 : mult + 1
		}
		
		mod = (11 - (sum % 11)).digit_sum < 2 ? 1 : 11 - (sum % 11)
		mod = [0,1,10,11].include?(mod) ? 1 : mod
	end
	
	def digit_sum
		len = self.length
		return self.to_i if len == 1
		sum = 0
		
		0.upto(len-1) {|i| sum += self[i,1].to_i }
		sum
	end
end

class Fixnum
	def mod10
		self.to_s.mod10
	end
	
	def mod11
		self.to_s.mod11
	end
	
	def digit_sum
		self.to_s.digit_sum
	end
end

class Boleto
	attr_accessor :formato_linha_digitavel
	attr_accessor :formato_codigo_barras
	attr_accessor :hoje
	
	attr_accessor :banco
	attr_accessor :banco_dv
	attr_accessor :moeda
	attr_accessor :carteira
	attr_accessor :data_vencimento
	attr_accessor :valor
	attr_accessor :valor_convertido
	attr_accessor :nosso_numero
	attr_accessor :nosso_numero_dv
	attr_accessor :agencia
	attr_accessor :conta_corrente
	attr_accessor :conta_corrente_dv
	attr_accessor :fator_vencimento
	
	attr_accessor :linha_digitavel
	attr_accessor :codigo_barras_numerico
	attr_accessor :codigo_barras
	attr_accessor :pixel_branco
	attr_accessor :pixel_preto
	
	attr_accessor :cedente
	attr_accessor :documento_cedente
	attr_accessor :numero_documento
	attr_accessor :especie
	attr_accessor :data_documento
	attr_accessor :sacado
	attr_accessor :instrucao1
	attr_accessor :instrucao2
	attr_accessor :instrucao3
	attr_accessor :instrucao4
	attr_accessor :instrucao5
	attr_accessor :instrucao6
	attr_accessor :local_pagamento
	attr_accessor :documento_sacado
	attr_accessor :aceite
	attr_accessor :especie_documento
	attr_accessor :valor_formatado
	attr_accessor :sacado_linha1
	attr_accessor :sacado_linha2
	attr_accessor :sacado_linha3
	
	protected
		def gerar_fator_vencimento
			return '0000' unless self.data_vencimento.kind_of? Date or self.data_vencimento.kind_of? Time
			base = Date.parse "1997-10-07"
			self.fator_vencimento = self.data_vencimento - base
		end
		
		def criar
			self.valor_convertido = sprintf("%.2f", self.valor).to_s.gsub(/\./, "")
			self.valor_formatado = sprintf("%.2f", self.valor).to_s.gsub(/\./, ",")
		end
		
		def gerar_codigo_barras
			bin = ["00110", "10001", "01001", "11000", "00101", "10100", "01100", "00011", "10010", "01010"]
			
			intercalado = ''
			
			0.upto(self.codigo_barras_numerico.length-1) {|i|
				next if i % 2 != 0
				d1 = self.codigo_barras_numerico[i, 1]
				d2 = self.codigo_barras_numerico[i + 1, 1]
				
				for j in (0..5)
					intercalado << bin[d1.to_i][j,1] + bin[d2.to_i][j,1]
				end
			}
			
			self.codigo_barras = ''
			
			0.upto(intercalado.length-1) {|i|
				imagem = i % 2 == 0 ? self.pixel_preto : self.pixel_branco
				largura = intercalado[i,1].to_i == 1 ? 3 : 1
				self.codigo_barras << "<img src=\"#{imagem}\" height=\"50\" width=\"#{largura}\" align=\"baseline\" />"
			}
			
			self.codigo_barras
		end
end

class Itau < Boleto
	def initialize
		self.formato_linha_digitavel = "abcd"
		self.formato_codigo_barras = "efgh"
		self.carteira = 175
		self.banco = 341
		self.banco_dv = self.banco.mod11
		self.especie_documento = 'DM'
		self.moeda = 9
		self.hoje = Date.today
		self.data_documento = self.hoje
		self.aceite = "N"
	end
	
	def processar
		#agencia, conta_corrente, carteira, nosso_numero
		dvaccn = "#{self.agencia}#{self.conta_corrente}#{self.carteira}#{self.nosso_numero}".mod10
		#agencia, conta_corrente, conta_corrente_dv
		dvac = "#{self.agencia}#{self.conta_corrente}#{self.conta_corrente_dv}".mod10
		#agencia, conta_corrente, conta_corrente_dv, carteira, nosso_numero
		dvacdcn = "#{self.agencia}#{self.conta_corrente}#{self.conta_corrente_dv}#{self.carteira}#{self.nosso_numero}".mod10
		
		#valor; adicionar zeros (10 - valor.length)
		vd = ''
		(10 - self.valor_convertido.length).times {|n| vd << '0' }
		vd << self.valor_convertido
		
		#codigo de barras numerico
		c1 = "#{self.banco}#{self.moeda}"
		c2 = "#{self.fator_vencimento}#{vd}#{self.carteira}#{self.nosso_numero}#{dvacdcn}#{self.agencia}#{self.conta_corrente}#{dvac}000"
		
		dvcb = "#{c1}#{c2}".mod11
		self.codigo_barras_numerico = "#{c1}#{dvcb}#{c2}"
		
		#linha digitavel
		d1 = "#{self.banco}#{self.moeda}#{self.carteira}#{self.nosso_numero[0,2]}"
		d1 << d1.mod10.to_s
		
		d2 = "#{self.nosso_numero[2,self.nosso_numero.length]}#{dvaccn}#{self.agencia[0,3]}"
		d2 << d2.mod10.to_s
		
		d3 = "#{self.agencia[-1,1]}#{self.conta_corrente}#{self.conta_corrente_dv}000"
		d3 << d3.mod10.to_s
		
		d4 = dvcb
		d5 = "#{self.fator_vencimento}#{vd}"
		
		self.linha_digitavel = "#{d1}#{d2}#{d3}#{d4}#{d5}"
		self.gerar_codigo_barras
		nil
	end
	
	def criar
		super
		
		self.conta_corrente_dv = (self.agencia + self.conta_corrente).mod10.to_s
		self.nosso_numero_dv = "#{self.agencia}#{self.conta_corrente}#{self.carteira}#{self.nosso_numero}".mod10
		self.gerar_fator_vencimento
		self.processar
	end
end