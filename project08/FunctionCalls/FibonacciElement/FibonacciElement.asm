// Initialize the file and start at Sys.init
@261
D=A
@SP
M=D
@Sys.init
0;JMP
// Function Main.fibonacci
(Main.fibonacci)
// Initialize all values to zero 
// PUSH-ARG
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
// PUSH-CONST
@2
D=A
@0
A=M
M=D
@0
M=M+1
// LT function
@0
A=M
A=A-1
D=M
A=A-1
D=M-D
@TEST.JLT.3
D;JLT
@0
M=M-1
M=M-1
A=M
M=0
@0
M=M+1
@TEST.JLT.EXIT.3
0;JMP
(TEST.JLT.3)
	@0
	M=M-1
	M=M-1
	A=M
	M=-1
	@0
	M=M+1
	@TEST.JLT.EXIT.3
	0;JMP
(TEST.JLT.EXIT.3)
// if-goto
@R0
M=M-1
A=M
D=M
@IF_TRUE
D;JNE
// goto
@IF_FALSE
0;JMP
// Label
(IF_TRUE)
// PUSH-ARG
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
// Return from function
// Store LCL in temp (R13)
@LCL
D=M
@R13
M=D
// Store the return address in temp (R14)
@R13
D=M
@5
D=D-A
A=D
D=M
@R14
M=D
// Pop return value and place at ARG location
@SP
D=M-1
A=D
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
// Restore THAT of caller
@R13
D=M
@1
D=D-A
A=D
D=M
@THAT
M=D
// Restore THIS of caller
@R13
D=M
@2
D=D-A
A=D
D=M
@THIS
M=D
// Restore ARG of caller
@R13
D=M
@3
D=D-A
A=D
D=M
@ARG
M=D
// Restore LCL of caller
@R13
D=M
@4
D=D-A
A=D
D=M
@LCL
M=D
// Goto return-address
@R14
A=M
0;JMP
// Label
(IF_FALSE)
// PUSH-ARG
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
// PUSH-CONST
@2
D=A
@0
A=M
M=D
@0
M=M+1
// SUB function
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
// Call Function
// push return-address
@return_address_0
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// Reposition ARG
@SP
D=M
@ARG
M=D
@1
D=A
@ARG
M=M-D
@5
D=A
@ARG
M=M-D
// Reposition LCL
@SP
D=M
@LCL
M=D
// Goto Main.fibonacci
@Main.fibonacci
0;JMP
(return_address_0)
// PUSH-ARG
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
// PUSH-CONST
@1
D=A
@0
A=M
M=D
@0
M=M+1
// SUB function
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
// Call Function
// push return-address
@return_address_1
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// Reposition ARG
@SP
D=M
@ARG
M=D
@1
D=A
@ARG
M=M-D
@5
D=A
@ARG
M=M-D
// Reposition LCL
@SP
D=M
@LCL
M=D
// Goto Main.fibonacci
@Main.fibonacci
0;JMP
(return_address_1)
// Add function
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
// Return from function
// Store LCL in temp (R13)
@LCL
D=M
@R13
M=D
// Store the return address in temp (R14)
@R13
D=M
@5
D=D-A
A=D
D=M
@R14
M=D
// Pop return value and place at ARG location
@SP
D=M-1
A=D
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
// Restore THAT of caller
@R13
D=M
@1
D=D-A
A=D
D=M
@THAT
M=D
// Restore THIS of caller
@R13
D=M
@2
D=D-A
A=D
D=M
@THIS
M=D
// Restore ARG of caller
@R13
D=M
@3
D=D-A
A=D
D=M
@ARG
M=D
// Restore LCL of caller
@R13
D=M
@4
D=D-A
A=D
D=M
@LCL
M=D
// Goto return-address
@R14
A=M
0;JMP
// Function Sys.init
(Sys.init)
// Initialize all values to zero 
// PUSH-CONST
@4
D=A
@0
A=M
M=D
@0
M=M+1
// Call Function
// push return-address
@return_address_2
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// Reposition ARG
@SP
D=M
@ARG
M=D
@1
D=A
@ARG
M=M-D
@5
D=A
@ARG
M=M-D
// Reposition LCL
@SP
D=M
@LCL
M=D
// Goto Main.fibonacci
@Main.fibonacci
0;JMP
(return_address_2)
// Label
(WHILE)
// goto
@WHILE
0;JMP
