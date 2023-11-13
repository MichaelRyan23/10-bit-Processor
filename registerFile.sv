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

/* This module integrates four 10-bit registers and 
//		manages the read and write operations. 
//		The outputs Q0 and Q1 are connected to the selected 
//			registers based on the read addresses RDA0 and RDA1

Conditional Operator (?:): The ?: is a ternary operator in Verilog,
working as a shorthand for if-else statements. It follows the form:
	condition ? value_if_true : value_if_false.

Rout0 and Rout1 are 4-bit signals that determine which register's output 
should be connected to Q0 and Q1, respectively. 
Each bit in Rout0 and Rout1 corresponds to one of the four registers (R0, R1, R2, R3).

For Q0: The statement checks each bit of Rout0 sequentially.
If Rout0[0] is true (i.e., the first register is selected for read), Q0 is assigned R0.Q (the output of R0).
If Rout0[0] is false, it checks Rout0[1], and so on until Rout0[3].
If none of the Rout0 bits are true (meaning no register is selected for read), 
	Q0 is set to high-impedance (10'bz), effectively disconnecting it.
For Q1: The same logic applies, but it uses Rout1 to determine the register connected to Q1.

 (10'bz): If none of the enable signals are active for a given output (Q0 or Q1), 
 that output is set to a high-impedance state to avoid driving any value on the bus and to prevent contention.




