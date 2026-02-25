class fifo_env;
	wr_age w_agn;
	rd_age r_agn;
	fifo_sbd sbd;
	task run();
        //$display("env functionality will be happened");
		w_agn=new();
		r_agn=new();
		sbd=new();
		fork
			w_agn.run();
			r_agn.run();
			sbd.run();
		join
	endtask
endclass
