module fifo_test #(parameter FIFO_WIDTH=8)( input logic clk, 
                  fifo_intf interf
                );




// SYSTEMVERILOG: new data types - bit ,logic
bit verbose=0;
bit TEST_write=0;
bit TEST_read=0;
bit TEST_write_read=0;
bit TEST_reset=0;
bit TEST_full=0;
bit TEST_empty=0;
logic [FIFO_WIDTH-1:0] data_buff;


// Monitor Results
  initial begin
      $timeformat ( -9, 0, " ns", 9 );
// SYSTEMVERILOG: Time Literals
      #40000ns $display ( "FIFO TEST TIMEOUT" );
      printstatus();
    end

task reset_and_check(); begin
    $display("FIFO RESET STARTED\n\n");

    interf.fifo_reset();
    
    $display("FIFO HAS BEEN RESET\n\n");

    $display("TEST IF EMPTY FLAG IS ACTIVE\n\n");
    @(negedge clk)
    if(interf.empty==1) begin $display("THE EMPTY FLAG IS ACTIVE!"); TEST_reset=1; end
    else begin $display("THE EMPTY FLAG IS INACTIVE!"); TEST_reset=0; end
                        end
endtask


initial
  begin 

  
        $display("FIFO TEST STARTED\n");
        $display("INITIAL FIFO RESET AND CHECK STARTED\n");

        reset_and_check();

        $display("INITIAL FIFO RESET AND CHECK DONE\n");

        $display("FIFO WRITE TEST STARTED\n");
        interf.fifo_write(8'b11111111);
        interf.fifo_write(8'b10101010);
        interf.fifo_write(8'b01010101);
        interf.fifo_write(8'b00001111);
        interf.fifo_write(8'b11110000);
        interf.fifo_write(8'b00000001);
        interf.fifo_write(8'b00000011);
        interf.fifo_write(8'b00000111);


        $display("FIFO WRITE TEST DONE\n");  
        $display("FIFO FULL TEST STARTED\n");
        TEST_full=interf.full;
        $display("FIFO FULL TEST DONE\n");
        $display("FIFO READ TEST STARTED\n");
        interf.fifo_read(data_buff) ;if(data_buff==8'b11111111) begin TEST_read=1; TEST_write=1; end else begin TEST_read=0; TEST_write=0; end
        interf.fifo_read(data_buff); if(data_buff==8'b10101010) begin TEST_read=1; TEST_write=1; end else begin TEST_read=0; TEST_write=0; end
        interf.fifo_read(data_buff); if(data_buff==8'b01010101) begin TEST_read=1; TEST_write=1; end else begin TEST_read=0; TEST_write=0; end
        interf.fifo_read(data_buff); if(data_buff==8'b00001111) begin TEST_read=1; TEST_write=1; end else begin TEST_read=0; TEST_write=0; end
        interf.fifo_read(data_buff); if(data_buff==8'b11110000) begin TEST_read=1; TEST_write=1; end else begin TEST_read=0; TEST_write=0; end
        interf.fifo_read(data_buff); if(data_buff==8'b00000001) begin TEST_read=1; TEST_write=1; end else begin TEST_read=0; TEST_write=0; end
        interf.fifo_read(data_buff); if(data_buff==8'b00000011) begin TEST_read=1; TEST_write=1; end else begin TEST_read=0; TEST_write=0; end
        interf.fifo_read(data_buff); if(data_buff==8'b11100000) begin TEST_read=1; TEST_write=1; end else begin TEST_read=0; TEST_write=0; end
        $display("FIFO READ TEST DONE\n");
        $display("FIFO EMPTY TEST STARTED\n");
        TEST_empty=interf.empty;
        $display("FIFO EMPTY TEST DONE\n");
        $display("FIFO TEST DONE\n");
        printstatus();
        
  end


function void printstatus();
begin
   // print results of test
  $display("-----------------------------------------------------");
  $display("-------------------FIFO Test summary:----------------");
  $display("-----------------------------------------------------");
  $display("Reset test results\t\t:\t%d",TEST_reset);
  $display("Write test results\t\t:\t%d",TEST_write);
  $display("Full test results\t\t:\t%d",TEST_full);
  $display("Read test results\t\t:\t%d",TEST_read);
  $display("Empty test results\t\t:\t%d",TEST_empty);
  $display("-----------------------------------------------------");
  $display("------------------End of Test Summary----------------");
  $display("-----------------------------------------------------");
    $finish;
end
endfunction

endmodule


