module inst_mem_tb;

reg [31:0] a;
wire [31:0] rd;

inst_mem uut (
    .a(a),
    .rd(rd)
);

initial begin
    $dumpfile("inst_mem.vcd");
    $dumpvars(0, inst_mem_tb);

    $monitor("a=%d rd=%h", a, rd);

    a = 32'd0;   #10;
    a = 32'd4;   #10;
    a = 32'd8;   #10;
    a = 32'd12;  #10;
    a = 32'd16;  #10;

    $finish;
end

endmodule