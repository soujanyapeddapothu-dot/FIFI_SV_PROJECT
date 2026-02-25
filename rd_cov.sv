class rd_cov;
	rd_tx tx;
	covergroup cg1;
		coverpoint tx.rd_en{
			bins reads={1'b1};
		}
	endgroup
	function new();
		cg1=new();
	endfunction
	task run();
		//$display("rd_cov functionality will be happened");
		forever begin
			fifo_common::rd_mon2cov.get(tx);
			cg1.sample();
			tx.print("rd_cov");
		end
	endtask
endclass
