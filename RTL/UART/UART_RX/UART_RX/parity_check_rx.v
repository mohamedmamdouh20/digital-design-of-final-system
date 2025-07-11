module parity_check_rx (
  input               par_typ, //signal to know the type of parity
  input               par_check_en, // enable signal from control block
  input               parity_bit, //parity bit from data sampler
  input      [7:0]    parallel_data,
  input               CLK,
  input               RST,
  
  output   reg        parity_error  //output error signal
);
  reg                 parity_calc;
  reg                 parity_error_comb;

  always @ (*)
    begin
      if(par_check_en)
        begin
          parity_calc = ~parallel_data;  
          if(par_typ) //means that it is odd parity therefor parity bit must equal 1
            begin
              parity_error_comb = !(parity_calc && parity_bit);
            end
          else //means that it is even parity therfor parity bit must equal 0
            begin
              parity_error_comb = parity_calc && parity_bit;
            end
        end
      else
        begin
          parity_error_comb = 0;
        end
        
    end
  always @ (posedge CLK or negedge RST)
    begin
      if(!RST)
        begin
          parity_error <= 0;
        end
      else if(par_check_en)
        begin
          parity_error <= parity_error_comb;
        end
    end
    
  endmodule