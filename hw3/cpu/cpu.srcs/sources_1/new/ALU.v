`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/09 18:47:19
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
        input [2:0] ALUOp,
        input ALUSrcA,
        input ALUSrcB,
        input [4:0] sa,
        input [31:0] ReadData1,
        input [31:0] ReadData2,
        input [31:0] ext,
        output reg zero,
        output reg [31:0] result
    );
    
    wire [31:0] saExt;
    wire [31:0] A;
    wire [31:0] B;
    
    assign saExt[4:0]=sa;
    assign saExt[31:5]=0;
    
    assign A=ALUSrcA?saExt:ReadData1;
    assign B=ALUSrcB?ext:ReadData2;

    always@(ALUOp or ALUSrcA or ALUSrcB or ReadData1 or ReadData2 or ext or A or B)begin
        case(ALUOp)
            3'b000:result=A+B;
            3'b001:result=A-B;
            3'b010:result=B<<A;
            3'b011:result=A|B;
            3'b100:result=A&B;
            3'b101:result=(A<B)?1:0;
            3'b110:result=((A<B&&A[31]==B[31])||(A[31]&&!B[31]))?1:0;
            3'b111:result=A^B;
            default:result=0;
        endcase
        zero=(result==0)?1:0;
    end
    
endmodule