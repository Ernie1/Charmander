`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/09 20:39:39
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input CLK,
    input RegWre,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input RegDst,
    input DBDataSrc,
    input [31:0] ALUresult,
    input [31:0] DataMemoryDataOut,
    output reg [31:0] ReadData1,
    output reg [31:0] ReadData2
    );

    wire [31:0] WriteReg;
    wire [31:0] WriteData;

    assign WriteReg=RegDst?rd:rt;
    assign WriteData=DBDataSrc?DataMemoryDataOut:ALUresult;
    
    reg [31:0] Register [0:31];

    initial begin
        integer i;
        for (i=0;i<32;i=i+1)
            Register[i]<=0;
    end

    assign ReadData1=Register[rs];
    assign ReadData2=Register[rt];

    always@(negedge CLK)begin
        if(RegWre&&WriteReg)
            Register[WriteReg]<=WriteData;
    end
endmodule