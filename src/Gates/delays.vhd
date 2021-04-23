package delays is
	-- NOT Gate
	constant propagation_delay_not1: time := 20 ps;	 
	
	-- AND Gates
	constant propagation_delay_and2: time := 20 ps;
	constant propagation_delay_and3: time := 20 ps;
	
	-- XOR Gates
	constant propagation_delay_xor2: time := 20 ps;
	constant propagation_delay_xor3: time := 20 ps;
	
	-- OR Gates
	constant propagation_delay_or3: time := 20 ps;
	constant propagation_delay_or4: time := 20 ps;
	constant propagation_delay_or5: time := 20 ps;
end package delays;