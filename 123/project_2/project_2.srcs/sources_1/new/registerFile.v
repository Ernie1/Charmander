`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/21 14:36:16
// Design Name: 
// Module Name: registerFile
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


module registerFile(
    input clk,
    input RegWre,
    input RegDst,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input DBDataSrc,
    input [31:0] dataFromALU,
    input [31:0] dataFromRW,
    output  [31:0] Data1,
    output  [31:0] Data2
    );
    wire [4:0] writeReg;
      
         wire [31:0] writeData;
      
         assign writeReg = RegDst? rd : rt;
      
         assign writeData = DBDataSrc? dataFromRW : dataFromALU;
      
           
         reg [31:0] register[0:31];
      
         integer i;
      
         initial begin
      
             for (i = 0; i < 32; i = i+1) register[i] <= 0;
      
         end
      
           
         // output
      
         assign Data1 = register[rs];
      
         assign Data2 = register[rt];
      
           
         // Write Reg 
     
         always @(negedge clk) begin
    
             if (RegWre && writeReg) register[writeReg] = writeData;  // ·ÀÖ¹Êý¾ÝÐ´Èë0ºÅ¼Ä´æÆ÷
      
         end

endmodule
