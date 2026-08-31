module sign_ext (
    input [15:0] value,
    output [31:0] ext_value
);
assign ext_value={{16{value[15]}},value};
    
endmodule