class rd_age;
	rd_gen gen;
	rd_bfm bfm;
	rd_mon mon;
	rd_cov cov;
	task run();
		//$display("rd_agent functionality will be happened");
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
