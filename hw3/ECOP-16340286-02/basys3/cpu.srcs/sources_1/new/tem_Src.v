`timescale 1ns / 1ps

module Src(
    input [1:0] src,
    input [7:0] PC,
    input [7:0] nextPC,
    input [4:0] rs,
    input [4:0] rt,
    input [7:0] ReadData1,
    input [7:0] ReadData2,
    input [7:0] result,
    input [7:0] DataOut,
    output reg [15:0] data
    );

    initial data=0;

    always@(*) begin
        case(src)
            2'b00:data={PC,nextPC};
            2'b01:data={3'b000,rs,ReadData1};
            2'b10:data={3'b000,rt,ReadData2};
            2'b11:data={result,DataOut};
            default:data=0;
        endcase
    end

endmodule