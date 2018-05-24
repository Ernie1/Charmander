`timescale 1ns / 1ps

module Display(
        input CLK,
        input Reset,
        input [15:0] data,
        output reg [6:0] seg,
        output reg [3:0] an,
        output dp
    );

    reg [1:0] iter;
    reg [3:0] num;
    wire [3:0] unknownReason;
    assign dp=1;
    assign unknownReason=4'b1111;
    
    // 当前位置
    always@(posedge CLK or negedge Reset)begin
        if(!Reset)
            iter<=0;
        else
            iter<=iter+1;
    end

    // 从右到左
    always@(*)begin
        case(iter)
            2'b00:num=data[3:0];
            2'b01:num=data[7:4];
            2'b10:num=data[11:8];
            2'b11:num=data[15:12];
            default:num=data[3:0];
        endcase
    end

    // 译码
    always@(*)begin
        case(num)
            4'b0000:seg=7'b0000001;
            4'b0001:seg=7'b1001111;
            4'b0010:seg=7'b0010010;
            4'b0011:seg=7'b0000110;
            4'b0100:seg=7'b1001100;
            4'b0101:seg=7'b0100100;
            4'b0110:seg=7'b0100000;
            4'b0111:seg=7'b0001111;
            4'b1000:seg=7'b0000000;
            4'b1001:seg=7'b0000100;
            4'b1010:seg=7'b0001000;
            4'b1011:seg=7'b1100000;
            4'b1100:seg=7'b0110001;
            4'b1101:seg=7'b1000010;
            4'b1110:seg=7'b0110000;
            4'b1111:seg=7'b0111000;
            default:seg=7'b1111111;
        endcase
    end

    // AN
    always@(*)begin
        an=4'b1111;
        if(unknownReason[iter])
            an[iter]=0;
    end

endmodule