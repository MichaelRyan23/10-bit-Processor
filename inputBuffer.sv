module inputBuffer(
	input logic [9:0] D,
	input logic externalEnable,
	output tri [9:0] dataBus
);

	always_comb begin
		 if (externalEnable) begin
			  dataBus <= D;
		 end
		 else begin
			  dataBus <= 10'bz;
		 end
	end

endmodule
