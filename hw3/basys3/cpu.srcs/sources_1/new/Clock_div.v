`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/23 22:53:48
// Design Name: 
// Module Name: Clock_div
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


module Clock_div(
        input W5, //100MHz��ϵͳĬ����Ƶ��
        output reg CLK = 0 //1Hz����Ƶ���Ƶ�ʡ������ʼ��Ϊ 0
    );
    reg [17:0] div_counter = 0;
    always @(posedge W5) begin
        if(div_counter>=250000) begin // �������� �������ļ� ������
            CLK <= ~CLK; // ��ƽ����
            div_counter <= 0;
        end else begin
            div_counter <= div_counter + 1;
        end
    end
endmodule