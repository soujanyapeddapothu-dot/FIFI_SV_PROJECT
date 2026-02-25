class wr_gen;
	wr_tx tx;
	task run();
		//$display("fifo wr_generator functionality will be happened");
		case(fifo_common::test_name)
			"full":begin
				writes(`depth);
			end
			"empty":begin
				fifo_common::wr_gen_count=`depth;
				writes(`depth);
			end
			"overflow":begin
			end
			"underflow":begin
			end
			"cocurrent":begin
			end
		endcase
	endtask
	task writes(input int n);
		repeat(n)begin
			tx=new();
			tx.randomize();
			fifo_common::wr_gen2bfm.put(tx);
			tx.print("wr_gen");
		end
	endtask
endclass
