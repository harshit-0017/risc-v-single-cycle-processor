module alu_control (
     input [1:0] ALUop,
     input [5:0] funct,  // instruction ki last 6 bits to decide operation of R-type
     output reg [2:0] alucontrol
);
always @(*) begin
    alucontrol = 3'b000;
    
    case (ALUop)
        2'b00: alucontrol = 3'b000; // lw/sw -> ADD (Match with ALU)
        2'b01: alucontrol = 3'b001; // beq -> SUB (Match with ALU)
        2'b10: begin // R-type
            case (funct)
                6'b100000: alucontrol = 3'b000; // ADD 
                6'b100010: alucontrol = 3'b001; // SUB 
                6'b100100: alucontrol = 3'b010; // AND 
                6'b100101: alucontrol = 3'b011; // OR  
                6'b101010: alucontrol = 3'b100; // SLT (
                default: alucontrol = 3'b000; 
            endcase
        end
        default: alucontrol = 3'b000;
    endcase
end

endmodule 
