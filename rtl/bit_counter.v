`timescale 1ns / 1ps

module bit_counter #(

    //=====================================
    // Parameters
    //=====================================
    parameter DATA_WIDTH = 8

)(

    //=====================================
    // Inputs
    //=====================================
    input  wire sclk,
    input  wire rst_n,
    input  wire enable,
    input  wire clear,

    //=====================================
    // Outputs
    //=====================================
    output reg bit_done

);

//=====================================
// Internal Registers
//=====================================
reg [3:0] count;


//=====================================
// Bit Counter Logic
//=====================================
always @(posedge sclk or negedge rst_n or posedge clear)
begin

    //=================================
    // Active-Low Reset
    //=================================
    if(!rst_n)
    begin
        count    <= 4'd0;
        bit_done <= 1'b0;
    end

    //=================================
    // Clear for New SPI Transaction
    //=================================
    else if(clear)
    begin
        count    <= 4'd0;
        bit_done <= 1'b0;
    end

    //=================================
    // Count SPI Bits
    //=================================
    else if(enable)
    begin

        if(count == DATA_WIDTH-1)
        begin
            count    <= 4'd0;
            bit_done <= 1'b1;
        end

        else
        begin
            count    <= count + 1'b1;
            bit_done <= 1'b0;
        end

    end

    //=================================
    // Counter Disabled
    //=================================
    else
    begin
        bit_done <= 1'b0;
    end

end

endmodule