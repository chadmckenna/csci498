// Initialize the file and start at Sys.init
@261
D=A
@SP
M=D
@Sys.init
0;JMP
// Function Class1.set
(Class1.set)
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
// POP-STATIC
@0
D=A
@16
D=D+A
@POP.STATIC.2
M=D
@R0
M=M-1
A=M
D=M
@POP.STATIC.2
A=M
M=D
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
// POP-STATIC
@1
D=A
@16
D=D+A
@POP.STATIC.4
M=D
@R0
M=M-1
A=M
D=M
@POP.STATIC.4
A=M
M=D
// PUSH-CONST
@0
D=A
@0
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
// Function Class1.get
(Class1.get)
// Initialize all values to zero 
// PUSH-STATIC
@0
D=A
@16
D=D+A
A=D
D=M
@R0
A=M
M=D
@R0
M=M+1
// PUSH-STATIC
@1
D=A
@16
D=D+A
A=D
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
// Function Class2.set
(Class2.set)
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
// POP-STATIC
@0
D=A
@16
D=D+A
@POP.STATIC.14
M=D
@R0
M=M-1
A=M
D=M
@POP.STATIC.14
A=M
M=D
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
// POP-STATIC
@1
D=A
@16
D=D+A
@POP.STATIC.16
M=D
@R0
M=M-1
A=M
D=M
@POP.STATIC.16
A=M
M=D
// PUSH-CONST
@0
D=A
@0
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
// Function Class2.get
(Class2.get)
// Initialize all values to zero 
// PUSH-STATIC
@0
D=A
@16
D=D+A
A=D
D=M
@R0
A=M
M=D
@R0
M=M+1
// PUSH-STATIC
@1
D=A
@16
D=D+A
A=D
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
@6
D=A
@0
A=M
M=D
@0
M=M+1
// PUSH-CONST
@8
D=A
@0
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
@2
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
// Goto Class1.set
@Class1.set
0;JMP
(return_address_0)
// POP-TEMP
@0
D=A
D=D+1
D=D+1
D=D+1
D=D+1
D=D+1
@POP.TEMP.28
M=D
@R0
A=M-1
D=M
@POP.TEMP.28
A=M
M=D
@R0
M=M-1
// PUSH-CONST
@23
D=A
@0
A=M
M=D
@0
M=M+1
// PUSH-CONST
@15
D=A
@0
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
@2
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
// Goto Class2.set
@Class2.set
0;JMP
(return_address_1)
// POP-TEMP
@0
D=A
D=D+1
D=D+1
D=D+1
D=D+1
D=D+1
@POP.TEMP.32
M=D
@R0
A=M-1
D=M
@POP.TEMP.32
A=M
M=D
@R0
M=M-1
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
@0
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
// Goto Class1.get
@Class1.get
0;JMP
(return_address_2)
// Call Function
// push return-address
@return_address_3
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
@0
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
// Goto Class2.get
@Class2.get
0;JMP
(return_address_3)
// Label
(WHILE)
// goto
@WHILE
0;JMP
