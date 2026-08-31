module inst_mem (
    input wire [31:0] a,      // 32-bit Address input from PC
    output reg [31:0] rd      // 32-bit Read Data (The Instruction)
);
    reg [31:0] RAM [0:63];

    
    initial begin
        $readmemh("program.hex", RAM);
    end

    always @(*) begin
        rd = RAM[a[31:2]]; 
    end

endmodule