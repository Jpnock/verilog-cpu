# Expect: 0x09175FAC

.text
.globl main
main:
    lw		$v0,  0x9175FAC1
    lw		$t0,  0x00000100
    srlv    $v0, $v0, $t0
    jr      $zero	
