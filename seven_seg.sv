//module declaration
module seven_seg(
	input logic [3:0] A,
	output logic [6:0] S
);
//logic
logic [15:0] Y;//assigns to Y as D assigns to A
//decoder module: implements the dec416 decoder for use here
//use buses to greater effect from now on
dec416 d1(.A(A), .Y(Y));
//hex digits: assigning the seven segment leds
assign S[0] = ~(Y[2]|Y[3]|Y[4]|Y[5]|Y[6]|Y[8]|Y[9]|Y[10]|Y[11]|Y[13]|Y[14]|Y[15]);//Sg
assign S[1] = ~(Y[0]|Y[4]|Y[5]|Y[6]|Y[8]|Y[9]|Y[10]|Y[11]|Y[12]|Y[14]|Y[15]);//Sf
assign S[2] = ~(Y[0]|Y[2]|Y[6]|Y[8]|Y[10]|Y[11]|Y[12]|Y[13]|Y[14]|Y[15]);//Se
assign S[3] = ~(Y[0]|Y[2]|Y[3]|Y[5]|Y[6]|Y[8]|Y[11]|Y[12]|Y[13]|Y[14]);//Sd
assign S[4] = ~(Y[0]|Y[1]|Y[3]|Y[4]|Y[5]|Y[6]|Y[7]|Y[8]|Y[9]|Y[10]|Y[11]|Y[13]);//Sc
assign S[5] = ~(Y[0]|Y[1]|Y[2]|Y[3]|Y[4]|Y[7]|Y[8]|Y[9]|Y[10]|Y[13]);//Sb
assign S[6] = ~(Y[0]|Y[2]|Y[3]|Y[5]|Y[6]|Y[7]|Y[8]|Y[9]|Y[10]|Y[12]|Y[14]|Y[15]);//Sa

endmodule