/****************************************************************
/*
/*  Description:
/*              count the frequency of each signal,
/*              for the huffman codeing processs afterwards
/*  Author:
/*              Guozhu Xin
/*  Date:
/*              2017/7/11
/*  Email:
/*              spikexin@outlook.com
******************************************************************/
/*              data_out      bit domain
/*                     17 |   16 --- 13   |   12   |  11 --- 8  | 7 --- 0
/*  been precessed,       |               |        |            |
/*  this bit=1(for debug) | parent number | 0 or 1 |number (0-9)| frequency
******************************************************************/
module freqcount(
  input               clk,
  input               rst_n,
  input               start,             // pulse signal
  input               start_done,        // along with the last data_in, pulse signal
  input       [3:0]   data_in,
  input               ack_coding,       // return signal of huffman coding module
  output wire         req_coding,       // request signal of huffman coding module
  output wire [17:0]  data_out0,
  output wire [17:0]  data_out1,
  output wire [17:0]  data_out2,
  output wire [17:0]  data_out3,
  output wire [17:0]  data_out4,
  output wire [17:0]  data_out5,
  output wire [17:0]  data_out6,
  output wire [17:0]  data_out7,
  output wire [17:0]  data_out8,
  output wire [17:0]  data_out9
  );

  reg  processing;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
      processing  <=  1'b0;
    else if (start)
      processing  <=  1'b1;
    else if (start_done)
      processing  <=  1'b0;
  end


  reg  [17:0] data_mem [0:9];

  integer i;
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      for (i = 0; i < 10; i++) begin
        data_mem[i] <=  18'b0;
      end
    end else if (processing) begin
      case(data_in)
      4'b0000:  data_mem[0] <=  data_mem[0] + 1;
      4'b0001:  data_mem[1] <=  data_mem[1] + 1;
      4'b0010:  data_mem[2] <=  data_mem[2] + 1;
      4'b0011:  data_mem[3] <=  data_mem[3] + 1;
      4'b0100:  data_mem[4] <=  data_mem[4] + 1;
      4'b0101:  data_mem[5] <=  data_mem[5] + 1;
      4'b0110:  data_mem[6] <=  data_mem[6] + 1;
      4'b0111:  data_mem[7] <=  data_mem[7] + 1;
      4'b1000:  data_mem[8] <=  data_mem[8] + 1;
      4'b1001:  data_mem[9] <=  data_mem[9] + 1;
    end
  end

  reg  start_done_q2, start_done_q1;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      start_done_q1 <=  1'b0;
      start_done_q2 <=  1'b0;
    end else begin
      start_done_q1 <=  start_done;
      start_done_q2 <=  start_done_q1;
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
      req_coding  <=  1'b0;
    else if (start_done_q1)
      req_coding  <=  1'b1;
    else if (ack_coding)
      req_coding  <=  1'b0;
  end


  assign data_out0 = start_done_q2 ? {6'b0, 4'd0, 8'b0} | data_mem[0] : 18'hz;
  assign data_out1 = start_done_q2 ? {6'b0, 4'd1, 8'b0} | data_mem[1] : 18'hz;
  assign data_out2 = start_done_q2 ? {6'b0, 4'd2, 8'b0} | data_mem[2] : 18'hz;
  assign data_out3 = start_done_q2 ? {6'b0, 4'd3, 8'b0} | data_mem[3] : 18'hz;
  assign data_out4 = start_done_q2 ? {6'b0, 4'd4, 8'b0} | data_mem[4] : 18'hz;
  assign data_out5 = start_done_q2 ? {6'b0, 4'd5, 8'b0} | data_mem[5] : 18'hz;
  assign data_out6 = start_done_q2 ? {6'b0, 4'd6, 8'b0} | data_mem[6] : 18'hz;
  assign data_out7 = start_done_q2 ? {6'b0, 4'd7, 8'b0} | data_mem[7] : 18'hz;
  assign data_out8 = start_done_q2 ? {6'b0, 4'd8, 8'b0} | data_mem[8] : 18'hz;
  assign data_out9 = start_done_q2 ? {6'b0, 4'd9, 8'b0} | data_mem[9] : 18'hz;

endmodule
