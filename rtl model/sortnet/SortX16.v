module SortX16 # (
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
  input       [DSIZE-1:0] a8,
  input       [DSIZE-1:0] a9,
  input       [DSIZE-1:0] a10,
  input       [DSIZE-1:0] a11,
  input       [DSIZE-1:0] a12,
  input       [DSIZE-1:0] a13,
  input       [DSIZE-1:0] a14,
  input       [DSIZE-1:0] a15,
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

  wire [DSIZE-1:0] sortX8_0_0;
  wire [DSIZE-1:0] sortX8_0_1;
  wire [DSIZE-1:0] sortX8_0_2;
  wire [DSIZE-1:0] sortX8_0_3;
  wire [DSIZE-1:0] sortX8_0_4;
  wire [DSIZE-1:0] sortX8_0_5;
  wire [DSIZE-1:0] sortX8_0_6;
  wire [DSIZE-1:0] sortX8_0_7;
  wire [DSIZE-1:0] sortX8_1_0;
  wire [DSIZE-1:0] sortX8_1_1;
  wire [DSIZE-1:0] sortX8_1_2;
  wire [DSIZE-1:0] sortX8_1_3;
  wire [DSIZE-1:0] sortX8_1_4;
  wire [DSIZE-1:0] sortX8_1_5;
  wire [DSIZE-1:0] sortX8_1_6;
  wire [DSIZE-1:0] sortX8_1_7;

  wire [DSIZE-1:0] sort0_0;
  wire [DSIZE-1:0] sort0_1;
  wire [DSIZE-1:0] sort1_0;
  wire [DSIZE-1:0] sort1_1;
  wire [DSIZE-1:0] sort2_0;
  wire [DSIZE-1:0] sort2_1;
  wire [DSIZE-1:0] sort3_0;
  wire [DSIZE-1:0] sort3_1;
  wire [DSIZE-1:0] sort4_0;
  wire [DSIZE-1:0] sort4_1;
  wire [DSIZE-1:0] sort5_0;
  wire [DSIZE-1:0] sort5_1;
  wire [DSIZE-1:0] sort6_0;
  wire [DSIZE-1:0] sort6_1;
  wire [DSIZE-1:0] sort7_0;
  wire [DSIZE-1:0] sort7_1;

  // divide sort
  SortX8 # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sortX8_inst0 (
    .a0       (a0),
    .a1       (a1),
    .a2       (a2),
    .a3       (a3),
    .a4       (a4),
    .a5       (a5),
    .a6       (a6),
    .a7       (a7),
    .sort0    (sortX8_0_0),
    .sort1    (sortX8_0_1),
    .sort2    (sortX8_0_2),
    .sort3    (sortX8_0_3),
    .sort4    (sortX8_0_4),
    .sort5    (sortX8_0_5),
    .sort6    (sortX8_0_6),
    .sort7    (sortX8_0_7)
  );
  SortX8 # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sortX8_inst1 (
    .a0       (a8),
    .a1       (a9),
    .a2       (a10),
    .a3       (a11),
    .a4       (a12),
    .a5       (a13),
    .a6       (a14),
    .a7       (a15),
    .sort0    (sortX8_1_0),
    .sort1    (sortX8_1_1),
    .sort2    (sortX8_1_2),
    .sort3    (sortX8_1_3),
    .sort4    (sortX8_1_4),
    .sort5    (sortX8_1_5),
    .sort6    (sortX8_1_6),
    .sort7    (sortX8_1_7)
  );

  // merge
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst0 (
    .a(sortX8_0_0),
    .b(sortX8_1_7),
    .sort0(sort0_0),
    .sort1(sort0_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst1 (
    .a(sortX8_0_1),
    .b(sortX8_1_6),
    .sort0(sort1_0),
    .sort1(sort1_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst2 (
    .a(sortX8_0_2),
    .b(sortX8_1_5),
    .sort0(sort2_0),
    .sort1(sort2_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst3 (
    .a(sortX8_0_3),
    .b(sortX8_1_4),
    .sort0(sort3_0),
    .sort1(sort3_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst4 (
    .a(sortX8_0_4),
    .b(sortX8_1_3),
    .sort0(sort4_0),
    .sort1(sort4_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst5 (
    .a(sortX8_0_5),
    .b(sortX8_1_2),
    .sort0(sort5_0),
    .sort1(sort5_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst6 (
    .a(sortX8_0_6),
    .b(sortX8_1_1),
    .sort0(sort6_0),
    .sort1(sort6_1)
  );
  SortElement # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) sort_inst7 (
    .a(sortX8_0_7),
    .b(sortX8_1_0),
    .sort0(sort7_0),
    .sort1(sort7_1)
  );

  // bitonic
  BitonicSortX8 # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) bitonicsortx8_inst0 (
    .a0       (sort0_0),
    .a1       (sort1_0),
    .a2       (sort2_0),
    .a3       (sort3_0),
    .a4       (sort4_0),
    .a5       (sort5_0),
    .a6       (sort6_0),
    .a7       (sort7_0),
    .sort0    (sort0),
    .sort1    (sort1),
    .sort2    (sort2),
    .sort3    (sort3),
    .sort4    (sort4),
    .sort5    (sort5),
    .sort6    (sort6),
    .sort7    (sort7)
  );
  BitonicSortX8 # (
    .DSIZE (DSIZE),
    .OFFSET(OFFSET)
  ) bitonicsortx8_inst1 (
    .a0       (sort7_1),
    .a1       (sort6_1),
    .a2       (sort5_1),
    .a3       (sort4_1),
    .a4       (sort3_1),
    .a5       (sort2_1),
    .a6       (sort1_1),
    .a7       (sort0_1),
    .sort0    (sort8),
    .sort1    (sort9),
    .sort2    (sort10),
    .sort3    (sort11),
    .sort4    (sort12),
    .sort5    (sort13),
    .sort6    (sort14),
    .sort7    (sort15)
  );

endmodule
