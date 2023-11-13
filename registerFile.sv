module registerFile(
    input logic [9:0] D,
    input logic ENW, ENR0, ENR1, CLKb,
    input logic [1:0] WRA, RDA0, RDA1,
    output logic [9:0] Q0, Q1
);

    logic [3:0] Rin, Rout0, Rout1;
	 // Rin is used for write enable of each register
	 // Rout0/Rout1 used for read enable of each register for Q0 and Q1

    // Decode the write address
    dec24 write_decoder(.A(WRA), .E(ENW), .Y(Rin));

    // Decode the read addresses
    dec24 read0_decoder(.A(RDA0), .E(ENR0), .Y(Rout0));
    dec24 read1_decoder(.A(RDA1), .E(ENR1), .Y(Rout1));

    // 10-bit Registers
    trireg10 R0(.D(D), .CLKb(CLKb), .Rin(Rin[0]), .Rout(Rout0[0] | Rout1[0]), .Q(Q0));
    trireg10 R1(.D(D), .CLKb(CLKb), .Rin(Rin[1]), .Rout(Rout0[1] | Rout1[1]), .Q(Q0));
    trireg10 R2(.D(D), .CLKb(CLKb), .Rin(Rin[2]), .Rout(Rout0[2] | Rout1[2]), .Q(Q0));
    trireg10 R3(.D(D), .CLKb(CLKb), .Rin(Rin[3]), .Rout(Rout0[3] | Rout1[3]), .Q(Q0));

    // Selecting outputs for Q0 and Q1
    assign Q0 = (Rout0[0]) ? R0.Q : (Rout0[1]) ? R1.Q : (Rout0[2]) ? R2.Q : (Rout0[3]) ? R3.Q : 10'bz;
    assign Q1 = (Rout1[0]) ? R0.Q : (Rout1[1]) ? R1.Q : (Rout1[2]) ? R2.Q : (Rout1[3]) ? R3.Q : 10'bz;

endmodule

// This module integrates four 10-bit registers and 
//		manages the read and write operations. 
//		The outputs Q0 and Q1 are connected to the selected 
//			registers based on the read addresses RDA0 and RDA1




