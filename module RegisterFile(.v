module RegisterFile(
	input clk, 
	input reset, 
	/*TODO: Declare input and output parameters in order to write & read register*/
	input we, //(RegWrite), 
	input RegSrc, //(RegSrc), 
	input addr1, //(ReadAddr1), 
	input addr2, //(ReadAddr2), 
	input addr3, //(WriteAddr),
	input waddr, //(WriteAddr), 
	input wdata, //(Result), 
	input pcin, //(NextPC), 
	
	output data1, //(ReadData1), 
	output data2, //(ReadData2), 
	output data3, //(ReadData3), 
	output pcout //(pctmp)
	);
	
	reg[31:0] register[15:0];
	reg[31:0] pcregister;

	//Write to register file
	always @ (negedge clk)
	begin
		if (reset)
		begin
			/*TODO: Write actions when reset button is clicked*/
			for(idx=0; idx<=14; idx=idx+1) register[idx] = 'h00000000;
		end
		
		else //When reset button isn't clicked,
		begin
			if(we/*TODO: Condition 1*/)
			begin
				//TODO: Write actions to run when the Condition 1 is met
				if((RegSrc[0] != 1'b1) && ( ??? == 1'b1) && (waddr != 4'd15))
					registers[waddr] = wdata;
				else registers[14] = pcregister + 'd4;
			end
			
			if(waddr != 4'b1111 || RegSrc[0] == 1'b1 /*TODO: Condition 2*/)
				//TODO: Write action to run when the Condition 2 is met
				registers[15] = pcin;
		end
	end
	
	//Read from register file
	always @ (posedge clk)
	begin
		if (reset)
		begin
			//TODO: Write actions when reset button is clicked
			data1 <= 'h00000000;
			data2 <= 'h00000000;
		end
		
		else 
		begin
			if(addr1 == 15 /*TODO: Condition 3*/)
			begin
				//TODO: Write actions to run when the Condition 3 is met
				data1 = pcregister + 32'd8;
			end
			else
			begin
				//TODO: Write actions to run when the Condition 3 is NOT met
				data1 = register[addr1];
			end
			
			if(addr2 == 15/*TODO: Condition 4*/)
			begin
				//TODO: Write actions to run when the Condition 4 is met
				data2 = pcregister + 32'd8;
			end
			else
			begin
				//TODO: Write actions to run when the Condition 4 is NOT met
				if (RegSrc[1] == 1'b0 /*TODO: Condition 5*/)
					//TODO: Write actions to run when the Condition 5 is met
					data2 = registers[addr2];
				else
					//TODO: Write actions to run when the Condition 5 is NOT met
					data2 = registers[waddr];
			end
			if(add3 == 15/*Condition 6*/)
			begin
				//TODO: Write actions to run when the Condition 6 is met
				data3 = pcregister + 32'd8;
			end
			else
			begin
				//TODO: Write actions to run when the Condition 6 is NOT met
				data3 = registers[addr3];
			end
		end

		// if ((addr  4'b1111 || RegSrc[0] == 1'b1) && (PC_Stall == 1'b0)) pcregister = pcin;
	
	assign data1 = (reset == 1'b1) ? 'h00000000 :
		(addr1 == 15) ? pcregister + 32'd8 : registers[addr1];

	assign data2 = (reset == 1'b1) ? 'h00000000 :
		(addr2 == 15) ? pcregister + 32'd8 :
		(RegSrc[1] == 1'b0) ? registers[addr2] : registers[waddr];

	assign data3 = (addr3 == 15) ? pcregister + 32'd8 : registers[addr3];

	always @ (posedge clk) begin
		if ((waddr != 4'b1111 || RegSrc[0] == 1'b1) && (PC_Stall == 1'b0)) pcregister = pcin;
	end

	end
	
endmodule
