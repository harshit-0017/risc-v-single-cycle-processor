module data_mem (
    input wire clk,
    input wire wen,            // Write Enable signal (Main Control Unit ke 'MemWrite' se aayega)
    input wire [31:0] a,      // 32-bit Address (ALU ke result se aayega)
    input wire [31:0] wd,     // 32-bit Write Data (Register File ke 'rt' se aayega)
    output reg [31:0] rd      // 32-bit Read Data (Wapas Register File mein jayega)
);

    reg [31:0] RAM [0:63];

    always @(*) begin
        rd = RAM[a[31:2]]; 
    end

    always @(posedge clk) begin
        if(wen) RAM[a[31:2]]<=wd;
    end

endmodule