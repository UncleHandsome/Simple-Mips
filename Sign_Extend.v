//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    select_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
input   select_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always @ (*) begin
    if (select_i) data_o <= { {16{data_i[15]}}, data_i[15:0] };
    else data_o <= { {16{1'b0}}, data_i[15:0] };
end
          
endmodule      
     
