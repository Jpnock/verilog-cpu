# Expect: 0x1

.text
.globl main
main:
    lw		$v0,  0xD47A11F1
    lw		$t0,  0x00011111
    srlv    $v0, $v0, $t0
    jr      $zero	
    