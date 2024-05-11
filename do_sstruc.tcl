#### VMD Script to Secondary Strucutre Calculations
#### Written by Alexandre Suman de Araujo in 2009

#Define as variaveis a serem usadas
set ssres "ss_by_residue.agr"

### Calcula a porcentagens de cada tipo de estrutura secundária em cada frame da traj

#Abre o arquivo de saida para a ss por residuo
set saida_ssres [ open $ssres w]

#Cabecalho para o Xmgrace secondary structure por residuo tirado do template
puts $saida_ssres [exec cat ssres_template.agr]


animate goto start

#Seleciona os CA da proteina
set sel [atomselect top "protein and name CA"]

#zera o conteudo das listas alfa, beta e coil_turn
for { set i 0 } { $i < [ $sel num ] } { incr i } {
set aalfa($i) 0
set abeta($i) 0
set acoil_turn($i) 0
}

#Corre todos os frames da trajetoria
for { set i 0 } { $i < [molinfo top get numframes] } { incr i } {
   
   #Atualiza as informacoes para o frame atual
   display update

   #Recalcula a estrutura secundaria
   mol ssrecalc top

   #Define o numero de residuos
   set num_res [ $sel num ]
   
   #Pega a informacao da estrutura secundaria de cada CA
   set lista_sstruc [ $sel get structure ]

   #Zera os numeros de cada tipo de estrutura secundaria
   set helice 0
   set beta 0
   set coil_turn 0

   #Corre a lista e calcula o numero de residuos com cada tipo
   # de estrutura secundaria para o frame em questao
   # e escreve a informacao para cada residuo
   for { set j 0 } { $j < $num_res } { incr j } {
      set ss_temp [ lindex $lista_sstruc $j ]

      #Se for H, G ou I --> Helice
      #Se for E ou B --> Folha beta
      #Se for C ou T --> Coil ou Turn
      if {$ss_temp == "H" || $ss_temp == "G" || $ss_temp == "I"} {
         incr helice
	 incr aalfa($j)
	 puts $saida_ssres "$i [expr $j+1] 10"
      } elseif {$ss_temp == "E" || $ss_temp == "B"} {
         incr beta
	 incr abeta($j)
	 puts $saida_ssres "$i [expr $j+1] 5"
      } elseif {$ss_temp == "C" || $ss_temp == "T"} {
         incr coil_turn
	 incr acoil_turn($j)
	 puts $saida_ssres "$i [expr $j+1] 9"
      }
   }
    
   #Pula para o proximo frame da trajetoria
   animate goto $i
}

#Coloca caracter no final do arquivo .agr
puts $saida_ssres "\&"

#Fecha os arquivos
close $saida_ssres

#Sai do VMD
#exit

