module alu(
    input [31:0] a,b,
    input [2:0] alucontrol,

    output reg [31:0] res
);
always @(*) begin
    case (alucontrol)
        3'b000: res=a+b; 
        3'b001: res=a-b;
        3'b010: res=a&b;
        3'b011: res=a|b;
        3'b100: res=($signed(a)<$signed(b)) ? 32'd1 : 32'd0;
        default: res=32'b0;
    endcase
end
endmodule