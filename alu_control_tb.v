module tb_alu_control;

    reg [1:0] ALUop;
    reg [5:0] funct;
    wire [2:0] alucontrol;

    alu_control uut (.ALUop(ALUop),.funct(funct),.alucontrol(alucontrol));

    initial begin
        $dumpfile("alu_control.vcd");
        $dumpvars(0, tb_alu_control);

        // lw / sw
        ALUop = 2'b00;
        funct = 6'b000000;
        #10;
        $display("ALUOp=%b funct=%b ALUControl=%b", ALUop, funct, alucontrol);

        // beq
        ALUop = 2'b01;
        funct = 6'b000000;
        #10;
        $display("ALUOp=%b funct=%b ALUControl=%b", ALUop, funct, alucontrol);

        // R-type ADD
        ALUop = 2'b10;
        funct = 6'b100000;
        #10;
        $display("ALUOp=%b funct=%b ALUControl=%b", ALUop, funct, alucontrol);

        // R-type SUB
        ALUop = 2'b10;
        funct = 6'b100010;
        #10;
        $display("ALUOp=%b funct=%b ALUControl=%b", ALUop, funct, alucontrol);

        // R-type AND
        ALUop = 2'b10;
        funct = 6'b100100;
        #10;
        $display("ALUOp=%b funct=%b ALUControl=%b", ALUop, funct, alucontrol);

        // R-type OR
        ALUop = 2'b10;
        funct = 6'b100101;
        #10;
        $display("ALUOp=%b funct=%b ALUControl=%b", ALUop, funct, alucontrol);

// R-type SLT
        ALUop = 2'b10;
        funct = 6'b101010;
        #10;
        $display("ALUOp=%b funct=%b ALUControl=%b", ALUop, funct, alucontrol);
        $finish;
    end

endmodule