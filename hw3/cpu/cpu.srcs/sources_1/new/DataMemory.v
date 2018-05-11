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

    reg [31:0] Data [0:31];
    
    integer i;
    initial begin
        for (i=0;i<32;i=i+1)
            Data[i]<=0;
    end

    assign DataOut=(!nRD)?Data[DAddr]:32'bz; //????????

    always@(negedge CLK)begin
        if(!nWR)
            Data[DAddr]<=DataIn;
    end
    
endmodule