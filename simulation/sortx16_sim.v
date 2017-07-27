`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/07/25 17:45:20
// Design Name:
// Module Name: sortx16_sim
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


module sortx16_sim # (
  parameter DSIZE = 5,
  parameter OFFSET = 4
  )(
  output wire [DSIZE-1:0] sort0,
  output wire [DSIZE-1:0] sort1,
  output wire [DSIZE-1:0] sort2,
  output wire [DSIZE-1:0] sort3,
  output wire [DSIZE-1:0] sort4,
  output wire [DSIZE-1:0] sort5,
  output wire [DSIZE-1:0] sort6,
  output wire [DSIZE-1:0] sort7,
  output wire [DSIZE-1:0] sort8,
  output wire [DSIZE-1:0] sort9,
  output wire [DSIZE-1:0] sort10,
  output wire [DSIZE-1:0] sort11,
  output wire [DSIZE-1:0] sort12,
  output wire [DSIZE-1:0] sort13,
  output wire [DSIZE-1:0] sort14,
  output wire [DSIZE-1:0] sort15
  );

    SortX16 # (
      .DSIZE (DSIZE),
      .OFFSET(OFFSET)
    ) sortx16_inst(
      .a0       (5'd3),
      .a1       (5'd9),
      .a2       (5'd15),
      .a3       (5'd6),
      .a4       (5'd12),
      .a5       (5'd2),
      .a6       (5'd8),
      .a7       (5'd14),
      .a8       (5'd4),
      .a9       (5'd10),
      .a10      (5'd0),
      .a11      (5'd1),
      .a12      (5'd7),
      .a13      (5'd23),
      .a14      (5'd13),
      .a15      (5'd5),
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
    
endmodule
