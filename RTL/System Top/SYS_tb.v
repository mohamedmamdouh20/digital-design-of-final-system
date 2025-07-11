`timescale 1ns/1ps
module SYS_tb #(parameter
ALU_DATA_WIDTH_tb = 16,
REGISTER_FILE_DATA_WIDTH_tb = 8,
FIFO_WIDTH_tb = 8,
FIFO_DEPTH_tb = 8,
POINTER_WIDTH_FIFO_tb = 4,
WIDTH_CLKDIV_MUX_tb = 8,
DEPTH_REG_FILE_tb = 16,
ADDRESS_WIDTH_REGISTER_FILE_tb = 4,
WIDTH_DATA_SYNC_tb = 8,
FLIP_FLOP_STAGES_DATA_SYSNC_tb = 2,
NUM_STAGES_RST_SYNC_tb = 2
);
  reg                           RST_N_tb;
  reg                           UART_CLK_tb;
  reg                           REF_CLK_tb;
  reg                           UART_RX_IN_tb;
  reg                           UART_TX_CLK_tb;
  
  wire                          UART_TX_O_tb;
  wire                          parity_error_tb;
  wire                          framing_error_tb;    

  //parameters declaration
  parameter UART_CLK_PERIOD = 271.267; 
  parameter REF_CLK_PERIOD = 20;
  parameter PAR_EN_tb = 1;
  parameter UART_TX_PERIOD = 8680;
  //initial block
  initial
    begin
      init();
      reset();
     
      //test case 1 write in register file
      #(2*UART_CLK_PERIOD);
      /*
      RX_INPUT(1'b0,8'hAA,1'b1,1'b1);
      RX_INPUT(1'b0,8'h04,1'b1,1'b1);
      RX_INPUT(1'b0,8'b10011011,1'b1,1'b1);
      */
      
      /*
      //test case 2 read from register file
      #(2*UART_CLK_PERIOD);
      RX_INPUT(1'b0,8'hBB,1'b1,1'b1);
      RX_INPUT(1'b0,8'h04,1'b1,1'b1);
      */
      /*
      //test case 3
      RX_INPUT(1'b0,8'hCC,1'b1,1'b1);
      RX_INPUT(1'b0,8'd04,1'b1,1'b1);
      RX_INPUT(1'b0,8'd6,1'b1,1'b1);
      RX_INPUT(1'b0,8'b0000,1'b1,1'b1);
      */
      
      //test case 4
      RX_INPUT(1'b0,8'hAA,1'b1,1'b1);
      RX_INPUT(1'b0,8'h00,1'b1,1'b1);
      RX_INPUT(1'b0,8'd04,1'b1,1'b1);
      
      RX_INPUT(1'b0,8'hAA,1'b1,1'b1);
      RX_INPUT(1'b0,8'h01,1'b1,1'b1);
      RX_INPUT(1'b0,8'd06,1'b1,1'b1);
      
      RX_INPUT(1'b0,8'hDD,1'b1,1'b1);
      RX_INPUT(1'b0,8'b0000,1'b1,1'b1);

      
      #100000;
      $finish;
    end
  

 
//initialize task
  task init;
    begin
      RST_N_tb = 1;
      UART_CLK_tb = 0;
      REF_CLK_tb = 0;
      UART_TX_CLK_tb = 0;
      UART_RX_IN_tb = 1;
    end
  endtask
  
  //reset task
  task reset;
    begin
      RST_N_tb = 1;
      #(REF_CLK_PERIOD);
      RST_N_tb = 0;
      #(REF_CLK_PERIOD);
      RST_N_tb = 1;
      #(REF_CLK_PERIOD);
    end
  endtask

  
  
  task RX_INPUT;
    input           start_bit;
    input [7:0]     data_in;
    input           parity_bit;
    input           stop_bit;
    integer         N;
      begin 
        UART_RX_IN_tb = start_bit;
        #(UART_TX_PERIOD) 
        for(N = 0; N <= 7; N = N + 1)
          begin
            UART_RX_IN_tb = data_in[N];
            #(UART_TX_PERIOD);
          end
        if(PAR_EN_tb)
          begin
            UART_RX_IN_tb = parity_bit;
            #(UART_TX_PERIOD)
            UART_RX_IN_tb = stop_bit;
            #(UART_TX_PERIOD);
          end
        else
          begin
            UART_RX_IN_tb = stop_bit;
            #(UART_TX_PERIOD);
          end
        
      end
  endtask
  
//module instantiation
SYS_TOP #(
.ALU_DATA_WIDTH_TOP (ALU_DATA_WIDTH_tb),
.REGISTER_FILE_DATA_WIDTH (REGISTER_FILE_DATA_WIDTH_tb),
.FIFO_WIDTH_TOP (FIFO_WIDTH_tb),
.FIFO_DEPTH_TOP (FIFO_DEPTH_tb),
.POINTER_WIDTH_FIFO (POINTER_WIDTH_FIFO_tb),
.WIDTH_CLKDIV_MUX (WIDTH_CLKDIV_MUX_tb),
.DEPTH_REG_FILE (DEPTH_REG_FILE_tb),
.ADDRESS_WIDTH_REGISTER_FILE (ADDRESS_WIDTH_REGISTER_FILE_tb),
.WIDTH_DATA_SYNC (WIDTH_DATA_SYNC_tb),
.FLIP_FLOP_STAGES_DATA_SYSNC (FLIP_FLOP_STAGES_DATA_SYSNC_tb),
.NUM_STAGES_RST_SYNC  (NUM_STAGES_RST_SYNC_tb)
)DUT(
.UART_CLK (UART_CLK_tb),
.REF_CLK (REF_CLK_tb),
.UART_RX_IN (UART_RX_IN_tb),
.UART_TX_O (UART_TX_O_tb),
.parity_error (parity_error_tb),
.framing_error (framing_error_tb),
.RST_N  (RST_N_tb)
);


  
  //clock generators:
  always #(UART_CLK_PERIOD/2) UART_CLK_tb = ~UART_CLK_tb;  
  always #(REF_CLK_PERIOD/2) REF_CLK_tb = ~REF_CLK_tb;  
  always #(UART_TX_PERIOD/2) UART_TX_CLK_tb = ~UART_TX_CLK_tb; 
    
endmodule
