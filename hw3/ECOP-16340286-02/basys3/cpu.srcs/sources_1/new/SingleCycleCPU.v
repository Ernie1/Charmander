`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/10 17:50:44
// Design Name: 
// Module Name: SingleCycleCPU
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


module SingleCycleCPU(
        input CLK,
        input Reset,
        output [31:0] PCAddress,
        output [31:0] nextPC,
        output [4:0] rs,
        output [4:0] rt,
        output [31:0] RegisterFileReadData1,
        output [31:0] RegisterFileReadData2,
        output [31:0] ALUResult,
        output [31:0] DataMemoryDataOut
    );

    wire [31:0] ext;
    wire [25:0] address;
    wire [15:0] immediate;
    wire [5:0] InstructionMemoryOp;
    wire [4:0] sa,rd;
    wire [2:0] ALUOp;
    wire [1:0] PCSrc;
    wire ALUSrcA,ALUSrcB,zero,InsMemRW,PCWre,ExtSel,DBDataSrc,nWR,nRD,RegWre,RegDst;
         
    ALU alu(ALUOp,ALUSrcA,ALUSrcB,sa,RegisterFileReadData1, RegisterFileReadData2,ext, zero, ALUResult);
    PC pc(CLK,Reset,nextPC,PCWre,PCAddress);
    nextPc nextpc(PCSrc,PCAddress,ext,address,nextPC);
    ControlUnit controlUnit(InstructionMemoryOp,zero,InsMemRW,PCWre,ExtSel,DBDataSrc,nWR,nRD,ALUSrcB,ALUSrcA,PCSrc,ALUOp,RegWre,RegDst);
    DataMemory dataMemory(CLK,nRD,nWR,ALUResult,RegisterFileReadData2,DataMemoryDataOut);
    InstructionMemory instructionMemory(InsMemRW,PCAddress,InstructionMemoryOp,rs,rt,rd,sa,immediate,address);
    RegisterFile registerFile(CLK,RegWre,rs,rt,rd,RegDst,DBDataSrc,ALUResult,DataMemoryDataOut,RegisterFileReadData1,RegisterFileReadData2);
    SignZeroExtend signZeroExtend(immediate,ExtSel,ext);

endmodule