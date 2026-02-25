class rd_gen;
	rd_tx tx;
	task run();
		//$display("rd_generator functionality will be happened");
		case(fifo_common::test_name)
			"full":begin
				
			
			end
			"empty":begin
				wait(fifo_common::wr_gen_count==fifo_common::wr_bfm_count);
				reads(`depth);

			end
			"overflow":begin
			end
			"underflow":begin
			end
			"cocurrent":begin
			end

	    endcase
	endtask
	task reads(input int n);
		repeat(n)begin
			tx=new();
			tx.randomize();
			fifo_common::rd_gen2bfm.put(tx);
			tx.print("rd_gen");
		end
		
	endtask
endclass
