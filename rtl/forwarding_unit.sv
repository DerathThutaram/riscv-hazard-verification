module forwarding_unit (
    // Source registers used by current instruction in EX stage
    input  logic [4:0] id_ex_rs1,
    input  logic [4:0] id_ex_rs2,
    
    // Destination register & write flag from EX/MEM stage
    input  logic [4:0] ex_mem_rd,
    input  logic       ex_mem_RegWrite,
    
    // Destination register & write flag from MEM/WB stage
    input  logic [4:0] mem_wb_rd,
    input  logic       mem_wb_RegWrite,
    
    // Mux select lines for ALU inputs (00: RegFile, 10: EX/MEM, 01: MEM/WB)
    output logic [1:0] forwardA,
    output logic [1:0] forwardB
);

    always_comb begin
        // Default: No forwarding (use register file output)
        forwardA = 2'b00;
        forwardB = 2'b00;

        // 1. EX Hazard: Forward from EX/MEM pipeline register
        if (ex_mem_RegWrite && (ex_mem_rd != 5'b00000) && (ex_mem_rd == id_ex_rs1)) begin
            forwardA = 2'b10;
        end
        if (ex_mem_RegWrite && (ex_mem_rd != 5'b00000) && (ex_mem_rd == id_ex_rs2)) begin
            forwardB = 2'b10;
        end

        // 2. MEM Hazard: Forward from MEM/WB pipeline register
        // (Only if EX hazard is not active for the same register)
        if (mem_wb_RegWrite && (mem_wb_rd != 5'b00000) && 
           !(ex_mem_RegWrite && (ex_mem_rd != 5'b00000) && (ex_mem_rd == id_ex_rs1)) &&
            (mem_wb_rd == id_ex_rs1)) begin
            forwardA = 2'b01;
        end

        if (mem_wb_RegWrite && (mem_wb_rd != 5'b00000) && 
           !(ex_mem_RegWrite && (ex_mem_rd != 5'b00000) && (ex_mem_rd == id_ex_rs2)) &&
            (mem_wb_rd == id_ex_rs2)) begin
            forwardB = 2'b01;
        end
    end

endmodule