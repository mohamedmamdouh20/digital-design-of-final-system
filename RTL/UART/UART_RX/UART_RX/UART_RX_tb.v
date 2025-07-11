`timescale 1us/1ns
module UART_RX_tb;
  //input signals
  reg             PAR_EN_tb;
  reg             PAR_TYP_tb;
  reg             RX_IN_tb;
  reg    [5:0]    prescale_tb;
  reg             RST_tb;
  reg             CLK_tb;
  //output signals
  wire   [7:0]    P_DATA_tb;
  wire            data_valid_tb;
  wire            parity_ext_err;
  wire            stop_ext_err;
  wire            start_ext_err;
  
  parameter CLK_PERIOD = 8.68 ;
  parameter prescale  = 8;
  //parameter NEW_CLOCK_PERIOD = 8.68us; // Period of the new clock
  

  initial
    begin
    		$dumpfile("UART_RX.vcd");
		  $dumpvars ;
      
      initialize();
      reset();
      
      //test case 1 : input data with right parity sent
      UART_RX_CONFIG(1,0,prescale);
      RX_INPUT('b0,'b10010101,'b0,'b1,prescale);
      check_output('b10010101,1,0);
      
      //test case 2 : input data with right parity sent
      UART_RX_CONFIG(1,0,prescale);
      RX_INPUT('b0,'b11111111,'b0,'b1,prescale);
      check_output('b11111111,2,0);
      
      UART_RX_CONFIG(0,0,prescale); //test case 3 : input data with disabling parity
      RX_INPUT('b0,'b10010101,'b0,'b1,prescale);
      check_output('b10010101,3,0);
      
      
      UART_RX_CONFIG(1,1,prescale); //test case 4 : input data with wrong parity config
      RX_INPUT('b0,'b10010101,'b0,'b1,prescale);
      check_output('b10010101,4,1);
      
      UART_RX_CONFIG(1,0,prescale);
      RX_INPUT('b0,'b1,'b00010001,'b0,prescale); // test case 5 : input data with wrong stop bit
      check_output('b10010101,5,1);
      
      #200
      $finish;
      
    end


  //tasks:
  task initialize;
    begin
      RX_IN_tb = 1;
      prescale_tb = 8;
      RST_tb = 1;
      CLK_tb = 0;
      PAR_TYP_tb = 0;
      PAR_EN_tb = 1;
    end
  endtask
  
  task reset;
    begin
      RST_tb = 1;
      #CLK_PERIOD
      RST_tb = 0;
      #CLK_PERIOD
      RST_tb = 1;
    end
  endtask

  task UART_RX_CONFIG;
    input             par_en;
    input             par_typ;
    input   [5:0]     prescale;
    
    begin
      PAR_TYP_tb = par_typ;
      PAR_EN_tb = par_en;
      prescale_tb = prescale;
    end
  endtask
  
  task RX_INPUT;
    input           start_bit;
    input [7:0]     data_in;
    input           parity_bit;
    input           stop_bit;
    input [5:0]     prescale;
    integer         N;
      begin 
        RX_IN_tb = start_bit;
        #(CLK_PERIOD) 
        for(N = 0; N <= 7; N = N + 1)
          begin
            RX_IN_tb = data_in[N];
            #(CLK_PERIOD);
          end
        if(PAR_EN_tb)
          begin
            RX_IN_tb = parity_bit;
            #(CLK_PERIOD)
            RX_IN_tb = stop_bit;
            #(CLK_PERIOD);
          end
        else
          begin
            RX_IN_tb = stop_bit;
            #(CLK_PERIOD);
          end
        
      end
  endtask
  
  task check_output;
  input   [7:0]     expected_op;
  input   integer   case_tb;
  input             false_case;
  begin
    if(!false_case)
      begin 
        @(posedge data_valid_tb); // Wait until data_valid_tb goes high
        if (P_DATA_tb == expected_op)
          $display("test case %d has passed with expected output %b and generated output %b and data valid high", case_tb, expected_op, P_DATA_tb);
   	    else
          $display("test case %d has failed with expected output %b and generated output %b", case_tb, expected_op, P_DATA_tb);
      end
    else
      begin
        
        @(posedge parity_ext_err or start_ext_err or stop_ext_err);
        if(!data_valid_tb && parity_ext_err)
          $display("test case passed by not rising data valid  and rise parity_error");
        else if (!data_valid_tb && start_ext_err)
          $display("test case passed by not rising data valid and rise start_error");
        else if (!data_valid_tb && stop_ext_err)
          $display("test case passed by not rising data valid and rise stop_error");
        else
          $display("error");
      end
  end
endtask
  
  //module instantiation:
  
  UART_RX_TOP DUT(
    .PAR_EN           (PAR_EN_tb),
    .PAR_TYP          (PAR_TYP_tb),
    .RX_IN            (RX_IN_tb),
    .prescale         (prescale_tb),
    .RST              (RST_tb),
    .CLK              (CLK_tb),
    .P_DATA           (P_DATA_tb),
    .parity_ext_err   (parity_ext_err),
    .stop_ext_err     (stop_ext_err),
    .start_ext_err    (start_ext_err),
    .data_valid       (data_valid_tb)
  );
  
  
  //clock generation
  always #(CLK_PERIOD / (prescale_tb * 2)) CLK_tb = ~CLK_tb; 
endmodule