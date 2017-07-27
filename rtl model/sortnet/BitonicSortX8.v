module BitonicSortX8 # (
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

  wire [DSIZE-1:0] sort0_0;
  wire [DSIZE-1:0] sort0_1;
  wire [DSIZE-1:0] sort1_0;
  wire [DSIZE-1:0] sort1_1;
  wire [DSIZE-1:0] sort2_0;
  wire [DSIZE-1:0] sort2_1;
  wire [DSIZE-1:0] sort3_0;
  wire [DSIZE-1:0] sort3_1;
  
  // half-clean
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst0 (
    .a(a0),
    .b(a4),
    .sort0(sort0_0),
    .sort1(sort0_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst1 (
    .a(a1),
    .b(a5),
    .sort0(sort1_0),
    .sort1(sort1_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst2 (
    .a(a2),
    .b(a6),
    .sort0(sort2_0),
    .sort1(sort2_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst3 (
    .a(a3),
    .b(a7),
    .sort0(sort3_0),
    .sort1(sort3_1)
  );
  // divide sort
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
    .a0     (sort0_1),
    .a1     (sort1_1),
    .a2     (sort2_1),
    .a3     (sort3_1),
    .sort0  (sort4),
    .sort1  (sort5),
    .sort2  (sort6),
    .sort3  (sort7)
  );

endmodule
