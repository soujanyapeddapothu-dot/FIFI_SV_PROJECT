class wr_cov;
	wr_tx tx;
	covergroup cg;
		coverpoint tx.wr_en{
			bins writes={1'b1};
		}
	endgroup
	function new();
		cg=new();
	endfunction
	task run();
		//$display("fifo coverage functionality will be happened");
		forever begin
			fifo_common::wr_mon2cov.get(tx);
			cg.sample();
			tx.print("wr_cov");
		end
	endtask
endclass
