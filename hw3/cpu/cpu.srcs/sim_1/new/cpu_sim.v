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

//    SingleCycleCPU cpu(
//        .CLK(CLK),
//        .Reset(Reset),
//        .InstructionMemoryOp(op),
//        .RegisterFileReadData1(OUT1),
//        .RegisterFileReadData2(OUT2),
//        .PCAddress(pc),
//        .ALUResult(result)
//        );
            SingleCycleCPU cpu(
                    .clk(CLK),
                    .Reset(Reset),
                    .opCode(op),
                    .Out1(OUT1),
                    .Out2(OUT2),
                    .curPC(pc),
                    .result(result)
                );

    always #5 CLK=~CLK; // ????? 10ns

    initial begin
        CLK=0;
        Reset=0;

        #10 Reset=1; // ?? 10ns ??????????
    end

endmodule