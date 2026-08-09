`timescale 1ns / 1ps

module clock_divider #(

    //=====================================
    // Parameters
    //=====================================
    parameter CLK_FREQ     = 100000000,
    parameter SPI_CLK_FREQ = 1000000,
    parameter CPOL         = 0

)(

    //=====================================
    // Inputs
    //=====================================
    input wire clk,
    input wire rst_n,
    input wire enable,

    //=====================================
    // Outputs
    //=====================================
    output reg sclk

);

//=====================================
// Local Parameters
//=====================================
localparam integer DIVIDER =
                    CLK_FREQ / (2 * SPI_CLK_FREQ);


//=====================================
// Internal Registers
//=====================================
reg [15:0] count;


//=====================================
// SPI Clock Divider Logic
//=====================================
always @(posedge clk or negedge rst_n)
begin

    //=================================
    // Active-Low Reset
    //=================================
    if(!rst_n)
    begin
        count <= 16'd0;
        sclk  <= CPOL;
    end

    //=================================
    // Generate SPI Clock
    //=================================
    else if(enable)
    begin

        if(count == DIVIDER - 1)
        begin
            count <= 16'd0;
            sclk  <= ~sclk;
        end

        else
        begin
            count <= count + 16'd1;
        end

    end

    //=================================
    // Idle State
    //=================================
    else
    begin
        count <= 16'd0;
        sclk  <= CPOL;
    end

end

endmodule