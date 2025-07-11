module clock_divider_tb();
  reg             i_ref_clk_tb;
  reg             i_rst_n_tb;
  reg             i_clk_en_tb;
  reg     [7:0]   i_div_ratio_tb;
                  
  wire            o_div_clk_tb;
                  
  //parameters:
  parameter CLK_PERIOD = 10;                
  
  initial
    begin
      init();
     //test case 1 enable == 0 and division ratio is 5 expecting that we have reference clock at output
      activate(0,5);
      reset(); //30
      #(5 * CLK_PERIOD)
      
      //test case 2 enable == 1 and division ratio is 1 expecting that we have reference clock at output
      activate(1,1); //80
      reset(); //30
      
      #(5 * CLK_PERIOD)
      
      
      //test case 3 enable == 1 and division ratio is 2 expecting that we have reference clock at output divided by 2
      reset(); //30
      activate(1,2); //160
      #(20 * CLK_PERIOD)
      
      //test case 4 enable == 1 and division ratio is 3 expecting that we have reference clock at output divided by 3

      reset(); //30
      activate(1,3);//390
      #(20 * CLK_PERIOD)

      
      //test case 5 enable == 1 and division ratio is 9 expecting that we have reference clock at output divided by 9
      reset(); //30
      activate(1,9);//620
      #(20 * CLK_PERIOD)
      
      //test case 6 enable == 1 and division ratio is 10 expecting that we have reference clock at output divided by 10
      reset(); //30
      activate(1,10);//850
      #(20 * CLK_PERIOD)
      
      //test case 7 enable == 1 and division ratio is 17 expecting that we have reference clock at output divided by 17
      reset(); //30
      activate(1,17);//1080
      #(50 * CLK_PERIOD)
      
      //test case 8 enable == 1 and division ratio is 21 expecting that we have reference clock at output divided by 21
      reset(); //30
      activate(1,21);//1340
      #(20 * CLK_PERIOD)
      
      //test case 9 enable == 1 and division ratio is 0 expecting that we have reference clock at output 
      reset(); //30
      activate(1,0);//1340
      
      #400
      $finish;
    end
  
  
  //tasks:
  task init; //init task make inintialization for all inputs
    begin
      i_ref_clk_tb = 0;
      i_rst_n_tb = 1;
      i_clk_en_tb = 0;
      i_div_ratio_tb = 0;
    end  
  endtask
  
  task reset; //task to make module reset
    begin
      i_rst_n_tb = 1;
      #(CLK_PERIOD);
      i_rst_n_tb = 0;
      #(CLK_PERIOD)
      i_rst_n_tb = 1;
      #(CLK_PERIOD);
    end
  endtask
  
  task activate; //activate task which take the division ratio and the enable signal for module
    input             enable_tb;
    input   [7:0]     ratio_tb;
    begin
      i_div_ratio_tb = ratio_tb;
      i_clk_en_tb = enable_tb;
    end
  endtask
  
  
  //module instantiation
  clock_divider DUT(
    .i_ref_clk      (i_ref_clk_tb),
    .i_rst_n        (i_rst_n_tb),
    .i_clk_en       (i_clk_en_tb),
    .i_div_ratio    (i_div_ratio_tb),
    .o_div_clk      (o_div_clk_tb)
  );
  
  
  
  //clock generator
  always #(CLK_PERIOD / 2) i_ref_clk_tb = ~i_ref_clk_tb;
  
  
endmodule


	