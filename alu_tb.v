module alu_tb;
    reg [31:0] a,b;
    reg [2:0] alucontrol;
    wire [31:0] res;
    alu uut(.a(a),.b(b),.alucontrol(alucontrol),.res(res));
    
initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);

    a=32'd10;
    b=32'd20;

    alucontrol=3'b000;
    #10
    $display("ADD: %d + %d= %d",a,b,res);

    a = 32'd50; 
    b = 32'd50;
    alucontrol = 3'b001;
    #10;
    $display("SUB : %d - %d = %d", a, b, res);

    a = 32'b1; 
    b = 32'b0;
    alucontrol = 3'b010;
    #10;
    $display("AND : %b & %b = %b", a, b, res);

    a = 32'b1; 
    b = 32'b0;
    alucontrol = 3'b011;
    #10;
    $display("OR  : %b | %b = %b", a, b, res);

    a = 32'b1; 
    b = 32'b0;
    alucontrol = 3'b100;
    #10;
    $display("SLT : %d < %d = %d", a, b, res);

    a = -32'd5;
    b = 32'd3;
    alucontrol = 3'b100;
    #10;
    $display("SLT : %d < %d = %d", $signed(a), $signed(b), res);
    
    $finish;
end
endmodule