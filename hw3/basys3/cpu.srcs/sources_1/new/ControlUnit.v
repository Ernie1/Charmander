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
    
    //дָ��洢��
    assign InsMemRW=1; 
    //half PC������
    assign PCWre=(op==6'b111111)?0:1;
    //ori 0��չ
    assign ExtSel=(op==6'b010000)?0:1;
    //lw �������ݴ洢����Data MEM�������
    assign DBDataSrc=(op==6'b100111)?1:0;
    //sw д���ݴ洢��
    assign nWR=(op==6'b100110)?0:1;
    //lw �����ݴ洢��
    assign nRD=(op==6'b100111)?0:1;
    //addi��ori��slti��sw��lw ����sign��zero��չ��������
    assign ALUSrcB=(op==6'b000001||op==6'b010000||op==6'b011011||op==6'b100110||op==6'b100111)?1:0;
    //sll ������λ��sa��ͬʱ������(zero-extend)sa���� {{27{0}},sa}
    assign ALUSrcA=(op==6'b011000)?1:0;
    //j 10��pc<��{(pc+4)[31:28],addr[27:2],2{0}}
    assign PCSrc[1]=(op==6'b111000)?1:0;
    //beq(zero=1)��bne(zero=0) 01��pc<��pc+4+(sign-extend)immediate
    assign PCSrc[0]=((op==6'b110000&&zero==1)||((op==6'b110001)&&zero==0))?1:0;
    //and��slti 100: �� 110: �Ƚ�A��B������
    assign ALUOp[2]=(op==6'b010001||op==6'b011011)?1:0;
    //sll��slti��ori��or 010: B����Aλ 011: �� 110: �Ƚ�A��B������
    assign ALUOp[1]=(op==6'b011000||op==6'b011011||op==6'b010000||op==6'b010010)?1:0;
    //sub��ori��or��beq��bne 001: �� 011: �� 111: ���
    assign ALUOp[0]=(op==6'b000010||op==6'b010000||op==6'b010010||op==6'b110000||op==6'b110001)?1:0;
    //beq��bne��sw��halt��j ��д�Ĵ�����Ĵ���
    assign RegWre=(op==6'b110000||op==6'b110001||op==6'b100110||op==6'b111111||op==6'b111000)?0:1;
    //addi��ori��lw��slti д�Ĵ�����Ĵ����ĵ�ַ������rt�ֶ�
    assign RegDst=(op==6'b000001||op==6'b010000||op==6'b100111||op==6'b011011)?0:1;
    
endmodule