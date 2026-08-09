`timescale 1ns / 1ps

module spi_fsm(

    //=====================================
    // Inputs
    //=====================================
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire bit_done,

    //=====================================
    // Outputs
    //=====================================
    output reg cs,
    output reg load,
    output reg shift,
    output reg clear_counter,
    output reg clk_enable,
    output reg busy,
    output reg done

);

//=====================================
// State Encoding
//=====================================
localparam IDLE     = 2'b00;
localparam LOAD     = 2'b01;
localparam TRANSFER = 2'b10;
localparam FINISH   = 2'b11;

//=====================================
// Internal Registers
//=====================================
reg [1:0] state;
reg [1:0] next_state;


//=====================================
// State Register
//=====================================
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        state <= IDLE;
    else
        state <= next_state;
end


//=====================================
// Next State Logic
//=====================================
always @(*)
begin

    case(state)

        IDLE:
        begin
            if(start)
                next_state = LOAD;
            else
                next_state = IDLE;
        end

        LOAD:
        begin
               next_state = TRANSFER;
        end

        TRANSFER:
        begin
            if(bit_done)
                next_state = FINISH;
            else
                next_state = TRANSFER;
        end

        FINISH:
        begin
            next_state = IDLE;
        end

        default:
            next_state = IDLE;

    endcase

end


//=====================================
// Output Logic
//=====================================
always @(*)
begin

    // Default Outputs
    cs            = 1'b1;
    load          = 1'b0;
    shift         = 1'b0;
    clear_counter = 1'b0;
    clk_enable    = 1'b0;
    busy          = 1'b0;
    done          = 1'b0;

    case(state)

        //---------------------------------
        // IDLE
        //---------------------------------
        IDLE:
        begin
            cs = 1'b1;
        end

        //---------------------------------
        // LOAD
        //---------------------------------
        LOAD:
        begin
            cs            = 1'b0;
            load          = 1'b1;
            clear_counter = 1'b1;
            clk_enable    = 1'b0;
            busy          = 1'b1;
        end

        //---------------------------------
        // TRANSFER
        //---------------------------------
        TRANSFER:
        begin
            cs         = 1'b0;
            load       = 1'b0;
            shift      = 1'b1;
            clk_enable = 1'b1;
            busy       = 1'b1;
        end

        //---------------------------------
        // FINISH
        //---------------------------------
        FINISH:
        begin
            cs   = 1'b1;
            done = 1'b1;
        end

    endcase

end

endmodule