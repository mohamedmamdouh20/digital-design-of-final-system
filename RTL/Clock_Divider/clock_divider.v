 module clock_divider (
	input 				       i_ref_clk, //input ref clock
	input				        i_rst_n,  //async reset signal
	input				        i_clk_en, //enable signal for the block
	input	  [7:0]			 i_div_ratio, //input division ratio

	output	 reg			   o_div_clk //output divided clock
	
);
//declaring internal signals
	reg    [7:0]			counter;// counter for module logic
	wire				       odd_ratio; // check if input division ratio 0 or 1
	wire				       even_cond; //condition that we toggle the clock in case of even ratio
	wire				       odd_cond; //condition that we toggle the clock in case of odd ratio
	wire 	 [7:0]   shift_right; //used to assign the division of i_div_ratio
	reg				       flag;//flag used in toggle clock in case of odd division
	reg			         o_div_clk_reg; // regestered output clock
	
	parameter count_value = 1; //parameter spicify what is the initial value of counter
	
assign  odd_ratio = i_div_ratio[0];
assign  shift_right = (i_div_ratio >> 1);
//assign conditions to toggle clock in cas of 
assign	 even_cond  = counter == shift_right;
assign  odd_cond  = (((counter == shift_right)&&!flag) | (counter == shift_right + 1));

always @ (posedge i_ref_clk or negedge i_rst_n )
begin
  if(!i_rst_n) //async reset signal for clock divider
    begin
      counter   <= count_value;
      o_div_clk_reg <= 1;
      flag <= 0;
    end
  else
    begin
      if(!odd_ratio && even_cond) //condition to toggle clock in case of even division
        begin
          o_div_clk_reg <= ~o_div_clk_reg;
          counter <= count_value;
        end
      else if(odd_ratio && odd_cond) //condition to toggle clock in case of odd division
        begin
          counter <= count_value;
          if(!flag)
            begin
              o_div_clk_reg <= 'b0;
            end
          else
            begin
              o_div_clk_reg <= 'b1;
            end
          flag <= ~flag;
        end
      else if(i_clk_en) //increment counter if no condition is true
        begin
          counter <= counter+1;
        end
    end
end

always @ (*)
begin
  if(!i_clk_en) //output of module is reference clock in case of disable module
    begin
      o_div_clk = i_ref_clk;
    end
    
  else if(i_clk_en && (shift_right == 0)) //condition handle division by 0 and by 1
    begin
      o_div_clk = i_ref_clk;
    end
  else
    begin // if there is no special case therefor the output signal is the regestered divided clock
      o_div_clk = o_div_clk_reg;
    end
    
end

endmodule