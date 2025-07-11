module parity_calc (
	input		    PAR_TYP,
	input		 [7:0]   P_Data,
	input		    Data_Valid,
	input      RST,
	input			CLK,
	
	output	reg	par_bit
);

	//parity calculator logic
	always @ (posedge CLK or negedge RST) 
	begin
		if(!RST)
			begin
			par_bit <= 1'b0; // a default value of parity bit that it is 0
			end
		else if(Data_Valid && !PAR_TYP)
			begin
			par_bit <= ~^P_Data; // when the XNOR is 1 so even par and when it is 0 its odd par
			end		
		else if (Data_Valid && PAR_TYP)
			begin
			par_bit <= ^P_Data; // when the XOR is 1 so odd par and when it is 0 its even par
			end
	end
	
	

endmodule