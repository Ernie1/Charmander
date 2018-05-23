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
        input [25:0] address,
        output reg [31:0] Address
    );
    
    always@(posedge CLK or negedge Reset)begin
        if(!Reset)
            Address<=0;
        else if(PCWre)begin
            case(PCSrc)
                2'b00:Address<=Address+4;// pc<£­pc+4
                2'b01:Address<=Address+4+(immediate*4);// pc<£­pc+4+immediate*4
                2'b10:begin    //pc<£­{(pc+4)[31:28],addr[27:2],2{0}}
                    Address<=Address+4;
                     Address<={Address[31:28],address,2'b00};
                 end
                 default:Address<=0;
            endcase
        end
    end
    
endmodule
