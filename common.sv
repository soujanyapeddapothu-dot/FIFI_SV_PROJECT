`define width 8
`define depth 16
`define ptr_width $clog2(`depth)
class fifo_common;
	static string test_name;
	static mailbox wr_gen2bfm=new();
	static mailbox wr_mon2cov=new();
	static mailbox wr_mon2sbd=new();
	static mailbox rd_gen2bfm=new();
	static mailbox rd_mon2cov=new();
	static mailbox rd_mon2sbd=new();
	static int wr_gen_count;
	static int wr_bfm_count;
	static int matchings,mismatchings;
endclass

