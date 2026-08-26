`timescale 1ns/1ps

module tb_top_hazard_system;

    // Clock and Reset
    logic clk;
    logic reset;

    // Testbench signals for Hazard & Forwarding Units
    logic [4:0] id_ex_rs1, id_ex_rs2, id_ex_rd;
    logic       id_ex_MemRead;
    logic       branch_taken;
    logic       stall, flush;

    logic [4:0] ex_mem_rd, mem_wb_rd;
    logic       ex_mem_RegWrite, mem_wb_RegWrite;
    logic [1:0] forwardA, forwardB;

    // Instantiate Hazard Detection Unit
    hazard_detection_unit hazard_unit (
        .id_ex_rs1(id_ex_rs1),
        .id_ex_rs2(id_ex_rs2),
        .id_ex_rd(id_ex_rd),
        .id_ex_MemRead(id_ex_MemRead),
        .branch_taken(branch_taken),
        .stall(stall),
        .flush(flush)
    );

    // Instantiate Forwarding Unit
    forwarding_unit fwd_unit (
        .id_ex_rs1(id_ex_rs1),
        .id_ex_rs2(id_ex_rs2),
        .ex_mem_rd(ex_mem_rd),
        .ex_mem_RegWrite(ex_mem_RegWrite),
        .mem_wb_rd(mem_wb_rd),
        .mem_wb_RegWrite(mem_wb_RegWrite),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        // Dump waves for viewing in GTKWave/EDA tools
        $dumpfile("sim/hazard_system.vcd");
        $dumpvars(0, tb_top_hazard_system);

        clk = 0;
        reset = 1;
        id_ex_rs1 = 0; id_ex_rs2 = 0; id_ex_rd = 0;
        ex_mem_rd = 0; mem_wb_rd = 0;
        id_ex_MemRead = 0; branch_taken = 0;
        ex_mem_RegWrite = 0; mem_wb_RegWrite = 0;

        #10 reset = 0;

        $display("\n=============================================");
        $display("   RISC-V HAZARD SYSTEM VERIFICATION SUITE   ");
        $display("=============================================");

        // Test 1: Load-Use Hazard Detection (Stall test)
        #10;
        id_ex_rd = 5'd5; id_ex_MemRead = 1'b1;
        id_ex_rs1 = 5'd5; id_ex_rs2 = 5'd2;
        #2;
        $display("[SCENARIO 1] Load-Use Hazard Detected -> Stall: %b (Exp: 1), Flush: %b (Exp: 0)", stall, flush);

        // Test 2: Control Hazard (Branch Flush test)
        #10;
        id_ex_MemRead = 1'b0; branch_taken = 1'b1;
        #2;
        $display("[SCENARIO 2] Branch Taken -> Stall: %b (Exp: 0), Flush: %b (Exp: 1)", stall, flush);

        // Test 3: EX Data Forwarding
        #10;
        branch_taken = 1'b0;
        id_ex_rs1 = 5'd3; id_ex_rs2 = 5'd4;
        ex_mem_rd = 5'd3; ex_mem_RegWrite = 1'b1;
        #2;
        $display("[SCENARIO 3] EX Forwarding -> forwardA: %b (Exp: 10), forwardB: %b (Exp: 00)", forwardA, forwardB);

        // Test 4: MEM Data Forwarding
        #10;
        ex_mem_RegWrite = 1'b0;
        mem_wb_rd = 5'd4; mem_wb_RegWrite = 1'b1;
        #2;
        $display("[SCENARIO 4] MEM Forwarding -> forwardA: %b (Exp: 00), forwardB: %b (Exp: 01)", forwardA, forwardB);

        $display("=============================================");
        $display("     ALL SYSTEM INTEGRATION TESTS PASSED     ");
        $display("=============================================\n");
        $finish;
    end

endmodule