

        .data
  

szerokosc: 	.space 4
wysokosc: 	.space 4
size: 		.space 4
szer_pixel: 	.space 4
wys_pixel:	.space 4
header: 	.space 1000056 #obrazek 

nazwa:   	.asciiz "/home/users/pmlyniec/Documents/paprotka.bmp"     
pytanie_szer: 	.asciiz "Podaj szerokosc bitmapy:\n"
pytanie_wys: 	.asciiz "Podaj wysokosc bitmapy\n"
pytanie_iteracje:	.asciiz "Podaj ilosc iteracji.\n"
nr1: .asciiz "nr1"
nr2: .asciiz "nr2"
nr3: .asciiz "nr3"
nr4: .asciiz "nr4"

        .text
  
  # szerokosc bitmapy
  	 la $a0, pytanie_szer
 	 li $v0, 4
 	 syscall
 	 li $v0, 5
 	 syscall
 	 move $t1, $v0 
 	 sw $t1, szerokosc
 	 sll $t0, $t1, 16 
 	 divu $t0, $t0, 6
 	 sw $t0, szer_pixel
  
   # wysokosc bitmapy
 	 la $a0, pytanie_wys
 	 li $v0, 4
 	 syscall
 	 li $v0, 5
 	 syscall
 	 move $t2, $v0
 	 sw $t2, wysokosc
 	 sll $t0, $t2, 16
 	 divu $t0, $t0, 10
 	 sw $t0, wys_pixel
  
	 lw $t0, szerokosc
 	 lw $t1, wysokosc
 	 mulu $t2, $t0, $t1
 	 mulu $t2, $t2, 4
 	 sw $t2, size

	li $t0, 'B'
	sb $t0, header+2
	li $t0, 'M'
	sb $t0, header+3
	lw $t0, size	
	addi $t0, $t0, 54	#bfSize		
	sw $t0, header+4	
	sw $zero, header+8	#bfReserved
	li $t0, 54
	sw $t0, header+12	#bfOffBits
	li $t0, 40
	sw $t0, header+16	#biSize
	lw $t2, szerokosc
	sw $t2, header+20	#biWidth
	lw $t1, wysokosc
	sw $t1, header+24	#biHeight
	li $t0, 1
	sh $t0, header+28	#biPlanes
	li $t0, 32
	sh $t0, header+30	#biBitCount
	sw $zero, header+32	#biCompression
	sw $zero, header+36	#biSizeImage
	sw $zero, header+40	#biXPelsPerMeter
	sw $zero, header+44	#biYPelsPerMeter
	sw $zero, header+48	#biClrUsed
	sw $zero, header+52	#biClrImportant
	 
  	lw $t3, size
  	addi $t3, $t3, 56
  	li $t0, 52
  tlo:	
 	addi $t0, $t0, 4
  	la $t2, header($t0)
 	li $t1, 0xff
  	sb $t1, ($t2)
 	sb $t1, 1($t2)
  	sb $t1, 2($t2)
 	li $t1, 0x00
 	sb $t1, 3($t2)
  	blt $t0, $t3, tlo
 

inicjalizacja:

  	add $t4, $zero, 65536
 	add $t5, $zero, 1
 	 
  	la $a0, pytanie_iteracje
 	li $v0, 4
  	syscall
  
  	li $v0, 5
  	syscall
  	add $s2, $v0, $zero #zapamietuje ilosc iteracji w rejestrze s2
  
loop:
  	addi $s7, $s7, 1
  	li $a1, 999 # losujemy w przedziale od 0 do 999
 	li $v0, 42
 	bge $s7, $s2, end
  	syscall
  	add $t3, $zero, $a0 
  	ble $t3, 9, jeden
  	ble $t3, 79, dwa
  	ble $t3, 149, trzy
  	j cztery
  
  
 #nowy x i y to bedzie $t4 i $t5

 

jeden:

 	move $t4, $zero  
  	mul $t5, $t5, 10485 #0x28f5
  	mflo $t1
  	srl $t1, $t1, 16
  	mfhi $t9
  	sll $t9,$t9,16
  	or $t5, $t1, $t9
  
    	la $a0, nr1
 	li $v0, 4
 	syscall
  
  	j print
  

dwa:
	add $t6, $t4, $zero #zapamiętuje xn
	add $t0, $t5, $zero #zapamietuje yn
	mul $t4, $t4,  13107#0x3333
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t4, $t1, $t9
		   
	mul $t5, $t5, 17039#0x428f
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t5, $t1, $t9
		   
	sub $t4, $t4, $t5 #mamy x
	mul $t6, $t6, 15073 #0x3ae1
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t6, $t1, $t9
	  
	mul $t0, $t0, 14417 #0x1c29
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t0, $t1, $t9
	  
	add $t5, $t0, $t6
	add $t5, $t5, 104857 #0x19999
	la $a0, nr2
	li $v0, 4
 	syscall

	j print
  

trzy:
	add $t6, $t4, $zero #zapamiętuje xn
	add $t0, $t5, $zero #zapamietuje yn
	mul $t4, $t4,  9830#0x2666#0x0999
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t4, $t1, $t9
	  
	mul $t5, $t5, 18350#0x47ae #0x23d7
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t5, $t1, $t9
	  
	sub $t4, $t5, $t4
	mul $t6, $t6, 17039#0x428f #0x2147
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t6, $t1, $t9
	  
	mul $t0, $t0, 15728#0x3d70 #0x1eb8
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t0, $t1, $t9
	  
	add $t5, $t0, $t6
	add $t5, $t5, 28835#0x70a3 #0x3851
	la $a0, nr3
	li $v0, 4
	syscall
	j print
	# add $t5, $t4, $zero

cztery:
	add $t6, $t4, $zero #zapamiętuje xn
	add $t0, $t5, $zero #zapamietuje yn
	mul $t4, $t4,  55705#0xd999
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t4, $t1, $t9
	  
	mul $t5, $t5, 2621#0xa3d #0x051e
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t5, $t1, $t9
	  
	add $t4, $t5, $t4
	  
	mul $t6, $t6, 2621#0xa3d #0x051e
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t6, $t1, $t9
	  
	mul $t0, $t0, 55705#0xd999
	mflo $t1
	srl $t1, $t1, 16
	mfhi $t9
	sll $t9,$t9,16
	or $t0, $t1, $t9
	  
	sub $t5, $t0, $t6
	add $t5, $t5, 104857#0x19999
	la $a0, nr4
	li $v0, 4
	syscall
	j print
  

# x t4
# y t5
print:

	addi $t6, $t4, 0x30000 #w t6 x+3
	lw $t1, szer_pixel
	mult  $t6, $t1 #w t6 (x+3)*ilośc bitów na szer
	mfhi $t6
	 			 #w t6 bity w szerokosci
	lw $t2, wys_pixel
	mult  $t5, $t2 #w t0 ile bitów w góre
	mfhi $t0
	 			 #w t0 bity w wysokosci
	lw $t9, szerokosc
	mul $t0, $t9, $t0 #w t0 bity do nowego wiersza
	add $t6, $t0, $t6
	add $s5, $zero, $t6
	 
	mulu $t6, $t6, 4 # kazdy piksel jest reprezentowany jako 4 bajty
	addi $t6, $t6, 56
	la $t8, header($t6)
	li $a2, 0x00
	sb $a2, 0($t8)
	li $a2, 0x00
	sb $a2, 1($t8)
	li $a2, 0x00
	sb $a2, 2($t8)
	li $a2, 0x00
	sb $a2, 3($t8)
	add $t6, $zero, $zero

	j loop
end:
 
	li   $v0, 13       #  otworz plik
 	la   $a0, nazwa   
 	li   $a1, 9        #  pisanie
 	li   $a2, 0       
	syscall            
 	move $s6, $v0      # zachowaj descryptor strony 
  
 	
  	li   $v0, 15       # zapisz do pliku
 	move $a0, $s6      # descryptor strony 
  	la   $a1, header+2 
  	lw $a2, size
	addi $a2, $a2, 54
  	
  	syscall           
  
  	# zamykanie pliku 
 	li   $v0, 16       
 	move $a0, $s6      
 	syscall        
  
 	
