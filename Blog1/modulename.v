module modulename
// Port Declration
(
input wire in0, in1,
output wire out0
);
// Internal Signal Declaration
wire sig0, sig1;
// Block logic
assign out0 = sig0 & sig1;
assign sig0 = in0 & in1;
assign sig1 = ~in0 & ~in1;

initial begin
    $dumpfile("waves.vcd");
    $dumpvars;
end

endmodule