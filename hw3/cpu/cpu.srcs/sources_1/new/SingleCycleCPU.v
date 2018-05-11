`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/21 21:38:17
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
    input clk,
    input Reset,
    output wire [5:0] opCode,
    output wire [31:0] Out1,
    output wire [31:0] Out2,
    output wire [31:0] curPC,
    output wire [31:0] result
    );
    wire [2:0] ALUOp;
      
                 wire [31:0] ExtOut, DMOut;
      
                 wire [15:0] immediate;
      
                 wire [4:0] rs, rt, rd, sa;
                 wire [25:0] addr;
     wire [1:0] PCSrc;
                 wire zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, _RD, _WR, ExtSel, RegDst;
      
         
             //ALU alu(Out1, Out2, ExtOut, sa, ALUSrcA, ALUSrcB, ALUOp, zero, result);
             ALU alu(ALUOp,ALUSrcA,ALUSrcB,sa,Out1, Out2,ExtOut, zero, result);

    
                //PC pc(clk, Reset, PCWre, PCSrc, ExtOut, addr,curPC);
                PC pc(PCWre,clk,Reset,PCSrc, ExtOut, addr,curPC);
    
                 //controlUnit control(opCode, zero, PCWre, ALUSrcA, ALUSrcB, RegWre, InsMemRW, ExtSel, PCSrc, RegDst, _RD, _WR, DBDataSrc, ALUOp);
      ControlUnit controlUnit(opCode,zero,InsMemRW,PCWre,ExtSel,DBDataSrc,_WR,_RD,ALUSrcB,ALUSrcA,PCSrc,ALUOp,RegWre,RegDst);
    
                 //dataMemory datamemory(clk, result, Out2, _RD, _WR, DMOut);
            DataMemory dataMemory(clk,_RD,_WR,result,Out2,DMOut);
         
             //InstructionMemory ins(curPC, InsMemRW, opCode, rs, rt, rd, sa, immediate,addr);
      InstructionMemory instructionMemory(InsMemRW,curPC,opCode,rs,rt,rd,sa,immediate,addr);
     
             //registerFile registerfile(clk, RegWre, RegDst, rs, rt, rd, DBDataSrc, result, DMOut, Out1, Out2);
      RegisterFile registerFile(clk,RegWre,rs,rt,rd,RegDst,DBDataSrc,result,DMOut,Out1,Out2);
    
                 //signZeroExtend ext(immediate, ExtSel, ExtOut);
                 SignZeroExtend signZeroExtend(immediate,ExtSel,ExtOut);
endmodule