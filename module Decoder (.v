module Decoder (
	//TODO: Write input and output parameters
	
    input[1:0] op,
    input[5:0] funct,

    output MemtoReg,
    output ALUSrc,
    output[1:0] RegSrc,

    output ALUOp,
    output Svalue
    );
	
	always @(*)
	//TODO: Write code for decoder
	/* 
	(1) Data processing instruction
	(2) Load, Store instruction
	(3) Branch instruction
	*/

    //reference : https://github.com/ErickOF/Single-Cycle-ARM-Processor-FPGA/blob/master/decoder.sv
    begin
        case(op)

        //Data-procesing immediate
        2'b00: begin
            if (funct[5]) begin
                
                RegSrc = 2'b00;
                //ImmSrc = 00
                ALUSrc = 1;
                MemtoReg = 0;
                //RegW = 1
                // MemW = 0
                // Branch 0
                ALUOp = 1;

            end

            else begin
                RegSrc = 2'b00;
                //ImmSrc = 00
                ALUSrc = 0;
                MemtoReg = 0;
                //RegW = 1
                // MemW = 0
                // Branch 0
                ALUOp = 1;
            end
            
        end
        
        //LDR + STR
        2'b01: begin
            if (funct[0]) begin //ldr

                RegSrc = 2'b00;
                //ImmSrc = 01
                ALUSrc = 1;
                MemtoReg = 1;
                //RegW = 1
                // MemW = 0
                // Branch 0
                ALUOp = 0;

            end

            else begin //str
                RegSrc = 2'b10;
                //ImmSrc = 01
                ALUSrc = 1;
                MemtoReg = 1; //
                //RegW = 0
                // MemW = 1
                // Branch 0
                ALUOp = 0;
            end

        end

        //B 혹은 BL..
        2'b10: begin

            if (funct[4]) begin //BL
                RegSrc = 2'b01;
                //ImmSrc = 10
                ALUSrc = 1;
                MemtoReg = 0;//'bx?
                //RegW = 0
                // MemW = 0
                // Branch 1
                ALUOp = 0;
            end

            else begin //B
                RegSrc = 2'b01;
                //ImmSrc = 10
                ALUSrc = 1;
                MemtoReg = 0; //'bx
                //RegW = 0
                // MemW = 0
                // Branch 1
                ALUOp = 0;
            end

        end

        default: begin

            RegSrc = 2'bx;
            //ImmSrc = 2'bx;
            ALUSrc = 'bx;
            MemtoReg = 'bx;
            //RegW = 'bx
            // MemW = 'bx
            // Branch 'bx
            ALUOp = 'bx;
        end

        endcase
    end

endmodule