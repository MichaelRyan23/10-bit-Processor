module controller(
    input logic [9:0] INSTR, // 10-bit instruction
    input logic [1:0] T,     // Timestep
    output logic [9:0] IMM,  // Immediate value
    output logic [1:0] Rin, Rout, // Register addresses
    output logic ENW, ENR, // Enable signals for the register file
    output logic Ain, Gin, Gout, // ALU intermediate signals
    output logic [3:0] ALUcont, // ALU operation control
    output logic Ext, IRin, // External data and instruction register inputs
    output logic Clr // Counter clear signal
);

// Instruction
    logic [1:0] opcode, regX, regY;
    // logic [5:0] immValue;

    // Decode instruction fields
    always_comb begin
        opcode = INSTR[9:8];
        regX = INSTR[7:6];
        regY = INSTR[5:4];
        // immValue = INSTR[5:0];
    end
	 
	 always_comb begin
		case(opcode)
			2'b00: begin
				case(INSTR[3:0])
					4'b0000: begin			// load
						if(T == 2'b00) begin
							Ext = 1'b1;		// enable external data to bus
							IRin = 1'b1;	// enable IR instruction
						end
						if(T == 2'b01) begin
							ENW = 1'b1;		// enable write to register file	
							Rin = regX;		// loading regX
						end
					end
					4'b0001: begin			// copy
						if(T == 2'b00) begin
							Rout = regY;
							ENR = 1'b1;
						end
						if(T == 2'b01) begin
							Rin = regX;
							ENW = 1'b1;
						end
					end
					4'b0010: begin			// add
						if(T == 2'b00) begin
						end
					end
						
					4'b0011: begin			// subtract
						if(T == 2'b00) begin
						end
					end
						
					4'b0100: begin			// invert: RX <- -RY
						if(T == 2'b00) begin
						end
					end
						
					4'b0101: begin			// flip: RX <- ~RY
						if(T == 2'b00) begin
						end
					end
						
					4'b0110: begin			// AND
						if(T == 2'b00) begin
						end
					end
						
					4'b0111: begin			// OR
						if(T == 2'b00) begin
						end
					end
						
					4'b1000: begin			// XOR
						if(T == 2'b00) begin
						end
					end
						
					4'b1001: begin			// lsl: logical shift left
						if(T == 2'b00) begin
						end
					end
						
					4'b1010: begin			// lsr: logical shift right
						if(T == 2'b00) begin
						end
					end
	 
					4'b1011: begin			// asr: Arithmatic shift right
						if(T == 2'b00) begin
						end
					end
					default;
				endcase
			
			//2'b01: begin 
				
			
			end
			
		endcase
		
	 end
	 
endmodule




