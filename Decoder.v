//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
    SinExt_o,
    MemToReg_o,
    MemWrite_o,
    Jump_o,
    BranchType_o,
	);

//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output         SinExt_o;
output         MemToReg_o;
output         MemWrite_o;
output         Jump_o;
output [1:0]   BranchType_o;

reg [12:0]   countrol;

//Parameter
parameter [6-1:0] OP_RTYPE = 6'b000000;
parameter [6-1:0] OP_ADDI  = 6'b001000;
parameter [6-1:0] OP_BEQ   = 6'b000100;
parameter [6-1:0] OP_ORI   = 6'b001101;
parameter [6-1:0] OP_LW	   = 6'b100011;
parameter [6-1:0] OP_SW    = 6'b101011;
parameter [6-1:0] OP_JUMP  = 6'b000010;
parameter [6-1:0] OP_BGT   = 6'b000111;
parameter [6-1:0] OP_BNEZ  = 6'b000101;
parameter [6-1:0] OP_BGEZ  = 6'b000001;
parameter [6-1:0] OP_LUI   = 6'b001111;
parameter [6-1:0] OP_JAL   = 6'b000011;

assign {RegWrite_o, RegDst_o, ALUSrc_o, Branch_o, MemWrite_o, MemToReg_o,
        Jump_o, ALU_op_o, SinExt_o, BranchType_o} = countrol;

//Main function
always @ (*) begin
    case (instr_op_i)
        OP_RTYPE: countrol <= 13'b1100000_010_1_00;
        OP_LW   : countrol <= 13'b1010010_000_1_00;
        OP_SW   : countrol <= 13'b0010100_000_1_00;
        OP_BEQ  : countrol <= 13'b0001000_001_1_00;
        OP_ADDI : countrol <= 13'b1010000_000_1_00;
        OP_JUMP : countrol <= 13'b0000001_000_1_00;
        OP_ORI  : countrol <= 13'b1010000_011_0_00;
        OP_JAL  : countrol <= 13'b1101001_000_1_00;
        OP_BGT  : countrol <= 13'b0001000_001_1_01;
        OP_BNEZ : countrol <= 13'b0001000_001_1_11;
        OP_BGEZ : countrol <= 13'b0001000_001_1_10;
        OP_LUI  : countrol <= 13'b1010000_000_0_00;
        default : countrol <= 13'bxxxxxxx_xxx_x_xx;
    endcase
end

endmodule
