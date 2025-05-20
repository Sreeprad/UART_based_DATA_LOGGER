// ==========================
// Module: DATA_LOGGER
// Description: Wraps a FIFO IP core for read/write operations
// ==========================
module DATA_LOGGER(
    input wire clk,
    input wire reset,
    input wire write_enable,
    input wire read_enable,
    input wire [31:0] write_data,
    output wire [31:0] read_data,
    output wire full,
    output wire empty
);

    // Instantiate FIFO IP core
    fifo_generator_0 fifo_inst (
        .clk(clk),
        .srst(reset),
        .din(write_data),
        .wr_en(write_enable),
        .rd_en(read_enable),
        .dout(read_data),
        .full(full),
        .empty(empty)
    );

endmodule