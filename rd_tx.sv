class rd_tx;
	rand bit rd_en;
	rand bit[`width-1:0]rdata;
	bit empty,underflow;
	function void print(input string str="wr_tx");
		$display("--------%0t-----%0s---------",$time,str);
		$display("rd_en=%b",rd_en);
		$display("rdata=%d",rdata);
		$display("empty=%b",empty);
		$display("underflow=%b",underflow);
	endfunction
	constraint rd_c{
		rd_en==1'b1;
	}

endclass
