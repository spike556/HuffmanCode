/****************************************************************
/*
/*  Description:
/*              change internal parallel data to output
/*              serial data
/*  Author:
/*              Guozhu Xin
/*  Date:
/*              2017/7/10
/*  Email:
/*              spikexin@outlook.com
******************************************************************/

module para2ser(
  input       clk,
  input       rst_n,
  input       trans_start,   // indicate tansform begin, level signal
  input [8:0] data,          // signal:0-9   max coding length:9
  input [3:0] data_len,      // 9 - 1
  output wire output_data,    // MSB first
  output wire output_start,
  output wire output_done
  );

  reg [3:0] data_cnt;
  reg [8:0] data_reg;

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      data_cnt  <=  4'b0;
      data_reg  <=  9'b0;
    end
    else if(trans_start) begin
      data_cnt  <=  (data_cnt == 4'b0) ? data_len-1 : data_cnt-1;
      data_reg  <=  data;
    end
  end

  reg trans_start_q1;
  reg trans_start_q2;
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      trans_start_q1  <=  1'b0;
      trans_start_q2  <=  1'b0;
    end
    else begin
      trans_start_q1  <=  trans_start;
      trans_start_q2  <=  trans_start_q1;
    end
  end

  assign output_start = trans_start & ~trans_start_q1;
  assign output_done = ~trans_start_q1 & trans_start_q2;
  assign output_data = (data_reg >> data_cnt) & 1'b1;

endmodule
