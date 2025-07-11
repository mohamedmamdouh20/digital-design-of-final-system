module RST_SYNC_tb #(parameter NUM_STAGES_tb = 3);

  reg           CLK_tb;
  reg           RST_tb;
  wire          RST_SYNC_tb;

  parameter CLK_PERIOD = 10;
  
  
  
//------------ initial block ------------
  
  initial
    begin
      $dumpfile("RST_SYNC.vcd");
      $dumpvars;
      initialize;
      
      #(3*CLK_PERIOD);
      @(posedge CLK_tb);
      reset;
      
      #(4*CLK_PERIOD);
      #3;
      $display("hello 1");
      reset;
      $display("hello 2");
      
      #100
      $finish;
    end

  
//------------ tasks ------------
  task initialize;
    begin
      CLK_tb = 0;
      RST_tb = 1;
    end
  endtask
  
  task reset;
    begin
      #(CLK_PERIOD);
      RST_tb = 0;
      #(CLK_PERIOD);
      RST_tb = 1;
      #(CLK_PERIOD);
    end
  endtask
  
  task delay;
    input   integer     delay;
    begin
      #(delay);
    end
  endtask
  
//------------ clock generator ------------
  always #(CLK_PERIOD / 2) CLK_tb = ~CLK_tb; 



//------------ module instantiation ------------
  RST_SYNC #(.NUM_STAGES (NUM_STAGES_tb) ) DUT (
    .CLK        (CLK_tb),
    .RST        (RST_tb),
    .RST_SYNC   (RST_SYNC_tb)
  );



endmodule