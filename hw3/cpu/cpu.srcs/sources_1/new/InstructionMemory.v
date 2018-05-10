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
    output reg [5:0] op,
    output reg [4:0] rs,
    output reg [4:0] rt,
    output reg [4:0] rd,
    output reg [4:0] sa,
    output reg [15:0] immediate,
    output reg [25:0] address
    );

    reg [31:0] Instruction [0:19];

    initial $readmemb ("instructions.txt", Instruction);

    //指令存储器读写控制信号，为0写，为1读，这里暂不实现写
    always@(InsMemRW)begin
        op=Instruction[IAddr][31:26];
        rs=Instruction[IAddr][25:21];
        rt=Instruction[IAddr][20:16];
        rd=Instruction[IAddr][15:11];
        sa=Instruction[IAddr][10:6];
        immediate=Instruction[IAddr][15:0];
        address=Instruction[IAddr][25:0];
    end

endmodule