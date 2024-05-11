#################################################################
#Script to graph the distance between the CM of two groups     #
#################################################################

########################################################
#Measures crossed distances and writes to the output file#

#Open output file
set dist [open dist_dinamica.dat w]

#Set the selections
set sel1 [atomselect top "name CA"]
set sel2 [atomselect top "name P"]

#Initialize loop on the trajectory
animate goto start
set nframes [molinfo top get numframes]
set frame 0 


#Scan each frame
for {set i 0} {$i < $nframes} {incr i } {
  #vai para frame i
  animate goto $i 

  #Calculate distances
  set d [expr abs([lindex [measure center $sel1] 2] - [lindex [measure center $sel2] 2])]

  #Write information to output files
  puts $dist "$i $d"
}

#close file
close $dist
