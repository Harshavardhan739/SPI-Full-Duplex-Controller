`timescale 1ns / 1ps

module spi_master_tb;

//=====================================
// Parameters
//=====================================
parameter DATA_WIDTH   = 8;
parameter CLK_FREQ     = 100000000;
parameter SPI_CLK_FREQ = 1000000;
parameter CPOL         = 0;
parameter MSB_FIRST    = 1;

//=====================================
// Inputs
//=====================================
reg clk;
reg rst_n;
reg start;
reg [DATA_WIDTH-1:0] tx_data;
reg miso;

//=====================================
// Outputs
//=====================================
wire mosi;
wire sclk;
wire cs;
wire [DATA_WIDTH-1:0] rx_data;
wire busy;
wire done;

//=====================================
// DUT
//=====================================
spi_master #(

.DATA_WIDTH(DATA_WIDTH),
.CLK_FREQ(CLK_FREQ),
.SPI_CLK_FREQ(SPI_CLK_FREQ),
.CPOL(CPOL),
.MSB_FIRST(MSB_FIRST)

)
dut
(

.clk(clk),
.rst_n(rst_n),
.start(start),

.tx_data(tx_data),
.miso(miso),

.mosi(mosi),
.sclk(sclk),
.cs(cs),

.rx_data(rx_data),

.busy(busy),
.done(done)

);

//=====================================
// Clock Generation (100 MHz)
//=====================================
always #5 clk = ~clk;

//=====================================
// Stimulus
//=====================================
initial
begin

clk   = 0;
rst_n = 0;
start = 0;
tx_data = 8'hA5;
miso = 0;

#20;
rst_n = 1;

#20;
start = 1;

#10;
start = 0;

repeat(8)
begin

@(negedge sclk)
miso = $random;

end

#1000;

$stop;

end

endmodule