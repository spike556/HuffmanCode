/****************************************************************
/*
/*  Description:
/*              top file
/*  Author:
/*              Guozhu Xin
/*  Date:
/*              2017/7/30
/*  Email:
/*              spikexin@outlook.com
******************************************************************/

module huffman_top(
  input               clk,
  input               rst_n,
  input               start,             // pulse signal
  input               start_done,        // along with the last data_in, pulse signal
  input       [3:0]   data_in,
  output  wire        output_data,    // MSB first
  output  wire        output_start,
  output  wire        output_done
  );

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
  wire  [8:0]   data_para;
  wire  [3:0]   data_len;
  wire          trans_start;

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
    .data_in0  (data0),
    .data_in1  (data1),
    .data_in2  (data2),
    .data_in3  (data3),
    .data_in4  (data4),
    .data_in5  (data5),
    .data_in6  (data6),
    .data_in7  (data7),
    .data_in8  (data8),
    .data_in9  (data9),
    .req_coding (req_coding),
    .ack_coding (ack_coding),
    .data_out   (data_para),
    .data_len   (data_len),
    .trans_start(trans_start)
    );

  para2ser para2ser_inst(
    .clk          (clk),
    .rst_n        (rst_n),
    .trans_start  (trans_start),   // indicate tansform begin, level signal
    .data         (data_para),          // signal:0-9   max coding length:9
    .data_len     (data_len),      // 9 - 1
    .output_data  (output_data),    // MSB first
    .output_start (output_start),
    .output_done  (output_done)
    );

endmodule
