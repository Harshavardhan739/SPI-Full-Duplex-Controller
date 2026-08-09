`timescale 1ns / 1ps

module rx_shift_register #(

    //=====================================
    // Parameters
    //=====================================
    parameter DATA_WIDTH = 8,
    parameter MSB_FIRST  = 1

)(

    //=====================================
    // Inputs
    //=====================================
    input wire sclk,
    input wire rst_n,
    input wire shift,
    input wire miso,

    //=====================================
    // Outputs
    //=====================================
    output reg [DATA_WIDTH-1:0] rx_data

);

//=====================================
// Internal Registers
//=====================================
reg [DATA_WIDTH-1:0] shift_reg;
reg [2:0] bit_count;


//=====================================
// RX Shift Register + Output Register
//=====================================
always @(posedge sclk or negedge rst_n)
begin

    //=================================
    // Active-Low Reset
    //=================================
    if(!rst_n)
    begin
        shift_reg <= {DATA_WIDTH{1'b0}};
        rx_data   <= {DATA_WIDTH{1'b0}};
        bit_count <= 3'd0;
    end

    //=================================
    // Shift Incoming MISO Data
    //=================================
    else if(shift)
    begin

        //=================================
        // MSB First
        //=================================
        if(MSB_FIRST)
        begin
            shift_reg <= {
                shift_reg[DATA_WIDTH-2:0],
                miso
            };

            // Update RX output after complete byte
            if(bit_count == DATA_WIDTH-1)
            begin
                rx_data <= {
                    shift_reg[DATA_WIDTH-2:0],
                    miso
                };

                bit_count <= 3'd0;
            end

            else
            begin
                bit_count <= bit_count + 1'b1;
            end

        end

        //=================================
        // LSB First
        //=================================
        else
        begin
            shift_reg <= {
                miso,
                shift_reg[DATA_WIDTH-1:1]
            };

            // Update RX output after complete byte
            if(bit_count == DATA_WIDTH-1)
            begin
                rx_data <= {
                    miso,
                    shift_reg[DATA_WIDTH-1:1]
                };

                bit_count <= 3'd0;
            end

            else
            begin
                bit_count <= bit_count + 1'b1;
            end

        end

    end

end

endmodule