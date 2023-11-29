module trireg10(
    input logic [9:0] D,
    input logic CLKb, Rin, Rout,
    output tri [9:0] Q
);
    logic [9:0] internal_Q; // Internal register to hold the value

    // Write operation on positive clock edge
    always_ff @(negedge CLKb) begin
        if (Rin) begin
            internal_Q <= D; // Load D into internal register when Rin is high
        end
    end

    // Tri-state control for output
    assign Q = Rout ? internal_Q : 10'bz; // Drive Q with internal_Q when Rout is high, otherwise high impedance

endmodule

/*
z: This is the actual value being assigned to the 10-bit number. 
In Verilog, z represents a high-impedance state. It's used in digital circuit design 
to indicate that a line is effectively disconnected from the circuit.
This state is neither 0 (low) nor 1 (high); it's as if the line is not driving any value.

In a tri-state bus or signal context, where multiple components
can drive the value on the same line, the z state is crucial. 
It allows a component to "disconnect" itself from the bus, ensuring that it does not 
interfere with other components that might be driving a value on the bus. 
When all components connected to a bus are in the high-impedance state (z), 
the bus itself is in a high-impedance state.

For instance, in a register file, when a particular register is not selected for reading,
its output is set to 10'bz. This means that the register disconnects itself from the output bus, 
allowing other registers to drive their values onto the bus without contention.














