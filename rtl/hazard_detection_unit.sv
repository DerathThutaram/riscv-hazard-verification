module hazard_detection_unit (
    input  logic [4:0] id_ex_rs1,
    input  logic [4:0] id_ex_rs2,
    input  logic [4:0] id_ex_rd,
    input  logic       id_ex_MemRead,
    
    input  logic       branch_taken,

    output logic       stall,
    output logic       flush
);

    always_comb begin
        // Default control signal states
        stall = 1'b0;
        flush = 1'b0;

        // 1. Detect Load-Use Hazard
        // If the instruction in ID/EX is a Load (MemRead=1) and its destination register (rd)
        // matches either source register (rs1/rs2) of the instruction currently in IF/ID:
        if (id_ex_MemRead && ((id_ex_rd == id_ex_rs1) || (id_ex_rd == id_ex_rs2)) && (id_ex_rd != 5'b0)) begin
            stall = 1'b1;
        end

        // 2. Detect Control Hazard (Branch Taken)
        // If a branch/jump is taken, flush speculative instructions from the pipeline
        if (branch_taken) begin
            flush = 1'b1;
        end
    end

endmodule