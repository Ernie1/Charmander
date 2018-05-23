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

    reg [31:0] Instruction [0:79];

    initial begin
        //addi  $1,$0,8
        Instruction[3]=8'b00000100;
        Instruction[2]=8'b00000001;
        Instruction[1]=8'b00000000;
        Instruction[0]=8'b00001000;
        //ori  $2,$0,2
        Instruction[7]=8'b01000000;
        Instruction[6]=8'b00000010;
        Instruction[5]=8'b00000000;
        Instruction[4]=8'b00000010;
        //add  $3,$2,$1
        Instruction[11]=8'b00000000;
        Instruction[10]=8'b01000001;
        Instruction[9]=8'b00011000;
        Instruction[8]=8'b00000000;
        //sub  $5,$3,$2
        Instruction[15]=8'b00001000;
        Instruction[14]=8'b01100010;
        Instruction[13]=8'b00101000;
        Instruction[12]=8'b00000000;
        //and  $4,$5,$2
        Instruction[19]=8'b01000100;
        Instruction[18]=8'b10100010;
        Instruction[17]=8'b00100000;
        Instruction[16]=8'b00000000;
        //or  $8,$4,$2
        Instruction[23]=8'b01001000;
        Instruction[22]=8'b10000010;
        Instruction[21]=8'b01000000;
        Instruction[20]=8'b00000000;
        //sll  $8,$8,1
        Instruction[27]=8'b01100000;
        Instruction[26]=8'b00001000;
        Instruction[25]=8'b01000000;
        Instruction[24]=8'b01000000;
        //bne  $8,$1,-2 (??,?18)
        Instruction[31]=8'b11000101;
        Instruction[30]=8'b00000001;
        Instruction[29]=8'b11111111;
        Instruction[28]=8'b11111110;
        //slti  $6,$2,8
        Instruction[35]=8'b01101100;
        Instruction[34]=8'b01000110;
        Instruction[33]=8'b00000000;
        Instruction[32]=8'b00001000;
        //slti  $7,$6,0
        Instruction[39]=8'b01101100;
        Instruction[38]=8'b11000111;
        Instruction[37]=8'b00000000;
        Instruction[36]=8'b00000000;
        //addi $7,$7,8
        Instruction[43]=8'b00000100;
        Instruction[42]=8'b11100111;
        Instruction[41]=8'b00000000;
        Instruction[40]=8'b00001000;
        //beq $7,$1,-2 (=,?28)
        Instruction[47]=8'b11000000;
        Instruction[46]=8'b11100001;
        Instruction[45]=8'b11111111;
        Instruction[44]=8'b11111110;
        //sw  $2,4($1)
        Instruction[51]=8'b10011000;
        Instruction[50]=8'b00100010;
        Instruction[49]=8'b00000000;
        Instruction[48]=8'b00000100;
        //lw  $9,4($1)
        Instruction[55]=8'b10011100;
        Instruction[54]=8'b00101001;
        Instruction[53]=8'b00000000;
        Instruction[52]=8'b00000100;
        //j  0x00000040
        Instruction[59]=8'b11100000;
        Instruction[58]=8'b00000000;
        Instruction[57]=8'b00000000;
        Instruction[56]=8'b00010000;
        //addi  $10,$0,10
        Instruction[63]=8'b00000100;
        Instruction[62]=8'b00001010;
        Instruction[61]=8'b00000000;
        Instruction[60]=8'b00001010;
        //halt
        Instruction[67]=8'b11111100;
        Instruction[66]=8'b00000000;
        Instruction[65]=8'b00000000;
        Instruction[64]=8'b00000000;
    end

        //指令存储器读写控制信号InsMemRW，为0写，为1读，这里暂不实现写，所以忽略InsMemRW
        assign op=Instruction[IAddr+3][7:2];
        assign rs={Instruction[IAddr+3][1:0],Instruction[IAddr+2][7:5]};
        assign rt=Instruction[IAddr+2][4:0];
        assign rd=Instruction[IAddr+1][7:3];
        assign sa={Instruction[IAddr+1][2:0],Instruction[IAddr][7:6]};
        assign immediate={Instruction[IAddr+1][7:0],Instruction[IAddr][7:0]};
        assign address={Instruction[IAddr+3][1:0],Instruction[IAddr+2][7:0],Instruction[IAddr+1][7:0],Instruction[IAddr][7:0]};
        
endmodule