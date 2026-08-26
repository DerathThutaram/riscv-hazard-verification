module ex_mem_reg (
    input  logic        clk,
    input  logic        reset,

    input  logic        in_MemRead,
    input  logic        in_MemWrite,
    input  logic        in_RegWrite,
    output logic        out_MemRead,
    output logic        out_MemWrite,
    output logic        out_RegWrite,

    input  logic [31:0] in_alu_result,
    input  logic [31:0] in_write_data,
    input  logic [4:0]  in_rd,
    output logic [31:0] out_alu_result,
    output logic [31:0] out_write_data,
    output logic [4:0]  out_rd
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out_MemRead    <= 1'b0;
            out_MemWrite   <= 1'b0;
            out_RegWrite   <= 1'b0;
            out_alu_result <= 32'b0;
            out_write_data <= 32'b0;
            out_rd         <= 5'b0;
        end else begin
            out_MemRead    <= in_MemRead;
            out_MemWrite   <= in_MemWrite;
            out_RegWrite   <= in_RegWrite;
            out_alu_result <= in_alu_result;
            out_write_data <= in_write_data;
            out_rd         <= in_rd;
        end
    end
endmodule