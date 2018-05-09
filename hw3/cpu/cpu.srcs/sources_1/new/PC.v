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
        input PCWre,
        input CLK,
        input Reset,
        input [1:0] PCSrc,
        input [31:0] immediate,
        input [25:0] addr,
        output reg [31:0] Address
    );
    
    always@(posedge CLK or negedge Reset)begin
        if(!Reset)
            Address<=0;
        else if(PCWre)begin
            case(PCSrc)
                2'b00:Address<=Address+4;
                2'b01:Address<=Address+4+(immedia*4);
                2'b10:begin
                    Address<=Address+4;
                    Address<={Address[31:28],addr,2'b00};
                end
                default:Address<=0;
            endcase
        end
    end
    
endmodule
