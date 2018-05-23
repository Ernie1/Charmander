`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/10 14:03:37
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input CLK,
    input nRD,
    input nWR,
    input [31:0] DAddr,
    input [31:0] DataIn,
    output [31:0] DataOut
    );

    reg [7:0] Data [0:63];
    
    integer i;
    initial begin
        for (i=0;i<127;i=i+1)
            Data[i]<=0;
    end

    assign DataOut=(!nRD)?{Data[DAddr*4+3],Data[DAddr*4+2],Data[DAddr*4+1],Data[DAddr*4]}:32'bz; // z Îª¸ß×èÌ¬
 
    always@(negedge CLK)begin
        if(!nWR)begin
            Data[DAddr*4+3]<=DataIn[31:24];
            Data[DAddr*4+2]<=DataIn[23:16];
            Data[DAddr*4+1]<=DataIn[15:8];
            Data[DAddr*4]<=DataIn[7:0];
        end
    end
    
endmodule