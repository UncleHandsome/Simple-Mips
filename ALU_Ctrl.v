//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o,
          IndirectJump_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
output     IndirectJump_o;
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
parameter [6-1:0] FUNC_ADD = 6'b100000;
parameter [6-1:0] FUNC_SUB = 6'b100010;
parameter [6-1:0] FUNC_AND = 6'b100100;
parameter [6-1:0] FUNC_OR  = 6'b100101;
parameter [6-1:0] FUNC_SLT = 6'b101010;
parameter [6-1:0] FUNC_SLLV= 6'b000100;
parameter [6-1:0] FUNC_SLL = 6'b000000;
parameter [6-1:0] FUNC_SRLV= 6'b000110;
parameter [6-1:0] FUNC_SRL = 6'b000010;
parameter [6-1:0] FUNC_MUL = 6'b011000;
parameter [6-1:0] FUNC_JR  = 6'b001000;

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
       
//Select exact operation
always @ (*) begin
    case (ALUOp_i)
        3'b000: ALUCtrl_o <= 4'b0010; // add (for addi)
        3'b001: ALUCtrl_o <= 4'b0110; // sub (for beq)
        3'b010: case(funct_i) // R-type instruction
            FUNC_ADD : ALUCtrl_o <= ALU_ADD;
            FUNC_SUB : ALUCtrl_o <= ALU_SUB;
            FUNC_AND : ALUCtrl_o <= ALU_AND;
            FUNC_OR  : ALUCtrl_o <= ALU_OR;
            FUNC_SLT : ALUCtrl_o <= ALU_SLT;
            FUNC_SLL : ALUCtrl_o <= ALU_SLL;
            FUNC_SLLV: ALUCtrl_o <= ALU_SLLV;
            FUNC_SRL : ALUCtrl_o <= ALU_SRL;
            FUNC_SRLV: ALUCtrl_o <= ALU_SRLV;
            FUNC_MUL : ALUCtrl_o <= ALU_MUL;
            FUNC_JR  : ALUCtrl_o <= ALU_ADD; // Add 0
            default:   ALUCtrl_o <= 4'bxxxx;
        endcase
        3'b011: ALUCtrl_o <= 4'b0001; // or (for ori)
    endcase
end

assign IndirectJump_o = (ALUOp_i == 3'b010) & (funct_i == FUNC_JR);

endmodule     





                    
                    
