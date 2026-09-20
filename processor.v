module processor (
    input clk,
    input reset
);
 
    reg  [31:0] pc;
    wire [31:0] pc_next, pc_plus4, pc_branch;
    wire [31:0] instruction;
    
    // Control Signals
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, Branch;
    wire [1:0] ALUOp;
    wire [2:0] ALUControl;
    
    // Data Wires
    wire [4:0]  WriteReg;       // Target register address
    wire [31:0] SrcA, SrcB;     // ALU Inputs
    wire [31:0] WriteDataReg;   // Data going INTO Register File
    wire [31:0] alu_result;     // ALU Output
    wire [31:0] read_data;      // Output from Data Memory
    wire [31:0] signImm;        // Sign Extended Immediate
    wire [31:0] signImmShifted; // Sign Extended Immediate shifted left by 2
    
    wire Zero;                  // ALU Zero flag
    wire PCSrc;                 // Branch AND Zero logic
    wire [31:0] RegReadData2;   // Data from RegFile port 2 

 
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;
        else
            pc <= pc_next; 
    end

    // PC Plus 4 Adder
    assign pc_plus4 = pc + 32'd4;
    
    // Shift Left 2 logic for Branch address
    assign signImmShifted = {signImm[29:0], 2'b00}; 
     
    // Branch Target Address Adder
    assign pc_branch = pc_plus4 + signImmShifted;

    assign Zero = (alu_result == 32'b0) ? 1'b1 : 1'b0;

    // TODO: Write logic for PCSrc (When do we branch?)
    assign PCSrc = Branch&Zero;
    
    // MUX 1: PCNext MUX (Chooses between pc_plus4 and pc_branch)
    assign pc_next = PCSrc?pc_branch:pc_plus4;
    
    // MUX 2: RegDst MUX (Chooses between instruction[20:16] and instruction[15:11])
    assign WriteReg = RegDst?instruction[15:11]:instruction[20:16];
    
    // MUX 3: ALUSrc MUX (Chooses between RegReadData2 and signImm)
    assign SrcB = ALUSrc?signImm:RegReadData2;
    
    // MUX 4: MemtoReg MUX (Chooses between alu_result and read_data)
    assign WriteDataReg = MemtoReg?read_data:alu_result;


    // Instruction Memory
    inst_mem IM (
        .a(pc),
        .rd(instruction)
    );

    // Main Control Unit
    main_cu CU (
        .opcode(instruction[31:26]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegW(RegWrite),      // Mapped to your 'RegW'
        .MemW(MemWrite),      // Mapped to your 'MemW'
        .Branch(Branch),
        .ALUop(ALUOp)         // Mapped to your 'ALUop'
    );

    // Register File
    regfile RF (
        .clk(clk),
        .wen(RegWrite),       // Mapped to your 'wen'
        .ra1(instruction[25:21]), 
        .ra2(instruction[20:16]), 
        .wa(WriteReg),        // Mapped to your 'wa'
        .wd(WriteDataReg),    // Mapped to your 'wd'
        .rd1(SrcA),           // Mapped to your 'rd1'
        .rd2(RegReadData2)    // Mapped to your 'rd2'
    );

    // Sign Extension
    sign_ext SE (
        .value(instruction[15:0]), // Mapped to your 'value'
        .ext_value(signImm)        // Mapped to your 'ext_value'
    );

    // ALU Control
    alu_control AC (
        .ALUop(ALUOp),        // Mapped to your 'ALUop'
        .funct(instruction[5:0]),
        .alucontrol(ALUControl)
    );

    // ALU
    alu ALU (
        .a(SrcA),
        .b(SrcB),
        .alucontrol(ALUControl),
        .res(alu_result)      // Mapped to your 'res'
    );

    // Data Memory
    data_mem DM (
        .clk(clk),
        .wen(MemWrite),       // Mapped to your 'wen'
        .a(alu_result),
        .wd(RegReadData2),
        .rd(read_data)
    );

endmodule