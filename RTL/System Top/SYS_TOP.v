
module SYS_TOP #( parameter
ALU_DATA_WIDTH_TOP = 16,
REGISTER_FILE_DATA_WIDTH = 8,
FIFO_WIDTH_TOP = 8,
FIFO_DEPTH_TOP = 8,
POINTER_WIDTH_FIFO = 4,
WIDTH_CLKDIV_MUX = 8,
DEPTH_REG_FILE = 16,
ADDRESS_WIDTH_REGISTER_FILE = 4,
WIDTH_DATA_SYNC = 8,
FLIP_FLOP_STAGES_DATA_SYSNC = 2,
NUM_STAGES_RST_SYNC = 2
)
(
 input   wire                          RST_N,
 input   wire                          UART_CLK,
 input   wire                          REF_CLK,
 input   wire                          UART_RX_IN,
 output  wire                          UART_TX_O,
 output  wire                          parity_error,
 output  wire                          framing_error
);

//define internal signals

//reset sync signals  
  wire        UART_RST_DOMAIN; //reset sync domain
  wire        SYS_CTRL_RST_DOMAIN; //system control reset domain

//data sync signals
  wire    [WIDTH_DATA_SYNC-1:0]    ASYNC_DATA;
  wire    [WIDTH_DATA_SYNC-1:0]    SYNC_DATA;
  wire                             ASYNC_DATA_ENABLE;
  wire                             DATA_VALID_SYNC;
  
//fifo signals
  wire                        WRITE_INC;
  wire                        READ_INC;
  wire                        FULL_FLAG;
  wire                        EMPTY_FLAG;
  wire    [FIFO_WIDTH_TOP-1:0]   FIFO_WRITE_DATA;
  wire    [FIFO_WIDTH_TOP-1:0]   FIFO_READ_DATA;
  
//UART signals
  wire                        BUSY_FLAG;
  
//clock divider mux
  wire    [WIDTH_CLKDIV_MUX-1:0]  PRESCALE;
  wire                            UART_RX_CLK;
  wire                            UART_TX_CLK;
  
//reg file signals
  wire    [REGISTER_FILE_DATA_WIDTH-1:0]    REG0_TOP;
  wire    [REGISTER_FILE_DATA_WIDTH-1:0]    REG1_TOP;
  wire    [REGISTER_FILE_DATA_WIDTH-1:0]    REG2_TOP;
  wire    [REGISTER_FILE_DATA_WIDTH-1:0]    REG3_TOP;
  wire    [REGISTER_FILE_DATA_WIDTH-1:0]    READ_DATA_REG_FILE;
  wire                                      READ_DATA_VALID_REG;


//system control signals
  wire                                        CLKDIV_EN;
  wire                                        ALU_ENABLE;  
  wire    [3:0]                               ALU_FUNCTION;  
  wire    [ADDRESS_WIDTH_REGISTER_FILE-1:0]   ADDRESS_BUS;
  wire                                        WRITE_ENABLE;
  wire                                        READ_ENABLE;
  wire    [REGISTER_FILE_DATA_WIDTH-1:0]      WRITE_DATA_REG_FILE;
  wire                                        CLK_GATE_EN;
  
//ALU signals
  wire   [ALU_DATA_WIDTH_TOP-1:0]      ALU_OUT_TOP;
  wire                                      ALU_OUT_Valid;
  
//clock gating signals
  wire            GATED_CLK_TOP;


///********************************************************///
//////////////////// Reset synchronizers /////////////////////
///********************************************************///

// UART domain rst sync
RST_SYNC #(.NUM_STAGES (NUM_STAGES_RST_SYNC))
RST_SYNC_UART_U0(
  .RST          (RST_N),
  .CLK          (UART_CLK),
  .RST_SYNC      (UART_RST_DOMAIN)
);

// control domain rst sync
RST_SYNC #(.NUM_STAGES (NUM_STAGES_RST_SYNC))
RST_SYNC_SYS_CTRL_U0(
  .RST          (RST_N),
  .CLK          (REF_CLK),
  .RST_SYNC      (SYS_CTRL_RST_DOMAIN)
);



///********************************************************///
///////////////////// Data Synchronizers /////////////////////
///********************************************************///

DATA_SYNC #(
.WIDTH (WIDTH_DATA_SYNC), 
.FLIP_FLOP_STAGES(FLIP_FLOP_STAGES_DATA_SYSNC)
)
DATA_SYNC_U0(
  .unsync_bus     (ASYNC_DATA),
  .bus_enable     (ASYNC_DATA_ENABLE),
  .RST            (SYS_CTRL_RST_DOMAIN),
  .CLK            (REF_CLK),
  .sync_bus       (SYNC_DATA),
  .enable_pulse_reg (DATA_VALID_SYNC)
);

///********************************************************///
///////////////////////// Async FIFO /////////////////////////
///********************************************************///

Async_fifo #(.D_SIZE (FIFO_WIDTH_TOP), 
.F_DEPTH (FIFO_DEPTH_TOP), 
.P_SIZE(POINTER_WIDTH_FIFO))
Async_fifo_U0 (
  .i_w_clk      (REF_CLK),
  .i_w_rstn     (SYS_CTRL_RST_DOMAIN),
  .i_w_inc      (WRITE_INC),
  .i_r_clk      (UART_CLK),
  .i_r_rstn     (UART_RST_DOMAIN),
  .i_r_inc      (READ_INC),
  .i_w_data     (FIFO_WRITE_DATA),
  .o_r_data     (FIFO_READ_DATA),
  .o_full       (FULL_FLAG),
  .o_empty      (EMPTY_FLAG)
);

///********************************************************///
//////////////////////// Pulse Generator /////////////////////
///********************************************************///
PULSE_GEN
PULSE_GEN_U0(
  .clk        (UART_CLK),
  .rst        (UART_RST_DOMAIN),
  .lvl_sig    (BUSY_FLAG),
  .pulse_sig  (READ_INC)
);

///********************************************************///
//////////// Clock Divider for UART_TX Clock /////////////////
///********************************************************///


//uart tx clock divider
clock_divider
clock_divider_TX_U0(
  .i_ref_clk        (UART_CLK),
  .i_rst_n          (UART_RST_DOMAIN),
  .i_clk_en         (CLKDIV_EN),
  .i_div_ratio      (REG3_TOP),
  .o_div_clk        (UART_TX_CLK)
);


///********************************************************///
/////////////////////// Custom Mux Clock /////////////////////
///********************************************************///

//clock divider mux
CLKDIV_MUX #(.WIDTH (WIDTH_CLKDIV_MUX))
CLKDIV_MUX_U0(
  .IN       (REG2_TOP[7:2]),
  .OUT      (PRESCALE)
);


///********************************************************///
//////////// Clock Divider for UART_RX Clock /////////////////
///********************************************************///


//uart rx clock divider
clock_divider
clock_divider_RX_U0(
  .i_ref_clk        (UART_CLK),
  .i_rst_n          (UART_RST_DOMAIN),
  .i_clk_en         (CLKDIV_EN),
  .i_div_ratio      (PRESCALE),
  .o_div_clk        (UART_RX_CLK)
);


///********************************************************///
/////////////////////////// UART /////////////////////////////
///********************************************************///
UART_TOP
UART_TOP_U0(
  .TX_CLK       (UART_TX_CLK),
  .RX_CLK       (UART_RX_CLK),
  .RST          (UART_RST_DOMAIN),
  .RX_IN        (UART_RX_IN),
  .TX_IN        (FIFO_READ_DATA),
  .F_EMPTY      (EMPTY_FLAG),
  .PAR_EN       (REG2_TOP[0]),
  .PAR_TYP      (REG2_TOP[1]),
  .prescale     (REG2_TOP[7:2]),
  .RX_OUT       (ASYNC_DATA),
  .TX_OUT       (UART_TX_O),
  .BUSY         (BUSY_FLAG),
  .DATA_VALID   (ASYNC_DATA_ENABLE),
  .parity_error (parity_error),
  .framing_error  (framing_error)
);


///********************************************************///
//////////////////// System Controller ///////////////////////
///********************************************************///

system_control  #(
.ALU_DATA_WIDTH (ALU_DATA_WIDTH_TOP),
.ADDRESS_WIDTH  (ADDRESS_WIDTH_REGISTER_FILE),
.REG_DATA_WIDTH (REGISTER_FILE_DATA_WIDTH),
.FIFO_WIDTH     (FIFO_WIDTH_TOP)
)
system_control_U0(
  .ALU_OUT        (ALU_OUT_TOP),
  .OUT_Valid      (ALU_OUT_Valid),
  .RX_P_Data      (SYNC_DATA),
  .RX_D_VLD       (DATA_VALID_SYNC),
  .Rd_D           (READ_DATA_REG_FILE),
  .RDData_Valid   (READ_DATA_VALID_REG),
  .CLK            (REF_CLK),
  .RST            (SYS_CTRL_RST_DOMAIN),
  .FIFO_FULL      (FULL_FLAG),
  .ALU_EN         (ALU_ENABLE),
  .ALU_FUN        (ALU_FUNCTION),
  .Address        (ADDRESS_BUS),
  .WrEN           (WRITE_ENABLE),
  .RdEN           (READ_ENABLE),
  .Wr_D           (WRITE_DATA_REG_FILE),
  .TX_P_DATA      (FIFO_WRITE_DATA),
  .TX_D_VLD       (WRITE_INC),
  .clk_gate_en    (CLK_GATE_EN),
  .clk_div_en     (CLKDIV_EN)
);

///********************************************************///
/////////////////////// Register File ////////////////////////
///********************************************************///

RegFile #(
.WIDTH (REGISTER_FILE_DATA_WIDTH),
.DEPTH (DEPTH_REG_FILE),
.ADDR  (ADDRESS_WIDTH_REGISTER_FILE)
)
RegFile_U0(
  .CLK        (REF_CLK),
  .RST        (SYS_CTRL_RST_DOMAIN),
  .WrEn       (WRITE_ENABLE),
  .RdEn       (READ_ENABLE),
  .Address    (ADDRESS_BUS),
  .WrData     (WRITE_DATA_REG_FILE),
  .RdData     (READ_DATA_REG_FILE),
  .RdData_VLD (READ_DATA_VALID_REG),
  .REG0       (REG0_TOP),
  .REG1       (REG1_TOP),
  .REG2       (REG2_TOP),
  .REG3       (REG3_TOP)
);


///********************************************************///
//////////////////////////// ALU /////////////////////////////
///********************************************************///
ALU #(
  .OPER_WIDTH (REGISTER_FILE_DATA_WIDTH),
  .OUT_WIDTH (ALU_DATA_WIDTH_TOP)
)
ALU_U0(
  .A          (REG0_TOP),
  .B          (REG1_TOP),
  .EN         (ALU_ENABLE),
  .ALU_FUN    (ALU_FUNCTION),
  .CLK        (GATED_CLK_TOP),
  .RST        (SYS_CTRL_RST_DOMAIN),
  .ALU_OUT    (ALU_OUT_TOP),
  .OUT_VALID  (ALU_OUT_Valid)
);

///********************************************************///
///////////////////////// Clock Gating ///////////////////////
///********************************************************///

CLK_GATE 
CLK_GATE_U0(
  .CLK_EN       (CLK_GATE_EN),
  .CLK          (REF_CLK),
  .GATED_CLK    (GATED_CLK_TOP)
);



endmodule
 
