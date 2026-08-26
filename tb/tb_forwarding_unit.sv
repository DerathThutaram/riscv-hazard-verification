`timescale 1ns/1ps

module tb_forwarding_unit;

    // Testbench signals
    logic [4:0] id_ex_rs1;
    logic [4:0] id_ex_rs2;
    logic [4:0] ex_mem_rd;
    logic       ex_mem_RegWrite;
    logic [4:0] mem_wb_rd;
    logic       mem_wb_RegWrite;

    logic [1:0] forwardA;
    logic [1:0] forwardB;

    // Instantiate Forwarding Unit
    forwarding_unit dut (
        .id_ex_rs1(id_ex_rs1),
        .id_ex_rs2(id_ex_rs2),
        .ex_mem_rd(ex_mem_rd),
        .ex_mem_RegWrite(ex_mem_RegWrite),
        .mem_wb_rd(mem_wb_rd),
        .mem_wb_RegWrite(mem_wb_RegWrite),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    initial begin
        // Defaults
        id_ex_rs1 = 5'd0; id_ex_rs2 = 5'd0;
        ex_mem_rd = 5'd0; ex_mem_RegWrite = 1'b0;
        mem_wb_rd = 5'd0; mem_wb_RegWrite = 1'b0;

        #10;
        $display("--- Test Case 1: No Forwarding ---");
        id_ex_rs1 = 5'd1; id_ex_rs2 = 5'd2;
        #10;
        $display("forwardA: %b (Expected: 00) | forwardB: %b (Expected: 00)", forwardA, forwardB);

        #10;
        $display("--- Test Case 2: EX Hazard Forwarding (EX/MEM -> EX) ---");
        ex_mem_rd = 5'd1; ex_mem_RegWrite = 1'b1;
        #10;
        $display("forwardA: %b (Expected: 10) | forwardB: %b (Expected: 00)", forwardA, forwardB);

        #10;
        $display("--- Test Case 3: MEM Hazard Forwarding (MEM/WB -> EX) ---");
        ex_mem_RegWrite = 1'b0; // Clear EX hazard
        mem_wb_rd = 5'd2; mem_wb_RegWrite = 1'b1;
        #10;
        $display("forwardA: %b (Expected: 00) | forwardB: %b (Expected: 01)", forwardA, forwardB);

        #10;
        $display("--- Test Case 4: Double Hazard (EX priority over MEM) ---");
        ex_mem_rd = 5'd1; ex_mem_RegWrite = 1'b1; // EX hazard on rs1
        mem_wb_rd = 5'd1; mem_wb_RegWrite = 1'b1; // MEM hazard on rs1
        #10;
        $display("forwardA: %b (Expected: 10) | forwardB: %b (Expected: 00)", forwardA, forwardB);

        #10;
        $display("--- Forwarding Unit Verification Completed ---");
        $finish;
    end

endmodule