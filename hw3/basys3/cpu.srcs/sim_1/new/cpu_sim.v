`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/10 22:41:19
// Design Name: 
// Module Name: cpu_sim
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


module cpu_sim(

    );
    
    reg CLK,Reset;
    wire [31:0] PCAddress;
    wire [31:0] nextPC;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [31:0] RegisterFileReadData1;
    wire [31:0] RegisterFileReadData2;
    wire [31:0] ALUResult;
    wire [31:0] DataMemoryDataOut;

    SingleCycleCPU singleCycleCPU(CLK,Reset,PCAddress,nextPC,rs,rt,RegisterFileReadData1,RegisterFileReadData2,ALUResult,DataMemoryDataOut);

    always #5 CLK=~CLK;  // 周期为 10ns

    initial begin
        CLK=0;
        Reset=0;

        #10 Reset=1;  // 从 10ns 开始仿真输出
    end

endmodule