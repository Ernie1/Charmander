`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/10 10:38:54
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
    input InsMemRW,
    input [31:0] IAddr,
    output  [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] sa,
    output [15:0] immediate,
    output [25:0] address
    );

    reg [31:0] Instruction [0:19];

    initial begin
        //addi  $1,$0,8
        Instruction[0]=32'b00000100000000010000000000001000;
        //ori  $2,$0,2
        Instruction[1]=32'b01000000000000100000000000000010;
        //add  $3,$2,$1
        Instruction[2]=32'b00000000010000010001100000000000;
        //sub  $5,$3,$2
        Instruction[3]=32'b00001000011000100010100000000000;
        //and  $4,$5,$2
        Instruction[4]=32'b01000100101000100010000000000000;
        //or  $8,$4,$2
        Instruction[5]=32'b01001000100000100100000000000000;
        //sll  $8,$8,1
        Instruction[6]=32'b01100000000010000100000001000000;
        //bne  $8,$1,-2 (??,?18)
        Instruction[7]=32'b11000101000000011111111111111110;
        //slti  $6,$2,8
        Instruction[8]=32'b01101100010001100000000000001000;
        //slti  $7,$6,0
        Instruction[9]=32'b01101100110001110000000000000000;
        //addi $7,$7,8
        Instruction[10]=32'b00000100111001110000000000001000;
        //beq $7,$1,-2 (=,?28)
        Instruction[11]=32'b11000000111000011111111111111110;
        //sw  $2,4($1)
        Instruction[12]=32'b10011000001000100000000000000100;
        //lw  $9,4($1)
        Instruction[13]=32'b10011100001010010000000000000100;
        //j  0x00000040
        Instruction[14]=32'b11100000000000000000000000010000;
        //addi  $10,$0,10
        Instruction[15]=32'b00000100000010100000000000001010;
        //halt
        Instruction[16]=32'b11111100000000000000000000000000;
    end

    //???›¥????§Õ?????????0§Õ???1??????????????§Õ
        assign op=Instruction[IAddr>>2][31:26];
        assign rs=Instruction[IAddr>>2][25:21];
        assign rt=Instruction[IAddr>>2][20:16];
        assign rd=Instruction[IAddr>>2][15:11];
        assign sa=Instruction[IAddr>>2][10:6];
        assign immediate=Instruction[IAddr>>2][15:0];
        assign address=Instruction[IAddr>>2][25:0];

endmodule