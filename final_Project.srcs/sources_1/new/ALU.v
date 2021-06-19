`timescale 1ns / 1ps

module ALU(
    input [15:0] A,
    input [15:0] B,
    input  C,
    input [7:0] OpCode,
    input Sal,
    input clk,
    output reg [15:0] Output,
    output Flag_Output
    );
    reg [3:0] Flag_Out;
    reg[16:0] Out;
    reg[15:0] Z=16'hffff;
    integer i,ones=0;
    Flag_Register f1(.Flag_Out(Flag_Out),.Sal(Sal),
    .clk(clk),.OpCode(OpCode),.Flag_Output(Flag_Output));
    always @(OpCode or A or B or C)
    begin
        Flag_Out[1]=0;
        case(OpCode[7])
        1'b0 :     //Logical Operations
        begin
            if(OpCode[6:4]==3'b000)
                Output = ~A;
            else if(OpCode[6:4]==3'b001)
                Output = A^B;
            else if(OpCode[6:4]==3'b010)
                Output = A^(~B);
            else if(OpCode[6:4]==3'b011)
                Output = (~Z)&(~A)&(~B);
            else if(OpCode[6:4]==3'b100)
                Output = ~(A&B|Z);
            else if(OpCode[6:4]==3'b101)
                Output = (~A)^(~B);
            else if(OpCode[6:4]==3'b110)
                Output = ((~A)|B&(~Z));
            else if(OpCode[6:4]==3'b111)
                Output = A|(~B);
        end
        1'b1 :   //Arithematic Operations
        begin
            if(OpCode[6:4]==3'b000)
            begin
                Out = A+1;
                Output = Out[15:0];
                Flag_Out[1] = Out[16];
            end
            else if(OpCode[6:4]==3'b001)
            begin
                Out = ((A&B)+Z);
                Output = Out[15:0];
                Flag_Out[1] = Out[16];
            end
            else if(OpCode[6:4]==3'b010)
            begin
                Out = (A&(~B))+(B&Z);
                Output = Out[15:0];
                Flag_Out[1] = Out[16];
            end
            else if(OpCode[6:4]==3'b011)
            begin
                Out = (A&B)-(B&Z);
                Output = Out[15:0];
                Flag_Out[1] = Out[16];
            end
            else if(OpCode[6:4]==3'b100)
            begin
                Out = A+B;
                Output = Out[15:0];
                Flag_Out[1] = Out[16];
            end
            else if(OpCode[6:4]==3'b101)
            begin
                Out = (A&B)-1;
                Output = Out[15:0];
                Flag_Out[1] = Out[16];
            end
            else if(OpCode[6:4]==3'b110)
            begin
                Out = (A&B)+1;
                Output = Out[15:0];
                Flag_Out[1] = Out[16];
            end
            else if(OpCode[6:4]==3'b111)
            begin
                Out = A+B-C;
                Output = Out[15:0];
                Flag_Out[1] = Out[16];
            end
        end
        endcase
        if(Output == 16'h0000) // Zero flag;
            Flag_Out[0]=1;
        else
            Flag_Out[0]=0;
        if(Output[15]==1'b0)  // Sign flag;
            Flag_Out[2]=0;
        else
            Flag_Out[2] =1;
        for(i=0;i<16;i=i+1)
        begin
            if(Output[i]==1)
                ones=ones+1;            
        end
        if(ones%2==0)       //parity flag;
            Flag_Out[3]=1;
        else
            Flag_Out[3]=0;
    end
endmodule