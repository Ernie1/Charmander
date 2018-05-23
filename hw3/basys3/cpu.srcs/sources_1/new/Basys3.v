`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/23 23:09:53
// Design Name: 
// Module Name: Basys3
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


module Basys3(
        input W5,
        input Reset,
        input button,
        input [1:0] src,
        output [6:0] seg,
        output [3:0] an,
        output dp 
    );

    wire CLK,trigger;
    wire [4:0] rs,rt;
    wire [15:0] data;
    wire [31:0] PCAddress,nextPC,RegisterFileReadData1,RegisterFileReadData2,ALUResult,DataMemoryDataOut;

    Clock_div clock_div(W5,CLK);
    Button button(CLK,button,trigger);
    SingleCycleCPU singleCycleCPU(trigger,Reset,PCAddress,nextPC,rs,rt,RegisterFileReadData1,RegisterFileReadData2,ALUResult,DataMemoryDataOut);
    Src src(src,PCAddress[7:0],nextPC[7:0],rs,rt,RegisterFileReadData1[7:0],RegisterFileReadData2[7:0],ALUResult[7:0],DataMemoryDataOut[7:0],data);
    Display display(CLK,Reset,data,seg,an,dp);

endmodule