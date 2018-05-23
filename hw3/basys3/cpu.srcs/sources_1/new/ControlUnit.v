`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/10 14:39:08
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
        input [5:0] op,
        input zero,
        output InsMemRW,
        output  PCWre,
        output ExtSel,
        output DBDataSrc,
        output nWR,
        output nRD,
        output ALUSrcB,
        output ALUSrcA,
        output [1:0] PCSrc,
        output [2:0] ALUOp,
        output RegWre,
        output RegDst
    );
    
    //写指令存储器
    assign InsMemRW=1; 
    //half PC不更改
    assign PCWre=(op==6'b111111)?0:1;
    //ori 0扩展
    assign ExtSel=(op==6'b010000)?0:1;
    //lw 来自数据存储器（Data MEM）的输出
    assign DBDataSrc=(op==6'b100111)?1:0;
    //sw 写数据存储器
    assign nWR=(op==6'b100110)?0:1;
    //lw 读数据存储器
    assign nRD=(op==6'b100111)?0:1;
    //addi、ori、slti、sw、lw 来自sign或zero扩展的立即数
    assign ALUSrcB=(op==6'b000001||op==6'b010000||op==6'b011011||op==6'b100110||op==6'b100111)?1:0;
    //sll 来自移位数sa，同时，进行(zero-extend)sa，即 {{27{0}},sa}
    assign ALUSrcA=(op==6'b011000)?1:0;
    //j 10：pc<－{(pc+4)[31:28],addr[27:2],2{0}}
    assign PCSrc[1]=(op==6'b111000)?1:0;
    //beq(zero=1)、bne(zero=0) 01：pc<－pc+4+(sign-extend)immediate
    assign PCSrc[0]=((op==6'b110000&&zero==1)||((op==6'b110001)&&zero==0))?1:0;
    //and、slti 100: 与 110: 比较A与B带符号
    assign ALUOp[2]=(op==6'b010001||op==6'b011011)?1:0;
    //sll、slti、ori、or 010: B左移A位 011: 或 110: 比较A与B带符号
    assign ALUOp[1]=(op==6'b011000||op==6'b011011||op==6'b010000||op==6'b010010)?1:0;
    //sub、ori、or、beq、bne 001: 减 011: 或 111: 异或
    assign ALUOp[0]=(op==6'b000010||op==6'b010000||op==6'b010010||op==6'b110000||op==6'b110001)?1:0;
    //beq、bne、sw、halt、j 无写寄存器组寄存器
    assign RegWre=(op==6'b110000||op==6'b110001||op==6'b100110||op==6'b111111||op==6'b111000)?0:1;
    //addi、ori、lw、slti 写寄存器组寄存器的地址，来自rt字段
    assign RegDst=(op==6'b000001||op==6'b010000||op==6'b100111||op==6'b011011)?0:1;
    
endmodule