module pwm_top_tb;
logic [BW-1:0] duty;
logic clk,rst, en;
logic out;

parameter BW=8;
	pwm_top #(BW) dut (
		.duty(duty),
		.clk(clk),
		.rst(rst),
		.en(en),
		.out(out)
	);
	always begin
	 #10;
	 clk <= !clk;
	end
	integer i, count=0;
	logic fail=0;
	initial begin
		rst=1; clk=0; duty=(2**BW)-1; en=1;
		#25;
		rst=0;
		#20;
		for(i=0;i < (2**BW) ; i=i+1)begin
				#20;
				if(!out) fail=1; 
		end
		if(fail) begin
			$display("Error output not consistent with 100% duty cycle");
			$finish;
		end
		duty=100;
		#40;
		for(i=0;i <(2**BW)-1; i=i+1)begin
				if(out) count=count+1; 
				#20;		
		end
		
		if(count != duty ) begin
			$display("Error output not consistent %d duty cycle", duty);
			$finish;
		end
						
			
		$display("Verification pass");
		$finish;
	end
endmodule


