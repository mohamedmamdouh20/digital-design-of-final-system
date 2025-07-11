module system_control #(parameter ALU_DATA_WIDTH = 16,ADDRESS_WIDTH = 4, REG_DATA_WIDTH = 8,FIFO_WIDTH = 16)(
  input     wire    [ALU_DATA_WIDTH-1:0]            ALU_OUT,
  input     wire                                    OUT_Valid,
  input     wire    [7:0]                           RX_P_Data,
  input     wire                                    RX_D_VLD, //flag from rx to recieve data from it
  input     wire    [REG_DATA_WIDTH-1:0]            Rd_D, //data from reg file
  input     wire                                    RDData_Valid, // flag from reg file
  input     wire                                    CLK,
  input     wire                                    RST,
  input     wire                                    FIFO_FULL,
  
  output    reg                                     ALU_EN,
  output    reg    [3:0]                            ALU_FUN,
  output    reg    [ADDRESS_WIDTH-1:0]              Address, //address bus for reg file
  output    reg                                     WrEN, //enable for write in reg file
  output    reg                                     RdEN, //enable for read from reg file
  output    reg    [REG_DATA_WIDTH-1:0]             Wr_D, //data sent to reg file
  output    reg    [FIFO_WIDTH-1:0]                 TX_P_DATA, // WR_DATA connected to fifo
  output    wire                                    TX_D_VLD, //write inc signal
  output    reg                                     clk_gate_en,
  output    reg                                     clk_div_en
);
  
  reg                           write_flag;
  reg                           address_enable, write_enable;
  reg   [REG_DATA_WIDTH-1:0]    READ_REG;
  reg   [ALU_DATA_WIDTH-1:0]    OP_A;
  reg   [ALU_DATA_WIDTH-1:0]    OP_B;
  reg                           WR_INC;
  reg   [ALU_DATA_WIDTH-1:0]    ALU_OUT_reg;
  reg                           WrEN_comp;
  reg                           RdEN_comp;
  reg                           OP_A_enable;
  reg                           OP_B_enable; 
  reg                           ALU_FUN_enable;
  reg                           ALU_OUT_ENABLE;
  reg                           ALU_EN_comp;
  
  typedef enum bit [3:0] {  idle_state = 'b0000,
              write_reg_address_state = 'b0001,
              write_reg_data_state = 'b0010,
              read_reg_state = 'b0011,
              send_tx_state = 'b0100,
              ALU_READ_OP_A_STATE = 'b0101,
              ALU_READ_OP_B_STATE = 'b0110,
              ALU_READ_FUN_STATE = 'b0111,
              ALU_OUTPUT_FIRST_STATE = 'b1000,
              ALU_OUTPUT_SECOND_STATE = 'b1001,
              ALU_NO_OP_STATE = 'b1010
  }state_e;
              
  state_e    next_state, current_state;
  
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          ALU_EN <=0;
        end
      else
        begin
          ALU_EN <= ALU_EN_comp;
        end
    end

  assign TX_D_VLD = WR_INC;
  
  always @ (*)
    begin
      if(current_state == send_tx_state)
        begin
          TX_P_DATA = READ_REG;
        end
      else if(current_state == ALU_OUTPUT_FIRST_STATE)
        begin 
          TX_P_DATA = ALU_OUT_reg[7:0];
        end
      else if(current_state == ALU_OUTPUT_SECOND_STATE)
        begin 
          TX_P_DATA = ALU_OUT_reg[15:8];
        end
      else
        begin
          TX_P_DATA = 'b0;
        end
    end
  
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          WrEN <=0;
        end
      else
        begin
          WrEN <= WrEN_comp;
        end
    end
    
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          RdEN <=0;
        end
      else
        begin
          RdEN <= RdEN_comp;
        end
    end
  
  //write data to the register file 
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          Wr_D <= 'b0;
          Address <= 'b0;
        end
      else
        begin
          if(write_enable)
            begin
              Wr_D <= RX_P_Data;
            end
          else if(OP_A_enable)
            begin
              Wr_D <= RX_P_Data;
              Address <= 8'h00;
            end
          else if(OP_B_enable)
            begin
              Wr_D <= RX_P_Data;
              Address <= 8'h01;
            end
					else if(address_enable)
            begin
              Address <= RX_P_Data;
            end
        end
    end
  
  // read the data from register file
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          READ_REG <= 'b0;
        end
      else 
        begin
          if(RDData_Valid)
            begin
              READ_REG <= Rd_D ;
            end
        end
    end
   
  /* //write address to register file
   always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          Address <= 'b0;
        end
      else
        begin
          if(address_enable)
            begin
              Address <= RX_P_Data;
            end
        end
    end
    */
  // current state logic
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          current_state <= idle_state;
        end
      else
        begin
          current_state <= next_state;
        end
    end  
  

  // function register
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          ALU_FUN <= 'b0;
        end
      else
        begin
          if(ALU_FUN_enable)
            begin
              ALU_FUN <= RX_P_Data;
            end
        end
    end
  
  //ALU output register
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          ALU_OUT_reg <= 'b0;
        end
      else
        begin
          if(OUT_Valid)
            begin
              ALU_OUT_reg <= ALU_OUT;
            end
        end
    end
  
  //FSM
  always @ (*)
    begin
      ALU_EN_comp = 0;
      WrEN_comp = 0;
      WR_INC = 0;
      address_enable = 0;
      write_enable = 0;
      OP_A_enable = 0;
      OP_B_enable = 0;
      ALU_FUN_enable = 0;
      clk_div_en = 1;
      clk_gate_en = 0;
      ALU_OUT_ENABLE = 0;
      RdEN_comp = 0;
      case (current_state)
        idle_state:
          begin
            if(RX_P_Data == 8'hAA && RX_D_VLD)
              begin
                next_state = write_reg_address_state;
              end
            else if(RX_P_Data == 8'hBB && RX_D_VLD)
              begin
                next_state = read_reg_state;
              end
            else if(RX_P_Data == 8'hCC && RX_D_VLD)
              begin
                next_state = ALU_READ_OP_A_STATE;
              end
            else if(RX_P_Data == 8'hDD && RX_D_VLD)
              begin
                next_state = ALU_NO_OP_STATE;
              end
            else
              begin
                next_state = idle_state;
              end
          end
        write_reg_address_state:
          begin
            if(RX_D_VLD)
              begin
                address_enable = 1;
                next_state = write_reg_data_state;
              end
            else
              begin
                address_enable = 0;
                next_state = write_reg_address_state;
              end
          end
        write_reg_data_state:
          begin
            if(RX_D_VLD )
              begin
                write_enable = 1;
                WrEN_comp = 1;
                next_state = idle_state;
              end
            else
              begin
                write_enable = 0;
                WrEN_comp = 0;
                next_state = write_reg_data_state;
              end
          end
        read_reg_state:
          begin
            if(RX_D_VLD)
              begin
                address_enable = 1;
                RdEN_comp = 1;
                next_state = read_reg_state;
              end
			else if(RDData_Valid)
			  begin
			    address_enable = 0;
                RdEN_comp = 0;
                next_state = send_tx_state;
			  end
            else
              begin
                next_state = read_reg_state;
                address_enable = 0;
                RdEN_comp = 0;
              end
          end
        send_tx_state:
          begin
            if(!FIFO_FULL)
              begin
                next_state = idle_state;
                WR_INC = 1;
              end
            else
              begin
                next_state = send_tx_state;
                WR_INC = 0;
              end
          end
        ALU_READ_OP_A_STATE:
          begin
            if(RX_D_VLD)
              begin
                OP_A_enable = 1;
                WrEN_comp = 1;
                next_state = ALU_READ_OP_B_STATE;
              end
            else
              begin
                OP_A_enable = 0;
                WrEN_comp = 0;
                next_state = ALU_READ_OP_A_STATE;
              end
          end
        ALU_READ_OP_B_STATE:
          begin
            if(RX_D_VLD)
              begin
                OP_B_enable = 1;
                WrEN_comp = 1;
                next_state = ALU_READ_FUN_STATE;
              end
            else
              begin
                OP_B_enable = 0;
                WrEN_comp = 0;
                next_state = ALU_READ_OP_B_STATE;
              end
          end
        ALU_READ_FUN_STATE:
          begin
            clk_gate_en = 1;
            ALU_EN_comp = 1;
            if(RX_D_VLD)
              begin
                ALU_FUN_enable = 1;
                next_state =  ALU_READ_FUN_STATE;
                WrEN_comp = 1;
              end
            else if(OUT_Valid)
              begin
                ALU_FUN_enable = 0;
                next_state = ALU_OUTPUT_FIRST_STATE;
                WrEN_comp = 0;
              end
            else
              begin
                ALU_FUN_enable = 0;
                next_state = ALU_READ_FUN_STATE;
                WrEN_comp = 0;
              end
          end
        ALU_OUTPUT_FIRST_STATE:
          begin
            clk_gate_en = 0;
            if(!FIFO_FULL)
              begin
                next_state = ALU_OUTPUT_SECOND_STATE;
                WR_INC = 1;
              end
            else
              begin
                next_state = ALU_OUTPUT_FIRST_STATE;
                WR_INC = 0;
              end
          end
          ALU_OUTPUT_SECOND_STATE:
          begin
            clk_gate_en = 0;
            if(!FIFO_FULL)
              begin
                next_state = idle_state;
                WR_INC = 1;
              end
            else
              begin
                next_state = ALU_OUTPUT_SECOND_STATE;
                WR_INC = 0;
              end
          end
        ALU_NO_OP_STATE:
          begin
            clk_gate_en = 1;
            ALU_EN_comp = 1;
            if(RX_D_VLD)
              begin
                ALU_FUN_enable = 1;
                next_state =  ALU_NO_OP_STATE;
              end
            else if(OUT_Valid)
              begin
                ALU_FUN_enable = 0;
                next_state = ALU_OUTPUT_FIRST_STATE;
              end
            else
              begin
                ALU_FUN_enable = 0;
                next_state = ALU_NO_OP_STATE;
              end
            end
				default:
						begin
							next_state = idle_state;
						end      
			endcase
      
    end
  

endmodule
