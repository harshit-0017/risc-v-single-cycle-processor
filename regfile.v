module regfile (
    input clk, wen,
    input [4:0] ra1,ra2,wa,
    input [31:0] wd,
    output [31:0] rd1,rd2
);
    reg [31:0] registers [31:0]; // 32 register , each of 32 bit wide

    integer i;// sare reg ko 0 karne ke liye (optional)
    initial begin
    for(i = 0; i < 32; i = i + 1)
        registers[i] = 32'b0;
    end
    assign rd1 = registers[ra1];
    assign rd2 = registers[ra2];

    always @(posedge clk) begin
        if(wen && (wa!=5'b0)) begin
            registers[wa]<=wd;
        end        
    end
endmodule