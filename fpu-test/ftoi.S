.text
.global _start
_start:
    movh %d10, 0x05f6
    mov.u %d15, 0xe605
    add %d10, %d10, %d15
    ftoi %d9, %d10
##
    movh %d1, 1
    mov.u %d15, 0x2200
    add %d1, %d1, %d15
    ftoi %d10, %d1
##
    mov %d12, -1
    ftoi %d4,%d12
exit:
	debug
	j exit
