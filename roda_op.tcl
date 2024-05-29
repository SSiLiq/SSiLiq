source orderparam2_update.tcl
# Store order parameter data in array named arr 
orderparam-c3 arrc3 {same residue as within 10 of protein}
orderparam-c2 arrc2 {same residue as within 10 of protein}
# Store order parameter data for just the top monolayer 
#orderparam-c3 arr {same residue as "name P.*" and z > 0} 
# Write out data to a file 

set fd1 [open opc2.dat w+] 
foreach key [lsort -integer [array names arrc2]] { 
  puts $fd1 "[list $key $arrc2($key)]" 
} 
close $fd1 

set fd2 [open opc3.dat w+] 
foreach key [lsort -integer [array names arrc3]] { 
  puts $fd2 "[list $key $arrc3($key)]" 
} 
close $fd2 


