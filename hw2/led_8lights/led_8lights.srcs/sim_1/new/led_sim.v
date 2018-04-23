`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/23 21:00:23
// Design Name: 
// Module Name: led_sim
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


module led_sim( );
    // input
    reg clock;
    reg reset;
    // output
    wire Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
    led_8lights uut(
        .clock(clock), .reset(reset), .Y0(Y0), .Y1(Y1), .Y2(Y2), .Y3(Y3), .Y4(Y4), .Y5(Y5), .Y6(Y6), .Y7(Y7)
    );
    always #5 clock = ~clock; // 周期为 10ns
    initial begin
        clock = 0;
        reset = 0;
        #100 reset = 1; // 从 100ns 开始仿真输出
    end
endmodule