#################################################################
#Script para graficar a distância entre o CM de dois grupos     #
#################################################################

########################################################
#Mede distancias cruzadas e escreve no arquivo de saida#

#Abre arquivo de saida
set dist [open dist_dinamica.dat w]

#Define as selecoes
set sel1 [atomselect top "name CA"]
set sel2 [atomselect top "name P"]

#Inicializa loop na trajetoria
animate goto start
set nframes [molinfo top get numframes]
set frame 0 


#Varre cada frame
for {set i 0} {$i < $nframes} {incr i } {
  #vai para frame i
  animate goto $i 

  #Calcula as distancias
  set d [expr abs([lindex [measure center $sel1] 2] - [lindex [measure center $sel2] 2])]

  #Escreve as infromacoes nos arquivos de saida
  puts $dist "$i $d"
}

#fecha arquivo
close $dist
