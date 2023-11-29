module ALU(
	input logic [9:0] OP,
	input logic [3:0] FN,
	input logic Ain, Gin, Gout, CLKb,
	output logic [9:0] Q
);
	logic [9:0]Temp;
	logic [9:0]_Q;
	logic [9:0]_G;
	
	always_comb
	begin
		case(FN)
			4'b0000: _Q = OP;//load
			4'b0001: _Q = Temp;//copy
			4'b0010: _Q = OP + Temp;//add
			4'b0011:	_Q = OP - Temp;//sub
			4'b0100: _Q = -Temp;//inverse
			4'b0101: _Q = ~Temp;//flip
			4'b0110: _Q = OP & Temp;//and
			4'b0111: _Q = OP | Temp;//or
			4'b1000: _Q = OP ^ Temp;//xor
			4'b1001: _Q = OP << 1;//Logical shift left
			4'b1010: _Q = OP >> 1;//Logical shift right
			4'b1011: _Q = OP >>> 1;//Arithmetic shift right
			4'b1100: _Q = OP + Temp;//addi
			4'b1101: _Q = OP - Temp;//subi
			default: _Q = 10'b0;//default to handle exeptions.
		endcase
	end
	
	always_ff @(negedge CLKb)
	begin
		if(Ain) 
		begin
			Temp <= OP;
		end
		if(Gin) 
		begin
			_G <= _Q;
		end
		if(Gout) //maybe change to always_comb
		begin
			trireg10(.D(_G), .CLKb(CLKb), .Rin(Gout), .Rout(Gout), .Q(Q));
		end
	end
	
endmodule