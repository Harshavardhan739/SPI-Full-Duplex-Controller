`timescale 1ns / 1ps

module spi_slave #(

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
    input wire cs,

    input wire mosi,
    input wire [DATA_WIDTH-1:0] tx_data,

    //=====================================
    // Outputs
    //=====================================
    output wire miso,
    output reg  [DATA_WIDTH-1:0] rx_data,
    output reg  done

);

//=====================================
// Internal Registers
//=====================================
reg [DATA_WIDTH-1:0] tx_shift_reg;
reg [DATA_WIDTH-1:0] rx_shift_reg;

reg [3:0] bit_count;


//=====================================
// Load Slave TX Data
//=====================================
// Load TX data when CS becomes active
always @(negedge cs or negedge rst_n)
begin

    // Active-Low Reset
    if(!rst_n)
    begin
        tx_shift_reg <= 0;
    end

    // Load Parallel TX Data
    else
    begin
        tx_shift_reg <= tx_data;
    end

end


//=====================================
// Receive MOSI Data
//=====================================
always @(posedge sclk or negedge rst_n)
begin

    // Active-Low Reset
    if(!rst_n)
    begin
        rx_shift_reg <= 0;
        rx_data      <= 0;
        bit_count    <= 0;
        done         <= 0;
    end

    // Receive only when CS is active
    else if(!cs)
    begin

        //=================================
        // Shift Received Data
        //=================================
        if(MSB_FIRST)
        begin
            rx_shift_reg <= {
                rx_shift_reg[DATA_WIDTH-2:0],
                mosi
            };
        end

        else
        begin
            rx_shift_reg <= {
                mosi,
                rx_shift_reg[DATA_WIDTH-1:1]
            };
        end


        //=================================
        // Check Last Bit
        //=================================
        if(bit_count == DATA_WIDTH-1)
        begin

            // MSB First
            if(MSB_FIRST)
            begin
                rx_data <= {
                    rx_shift_reg[DATA_WIDTH-2:0],
                    mosi
                };
            end

            // LSB First
            else
            begin
                rx_data <= {
                    mosi,
                    rx_shift_reg[DATA_WIDTH-1:1]
                };
            end

            bit_count <= 0;
            done      <= 1;

        end

        else
        begin
            bit_count <= bit_count + 1;
            done      <= 0;
        end

    end

end


//=====================================
// Shift Slave TX Data
//=====================================
always @(negedge sclk or negedge rst_n)
begin

    // Active-Low Reset
    if(!rst_n)
    begin
        tx_shift_reg <= 0;
    end

    // Shift only when CS is active
    else if(!cs)
    begin

        //=================================
        // MSB First
        //=================================
        if(MSB_FIRST)
        begin
            tx_shift_reg <= {
                tx_shift_reg[DATA_WIDTH-2:0],
                1'b0
            };
        end

        //=================================
        // LSB First
        //=================================
        else
        begin
            tx_shift_reg <= {
                1'b0,
                tx_shift_reg[DATA_WIDTH-1:1]
            };
        end

    end

end


//=====================================
// MISO Output
//=====================================
assign miso = (MSB_FIRST) ?
              tx_shift_reg[DATA_WIDTH-1] :
              tx_shift_reg[0];

endmodule