`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2010
// Design Name:
// Module Name:    alu
// Project Name:
// Target Devices:
// Tool versions:
// Desrciption:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           shamt,
           ALU_control,   // 4 bits ALU control input  (input)
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4:0]   shamt;
input   [4-1:0] ALU_control;
input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
wire             zero;
reg              cout;
wire             overflow;

// ALU Operation parameter
// unused: 0100, 0101, 1101, 1110, 1111
parameter [3:0] ALU_AND  = 4'b0000;
parameter [3:0] ALU_OR   = 4'b0001;
parameter [3:0] ALU_ADD  = 4'b0010;
parameter [3:0] ALU_MUL  = 4'b0011;
parameter [3:0] ALU_SUB  = 4'b0110;
parameter [3:0] ALU_SLT  = 4'b0111;
parameter [3:0] ALU_SLL  = 4'b1000;
parameter [3:0] ALU_SLLV = 4'b1010;
parameter [3:0] ALU_SRL  = 4'b1001;
parameter [3:0] ALU_SRLV = 4'b1011;
parameter [3:0] ALU_XOR  = 4'b1100;

always @(*) begin
    casex(ALU_control)
        ALU_AND : result <= src1 & src2;
        ALU_OR  : result <= src1 | src2;
        ALU_ADD : {cout, result} <= src1 + src2;
        ALU_MUL : result <= src1 * src2;
        ALU_SUB : {cout, result} <= src1 + ~src2 + 1;
        ALU_SLT : result <= (src1 < src2);
        ALU_SLL : result <= src2 << shamt;
        ALU_SLLV: result <= src2 << src1[4:0];
        ALU_SRL : result <= src2 >> shamt;
        ALU_SRLV: result <= src2 >> src1[4:0];
        ALU_XOR : result <= src1 ~| src2;
    endcase
end           

assign zero = result == 0;
assign overflow = (src1[31] & src2[31]) ^ result[31];
endmodule
