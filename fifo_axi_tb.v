

// ==========================
// Module: fifo_axi_tb
// Description: Testbench for DATA_LOGGER module
// ==========================
module fifo_axi_tb;

  // Testbench Signals
  reg clk;
  reg reset;
  reg write_enable;
  reg read_enable;
  reg [31:0] write_data;
  wire [31:0] read_data;
  wire full, empty;

  // Instantiate the DATA_LOGGER DUT
  DATA_LOGGER uut (
    .clk(clk),
    .reset(reset),
    .write_enable(write_enable),
    .read_enable(read_enable),
    .write_data(write_data),
    .read_data(read_data),
    .full(full),
    .empty(empty)
  );

  // Clock Generation - 100 MHz
  always #5 clk = ~clk;

  initial begin
    // Initialize signals
    clk = 0;
    reset = 1;
    write_enable = 0;
    read_enable = 0;
    write_data = 32'h00000000;
    
    // Reset sequence
    #10 reset = 0;
    
    // Write multiple values into FIFO
    repeat (16) begin
      #10;
      if (!full) begin
        write_enable = 1;
        write_data = $random;
      end else begin
        write_enable = 0;
      end
    end
    write_enable = 0;
    
    // Read multiple values from FIFO
    repeat (16) begin
      #10;
      if (!empty) begin
        read_enable = 1;
      end else begin
        read_enable = 0;
      end
    end
    read_enable = 0;
    
    // Test Overflow Condition
    repeat (10) begin
      #10;
      if (!full) begin
        write_enable = 1;
        write_data = $random;
      end else begin
        write_enable = 0;
      end
    end
    write_enable = 0;
    
    // Test Underflow Condition
    repeat (10) begin
      #10;
      if (!empty) begin
        read_enable = 1;
      end else begin
        read_enable = 0;
      end
    end
    read_enable = 0;
    
    // Reset and check FIFO behavior
    #10 reset = 1;
    #10 reset = 0;
    
    // Final Read/Write Test after Reset
    repeat (5) begin
      #10 write_enable = 1; write_data = $random;
      #10 write_enable = 0;
    end
    
    repeat (5) begin
      #10 read_enable = 1;
      #10 read_enable = 0;
    end
    
    // End simulation
    #20 $stop;
  end

endmodule
