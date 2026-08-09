`timescale 1ns / 1ps

module tx_shift_register #(

    //=====================================
    // Parameters
    //=====================================
    parameter DATA_WIDTH = 8,
    parameter MSB_FIRST  = 1

)(

    //=====================================
    // Inputs
    //=====================================
    input wire clk,
    input wire sclk,
    input wire rst_n,

    input wire load,
    input wire shift,

    input wire [DATA_WIDTH-1:0] tx_data,

    //=====================================
    // Outputs
    //=====================================
    output wire mosi

);

//=====================================
// Internal Registers
//=====================================
reg [DATA_WIDTH-1:0] shift_reg;
reg sclk_d;


//=====================================
// SCLK Delayed Copy
//=====================================
always @(posedge clk or negedge rst_n)
begin

    // Active-Low Reset
    if(!rst_n)
        sclk_d <= 1'b0;

    else
        sclk_d <= sclk;

end


//=====================================
// TX Shift Register Logic
//=====================================
always @(posedge clk or negedge rst_n)
begin

    // Active-Low Reset
    if(!rst_n)
    begin
        shift_reg <= {DATA_WIDTH{1'b0}};
    end

    // Load Parallel TX Data
    else if(load)
    begin
        shift_reg <= tx_data;
    end

    // Detect SCLK Falling Edge and Shift
    else if(shift && sclk_d && !sclk)
    begin

        // MSB First
        if(MSB_FIRST)
        begin
            shift_reg <= {
                shift_reg[DATA_WIDTH-2:0],
                1'b0
            };
        end

        // LSB First
        else
        begin
            shift_reg <= {
                1'b0,
                shift_reg[DATA_WIDTH-1:1]
            };
        end

    end

end


//=====================================
// MOSI Output
//=====================================
assign mosi = (MSB_FIRST) ?
              shift_reg[DATA_WIDTH-1] :
              shift_reg[0];

endmodule