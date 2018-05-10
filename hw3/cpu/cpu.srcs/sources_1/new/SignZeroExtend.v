`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/09 23:25:46
// Design Name: 
// Module Name: SignZeroExtend
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


module SignZeroExtend(
    input [15:0] immediate,
    input ExtSel,
    output reg [31:0] ext
    );

    assign ext[15:0]=immediate;
    assign ext[31:16]=ExtSel?(immediate[15]?16'hffff:0):0;

endmodule