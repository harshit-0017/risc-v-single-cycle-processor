module regfile_tb;
    reg clk, wen;
    reg [4:0] ra1, ra2, wa;
    reg [31:0] wd;
    wire [31:0] rd1,rd2;

    regfile uut(.clk(clk),.wen(wen),.ra1(ra1),.ra2(ra2),.wa(wa),.wd(wd),.rd1(rd1),.rd2(rd2));
    always #5 clk=~clk;

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0,regfile_tb);

        clk=0; wen=0; ra1=0; ra2=0; wa=0; wd=0;

        // agr reg no 5 me 100 likhan hn
        @(negedge clk);
        wen=1;
        wa=5;
        wd=32'd100;
        @(posedge clk)
        #1
        //reg 5 ko read kane ke liye
        wen=0;
        ra1=5;
        #1
        $display("reg[5]=%d",rd1 );
        
        // reg 0 me write 
        @(negedge clk);
        wen=1;
        wa=0;
        wd=32'd999;
        @(posedge clk)
        #1
        //read reg 0
        wen=0;
        ra2=0;
        #1
        $display("reg[0]=%d",rd2 );
        #10
        $finish;

    end
endmodule
