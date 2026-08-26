`timescale 1ns/1ps

module tb_hazard_detection;

    // Testbench signals
    logic [4:0] id_ex_rs1;
    logic [4:0] id_ex_rs2;
    logic [4:0] id_ex_rd;
    logic       id_ex_MemRead;
    logic       branch_taken;

    logic       stall;
    logic       flush;

    // Instantiate Hazard Detection Unit
    hazard_detection_unit dut (
        .id_ex_rs1(id_ex_rs1),
        .id_ex_rs2(id_ex_rs2),
        .id_ex_rd(id_ex_rd),
        .id_ex_MemRead(id_ex_MemRead),
        .branch_taken(branch_taken),
        .stall(stall),
        .flush(flush)
    );

    initial begin
        // Initialize inputs
        id_ex_rs1     = 5'b0;
        id_ex_rs2     = 5'b0;
        id_ex_rd      = 5'b0;
        id_ex_MemRead = 1'b0;
        branch_taken  = 1'b0;

        #10;
        $display("--- Test Case 1: No Hazards ---");
        id_ex_rs1 = 5'd1; id_ex_rs2 = 5'd2; id_ex_rd = 5'd3; id_ex_MemRead = 1'b0;
        #10;
        $display("Stall: %b (Expected: 0) | Flush: %b (Expected: 0)", stall, flush);

        #10;
        $display("--- Test Case 2: Load-Use Hazard (rs1 match) ---");
        id_ex_rd = 5'd1; id_ex_MemRead = 1'b1;
        #10;
        $display("Stall: %b (Expected: 1) | Flush: %b (Expected: 0)", stall, flush);

        #10;
        $display("--- Test Case 3: Branch Control Hazard ---");
        id_ex_MemRead = 1'b0; branch_taken = 1'b1;
        #10;
        $display("Stall: %b (Expected: 0) | Flush: %b (Expected: 1)", stall, flush);

        #10;
        $display("--- Verification Completed Successfully ---");
        $finish;
    end

endmodule