module DATA_SYNC #(parameter WIDTH = 8, FLIP_FLOP_STAGES = 2)(
  //input signals
  input   wire      [WIDTH-1:0]     unsync_bus, //input data from domain 1
  input   wire                      bus_enable, //input signal to enable data capture
  input   wire                      RST, //negative Async RST signal
  input   wire                      CLK, //clock signal
  //output signals
  output  reg       [WIDTH-1:0]     sync_bus,
  output  reg                       enable_pulse_reg        
);
  
  //internal signals
  reg    [FLIP_FLOP_STAGES-1:0]     synchronizers_ff;
  reg                               pulse_gen_ff;
  wire                              enable_pulse;
  reg    [WIDTH-1:0]                mux_op;
  integer                           N;
  
  //--------------- data syncronizers flip flops ---------------
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          synchronizers_ff <= 0;
        end
      else
        begin
          synchronizers_ff[0] <= bus_enable;
            for (N = 1; N < FLIP_FLOP_STAGES; N = N + 1)
              begin
                synchronizers_ff[N] <= synchronizers_ff[N-1];
              end
        end
    end
  //--------------- pulse generation logic ---------------
    //input flip flop
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          pulse_gen_ff <= 0;
        end
      else
        begin
          pulse_gen_ff <= synchronizers_ff[FLIP_FLOP_STAGES-1];
        end
    end
  
    // compinational logic for pulse generation
  assign enable_pulse = !pulse_gen_ff && synchronizers_ff[FLIP_FLOP_STAGES-1];
    
    // output pulse generator
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          enable_pulse_reg <= 0;
        end
      else
        begin
          enable_pulse_reg <= enable_pulse;
        end
          
    end
  
  //--------------- sync bus ouput logic ---------------
    //mux logic
  
  //assign mux_op = enable_pulse ? unsync_bus : sync_bus;
  
  always @ (*)
    begin
      if(enable_pulse)
        begin
          mux_op = unsync_bus;
        end
      else
        begin
          mux_op = sync_bus;
        end
    end
  
    // output flip flops
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          sync_bus <= 0;
        end
      else
        begin
          sync_bus <= mux_op;
        end
    end
  
endmodule
