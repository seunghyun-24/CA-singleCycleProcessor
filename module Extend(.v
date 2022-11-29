module Extend( /*TODO: Declare variables of inputs and output for multiplexer*/
	
	input[23:0] inst, 
	input[1:0] ImmSrc, 
	output[31:0] ExtImm 
	);
	
	always @ (*)

	begin
		case(ImmSrc) /*TODO: Write on Variable name to distinguish various cases*/
		/*TODO: Case 1*/
		2'b00: begin // zero extended-imm8
			//TODO: Write actions to run when (Variable) == (Case 1).
			ExtImm = {24'b0, Instr[7:0]};
		end
		
		/*TODO: Case 2*/
		2'b01: begin //zero extended-imm12
			//TODO: Write actions to run when (Variable) == (Case 2).
			ExtImm = {20'b0, Instr[11:0]};
		end
		
		/*TODO: Case 3*/
		2'b10: begin //sign-extended-imm24, shifting left two bits
			//TODO: Write actions to run when (Variable) == (Case 3).
			ExtImm = {{6{Instr[23]}}, Instr[23:0], 2'b00};
		end
		
		default:
			//TODO: Assign the default value to output variable
			ExtImm = 32'bx;
		endcase
	end

endmodule
