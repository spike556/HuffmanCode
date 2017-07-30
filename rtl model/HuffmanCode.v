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
  input             clk,
  input             rst_n,
  input [18:0]      data_in0,
  input [18:0]      data_in1,
  input [18:0]      data_in2,
  input [18:0]      data_in3,
  input [18:0]      data_in4,
  input [18:0]      data_in5,
  input [18:0]      data_in6,
  input [18:0]      data_in7,
  input [18:0]      data_in8,
  input [18:0]      data_in9,
  input             req_coding,
  output reg        ack_coding,
  output reg [8:0]  data_out,
  output reg [3:0]  data_len,
  output wire       trans_start
  );

  localparam  IDLE =     2'd0;
  localparam  CODING =   2'd1;
  localparam  TRAVERSE = 2'd2;
  localparam  OUTPUT =   2'd3;
  reg  [1:0]  state;           // coding=0, traverse=1
  reg  [1:0]  next_state;
  reg  [3:0]  phase;
  reg  [3:0]  next_phase;
  reg  [3:0]  loop;
  reg  [3:0]  next_loop;

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
      loop  <=  4'd0;
    end else begin
      state <=  next_state;
      phase <=  next_phase;
      loop  <=  next_loop;
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
      next_loop = 4'd0;
    end
    CODING: begin
      if (phase == 4'd9) begin
        next_state  = TRAVERSE;
        next_phase = 4'd0;
      end else begin
        next_state  = CODING;
        next_phase = phase + 1;
      end
      next_loop = 4'd0;
    end
    TRAVERSE: begin
      if (phase == 4'd8) begin
        next_state  = OUTPUT;
        next_phase = 4'd0;
        next_loop = code_length[0];
      end else begin
        next_state  = TRAVERSE;
        next_phase = phase + 1;
        next_loop = 4'd0;
      end
    end
    OUTPUT: begin
      if (loop == 4'd1) begin
        if (phase == 4'd9) begin
          next_state = IDLE;
          next_phase = 4'd0;
          next_loop = 4'd0;
        end else begin
          next_state = OUTPUT;
          next_phase = phase + 1;
          next_loop = code_length[phase+1];
        end
      end
      else begin
        next_state = OUTPUT;
        next_phase = phase;
        next_loop = loop - 1;
      end
    end
    default: begin
      next_state = state;
      next_phase = phase;
      next_loop = loop;
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
    end
    else if (state==CODING) begin
      case(phase)
      4'd0: begin
        a0    <=  data_in0;
        a1    <=  data_in1;
        a2    <=  data_in2;
        a3    <=  data_in3;
        a4    <=  data_in4;
        a5    <=  data_in5;
        a6    <=  data_in6;
        a7    <=  data_in7;
        a8    <=  data_in8;
        a9    <=  data_in9;
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
    end
    else begin
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
    end
    else if (state == CODING) begin
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

  // traverse
  genvar j;
  reg [8:0] code_result [0:9];
  reg [3:0] code_length [0:9];
  reg [4:0] index [0:9];

  generate
    for (j = 0; j < 10; j = j + 1) begin
      always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
          code_result[j]  <=  9'b0;
          code_length[j]  <=  4'b0;
          index[j]  <=  5'b0;
        end else if (state == TRAVERSE) begin
          case (phase)
          4'd0: begin
            code_result[j][0]  <=  mem[j][13];
            code_length[j]  <=  code_length[j] + 1;
            index[j]  <=  mem[j][18:14];
          end
          4'd1: begin
            if (index[j] != 5'd18) begin
              code_result[j][1]  <= mem[index[j]][13];
              code_length[j]  <=  code_length[j] + 1;
              index[j]  <=  mem[index[j]][18:14];
            end
          end
          4'd2: begin
            if (index[j] != 5'd18) begin
              code_result[j][2]  <= mem[index[j]][13];
              code_length[j]  <=  code_length[j] + 1;
              index[j]  <=  mem[index[j]][18:14];
            end
          end
          4'd3: begin
            if (index[j] != 5'd18) begin
              code_result[j][3]  <=  mem[index[j]][13];
              code_length[j]  <=  code_length[j] + 1;
              index[j]  <=  mem[index[j]][18:14];
            end
          end
          4'd4: begin
            if (index[j] != 5'd18) begin
              code_result[j][4]  <= mem[index[j]][13];
              code_length[j]  <=  code_length[j] + 1;
              index[j]  <=  mem[index[j]][18:14];
            end
          end
          4'd5: begin
            if (index[j] != 5'd18) begin
              code_result[j][5]  <= mem[index[j]][13];
              code_length[j]  <=  code_length[j] + 1;
              index[j]  <=  mem[index[j]][18:14];
            end
          end
          4'd6: begin
            if (index[j] != 5'd18) begin
              code_result[j][6]  <= mem[index[j]][13];
              code_length[j]  <=  code_length[j] + 1;
              index[j]  <=  mem[index[j]][18:14];
            end
          end
          4'd7: begin
            if (index[j] != 5'd18) begin
              code_result[j][7]  <= mem[index[j]][13];
              code_length[j]  <=  code_length[j] + 1;
              index[j]  <=  mem[index[j]][18:14];
            end
          end
          4'd8: begin
            if (index[j] != 5'd18) begin
              code_result[j][8]  <= mem[index[j]][13];
              code_length[j]  <=  code_length[j] + 1;
              index[j]  <=  mem[index[j]][18:14];
            end
          end
          default:  begin
            code_result[j]  <= 9'b0;
            code_length[j]  <= 4'b0;
            index[j]  <=  5'b0;
          end
          endcase
        end
      end
    end
  endgenerate

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      data_out  <=  9'd0;
      data_len  <=  4'd0;
    end
    else begin
      if (next_state == OUTPUT) begin
        data_out  <=  code_result[next_phase];
        data_len  <=  code_length[next_phase];
      end
      else begin
        data_out  <=  9'd0;
        data_len  <=  4'd0;
      end
    end
  end

  assign trans_start =  (state == OUTPUT) ? 1'b1 : 1'b0;

endmodule
