.data
SYSREAD=0
SYSWRITE=1
STDIN=0
STDOUT=1
SYSEXIT=60
EXIT_SUCCESS=0
BUFLEN=1024
.bss
.comm string_in, 1024
.comm string_out, 1024

.text
.globl _start
_start:
	read:
		movq $SYSREAD, %rax
		movq $STDIN, %rdi
		movq $string_in, %rsi
		movq $BUFLEN, %rdx
		syscall
		
	movq $0, %rdi
	dec %rax
	check:
		movb string_in(,%rdi,1), %bl
		cmp $'0', %bl
		jl no_change
		cmp $'9', %bl
		jle number
		cmp $'A', %bl
		jl no_change
		cmp $'Z', %bl
		jl letter
	letter:
	add $3, %bl
	jmp no_change
	number:
	add $5, %bl
	no_change:
	movb %bl, string_out(,%rdi,1)
	inc %rdi
	cmp %rax, %rdi
	jl check
		
	movb $'\n', string_out(,%rdi,1)
	write:
		movq $SYSWRITE, %rax
		movq $STDOUT, %rdi
		movq $string_out, %rsi
		movq $BUFLEN, %rdx
		syscall
	exit:
		movq $SYSEXIT, %rax
		movq $EXIT_SUCCESS, %rsi
		syscall 
