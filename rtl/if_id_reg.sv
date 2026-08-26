module if_id_reg (
    input  logic        clk,
    input  logic        reset,
    input  logic        flush,      // Clears instruction on branch/jump
    input  logic        stall,      // Pauses instruction on hazard

    input  logic [31:0] in_pc,
    input  logic [31:0] in_instr,
    output logic [31:0] out_pc,
    output logic [31:0] out_instr
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset || flush) begin
            out_pc    <= 32'b0;
            out_instr <= 32'h00000013; // NOP (addi x0, x0, 0)
        end else if (!stall) begin
            out_pc    <= in_pc;
            out_instr <= in_instr;
        end
    end
endmodule