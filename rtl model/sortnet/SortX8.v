module SortX8 # (
  parameter DSIZE = 18,
  parameter OFFSET = 8
  )(
  input       [DSIZE-1:0] a0,
  input       [DSIZE-1:0] a1,
  input       [DSIZE-1:0] a2,
  input       [DSIZE-1:0] a3,
  input       [DSIZE-1:0] a4,
  input       [DSIZE-1:0] a5,
  input       [DSIZE-1:0] a6,
  input       [DSIZE-1:0] a7,
  output wire [DSIZE-1:0] sort0,
  output wire [DSIZE-1:0] sort1,
  output wire [DSIZE-1:0] sort2,
  output wire [DSIZE-1:0] sort3,
  output wire [DSIZE-1:0] sort4,
  output wire [DSIZE-1:0] sort5,
  output wire [DSIZE-1:0] sort6,
  output wire [DSIZE-1:0] sort7
  );

  wire [DSIZE-1:0] sortx4_0_0;
  wire [DSIZE-1:0] sortx4_0_1;
  wire [DSIZE-1:0] sortx4_0_2;
  wire [DSIZE-1:0] sortx4_0_3;
  wire [DSIZE-1:0] sortx4_1_0;
  wire [DSIZE-1:0] sortx4_1_1;
  wire [DSIZE-1:0] sortx4_1_2;
  wire [DSIZE-1:0] sortx4_1_3;

  wire [DSIZE-1:0] sort0_0;
  wire [DSIZE-1:0] sort0_1;
  wire [DSIZE-1:0] sort1_0;
  wire [DSIZE-1:0] sort1_1;
  wire [DSIZE-1:0] sort2_0;
  wire [DSIZE-1:0] sort2_1;
  wire [DSIZE-1:0] sort3_0;
  wire [DSIZE-1:0] sort3_1;

  // divide sort
  SortX4 # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sortx4_inst0 (
    .a0     (a0),
    .a1     (a1),
    .a2     (a2),
    .a3     (a3),
    .sort0  (sortx4_0_0),
    .sort1  (sortx4_0_1),
    .sort2  (sortx4_0_2),
    .sort3  (sortx4_0_3)
  );
  SortX4 # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sortx4_inst1 (
    .a0     (a4),
    .a1     (a5),
    .a2     (a6),
    .a3     (a7),
    .sort0  (sortx4_1_0),
    .sort1  (sortx4_1_1),
    .sort2  (sortx4_1_2),
    .sort3  (sortx4_1_3)
  );

  // merge
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst0 (
    .a(sortx4_0_0),
    .b(sortx4_1_3),
    .sort0(sort0_0),
    .sort1(sort0_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst1 (
    .a(sortx4_0_1),
    .b(sortx4_1_2),
    .sort0(sort1_0),
    .sort1(sort1_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst2 (
    .a(sortx4_0_2),
    .b(sortx4_1_1),
    .sort0(sort2_0),
    .sort1(sort2_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst3 (
    .a(sortx4_0_3),
    .b(sortx4_1_0),
    .sort0(sort3_0),
    .sort1(sort3_1)
  );

  // bitonic
  BitonicSortX4 # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) bitonicsortx4_inst0 (
    .a0     (sort0_0),
    .a1     (sort1_0),
    .a2     (sort2_0),
    .a3     (sort3_0),
    .sort0  (sort0),
    .sort1  (sort1),
    .sort2  (sort2),
    .sort3  (sort3)
  );
  BitonicSortX4 # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) bitonicsortx4_inst1 (
    .a0     (sort3_1),
    .a1     (sort2_1),
    .a2     (sort1_1),
    .a3     (sort0_1),
    .sort0  (sort4),
    .sort1  (sort5),
    .sort2  (sort6),
    .sort3  (sort7)
  );

endmodule
