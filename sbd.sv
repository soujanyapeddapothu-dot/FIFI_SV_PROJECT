class fifo_sbd;
	wr_tx w_tx;
	rd_tx r_tx;
	int que[$];
	int data;
	task run();
		//$display("sbd functionality will be happened");
		forever begin
			fifo_common::wr_mon2sbd.get(w_tx);
			//w_tx.print("wr_sbd");
			if(w_tx.wr_en==1)begin
				que.push_back(w_tx.wdata);
			end
			fifo_common::rd_mon2sbd.get(r_tx);
			if(r_tx.rd_en==1)begin
				data=que.pop_front();
				if(data==r_tx.rdata)fifo_common::matchings++;
				else fifo_common::mismatchings++;
			end
			//r_tx.print("rd_sbd");
		end
	endtask
endclass
