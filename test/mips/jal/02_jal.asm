# Expect: 0x0000004

.text
.globl main
main: 
    jal     L1
    jr      $zero

L1: 
    addi	$v0, $ra, 0x0
    jr      $ra
    
.data
var1: .word 0x00002351