module DATA_SYNC_tb #(parameter WIDTH_tb = 8, FLIP_FLOP_STAGES_tb = 3);
  reg         [WIDTH_tb-1:0]        unsync_bus_tb;               
  reg                               bus_enable_tb;
  reg                               RST_tb;
  reg                               CLK_tb;
  wire        [WIDTH_tb-1:0]        sync_bus_tb;
  wire                              enable_pulse_tb;
  
  parameter CLK_PERIOD = 10;
  
//------------- initial block -------------
  initial
    begin
      $dumpfile("DATA_SYNC.vcd");
      $dumbvars;
      initialize;
      reset; 
      //test case 1 input data with enable signal is high
      input_data('b10101010,'b1);
      check_op('b10101010, 1,0); 
      
      //test case 2 input data with enable signal is low 
      input_data('b11111111,'b0);
      check_op('b10101010, 2,1);
            
            
      //test case 3 input data with enable signal is high 
      input_data('b10101110,'b1);
      check_op('b10101110, 3,0);
      
      
      
      #100
      $finish;
    end
  
//------------- tasks -------------
  task initialize;  
    begin
      unsync_bus_tb = 'b0;
      bus_enable_tb = 'b0;
      RST_tb = 'b1;
      CLK_tb = 'b0;
    end
  endtask
  
  task reset;
    begin
      #CLK_PERIOD;
      RST_tb = 0;
      #CLK_PERIOD;
      RST_tb = 1;
      #CLK_PERIOD;
    end
  endtask
  
  task input_data;
    input     [WIDTH_tb-1:0]        async_input;
    input                           bus_enable;
    begin
      unsync_bus_tb = async_input;
      bus_enable_tb = bus_enable;
    end
  endtask
  
  task check_op;
    input   [WIDTH_tb-1:0]          expected_op;
    input   integer                 case_number;
    input                           wrong_op;
    integer latnecy;
    begin
      latnecy = FLIP_FLOP_STAGES_tb + 1;
      #(CLK_PERIOD * latnecy);
      if((expected_op == sync_bus_tb) && (enable_pulse_tb || wrong_op))
        $display("test case %d pass with input data %b and expected output %b and output %b and enable signal %b",case_number,unsync_bus_tb,expected_op,sync_bus_tb,bus_enable_tb);
      else
        $display("test case %d failed with input data %b and expected output %b and output %b and enable signal %b",case_number,unsync_bus_tb,expected_op,sync_bus_tb,bus_enable_tb);
    end
  endtask 
  
//------------- clock generator -------------  
  always #(CLK_PERIOD / 2) CLK_tb = ~CLK_tb;
  
  
  
//------------- module instantiation -------------
  DATA_SYNC #(.WIDTH(WIDTH_tb), .FLIP_FLOP_STAGES(FLIP_FLOP_STAGES_tb)) DUT (
    .unsync_bus          (unsync_bus_tb),
    .bus_enable          (bus_enable_tb),
    .RST                 (RST_tb),
    .CLK                 (CLK_tb),
    .sync_bus            (sync_bus_tb),
    .enable_pulse_reg    (enable_pulse_tb)
  );
  
  
endmodule
