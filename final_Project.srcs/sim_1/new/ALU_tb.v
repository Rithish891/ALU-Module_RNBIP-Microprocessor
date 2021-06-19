`timescale 1ns / 1ps

module ALU_tb(
    );
    reg [15:0] A,B;
    reg C=1'b0;
    reg Sal=1;
    reg clk=0;
    reg[7:0] OpCode;
    wire [15:0] Output;
    wire Flag_Output;
    ALU a1(A,B,C,OpCode,Sal,clk,Output,Flag_Output);
    always
    begin
        #10 clk=~clk;
    end    
    initial 
    begin
    OpCode=8'b00000010;
    A=16'hffff;
    B=16'h0001;
    #20
    OpCode=8'b0001000;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b00100000;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b00111101;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b01000000;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b01011111;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b01100100;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b01110100;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b10000010;
    A=16'hffff;
    #20
    OpCode=8'b10010101;
    A=16'hffff;
    B=16'hffff;
    #20
    OpCode=8'b10100001;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b10111101;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b11000010;
    A=16'h7fff;
    B=16'h0001;
    #20
    OpCode=8'b11011111;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b11100100;
    A=16'h1234;
    B=16'h1111;
    #20
    OpCode=8'b11110001;
    A=16'h0000;
    B=16'h0000;
    C=1'b1;
    end
endmodule