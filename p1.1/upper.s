.data
SYSREAD=3
SYSWRITE=4
STDIN=0
STDOUT=1
SYSEXIT=1
EXIT_SUCCESS=0
BUFLEN=256

.bss
    .lcomm textin,256
    .lcomm textout,256

.text
.globl _start
_start:
    mov $SYSREAD, %eax
    mov $STDIN, %ebx
    mov $textin, %ecx
    mov $BUFLEN, %edx
    int $0x80

    
    mov $0, %edi
    dec %eax
    
    
    upper:
        movb textin(,%edi,1), %bl
        cmp $'a', %bl
        jl write
        cmp $'z',%bl
        jg write

        movb $32,%bh
        xor %bh,%bl

    write:
        movb %bl, textout(,%edi,1)
        inc %edi
        cmp %eax,%edi
        jl upper

    movb $'\n',textout(,%edi,1)
    
    mov $SYSWRITE, %eax
    mov $STDOUT, %ebx
    mov $textout, %ecx
    mov $BUFLEN, %edx
    int $0x80

    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $0x80
