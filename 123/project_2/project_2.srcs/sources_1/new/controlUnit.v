`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/21 14:12:02
// Design Name: 
// Module Name: controlUnit
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


module controlUnit(
    input [5:0] opCode,
    input zero,
    output PCWre,
    output ALUSrcA,
    output ALUSrcB,
    output RegWre,
    output InsMemRW,
    output ExtSel,
    output [1:0] PCSrc,
    output RegDst,
    output  _RD,
    output  _WR,
    output DBDataSrc,
    output [2:0] ALUOP
    );
    assign PCWre = (opCode == 6'b111111)? 0 : 1;
    assign ALUSrcA = (opCode == 6'b011000)? 1 : 0;
    assign ALUSrcB = (opCode == 6'b000001 || opCode == 6'b010000 || opCode == 6'b100110 || opCode == 6'b100111)? 1 : 0;
    assign DBDataSrc = (opCode == 6'b100111)? 1 : 0;
    assign RegWre = (opCode == 6'b110000 || opCode == 6'b110001 || opCode == 6'b110010 || opCode == 6'b100110 || opCode == 6'b111111 || opCode == 6'b111000) ? 0 : 1;
    assign InsMemRW = 1; 
    assign ExtSel = (opCode == 6'b010000) ? 0:1;
    assign PCSrc[0] = ((opCode == 6'b110000 && zero == 1) || ((opCode == 6'b110001 || opCode == 6'b110010) && zero == 0))? 1 : 0;
    assign PCSrc[1] = (opCode == 6'b111000)?1 : 0;
    assign RegDst = (opCode == 6'b000001 || opCode == 6'b010000 || opCode == 6'b100111)? 0 : 1;
    assign ALUOP[2] = (opCode == 6'b010001 || opCode == 6'b011100 || opCode == 6'b110010)? 1 : 0;
    assign ALUOP[1] = (opCode == 6'b011000 || opCode == 6'b011100 || opCode == 6'b010000 || opCode == 6'b010010 || opCode == 6'b110010)? 1 : 0;
    assign ALUOP[0] = (opCode == 6'b000010 || opCode == 6'b010000 || opCode == 6'b010010|| opCode == 6'b110000 || opCode == 6'b110001) ? 1 : 0;
    assign _RD = (opCode == 6'b100111)? 0:1;
    assign _WR = (opCode == 6'b100110)? 0:1;
endmodule
