module output_logic(
	input logic [9:0]BUS,
	input logic [9:0]REG,
	input logic [1:0]TIME,
	input logic PEEKb,
	input logic DONE,
	output logic [9:0]LED_B,
	output logic [6:0]DHEX0,
	output logic [6:0]DHEX1,
	output logic [6:0]DHEX2,
	output logic [6:0]THEX,
	output logic LED_D
);
	
	logic [3:0]BUS0, BUS1, BUS2;
	logic [3:0]REG0, REG1, REG2;
	
	assign LED_B = BUS;
	always_comb
	begin
		if(PEEKb)
		begin
			assign BUS0 = BUS[3:0];
			assign BUS1 = BUS[8:4];
			assign BUS2 = BUS[9];
		end
		else
		begin
			assign BUS0 = REG[3:0];
			assign BUS1 = REG[8:4];
			assign BUS2 = REG[9];
		end
		if(DONE) LED_D = 1;
		else LED_D = 0;
	end	
	seven_seg hex0(.A(BUS0), .S(DHEX0));//seven segs will need to be changed if we use yours
	seven_seg hex1(.A(BUS1), .S(DHEX1));//which considering you have a lot of the code we should do that
	seven_seg hex2(.A(BUS2), .S(DHEX2));//unsure if this will work. sorry
	seven_seg hex6(.A(TIME), .S(THEX));
	

endmodule