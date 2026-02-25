module asynchfifo(wr_clk,rd_clk,res,wr_en,wdata,full,overflow,rd_en,rdata,empty,underflow);

input wr_clk,rd_clk,res,wr_en,rd_en;
input [`width-1:0]wdata;

output reg[`width-1:0]rdata;
output reg full,overflow,empty,underflow;

integer i;

reg [`width-1:0]asynchfifo[`depth-1:0];
reg [`ptr_width-1:0]wr_ptr,rd_ptr;
reg wr_toggle_f,rd_toggle_f;

// synchronized pointers
reg [`ptr_width-1:0]rd_ptr_wr_clk,wr_ptr_rd_clk;
reg rd_toggle_f_wr_clk,wr_toggle_f_rd_clk;

/////////////////////////////////////////////////////////
// WRITE DOMAIN
/////////////////////////////////////////////////////////
always @(posedge wr_clk) begin
if(res==1) begin
    full=0;
    overflow=0;
    wr_ptr=0;
    wr_toggle_f=0;
    rd_ptr_wr_clk=0;
    rd_toggle_f_wr_clk=0;
end
else begin

    // synchronize read pointer into write clock
    rd_ptr_wr_clk = rd_ptr;
    rd_toggle_f_wr_clk = rd_toggle_f;

    if(wr_en==1) begin
        if(full==1) begin
            overflow=1;
        end
        else begin
            asynchfifo[wr_ptr]=wdata;

            if(wr_ptr==`depth-1) begin
                wr_toggle_f=~wr_toggle_f;
                wr_ptr=0;
            end
            else begin
                wr_ptr=wr_ptr+1;
            end
        end
    end
end
end

/////////////////////////////////////////////////////////
// READ DOMAIN
/////////////////////////////////////////////////////////
always @(posedge rd_clk) begin
if(res==1) begin
    empty=1;
    underflow=0;
    rd_ptr=0;
    rd_toggle_f=0;
    wr_ptr_rd_clk=0;
    wr_toggle_f_rd_clk=0;
    rdata=0;
end
else begin

    // synchronize write pointer into read clock
    wr_ptr_rd_clk = wr_ptr;
    wr_toggle_f_rd_clk = wr_toggle_f;

    if(rd_en==1) begin
        if(empty==1) begin
            underflow=1;
        end
        else begin
            rdata=asynchfifo[rd_ptr];

            if(rd_ptr==`depth-1) begin
                rd_toggle_f=~rd_toggle_f;
                rd_ptr=0;
            end
            else begin
                rd_ptr=rd_ptr+1;
            end
        end
    end
end
end

/////////////////////////////////////////////////////////
// FULL & EMPTY LOGIC
/////////////////////////////////////////////////////////
always @(*) begin

full=0;
empty=0;

// FULL condition
if((wr_ptr==rd_ptr_wr_clk) && (wr_toggle_f!=rd_toggle_f_wr_clk))
    full=1;

// EMPTY condition
if((wr_ptr_rd_clk==rd_ptr) && (wr_toggle_f_rd_clk==rd_toggle_f))
    empty=1;

end

endmodule
