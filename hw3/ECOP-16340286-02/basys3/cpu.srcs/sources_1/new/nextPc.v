`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/23 13:40:56
// Design Name: 
// Module Name: nextPc
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


module nextPc(
        input [1:0] PCSrc,
        input [31:0] Address,
        input [31:0] immediate,
        input [25:0] address,
        output reg [31:0] nextPC
    );
    
    always@(*) begin
        case(PCSrc)
            2'b00:nextPC<=Address+4;
            2'b01:nextPC<=Address+4+(immediate*4);
            2'b10:begin
                    nextPC<=Address+4;
                    nextPC<={nextPC[31:28],address,2'b00};
                end
                default:nextPC<=0;
        endcase
    end
    
endmodule