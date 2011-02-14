(RESET)
	//@512	//TEST
	@8192
	D=A
	@curadd
	M=D
	
	@PROG
	0;JMP

(BLACK)
	@curadd
	M=M-1
	D=M
	@RESET
	D;JLT
	@SCREEN
	A=A+D
	M=-1
	@BLACK
0;JMP

(WHITE)
	@curadd
	M=M-1
	D=M
	@RESET
	D;JLT
	@SCREEN
	A=A+D
	M=0
	@WHITE
0;JMP

(PROG)
	@KBD
	D=M
	@WHITE
	D;JEQ
	@BLACK
	D;JGT
	@RESET
0;JMP

(END)
	@END
	0;JMP