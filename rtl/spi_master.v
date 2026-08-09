`timescale 1ns / 1ps

module spi_master #(

    //=====================================
    // Parameters
    //=====================================
    parameter DATA_WIDTH   = 8,
    parameter CLK_FREQ     = 100000000,
    parameter SPI_CLK_FREQ = 1000000,
    parameter CPOL         = 0,
    parameter MSB_FIRST    = 1

)(

    //=====================================
    // Inputs
    //=====================================
    input  wire clk,
    input  wire rst_n,
    input  wire start,

    input  wire [DATA_WIDTH-1:0] tx_data,
    input  wire miso,

    //=====================================
    // Outputs
    //=====================================
    output wire mosi,
    output wire sclk,
    output wire cs,

    output wire [DATA_WIDTH-1:0] rx_data,

    output wire busy,
    output wire done

);

//=====================================
// Internal Signals
//=====================================
wire load;
wire shift;
wire clear_counter;
wire clk_enable;
wire bit_done;

//=====================================
// Clock Divider
//=====================================
clock_divider #(

    .CLK_FREQ(CLK_FREQ),
    .SPI_CLK_FREQ(SPI_CLK_FREQ),
    .CPOL(CPOL)

)
u_clock_divider
(

    .clk(clk),
    .rst_n(rst_n),
    .enable(clk_enable),

    .sclk(sclk)

);

//=====================================
// SPI FSM
//=====================================
spi_fsm
u_spi_fsm
(

    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .bit_done(bit_done),

    .cs(cs),
    .load(load),
    .shift(shift),
    .clear_counter(clear_counter),
    .clk_enable(clk_enable),

    .busy(busy),
    .done(done)

);

//=====================================
// TX Shift Register
//=====================================
tx_shift_register #(

    .DATA_WIDTH(DATA_WIDTH),
    .MSB_FIRST(MSB_FIRST)

)
u_tx_shift_register
(

    .clk(clk),
    .sclk(sclk),
    .rst_n(rst_n),

    .load(load),
    .shift(shift),

    .tx_data(tx_data),

    .mosi(mosi)

);

//=====================================
// RX Shift Register
//=====================================
rx_shift_register #(

    .DATA_WIDTH(DATA_WIDTH),
    .MSB_FIRST(MSB_FIRST)

)
u_rx_shift_register
(

    .sclk(sclk),
    .rst_n(rst_n),

    .shift(shift),
    .miso(miso),

    .rx_data(rx_data)

);

//=====================================
// Bit Counter
//=====================================
bit_counter #(

    .DATA_WIDTH(DATA_WIDTH)

)
u_bit_counter
(

    .sclk(sclk),
    .rst_n(rst_n),

    .enable(shift),
    .clear(clear_counter),

    .bit_done(bit_done)

);

endmodule