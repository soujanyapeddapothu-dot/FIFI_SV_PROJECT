module top;
	reg wr_clk,rd_clk,res;
	fifo_env env;
	fifo_intrf pif(wr_clk,rd_clk,res);
	always #5 wr_clk=~wr_clk;
	always #7 rd_clk=~rd_clk;
	asynchfifo dut(.wr_clk(pif.wr_clk),
				   .rd_clk(pif.rd_clk),
				   .res(pif.res),
				   .wr_en(pif.wr_en),
				   .rd_en(pif.rd_en),
				   .wdata(pif.wdata),
				   .full(pif.full),
				   .overflow(pif.overflow),
				   .rdata(pif.rdata),
				   .empty(pif.empty),
				   .underflow(pif.underflow));
	initial begin
		wr_clk=0;
		rd_clk=0;
		res=1;
		repeat(2)@(posedge wr_clk);
		res=0;
		$value$plusargs("test_name=%s",fifo_common::test_name);
		//$display("testbench functionality will be happened");
		env=new();
		env.run();
	end
	initial begin
		#800;
		if(fifo_common::matchings!=0 && fifo_common::mismatchings==0) begin
			$display("test passed");
			$display("matchings=%0d,mismatchings=%0d",fifo_common::matchings,fifo_common::mismatchings);
		end
		else begin
				$display("test failed");
			$display("matchings=%0d,mismatchings=%0d",fifo_common::matchings,fifo_common::mismatchings);

		end
		$finish;
	end
endmodule
