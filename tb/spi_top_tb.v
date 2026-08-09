`timescale 1ns / 1ps

module spi_top_tb;

    //==================================================
    // PARAMETERS
    //==================================================

    parameter DATA_WIDTH   = 8;
    parameter CLK_FREQ     = 100000000;
    parameter SPI_CLK_FREQ = 1000000;
    parameter CPOL         = 0;
    parameter MSB_FIRST    = 1;


    //==================================================
    // TESTBENCH SIGNALS
    //==================================================

    reg clk;
    reg rst_n;
    reg start;

    reg [DATA_WIDTH-1:0] master_tx_data;
    reg [DATA_WIDTH-1:0] slave_tx_data;

    wire [DATA_WIDTH-1:0] master_rx_data;
    wire [DATA_WIDTH-1:0] slave_rx_data;

    wire busy;
    wire done;

    integer pass_count;
    integer fail_count;


    //==================================================
    // DUT
    //==================================================

    spi_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .CLK_FREQ(CLK_FREQ),
        .SPI_CLK_FREQ(SPI_CLK_FREQ),
        .CPOL(CPOL),
        .MSB_FIRST(MSB_FIRST)
    )
    dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),

        .master_tx_data(master_tx_data),
        .slave_tx_data(slave_tx_data),

        .master_rx_data(master_rx_data),
        .slave_rx_data(slave_rx_data),

        .busy(busy),
        .done(done)
    );


    //==================================================
    // SYSTEM CLOCK
    //==================================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;       // 100 MHz
    end


    //==================================================
    // SPI TEST TASK
    //==================================================

    task spi_test;

        input [DATA_WIDTH-1:0] master_data;
        input [DATA_WIDTH-1:0] slave_data;

        begin

            // -----------------------------------------
            // Apply NEW TX data
            // -----------------------------------------

            master_tx_data = master_data;
            slave_tx_data  = slave_data;


            // -----------------------------------------
            // Make sure previous transaction is finished
            // -----------------------------------------

            wait(busy == 1'b0);
            wait(done == 1'b0);


            // -----------------------------------------
            // Start NEW transaction
            // -----------------------------------------

            @(posedge clk);
            start = 1'b1;

            @(posedge clk);
            start = 1'b0;


            // -----------------------------------------
            // Wait for THIS transaction to start
            // -----------------------------------------

            wait(busy == 1'b1);


            // -----------------------------------------
            // Wait for THIS transaction to finish
            // -----------------------------------------

            wait(done == 1'b1);


            // -----------------------------------------
            // Allow RX data to settle
            // -----------------------------------------

            @(posedge clk);
            @(posedge clk);


            // -----------------------------------------
            // Display result
            // -----------------------------------------

            $display("");
            $display("============================================");
            $display("SPI TRANSACTION");
            $display("============================================");

            $display("MASTER TX = %h", master_tx_data);
            $display("SLAVE  TX = %h", slave_tx_data);

            $display("MASTER RX = %h", master_rx_data);
            $display("SLAVE  RX = %h", slave_rx_data);

            $display("--------------------------------------------");


            // -----------------------------------------
            // Verify
            // -----------------------------------------

            if ((master_rx_data == slave_data) &&
                (slave_rx_data  == master_data))
            begin

                $display("RESULT : PASS");

                $display("Master RX correctly received Slave TX");
                $display("Slave  RX correctly received Master TX");

                pass_count = pass_count + 1;

            end

            else
            begin

                $display("RESULT : FAIL");

                $display("Expected MASTER RX = %h", slave_data);
                $display("Actual   MASTER RX = %h", master_rx_data);

                $display("Expected SLAVE RX  = %h", master_data);
                $display("Actual   SLAVE RX  = %h", slave_rx_data);

                fail_count = fail_count + 1;

            end

            $display("============================================");


            // -----------------------------------------
            // Wait until controller becomes idle
            // -----------------------------------------

            wait(busy == 1'b0);
            wait(done == 1'b0);

            repeat(20) @(posedge clk);

        end

    endtask


    //==================================================
    // MAIN TEST SEQUENCE
    //==================================================

    initial begin

        // ---------------------------------------------
        // Initial values
        // ---------------------------------------------

        rst_n          = 1'b0;
        start          = 1'b0;

        master_tx_data = 8'h00;
        slave_tx_data  = 8'h00;

        pass_count = 0;
        fail_count = 0;


        // ---------------------------------------------
        // Reset
        // ---------------------------------------------

        #100;

        rst_n = 1'b1;

        repeat(20) @(posedge clk);


        //================================================
        // TEST 1
        //================================================

        spi_test(8'hA5, 8'h3C);


        //================================================
        // TEST 2
        //================================================

        spi_test(8'h55, 8'hAA);


        //================================================
        // TEST 3
        //================================================

        spi_test(8'hFF, 8'h00);


        //================================================
        // TEST 4
        //================================================

        spi_test(8'h00, 8'hFF);


        //================================================
        // TEST 5
        //================================================

        spi_test(8'h3C, 8'hC3);


        //================================================
        // FINAL SUMMARY
        //================================================

        $display("");
        $display("");
        $display("============================================");
        $display("          SPI VERIFICATION SUMMARY");
        $display("============================================");

        $display("TOTAL TESTS = %0d", pass_count + fail_count);
        $display("PASSED      = %0d", pass_count);
        $display("FAILED      = %0d", fail_count);

        if (fail_count == 0)
        begin
            $display("--------------------------------------------");
            $display("ALL SPI TESTS PASSED");
            $display("FULL-DUPLEX SPI IS WORKING CORRECTLY");
            $display("--------------------------------------------");
        end
        else
        begin
            $display("--------------------------------------------");
            $display("SOME SPI TESTS FAILED");
            $display("--------------------------------------------");
        end

        $display("============================================");


        // ---------------------------------------------
        // End simulation
        // ---------------------------------------------

        #100;

        $stop;

    end

endmodule