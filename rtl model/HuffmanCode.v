/****************************************************************
/*
/*  Description:
/*              main FSM control of huffman coding process
/*  Author:
/*              Guozhu Xin
/*  Date:
/*              2017/7/27
/*  Email:
/*              spikexin@outlook.com
******************************************************************/

module HuffmanCode (
  input         clk,
  input         rst_n,
  input [18:0]  data_out0,
  input [18:0]  data_out1,
  input [18:0]  data_out2,
  input [18:0]  data_out3,
  input [18:0]  data_out4,
  input [18:0]  data_out5,
  input [18:0]  data_out6,
  input [18:0]  data_out7,
  input [18:0]  data_out8,
  input [18:0]  data_out9,
  input         req_coding,
  output reg    ack_coding
  //TODO add signal
  );

  localparam  IDLE =     2'd0;
  localparam  CODING =   2'd1;
  localparam  TRAVERSE = 2'd2;
  reg         state;           // coding=0, traverse=1
  reg         next_state;
  reg  [3:0]  phase;
  reg  [3:0]  next_phase;

  reg  [18:0] mem [0:18];
  reg  [18:0] a0;
  reg  [18:0] a1;
  reg  [18:0] a2;
  reg  [18:0] a3;
  reg  [18:0] a4;
  reg  [18:0] a5;
  reg  [18:0] a6;
  reg  [18:0] a7;
  reg  [18:0] a8;
  reg  [18:0] a9;
  reg  [18:0] a10;
  reg  [18:0] a11;
  reg  [18:0] a12;
  reg  [18:0] a13;
  reg  [18:0] a14;
  reg  [18:0] a15;
  wire [18:0] sort0;
  wire [18:0] sort1;
  wire [18:0] sort2;
  wire [18:0] sort3;
  wire [18:0] sort4;
  wire [18:0] sort5;
  wire [18:0] sort6;
  wire [18:0] sort7;
  wire [18:0] sort8;
  wire [18:0] sort9;
  wire [18:0] sort10;
  wire [18:0] sort11;
  wire [18:0] sort12;
  wire [18:0] sort13;
  wire [18:0] sort14;
  wire [18:0] sort15;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
      ack_coding  <=  1'b0;
    else if (req_coding)
      ack_coding  <=  1'b1;
    else
      ack_coding  <=  1'b0;
  end

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <=  IDLE;
      phase <=  4'b0;
    end else begin
      state <=  next_state;
      phase <=  next_phase;
    end
  end

  always @(*) begin
    case (state)
    IDLE: begin
      if (req_coding)
        next_state  = CODING;
      else
        next_state  = IDLE;
      next_phase = 4'b0;
    end
    CODING: begin
      if (phase == 4'd9)
        next_state  = TRAVERSE;
      else
        next_state  = CODING;
      next_phase =  (phase == 4'd9) ? 4'b0 : phase + 1;
    end
    // TRAVERSE: begin
    //   //TODO
    // end
    default: begin
      next_state = state;
      next_phase = phase;
    end
    endcase
  end

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      a0    <=  19'b0;
      a1    <=  19'b0;
      a2    <=  19'b0;
      a3    <=  19'b0;
      a4    <=  19'b0;
      a5    <=  19'b0;
      a6    <=  19'b0;
      a7    <=  19'b0;
      a8    <=  19'b0;
      a9    <=  19'b0;
      a10   <=  19'b0;
      a11   <=  19'b0;
      a12   <=  19'b0;
      a13   <=  19'b0;
      a14   <=  19'b0;
      a15   <=  19'b0;
    end else if (state==CODING) begin
      case(phase)
      4'd0: begin
        a0    <=  data_out0;
        a1    <=  data_out1;
        a2    <=  data_out2;
        a3    <=  data_out3;
        a4    <=  data_out4;
        a5    <=  data_out5;
        a6    <=  data_out6;
        a7    <=  data_out7;
        a8    <=  data_out8;
        a9    <=  data_out9;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd1: begin
        a0    <=  {6'b0, 5'd10, sort0[7:0]+sort1[7:0]};
        a1    <=  sort2;
        a2    <=  sort3;
        a3    <=  sort4;
        a4    <=  sort5;
        a5    <=  sort6;
        a6    <=  sort7;
        a7    <=  sort8;
        a8    <=  sort9;
        a9    <=  19'd255;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd2: begin
        a0    <=  {6'b0, 5'd11, sort0[7:0]+sort1[7:0]};
        a1    <=  sort2;
        a2    <=  sort3;
        a3    <=  sort4;
        a4    <=  sort5;
        a5    <=  sort6;
        a6    <=  sort7;
        a7    <=  sort8;
        a8    <=  19'd255;
        a9    <=  19'd255;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd3: begin
        a0    <=  {6'b0, 5'd12, sort0[7:0]+sort1[7:0]};
        a1    <=  sort2;
        a2    <=  sort3;
        a3    <=  sort4;
        a4    <=  sort5;
        a5    <=  sort6;
        a6    <=  sort7;
        a7    <=  19'd255;
        a8    <=  19'd255;
        a9    <=  19'd255;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd4: begin
        a0    <=  {6'b0, 5'd13, sort0[7:0]+sort1[7:0]};
        a1    <=  sort2;
        a2    <=  sort3;
        a3    <=  sort4;
        a4    <=  sort5;
        a5    <=  sort6;
        a6    <=  19'd255;
        a7    <=  19'd255;
        a8    <=  19'd255;
        a9    <=  19'd255;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd5: begin
        a0    <=  {6'b0, 5'd14, sort0[7:0]+sort1[7:0]};
        a1    <=  sort2;
        a2    <=  sort3;
        a3    <=  sort4;
        a4    <=  sort5;
        a5    <=  19'd255;
        a6    <=  19'd255;
        a7    <=  19'd255;
        a8    <=  19'd255;
        a9    <=  19'd255;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd6: begin
        a0    <=  {6'b0, 5'd15, sort0[7:0]+sort1[7:0]};
        a1    <=  sort2;
        a2    <=  sort3;
        a3    <=  sort4;
        a4    <=  19'd255;
        a5    <=  19'd255;
        a6    <=  19'd255;
        a7    <=  19'd255;
        a8    <=  19'd255;
        a9    <=  19'd255;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd7: begin
        a0    <=  {6'b0, 5'd16, sort0[7:0]+sort1[7:0]};
        a1    <=  sort2;
        a2    <=  sort3;
        a3    <=  19'd255;
        a4    <=  19'd255;
        a5    <=  19'd255;
        a6    <=  19'd255;
        a7    <=  19'd255;
        a8    <=  19'd255;
        a9    <=  19'd255;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd8: begin
        a0    <=  {6'b0, 5'd17, sort0[7:0]+sort1[7:0]};
        a1    <=  sort2;
        a2    <=  19'd255;
        a3    <=  19'd255;
        a4    <=  19'd255;
        a5    <=  19'd255;
        a6    <=  19'd255;
        a7    <=  19'd255;
        a8    <=  19'd255;
        a9    <=  19'd255;
        a10   <=  19'd255;
        a11   <=  19'd255;
        a12   <=  19'd255;
        a13   <=  19'd255;
        a14   <=  19'd255;
        a15   <=  19'd255;
      end
      4'd9: begin
        a0    <=  19'b0;
        a1    <=  19'b0;
        a2    <=  19'b0;
        a3    <=  19'b0;
        a4    <=  19'b0;
        a5    <=  19'b0;
        a6    <=  19'b0;
        a7    <=  19'b0;
        a8    <=  19'b0;
        a9    <=  19'b0;
        a10   <=  19'b0;
        a11   <=  19'b0;
        a12   <=  19'b0;
        a13   <=  19'b0;
        a14   <=  19'b0;
        a15   <=  19'b0;
      end
      default: begin
        a0    <=  20'b0;
        a1    <=  20'b0;
        a2    <=  20'b0;
        a3    <=  20'b0;
        a4    <=  20'b0;
        a5    <=  20'b0;
        a6    <=  20'b0;
        a7    <=  20'b0;
        a8    <=  20'b0;
        a9    <=  20'b0;
        a10   <=  20'b0;
        a11   <=  20'b0;
        a12   <=  20'b0;
        a13   <=  20'b0;
        a14   <=  20'b0;
        a15   <=  20'b0;
      end
      endcase
    end else begin
      a0    <=  20'b0;
      a1    <=  20'b0;
      a2    <=  20'b0;
      a3    <=  20'b0;
      a4    <=  20'b0;
      a5    <=  20'b0;
      a6    <=  20'b0;
      a7    <=  20'b0;
      a8    <=  20'b0;
      a9    <=  20'b0;
      a10   <=  20'b0;
      a11   <=  20'b0;
      a12   <=  20'b0;
      a13   <=  20'b0;
      a14   <=  20'b0;
      a15   <=  20'b0;
    end
  end

  integer i;
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      for (i = 0; i < 19; i = i + 1) begin
        mem[i] <=  19'b0;
      end
    end else if (state==CODING) begin
      case (phase)
      4'd0: ;
      4'd1: begin
        mem[sort0[12:8]]  <=  {5'd10, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd10, 1'd1, sort1[12:0]};
      end
      4'd2: begin
        mem[sort0[12:8]]  <=  {5'd11, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd11, 1'd1, sort1[12:0]};
      end
      4'd3: begin
        mem[sort0[12:8]]  <=  {5'd12, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd12, 1'd1, sort1[12:0]};
      end
      4'd4: begin
        mem[sort0[12:8]]  <=  {5'd13, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd13, 1'd1, sort1[12:0]};
      end
      4'd5: begin
        mem[sort0[12:8]]  <=  {5'd14, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd14, 1'd1, sort1[12:0]};
      end
      4'd6: begin
        mem[sort0[12:8]]  <=  {5'd15, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd15, 1'd1, sort1[12:0]};
      end
      4'd7: begin
        mem[sort0[12:8]]  <=  {5'd16, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd16, 1'd1, sort1[12:0]};
      end
      4'd8: begin
        mem[sort0[12:8]]  <=  {5'd17, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd17, 1'd1, sort1[12:0]};
      end
      4'd9: begin
        mem[sort0[12:8]]  <=  {5'd18, 1'd0, sort0[12:0]};
        mem[sort1[12:8]]  <=  {5'd18, 1'd1, sort1[12:0]};
        mem[18]  <=  {5'd31, 1'd0, 5'd18, sort0[7:0]+sort1[7:0]};  // parent number 31
      end
      default:  ;
      endcase
    end
  end

  SortX16 # (
    .DSIZE  (5'd19),
    .OFFSET (4'd8)
    ) sortx16_inst0 (
      .a0       (a0),
      .a1       (a1),
      .a2       (a2),
      .a3       (a3),
      .a4       (a4),
      .a5       (a5),
      .a6       (a6),
      .a7       (a7),
      .a8       (a8),
      .a9       (a9),
      .a10      (a10),
      .a11      (a11),
      .a12      (a12),
      .a13      (a13),
      .a14      (a14),
      .a15      (a15),
      .sort0    (sort0),
      .sort1    (sort1),
      .sort2    (sort2),
      .sort3    (sort3),
      .sort4    (sort4),
      .sort5    (sort5),
      .sort6    (sort6),
      .sort7    (sort7),
      .sort8    (sort8),
      .sort9    (sort9),
      .sort10   (sort10),
      .sort11   (sort11),
      .sort12   (sort12),
      .sort13   (sort13),
      .sort14   (sort14),
      .sort15   (sort15)
    );

  //TODO traverse

  endmodule
