module pwm_top #(
parameter BW = 8
)(
input logic [BW-1:0] duty,
input logic clk,rst, en,
output logic out
);
logic counter;
	always_ff @(posedge clk) begin
		if(rst)
			counter<=0;
		else if(en)
			counter<= counter+1;
	end

	always_ff @(posedge clk) begin
		if(rst)
			out<=0;
		else if(en)
			out<= counter<duty;
	end

endmodule


