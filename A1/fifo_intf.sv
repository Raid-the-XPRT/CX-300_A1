interface fifo_intf #(DATA_WIDTH=8,DEPTH=8) (input clk);

// .clk, .read, .write, .addr,
            //   .data_in, .data_out
logic rst_n;            
logic wr_en;
logic rd_en;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;
logic full;
logic empty;

bit verbose=0;

    modport fifo(input rst_n,input wr_en,input rd_en,input data_in,output full,output empty,output data_out);
    modport fifo_test(output rst_n,output wr_en,output rd_en, output data_in,input full,input empty,input data_out);


task fifo_write(input [DATA_WIDTH-1:0] data_entered);
if(verbose) $display("writing data (%b) to fifo",data_entered);
@(negedge clk) rd_en=0; wr_en=1 ;rst_n=1; data_in=data_entered;
if(verbose) $display("Writing Data is done");                                         
endtask

task fifo_read(output [DATA_WIDTH-1:0] read_data); 
if(verbose) $display("Reading data from FIFO");
  @(negedge clk) rd_en=1; wr_en=0;rst_n=1;
  @(negedge clk) read_data=data_out;
if(verbose) $display("Reading data is successfull, data is: %b",read_data);       
endtask

task fifo_read_write(input [DATA_WIDTH-1:0] data_entered); 
if(verbose) $display("Reading and writing on FIFO");
fifo_write(data_entered);
fifo_read(data_out);                                               
endtask

task fifo_reset(); 
if(verbose) $display("Resetting FIFO");
@(negedge clk) rd_en=0;wr_en=0;rst_n=0;data_in=0;
if(verbose) $display("FIFO has been reset");
endtask
endinterface 

