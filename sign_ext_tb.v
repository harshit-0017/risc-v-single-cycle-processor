module sign_ext_tb;

reg [15:0] value;
wire [31:0] ext_value;

sign_ext uut (.value(value),.ext_value(ext_value));

initial begin
    $dumpfile("sign_ext.vcd");
    $dumpvars(0, sign_ext_tb);

    $monitor("value=%h ext_value=%h", value, ext_value);

    value = 16'h000A; #10;
    value = 16'h7FFF; #10;
    value = 16'h8000; #10;
    value = 16'hFFFF; #10;

    $finish;
end

endmodule
