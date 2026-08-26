module id_ex_reg (
    input  logic        clk,
    input  logic        reset,
    input  logic        flush,
    input  logic        stall,

    input  logic        in_MemRead,
    input  logic        in_MemWrite,
    input  logic        in_RegWrite,
    output logic        out_MemRead,
    output logic        out_MemWrite,
    output logic        out_RegWrite,

    input  logic [4:0]  in_rs1,
    input  logic [4:0]  in_rs2,
    input  logic [4:0]  in_rd,
    output logic [4:0]  out_rs1,
    output logic [4:0]  out_rs2,
    output logic [4:0]  out_rd
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset || flush) begin
            out_MemRead  <= 1'b0;
            out_MemWrite <= 1'b0;
            out_RegWrite <= 1'b0;
            out_rs1      <= 5'b0;
            out_rs2      <= 5'b0;
            out_rd       <= 5'b0;
        end else if (!stall) begin
            out_MemRead  <= in_MemRead;
            out_MemWrite <= in_MemWrite;
            out_RegWrite <= in_RegWrite;
            out_rs1      <= in_rs1;
            out_rs2      <= in_rs2;
            out_rd       <= in_rd;
        end
    end
endmodule