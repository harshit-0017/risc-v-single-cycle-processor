module main_cu_tb;
    reg [5:0] opcode;
    wire RegDst, ALUSrc, MemtoReg, RegW, MemW,Branch;
    wire [1:0] ALUop;

    main_cu uut(.opcode(opcode),.RegDst(RegDst),.ALUSrc(ALUSrc),.MemtoReg(MemtoReg),.RegW(RegW),
                .MemW(MemW),.Branch(Branch),.ALUop(ALUop));
    integer errors=0;
     task check;
        input [5:0] op;
        input exp_RegDst;
        input exp_ALUSrc;
        input exp_MemtoReg;
        input exp_RegW;
        input exp_MemW;
        input exp_Branch;
        input [1:0] exp_ALUop;

        begin
            opcode = op;
            #10;

            if (RegDst   !== exp_RegDst  ||
                ALUSrc   !== exp_ALUSrc  ||
                MemtoReg !== exp_MemtoReg||
                RegW     !== exp_RegW    ||
                MemW     !== exp_MemW    ||
                Branch   !== exp_Branch  ||
                ALUop    !== exp_ALUop)
            begin
                $display("FAIL : opcode=%b", op);
                errors = errors + 1;
            end
            else
                $display("PASS : opcode=%b", op);
        end
    endtask

initial begin
    $dumpfile("main_cu.vcd");
    $dumpvars(0,main_cu_tb);

    // R-type Instruction
    check(6'b000000, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 2'b10);

    // Load Instruction
    check(6'b000001, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00);

    // Store Instruction
    check(6'b000010, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00);

    // Branch Instruction
    check(6'b000011, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b01);

    // Invalid Opcode (Default Case)
    check(6'b111111, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00);

    if (errors == 0)
        $display("\nALL TESTS PASSED");
    else
        $display("\n%d TESTS FAILED", errors);

    $finish;
end

endmodule
