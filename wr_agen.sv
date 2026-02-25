class wr_age;
	wr_gen gen;
	wr_bfm bfm;
	wr_mon mon;
	wr_cov cov;
	task run();
		//$display("wr_agent functionality will be happened");
		gen=new();
		bfm=new();
		mon=new();
		cov=new();
	fork
		gen.run();
		bfm.run();
		mon.run();
		cov.run();
	join
	endtask
endclass
