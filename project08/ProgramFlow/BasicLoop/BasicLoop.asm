@0
D=A
@0
A=M
M=D
@0
M=M+1
@0
D=A
@R1
D=D+M
@POP.LOCAL.1
M=D
@R0
A=M-1
D=M
@POP.LOCAL.1
A=M
M=D
@R0
M=M-1
// Label
@0
D=A
@R2
A=M+D
D=M
@R0
A=M
M=D
@R0
M=M+1
@0
D=A
@R1
A=M+D
D=M
@R0
A=M
M=D
@R0
M=M+1
@0
A=M
A=A-1
D=M
A=A-1
D=D+M
@0
M=M-1
M=M-1
A=M
M=D
@0
M=M+1
@0
D=A
@R1
D=D+M
@POP.LOCAL.6
M=D
@R0
A=M-1
D=M
@POP.LOCAL.6
A=M
M=D
@R0
M=M-1
@0
D=A
@R2
A=M+D
D=M
@R0
A=M
M=D
@R0
M=M+1
@1
D=A
@0
A=M
M=D
@0
M=M+1
@0
A=M
A=A-1
D=M
A=A-1
D=M-D
@0
M=M-1
M=M-1
A=M
M=D
@0
M=M+1
@0
D=A
@R2
D=D+M
@POP.ARGUMENT.10
M=D
@R0
A=M-1
D=M
@POP.ARGUMENT.10
A=M
M=D
@R0
M=M-1
@0
D=A
@R2
A=M+D
D=M
@R0
A=M
M=D
@R0
M=M+1
// if-goto
@0
D=A
@R1
A=M+D
D=M
@R0
A=M
M=D
@R0
M=M+1
