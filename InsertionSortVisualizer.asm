;6502 ASM sorting algorithm (insertion sort) By: JackTheGripper. Sorts least to greatest. Only works in 6502js simulator by Skilldrick https://github.com/skilldrick/6502js. (monitor $0000 to $00ff to see array in memory.)

ArrayGenerate: ;fills memory with an array of random 8 bit values.

ldx $fe
cpx #$0f
bcs ArrayGenerate
stx $00,Y
iny
cpy #$40 ;change this value to change array size
bne ArrayGenerate
jmp sortsetup

sortsetup: ;makes sure both X and Y registers are set to 0 and jumps to sort subroutine.
ldx #$00
ldy #$00
jmp sort

sort: ;compares current byte with one to left of it.
cpx #$3f ;Set this to one less than array size.
beq done
lda $01,X
cmp $00,X
beq noswap
bcs noswap
jmp swapcheck

noswap: ;if no swap is to be made in incremments x, then jumps to the sort subroutine
inx
jmp sort

swapcheck: ;compares the values of the current byte with the one next to it
stx $0102
ldx $00
cpx $0103
ldx $0102
beq more
inx
stx $0101
dex
jmp more

more: ;swaps the two bits if its more and then compares it to the one next to it after swapping to see if it should be pushed further down the line
sta $0100
lda $00,X
sta $01,X
lda $0100
sta $00,X
lda $00,X
dex
cmp $00,X
bcs jmpback ;if the byte is where it belongs in the array then it calls the jumpback subroutine
jmp more

jmpback: ;the jumpback subroutine jumps back to where it was before pushing the value to the correct position
sty $40
stx $41
sta $42
ldx #0
sortdraw:
lda $00,X
sta $200,X
inx
cpx #$40
bne sortdraw
ldx $40
ldy $41
lda $42
inx
ldx $0101
jmp sort

done:
