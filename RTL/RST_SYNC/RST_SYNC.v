module RST_SYNC #(parameter NUM_STAGES = 2)(
  input     wire      RST,
  input     wire      CLK,
  
  output    wire      RST_SYNC
);
  
  reg     [NUM_STAGES-1:0]    regs;
  integer                     N;
  
  always @(posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          regs <= 0;
        end
      else
        begin
          regs[NUM_STAGES - 1] <= 1;
          for(N = NUM_STAGES - 2; N >= 0; N = N - 1)
            begin
              regs[N] <= regs[N+1];
            end
        end
    end
  
  assign RST_SYNC = regs[0];
  
endmodule
