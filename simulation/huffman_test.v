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

  wire  ack_coding;
  wire  req_coding;
  wire  [18:0]  data0;
  wire  [18:0]  data1;
  wire  [18:0]  data2;
  wire  [18:0]  data3;
  wire  [18:0]  data4;
  wire  [18:0]  data5;
  wire  [18:0]  data6;
  wire  [18:0]  data7;
  wire  [18:0]  data8;
  wire  [18:0]  data9;

  freqcount freq_inst(
    .clk          (clk),
    .rst_n        (rst_n),
    .start        (start),             // pulse signal
    .start_done   (start_done),        // along with the last data_in, pulse signal
    .data_in      (data_in),
    .ack_coding   (ack_coding),       // return signal of huffman coding module
    .req_coding   (req_coding),       // request signal of huffman coding module
    .data_out0    (data0),
    .data_out1    (data1),
    .data_out2    (data2),
    .data_out3    (data3),
    .data_out4    (data4),
    .data_out5    (data5),
    .data_out6    (data6),
    .data_out7    (data7),
    .data_out8    (data8),
    .data_out9    (data9)
    );

  HuffmanCode huffmancode (
      .clk        (clk),
      .rst_n      (rst_n),
      .data_out0  (data0),
      .data_out1  (data1),
      .data_out2  (data2),
      .data_out3  (data3),
      .data_out4  (data4),
      .data_out5  (data5),
      .data_out6  (data6),
      .data_out7  (data7),
      .data_out8  (data8),
      .data_out9  (data9),
      .req_coding (req_coding),
      .ack_coding (ack_coding)
      //TODO add signal
      );
endmodule
