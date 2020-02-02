.data
SYSREAD=3
SYSWRITE=4
STDIN=0
STDOUT=1
SYSEXIT=1
EXIT_SUCCESS=0
BUFLEN=512
SHIFT=1

.bss
    .lcomm textin, 512
    .lcomm textout, 512
    

.text
.globl _start
_start:
    mov $SYSREAD, %eax
    mov $STDIN, %ebx
    mov $textin, %ecx
    mov $BUFLEN, %edx
    int $0x80

    dec %eax
    mov $0, %edi
    code:
        movb textin(,%edi,1), %bh
        cmp $'A',%bh
        jl write
        cmp $'Z',%bh
        jg write

        add $SHIFT,%bh

    write:
        movb %bh,textout(,%edi,1)
        inc %edi
        cmp %eax,%edi
        jl code

    movb $'\n',textout(,%edi,1)

    mov $SYSWRITE, %eax
    mov $STDOUT, %ebx
    mov $textout, %ecx
    mov $BUFLEN, %edx
    int $0x80

    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $0x80
