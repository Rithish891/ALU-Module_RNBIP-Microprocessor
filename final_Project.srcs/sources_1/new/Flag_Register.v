`timescale 1ns / 1ps

module Flag_Register(
    input [3:0] Flag_Out,
    input Sal,
    input clk,
    input [7:0] OpCode,
    output reg Flag_Output
    );
    reg Z,NZ,C,NC,P,M,PE,PO;// Declaring all flags;
    always @(posedge clk)
    begin
    Z=Flag_Out[0];
    NZ=~Flag_Out[0];
    C=Flag_Out[1];
    NC=~Flag_Out[1];
    P=Flag_Out[2];
    M=~Flag_Out[2];
    PE=Flag_Out[3];
    PO=~Flag_Out[3];
    if(Sal==1)
    begin
        case(OpCode[2:0])
        3'b000: Flag_Output=Z;
        3'b001: Flag_Output=NZ;
        3'b010: Flag_Output=C;
        3'b011: Flag_Output=NC;
        3'b100: Flag_Output=P;
        3'b101: Flag_Output=M;
        3'b110: Flag_Output=PE;
        3'b111: Flag_Output=PO;
        endcase    
    end
    end
endmodule