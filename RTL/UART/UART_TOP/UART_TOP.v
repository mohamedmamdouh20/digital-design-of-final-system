module UART_TOP (
  input     wire              TX_CLK,
  input     wire              RX_CLK,
  input     wire              RST,
  input     wire              RX_IN,
  input     wire    [7:0]     TX_IN,     
  input     wire              F_EMPTY,
  input     wire              PAR_EN,
  input     wire              PAR_TYP,
  input     wire    [5:0]     prescale,
  
  output    wire    [7:0]     RX_OUT,
  output    wire              TX_OUT,
  output    wire              BUSY,
  output    wire              DATA_VALID,
  output    wire              parity_error,
  output    wire              framing_error
  
);

  UART_TX_TOP UART_TX_TOP_U0 (
    .P_DATA     (TX_IN),
    .PAR_EN     (PAR_EN),
    .PAR_TYP    (PAR_TYP),
    .CLK        (TX_CLK),
    .RST        (RST),
    .f_empty    (F_EMPTY),
    .Busy       (BUSY),
    .TX_OUT     (TX_OUT)
  );

  UART_RX_TOP UART_RX_TOP_U0 (
    .PAR_EN     (PAR_EN),
    .PAR_TYP    (PAR_TYP),
    .RX_IN      (RX_IN),
    .prescale   (prescale),
    .RST        (RST),
    .CLK        (RX_CLK),
    .data_valid (DATA_VALID),
    .P_DATA     (RX_OUT),
    .framing_err (framing_error),
    .parity_ext_err (parity_error)
  ); 


endmodule