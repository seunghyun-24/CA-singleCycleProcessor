module ConditionalLogic (
	//TODO: Write input and output parameters

    input[1:0] op,
    input[5:0] funct,
    input[3:0] cond,
    input Zero,

    output PCSrc,
    output RegWrite,
    output MemWrite
	);
	
	always @(*)
    //TODO: Write code for the three cases like below
	/* 
	(1) Data processing instruction 
	(2) Load, Store instruction
	(3) Branch instruction
	*/

    begin
        case(op)

        //Data-procesing instruction : ADD, SUB, CMP, MOV
        2'b00: begin
            if (funct[5]) begin // [25]가 I 값인가 그런데.. 이거 CMP나 MOV ?

                PCSrc = 0;
                RegWrite = 1;
                MemWrite = 0;

            end

            else begin //R-type 특인데..
                
                PCSrc = 0;
                RegWrite = 1;
                MemWrite = 0;

            end
            
        end
        
        //LDR or STR
        2'b01: begin
            if (funct[0]) begin // 1이면 LDR ([20])
                PCSrc = 0;
                RegWrite = 1;
                MemWrite = 0;
            end

            else begin // 0이면 STR
                PCSrc = 0;
                RegWrite = 0;
                MemWrite = 1;
            end

        end

        //B or BL..?
        2'b10: begin
            //L bitsms [24]
            //L bit가 0이면 B
            //L bit가 1이면 pc 업데이트 하고 뭘 더 저장을 함..
            // B ? 일단 Z == 1이면 equal
            
            if (funct[4]) begin //BL
                PCSrc = 1; //
                RegWrite = 0;
                MemWrite = 0;
            end

            else begin //B
                PCSrc = 1; 
                RegWrite = 0;
                MemWrite = 0;
            end

        end

        default: begin
            PCSrc = 0;
            RegWrite = 0;
            MemWrite = 0;

        end

        endcase
    end

	
endmodule