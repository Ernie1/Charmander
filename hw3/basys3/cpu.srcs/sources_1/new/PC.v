`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/09 11:35:08
// Design Name: 
// Module Name: PC
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


module PC(
        input CLK,
        input Reset,
        input [31:0] nextPC,
        input PCWre,
        output reg [31:0] Address
    );
    
    initial Address<=0;

    always@(posedge CLK or negedge Reset)begin
        if(!Reset)
            Address<=0;
        else if(PCWre)
            Address<=nextPC;
    end
    
endmodule
