module serializer(
	input     [7:0]     	P_Data,
	input               	Data_Valid,
	input					           ser_EN,
	input               	CLK,
	input               	RST,
		
	output		reg	    	    ser_OUT,
	output		reg			       ser_Done,
	output		reg	[3:0]	   counter_ser
);

	reg		[7:0]		data_regs;

	//data serializer logic
	
	always @ (posedge CLK or negedge RST) //serializer counter 
	begin
	if(!RST)
		begin
		counter_ser <= 0;
		end
	else
		begin
		if(!ser_Done && ser_EN)
			begin
			counter_ser <= counter_ser + 1;
			end
		else
			begin
			counter_ser <= 0;
			end
		end
	end
	
	always @ (posedge CLK or negedge RST)
	begin
	if(!RST)
		begin
			ser_OUT <= 'b0;
			ser_Done <= 'b0;
			data_regs <= 'b0;
		end
	else if(Data_Valid)
		begin
			data_regs <= P_Data; //now data is registered	
		end
	else if(ser_EN)
		begin
		if(counter_ser != 8)
			begin
			//{data_regs[7:1], ser_OUT} <= data_regs;
			ser_OUT <= data_regs[0];
			data_regs[0] <= data_regs[1];
			data_regs[1] <= data_regs[2];
			data_regs[2] <= data_regs[3];
			data_regs[3] <= data_regs[4];
			data_regs[4] <= data_regs[5];
			data_regs[5] <= data_regs[6];
			data_regs[6] <= data_regs[7];
			ser_Done <= 'b0;
			end
		else
			begin
			ser_Done <= 'b1;
			data_regs <= 'b0;
			end
		end
/*	else
		begin
		ser_OUT <= 'b0;
		ser_Done <= 'b0;
		data_regs <= 'b0;
		end*/
	end

endmodule