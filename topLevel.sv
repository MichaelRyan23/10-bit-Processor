module topLevel(
	input logic [9:0] D,
	input logic CLK50M,
	input logic peek,
	input logic CLK,
	
	output logic [9:0] bus,			// LEDs for current value on data bus
	output logic [6:0] DHEX0,
	output logic [6:0] DHEX1,
	output logic [6:0] DHEX2
	output logic [6:0] THEX,		// Timestep
	output logic done //belived to be LED_D
);

	logic CLKb;							// debounced clock signal
	logic irEN;							// controller IR enabler
	logic extEN;						// controller ext enabler
	logic peekb;						// debounced peek button
	logic Clr;							// clear signal
	logic [9:0] IR_instruction;	// from IR to controller
	logic [1:0] timestep;			// from counter to controller
	logic [9:0] Q1_regFile;			// from regFile to output logic
	wire [9:0] dataBus;				// shared bus
	
	logic [1:0] last_2_bits;		// last 2 bits that feed into regFile RDA1
	last_2_bits = D[1:0];
	
	// controller to regFile
	logic [1:0] Rin_WRA;
	logic [1:0] Rout_RDA0;
	logic ENW_ENW;
	logic ENR_ENR0;
	
	// controller to ALU
	logic Ain_Ain;
	logic Gin_Gin;
	logic Gout_Gout;
	logic ALUcont_FN;
	
	// debouncing clock signal
	debouncer dbCLK(		
		.A_noisy(CLK),
		.CLK50M(CLK50M),
		.A(CLKb)
	);
	
	// debouncing peek signal
	debouncer dbPK(
		.A_noisy(peek),
		.CLK50M(CLK50M),
		.A(peekb)
	);
	
	insRegister IR_reg(
		.D(dataBus),
		.EN(irEN),
		.CLKb(CLKb),
		.Q(IR_instruction)
	);
	
	upcount2 counter(
		.CLR(Clr),
		.CLKb(CLKb),
		.CNT(timestep)
	);
	
	controller brains(
		.INSTR(IR_instruction),
		.T(timestep),
		.IMM(dataBus),
		.Rin(Rin_WRA),
		.Rout(Rout_RDA0),
		.ENW(ENW_ENW),
		.ENR(ENR_ENR0),
		.Ain(Ain_Ain),
		.Gin(Gin_Gin),
		.Gout(Gout_Gout),
		.ALUcont(ALUcont_FN),
		.Ext(extEN),
		.IRin(irEN),
		.Clr(Clr)
	);

	registerFile regFile(
		.D(dataBus),
		.WRA(Rin_WRA),
		.RDA0(Rout_RDA0),
		.RDA1(last_2_bits),
		.ENW(ENW_ENW),
		.ENR0(ENR_ENR0),
		.ENR1(1'b1),
		.CLKb(CLKb),
		.Q0(dataBus),
		.Q1(Q1_regFile),
	);

	ALU alu(
		.OP(dataBus),
		.FN(ALUcont_FN),
		.Ain(Ain_Ain),
		.Gin(Gin_Gin),
		.Gout(Gout_Gout),
		.CLKb(CLKb),
		.Q(data_bus)
	);
	
	output_logic(
		.BUS(data_bus),
		.REG(Q1_regFile),
		.TIME(timestep),
		.PEEKb(peek),
		.DONE(Clr),
		.LED_B(bus),
		.DHEX0(DHEX0),
		.DHEX1(DHEX1),
		.DHEX2(DHEX2),
		.THEX(THEX),
		.LED_D(done)
	);
	
endmodule
