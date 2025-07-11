module UART_RX_TOP (
  input               PAR_EN,
  input               PAR_TYP,
  input               RX_IN,
  input       [5:0]   prescale,
  input               RST,
  input               CLK,
  
  
  output              data_valid,
  output     [7:0]    P_DATA,
  output              parity_ext_err,
  output              framing_err
);





  wire                parity_check_en;
  wire                par_err;
  wire                start_check_en;
  wire                start_glitch;
  wire                stop_check_en;
  wire                stop_err;
  wire                deser_en;
  wire                edge_bit_counter_en;
  wire     [3:0]      bit_counter;
  wire     [5:0]      edge_counter;
  wire                data_sample_en;
  wire                sampled_bit;
  
  
  fsm_rx U0_FSM_rx(
    .CLK                  (CLK),
    .RST                  (RST),
    .par_en               (PAR_EN),
    .bit_count            (bit_counter),
    .edge_count           (edge_counter),
    .rx_in                (RX_IN),
    .par_err              (par_err),
    .start_glitch         (start_glitch),
    .stop_err             (stop_err),
    .parity_check_en      (parity_check_en),
    .start_check_en       (start_check_en),
    .stop_check_en        (stop_check_en),
    .edge_bit_counter_en  (edge_bit_counter_en),
    .deserializer_en      (deser_en),
    .data_sampling_en     (data_sample_en),
    .data_valid           (data_valid),
    .parity_ext_err       (parity_ext_err),
    .framing_error        (framing_err)
  );
  
  data_sampling_rx U0_data_sampling_rx(
    .data_sample_en       (data_sample_en),
    .rx_in                (RX_IN),
    .edge_count           (edge_counter),
    .prescale             (prescale),
    .CLK                  (CLK),
    .RST                  (RST),
    .sampled_data         (sampled_bit)
  );
  
  deserializer_rx U0_deserializer_rx(
    .deserializer_en      (deser_en),
    .CLK                  (CLK),
    .RST                  (RST),
    .sampled_bit_in       (sampled_bit),
    .p_data               (P_DATA)
  );
  
  parity_check_rx U0_par_check_rx(
    .par_typ              (PAR_TYP),
    .par_check_en         (parity_check_en),
    .parity_bit           (sampled_bit),
    .parallel_data        (P_DATA),
    .parity_error         (par_err),
    .CLK                  (CLK),
    .RST                  (RST)
  );
  
  stop_check_rx U0_stop_check_rx(
    .stop_bit             (sampled_bit),
    .stop_check_en        (stop_check_en),
    .stop_err             (stop_err),
    .CLK                  (CLK),
    .RST                  (RST)
  );
  
  edge_bit_counter_rx U0_edge_bit_counter_rx(
    .CLK                  (CLK),
    .RST                  (RST),
    .enable              (edge_bit_counter_en),
    .prescaler            (prescale),
    .bit_counter          (bit_counter),
    .edge_counter         (edge_counter)
  );
  
  start_check_rx U0_start_check_rx(
    .start_check_en       (start_check_en),
    .start_bit            (sampled_bit),
    .start_glitch         (start_glitch),
    .CLK                  (CLK),
    .RST                  (RST)
  );
  
  
endmodule
