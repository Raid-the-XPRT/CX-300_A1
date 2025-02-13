`include "/home/Raid_Al-Tamimi/Verification/Assignments/A1/fifo.sv"
`include "/home/Raid_Al-Tamimi/Verification/Assignments/A1/fifo_intf.sv"
`include "/home/Raid_Al-Tamimi/Verification/Assignments/A1/fifo_test.sv"
module top;

bit         clk;

fifo_intf myInterf (.clk(clk));

fifo_test fifo_tst1 (.clk(clk),.interf(myInterf));
synchronous_fifo fifo1 ( .clk(clk),.rst_n(myInterf.rst_n),.w_en(myInterf.wr_en),.r_en(myInterf.rd_en),.data_in(myInterf.data_in),.data_out(myInterf.data_out),.full(myInterf.full),.empty(myInterf.empty));

always #5 clk = ~clk;
endmodule

