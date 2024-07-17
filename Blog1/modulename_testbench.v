`timescale 1ns/10ps

module modulename_testbench;
    reg test_in0, test_in1;
    wire test_out;

    modulename uut(.in0(test_in0), .in1(test_in1), .out0(test_out));

    initial begin
        $dumpfile("sample.vcd");
        $dumpvars(0, modulename_testbench);
        // Test Vector
        test_in0 = 1'b0;
        test_in1 = 1'b0;
        // Wait time
        # 100;
        test_in0 = 1'b1;
        test_in1 = 1'b0;
        # 100;
        test_in0 = 1'b0;
        test_in1 = 1'b1;
        # 100;
        test_in0 = 1'b1;
        test_in1 = 1'b1;
        # 100;
        $finish();
    end

endmodule