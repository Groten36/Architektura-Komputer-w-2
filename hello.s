.data
	SYSREAD = 0
	SYSWRITE = 1
	STDIN = 0
	STDOUT = 1
	SYSEXIT = 60
	EXIT_SUCCESS = 0

	string: .ascii "Hello world!\n"
	string_len= .-string

.text
.globl _start
_start:

	movq $SYSWRITE, %rax
	movq $STDOUT, %rdi
	movq $string, %rsi
	movq $string_len, %rdx
	syscall

movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall


