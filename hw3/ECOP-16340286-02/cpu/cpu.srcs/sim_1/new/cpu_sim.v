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
    wire [5:0] op;
    wire [31:0] OUT1,OUT2,pc,result;

    SingleCycleCPU cpu(
        .CLK(CLK),
        .Reset(Reset),
        .InstructionMemoryOp(op),
        .RegisterFileReadData1(OUT1),
        .RegisterFileReadData2(OUT2),
        .PCAddress(pc),
        .ALUResult(result)
        );

    always #5 CLK=~CLK;  // 周期为 10ns

    initial begin
        CLK=0;
        Reset=0;

        #10 Reset=1;  // 从 10ns 开始仿真输出
    end

endmodule