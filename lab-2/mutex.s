	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:
        @ INSERT CODE BELOW
	ldr r4, =locked		@ Load locked value into temp reg ,ldr r4,=locked
.test:	ldrex r5, [r0]		@ LDREX from [r0] an cmp to unlocked value
 		cmp r5, #0	@ if [r0] contents have the unlocked value
		strexeq r5,r4, [r0]	@ STREX value in temp variable into [r0]
		cmpeq r5, #0		@ if not successful goto loop
		bne .test
        @ END CODE INSERT
	bx lr

	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:
		@ INSERT CODE BELOW
	ldr r4, =unlocked        @ Load =unlocked value into a temp register
	str r4, [r0]	@ Store value from temp reg into [r0]
        @ END CODE INSERT
	bx lr
	.size unlock_mutex, .-unlock_mutex

	.end
