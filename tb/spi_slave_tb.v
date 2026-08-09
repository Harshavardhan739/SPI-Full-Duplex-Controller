`timescale 1ns / 1ps

module spi_slave_tb;

//=====================================
// Parameters
//=====================================
parameter DATA_WIDTH = 8;
parameter MSB_FIRST  = 1;

//=====================================
// Inputs
//=====================================
reg sclk;
reg rst_n;
reg cs;
reg mosi;
reg [DATA_WIDTH-1:0] tx_data;

//=====================================
// Outputs
//=====================================
wire miso;
wire [DATA_WIDTH-1:0] rx_data;
wire done;

//=====================================
// DUT
//=====================================
spi_slave #(
    .DATA_WIDTH(DATA_WIDTH),
    .MSB_FIRST(MSB_FIRST)
)
dut
(
    .sclk(sclk),
    .rst_n(rst_n),
    .cs(cs),
    .mosi(mosi),
    .tx_data(tx_data),
    .miso(miso),
    .rx_data(rx_data),
    .done(done)
);

//=====================================
// Clock Generation
//=====================================
always #10 sclk = ~sclk;

//=====================================
// Stimulus
//=====================================
initial
begin

    sclk    = 0;
    rst_n   = 0;
    cs      = 1;
    mosi    = 0;
    tx_data = 8'h3C;

    #20;
    rst_n = 1;

    #20;
    cs = 0;

    // Send A5 = 10100101
    mosi = 1; #20;
    mosi = 0; #20;
    mosi = 1; #20;
    mosi = 0; #20;
    mosi = 0; #20;
    mosi = 1; #20;
    mosi = 0; #20;
    mosi = 1; #20;

    #20;
    cs = 1;

    #100;

    $stop;

end

endmodule