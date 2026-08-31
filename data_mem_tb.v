module data_mem_tb;
    reg clk,wen;
    reg [31:0] a;
    reg [31:0] wd;
    wire [31:0] rd;

    #10 clk=~clk;
    data_mem uut(.clk(clk),.a(a),.wd(wd),.rd(rd));
    initial begin
        $dumpfile("data_mem.vcd");
        $dumpvars(0,data_mem_tb);
        
    end
endmodule