`timescale 1ns / 1ps

module spi_top #(

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

    input  wire [DATA_WIDTH-1:0] master_tx_data,
    input  wire [DATA_WIDTH-1:0] slave_tx_data,

    //=====================================
    // Outputs
    //=====================================
    output wire [DATA_WIDTH-1:0] master_rx_data,
    output wire [DATA_WIDTH-1:0] slave_rx_data,

    output wire busy,
    output wire done

);

//=====================================
// Internal SPI Signals
//=====================================
wire mosi;
wire miso;
wire sclk;
wire cs;

//=====================================
// SPI Master
//=====================================
spi_master #(

    .DATA_WIDTH(DATA_WIDTH),
    .CLK_FREQ(CLK_FREQ),
    .SPI_CLK_FREQ(SPI_CLK_FREQ),
    .CPOL(CPOL),
    .MSB_FIRST(MSB_FIRST)

)
u_spi_master
(

    .clk(clk),
    .rst_n(rst_n),
    .start(start),

    .tx_data(master_tx_data),
    .miso(miso),

    .mosi(mosi),
    .sclk(sclk),
    .cs(cs),

    .rx_data(master_rx_data),

    .busy(busy),
    .done(done)

);

//=====================================
// SPI Slave
//=====================================
spi_slave #(

    .DATA_WIDTH(DATA_WIDTH),
    .MSB_FIRST(MSB_FIRST)

)
u_spi_slave
(

    .sclk(sclk),
    .rst_n(rst_n),
    .cs(cs),

    .mosi(mosi),
    .tx_data(slave_tx_data),

    .miso(miso),

    .rx_data(slave_rx_data),
    .done()

);

endmodule