`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/07/27 17:45:20
// Design Name:
// Module Name: huffmancode
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module huffmancode_test();
  reg               clk;
  reg               rst_n;
  reg               start;             // pulse signal
  reg               start_done;        // along with the last data_in, pulse signal
  reg       [3:0]   data_in;

  initial begin
    rst_n = 1'b1;
    #10 rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end
  initial begin
    clk = 1'b1;
    forever #1 clk = ~clk;
  end
  initial begin
    start = 1'b0;
    #50 start = 1'b1;
    #2 start = 1'b0;
  end
  initial begin
    data_in = 4'b0;
    #52 data_in = 4'd0;     // 5
    #10 data_in = 4'd1;     // 1
    #2 data_in = 4'd2;      // 3
    #6 data_in = 4'd3;      // 2
    #4 data_in = 4'd4;      // 9
    #18 data_in = 4'd5;     // 7
    #14 data_in = 4'd6;     // 4
    #8  data_in = 4'd7;     // 8
    #16 data_in = 4'd8;     // 6
    #12 data_in = 4'd0;     // 0
  end
  initial begin
    start_done = 1'b0;
    #140 start_done = 1'b1;
    #2 start_done = 1'b0;
  end

  wire        output_data;    // MSB first
  wire        output_start;
  wire        output_done;

  huffman_top sim_top(
   .clk           (clk),
   .rst_n         (rst_n),
   .start         (start),             // pulse signal
   .start_done    (start_done),        // along with the last data_in, pulse signal
   .data_in       (data_in),
   .output_data   (output_data),    // MSB first
   .output_start  (output_start),
   .output_done   (output_done)
   );

endmodule
