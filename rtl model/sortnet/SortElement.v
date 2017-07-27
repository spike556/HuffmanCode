module SortElement # (
  parameter DSIZE = 18,
  parameter OFFSET = 8
  )(
  input         [DSIZE-1:0] a,
  input         [DSIZE-1:0] b,
  output wire   [DSIZE-1:0] sort0,
  output wire   [DSIZE-1:0] sort1
  );

  assign sort0 = a[OFFSET-1:0] > b[OFFSET-1:0] ? b : a;
  assign sort1 = a[OFFSET-1:0] > b[OFFSET-1:0] ? a : b;

  endmodule
