module main_cu(
    input [5:0] opcode,
    output reg RegDst, ALUSrc, MemtoReg, RegW,MemW,Branch,
    output reg [1:0] ALUop
);
always @(*) begin
    RegDst=1'b0;
    ALUSrc=1'b0;
    MemtoReg=1'b0;
    RegW=1'b0;
    MemW=1'b0;
    Branch=1'b0;
    ALUop=2'b00;

    case (opcode)
        6'b000000:begin
            RegDst=1'b1;
            RegW=1'b1;
            ALUop=2'b10;
        end 
        6'b000001: begin
            ALUSrc=1'b1;
            MemtoReg=1'b1;
            RegW=1'b1;
            ALUop=2'b00;
        end
        6'b000010:begin
            ALUSrc=1'b1;
            MemW=1'b1;
            ALUop=2'b00;
        end
        6'b000011:begin
            
            Branch=1'b1;
            ALUop=2'b01;
        end
        default: begin
        end
    endcase
end
endmodule