// Function SimpleFunction.test
(SimpleFunction.test)
// Initialize all values to zero 
@SP
A=M
M=0
@SP
M=M+1
//
@SP
A=M
M=0
@SP
M=M+1
//
// PUSH-LCL
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
// PUSH-LCL
@1
D=A
@R1
A=M+D
D=M
@R0
A=M
M=D
@R0
M=M+1
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
// NOT function
@0
A=M
A=A-1
D=!M
@0
M=M-1
A=M
M=D
@0
M=M+1
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
// PUSH-ARG
@1
D=A
@R2
A=M+D
D=M
@R0
A=M
M=D
@R0
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
