module SortX4 # (
  parameter DSIZE = 18,
  parameter OFFSET = 8
  )(
  input       [DSIZE-1:0] a0,
  input       [DSIZE-1:0] a1,
  input       [DSIZE-1:0] a2,
  input       [DSIZE-1:0] a3,
  output wire [DSIZE-1:0] sort0,
  output wire [DSIZE-1:0] sort1,
  output wire [DSIZE-1:0] sort2,
  output wire [DSIZE-1:0] sort3
  );

  wire [DSIZE-1:0] sort0_0;
  wire [DSIZE-1:0] sort0_1;
  wire [DSIZE-1:0] sort1_0;
  wire [DSIZE-1:0] sort1_1;
  wire [DSIZE-1:0] sort2_0;
  wire [DSIZE-1:0] sort2_1;
  wire [DSIZE-1:0] sort3_0;
  wire [DSIZE-1:0] sort3_1;

  // divide sort
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst0 (
    .a(a0),
    .b(a1),
    .sort0(sort0_0),
    .sort1(sort0_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst1 (
    .a(a2),
    .b(a3),
    .sort0(sort1_0),
    .sort1(sort1_1)
  );

  // merge
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst2 (
    .a(sort0_0),
    .b(sort1_1),
    .sort0(sort2_0),
    .sort1(sort2_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst3 (
    .a(sort0_1),
    .b(sort1_0),
    .sort0(sort3_0),
    .sort1(sort3_1)
  );

  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst4 (
    .a(sort2_0),
    .b(sort3_0),
    .sort0(sort0),
    .sort1(sort1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst5 (
    .a(sort3_1),
    .b(sort2_1),
    .sort0(sort2),
    .sort1(sort3)
  );

endmodule
