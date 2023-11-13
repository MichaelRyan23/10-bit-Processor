module trireg10(
    input logic [9:0] D,
    input logic CLKb, Rin, Rout,
    output logic [9:0] Q
);
    // Write operation
    always_ff @(posedge CLKb) begin
        if (Rin) begin
            Q <= D;
        end
    end

    // Read operation (combinational with tri-state output)
    assign Q = Rout ? Q : 10'bz;
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














