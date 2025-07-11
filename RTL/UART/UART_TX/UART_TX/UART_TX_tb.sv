module UART_TX_tb;
	reg		[7:0]		 P_DATA_tb;
	reg					   DATA_VALID_tb;
	reg					   PAR_EN_tb;
	reg					   PAR_TYP_tb;
	reg					   CLK_tb;
	reg					   RST_tb;
	
	wire				Busy_tb;
	wire				TX_OUT_tb;
	
	parameter	CLK_period = 10;
	
	
	integer N;
	reg		[10:0]	generated_output;
	
	initial
		begin
		
		 //test case 1: try to put input and check if the output is right and activate the even parity and data is even parity
			
			initialize();
			reset();
			send_data('b01010101,1,0);	// since even parity activated and data is even parity so the parity bit is one
			check_output('b11010101010,'b01010101,1);
			
			//test case 2: try to put input and check if the output is right and activate the even parity and data is odd parity
			reset();
			send_data('b01010111,1,0);	// since even parity activated and data is odd parity so the parity bit is zero
			check_output('b10010101110,'b01010111,2);
			
			//test case 3: try to put input and check if the output is right and activate the odd parity and data is odd parity
			reset();
			send_data('b01010111,1,1);	// since odd parity activated and data is odd parity so the parity bit is one
			check_output('b11010101110,'b01010111,3);
			
			//test case 4: try to put input and check if the output is right and activate the odd parity and data is even parity
			reset();
			send_data('b01010101,1,1);	// since odd parity activated and data is even parity so the parity bit is zero
			check_output('b10010101010,'b01010101,4);
			
			//test case 5: disable parity and send data and check if they are 10 bits correclty
			reset();
			send_data('b01010111,0,1);	// since odd parity activated and data is odd parity so the parity bit is 1 but we disable the parity
			check_output_dissable_par('b1010101110,'b01010101,5);	
			
			//test case 6: check the output in idle state:
			reset();
			if(TX_OUT_tb == 1)
			  begin
			    $display("test case 6 succed with op = 1 in idle state");
			  end
			 else
			  begin
			    $display("test case 6 failed with op != 1 in idle state");
			  end
			#100
			$finish;
		end
	
	//initialization
	task initialize;
		begin
			CLK_tb = 0;
			P_DATA_tb = 0;
			DATA_VALID_tb = 0;
			PAR_EN_tb = 0;
			PAR_TYP_tb = 0;
			RST_tb = 1;		
		end
	endtask
	
	//reset the block
	task reset;
		begin
			RST_tb = 1;
			#(CLK_period)
			RST_tb = 0;
			#(CLK_period)
			RST_tb = 1;
		end
	endtask	
	
	//recieve input data
	task recieve_data;
		begin
			DATA_VALID_tb = 0;
			#(CLK_period)
			DATA_VALID_tb = 1;
			#CLK_period
			DATA_VALID_tb = 0;
			#CLK_period;
		end
	endtask
	
	
	//begin sending data
	task send_data;
		input   [7:0]  	  parallel_data;
		input			          enable_parity;
		input			          parity_type;
		
		begin
			P_DATA_tb 	= parallel_data;
			PAR_EN_tb	= enable_parity;
			PAR_TYP_tb	= parity_type;
			recieve_data();
		end
	endtask

	//check output
	task check_output;
		input	[10:0]	     expected_output;
		input [7:0]       sent_data;
		input  integer	   case_tb;
		
		integer			        N;
		reg		[10:0]	      generated_output;
		
		begin
			for(N = 0; N <= 10; N = N + 1)
				begin
					generated_output[N] = TX_OUT_tb;
					#(CLK_period);
				end
			if (expected_output == generated_output)
				begin
					$display("test case %d passed with generated output: %d and expected output:%d, with data sent: %d", case_tb,generated_output,expected_output,sent_data);
				end
			else
				begin
					$display("test case %d failed", case_tb);
				end
		end
	endtask

		//check output
	task check_output_dissable_par;
		input	[9:0]	     expected_output;
		input [7:0]       sent_data;
		input  integer	   case_tb;
		
		integer			        N;
		reg		[9:0]	      generated_output;
		
		begin
			for(N = 0; N <= 9; N = N + 1)
				begin
					generated_output[N] = TX_OUT_tb;
					#(CLK_period);
				end
			if (expected_output == generated_output)
				begin
					$display("test case %d passed with disabled parity and with generated output: %d and expected output:%d, with data sent: %d", case_tb,generated_output,expected_output,sent_data);
				end
			else
				begin
					$display("test case %d failed", case_tb);
				end
		end
	endtask
	
	//generate clock
  always 	#(CLK_period/2) CLK_tb = ~CLK_tb;
	//module instantiation
	UART_TX_TOP DUT (
		.P_DATA			(P_DATA_tb),
		.DATA_VALID		(DATA_VALID_tb),
		.PAR_EN			(PAR_EN_tb),
		.PAR_TYP		(PAR_TYP_tb),
		.CLK			(CLK_tb),
		.RST			(RST_tb),
		.Busy			(Busy_tb),
		.TX_OUT			(TX_OUT_tb)
	);

endmodule

