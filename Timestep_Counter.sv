module upcount2(
	input logic CLR, CLKb,
	output logic [1:0] CNT
);
	controller control(.CLR(CLR));
	
	always_ff @(posedge CLR, negedge CLKb) // include CLRb for async opperation
	begin
		if(CLR) CNT <= 'b0;
		else if(CLKb) CNT <= CNT+1;
		else CNT <= CNT;
	end


endmodule
//A timestep counter counts the number of clock cycles which helps further
//control executions and calculate performance. Keeps track of the current
//time step of the current intruction execution.