@R2
MD=0
(LOOP)
	@R0
	D=M
	@END
	D;JLE
	@R1
	D=M
	@R2
	M=M+D
	@R0
	M=M-1
	@LOOP
	0;JMP
(END)
	@END
	0;JMP