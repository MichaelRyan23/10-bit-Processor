module dec24(
    input logic [1:0] A,
    input logic E,
    output logic [3:0] Y
);
    assign Y = E ? (1'b1 << A) : 4'b0;
endmodule

// This module decodes a 2-bit input into 
// 	one of four outputs, enabling one of 
// 		the registers based on the address.
//
//
