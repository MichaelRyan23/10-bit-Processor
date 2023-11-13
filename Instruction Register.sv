module insRegister(
    input logic [9:0] D,    // 10-bit data input
    input logic EN, CLKb,   // Enable and clock signals
    output logic [9:0] Q    // 10-bit data output
);

    // On the falling edge of the clock, if enable is high, update the output Q
    always_ff @(negedge CLKb) begin
        if (EN) begin
            Q <= D;
        end
    end

endmodule
