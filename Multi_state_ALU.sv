module ALU(
	input logic [9:0] OP,
	input logic [3:0] FN,
	input logic Ain, Gin, Gout, CLKb,
	output logic [9:0] Q
);
	logic [9:0]Temp;
	logic [9:0]_Q;
	logic [9:0]_G;
	always_ff @(negedge CLKb)
	begin
		if(Ain) 
		begin
			Temp <= OP;
			case(FN)
				4'b0001: _Q = OP + Temp;
				4'b0010:	_Q = OP - Temp;
				4'b0100: _Q = OP & Temp;
				4'b1000: _Q = OP | Temp;
				default: _Q = 10'b0;//default to handle exeptions.
			endcase
		end
		if(Gin) 
		begin
			_G <= _Q;
		end
		if(Gout) trireg10(.D(_G), .CLKb(CLKb), .Rin(Gout), .Rout(Gout), .Q(Q));
	end
	
endmodule