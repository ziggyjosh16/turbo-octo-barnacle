LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity de1_top_lab6_tb is
end entity;

architecture behav of de1_top_lab6_tb is

component de1_top is
port (
   -- 7 Segment Display
	HEX0		:out	std_logic_vector( 6 downto 0); -- right most
	HEX1		:out	std_logic_vector( 6 downto 0);	
	HEX2		:out	std_logic_vector( 6 downto 0);	
	HEX3		:out	std_logic_vector( 6 downto 0);	
	HEX4		:out	std_logic_vector( 6 downto 0);	
	HEX5		:out	std_logic_vector( 6 downto 0); -- left most
   -- Red LEDs above Slider switches
    LEDR		:out	std_logic_vector( 9 downto 0);	
	-- Push Button
	KEY		    :in     std_logic_vector( 3 downto 0);  
   -- Slider Switch
	SW			:in	    std_logic_vector( 9 downto 0 ) 
		);
end component;
	
constant CLK_PER:time := 20 ns;
constant clk_cycle:time := 2*clk_per;
	
signal aclr_n : std_logic;
signal clk    : std_logic;
signal sw     : std_logic_vector(9 downto 0);
signal key    : std_logic_vector(3 downto 0);
signal ledr   : std_logic_vector(9 downto 0);
signal hex0	  : std_logic_vector(6 downto 0); -- right most
signal hex1	  :	std_logic_vector(6 downto 0);	
signal hex2	  :	std_logic_vector(6 downto 0);	
signal hex3	  :	std_logic_vector(6 downto 0);	
signal hex4	  :	std_logic_vector(6 downto 0);	
signal hex5	  :	std_logic_vector(6 downto 0); -- left most

begin
	
	
	clock:process begin  -- this process just continues to run as the simulation time continues
		 clk <= '0';
		 wait for CLK_PER;
		 clk <= '1';
		 wait for CLK_PER;
		 end process;
		
	
	
	vectors:process begin -- put you test vectors here, remember to advance the simulation in modelsim

		aclr_n <= '0'; 		-- assert the asynchronous reset signal
		sw     <= "0000000000"; -- drive all the switch inputs to a 0
		wait for 5 ns; 			-- wait for a fraction of the clock so stimulus is not occuring on clock edges
		aclr_n <= '1'; 			-- release the reset signal

		wait for 2*clk_cycle; --  wait for a number of clock cycles
		
		-- add more vectors to test everything
		
		sw     <= "0000001100"; -- drive all the switch inputs to a 0
	--	wait for 5 ns; 			-- wait for a fraction of the clock so stimulus is not occuring on clock edges
	--	aclr_n <= '1'; 			-- release the reset signal

		wait for 2*clk_cycle; --  wait for a number of clock cycles
		
	
		sw     <= "0000110000"; -- drive all the switch inputs to a 0
		--wait for 5 ns; 			-- wait for a fraction of the clock so stimulus is not occuring on clock edges
		--aclr_n <= '1'; 			-- release the reset signal

		wait for 2*clk_cycle; --  wait for a number of clock cycles
		
		sw     <= "1111000000"; -- drive all the switch inputs to a 0
	--	wait for 5 ns; 			-- wait for a fraction of the clock so stimulus is not occuring on clock edges
		--aclr_n <= '1'; 			-- release the reset signal

		wait for 2*clk_cycle; --  wait for a number of clock cycles
		
		sw <= "1111111111";
		
		wait for 2*clk_cycle;
		
		--test shifters
		
		sw <= "1110111100";
		
		
		sw(0) <= '1';
		sw(1) <= '1';
		
		key(1) <= '0';
		key(1) <= '1';
	
		key(0) <= '1';
		key(0) <= '0';
		 wait for 5 ns;
		key(0) <= '1';
		key(0) <= '0';
		 wait for 5 ns;
		key(0) <= '1';
		key(0) <= '0';
		 wait for 5 ns;
		key(0) <= '1';
		key(0) <= '0';
		 wait for 5 ns;
		key(1) <= '0';
		key(0) <= '1';
		
		sw <= "1010101010";
		sw <= "1010101010";
		sw <= "1010000010";
		sw <= "1010101010";



		
		
		
		
		
		
		--mux
		
		--adder
		
		--subtract
	
		
		
		

		
		end process;

key(1) <= aclr_n;
key(0) <= clk;
		

-- instantiate the device under test (dut)
dut :de1_top
port map (
   -- 7 Segment Display
	HEX0 => hex0,--		:out	std_logic_vector( 6 downto 0); -- right most
	HEX1 => hex1,--		:out	std_logic_vector( 6 downto 0);	
	HEX2 => hex2,-- 	:out	std_logic_vector( 6 downto 0);	
	HEX3 => hex3,--     :out	std_logic_vector( 6 downto 0);	
	HEX4 => hex4,--		:out	std_logic_vector( 6 downto 0);	
	HEX5 => hex5,--	    :out	std_logic_vector( 6 downto 0); -- left most
   -- Red LEDs above Slider switches
    LEDR => ledr,--		:out	std_logic_vector( 9 downto 0);	
	-- Push Button
	KEY	 => key, --	    :in     std_logic_vector( 3 downto 0);  
   -- Slider Switch
    SW   => sw--		:in	std_logic_vector( 9 downto 0 ) 
		);	
end architecture;
		
		
		
	
	