LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity de1_top_tb is
end entity;

architecture behav of de1_top_tb is

component de1_top is
generic (
		simulation_wide :positive; -- how many bits is the counter
		simulation_max  :positive  -- what is the max count
		);
port (
   CLOCK_50 :in std_logic;
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
signal hex1	  : std_logic_vector(6 downto 0);	
signal hex2	  : std_logic_vector(6 downto 0);	
signal hex3	  : std_logic_vector(6 downto 0);	
signal hex4	  : std_logic_vector(6 downto 0);	
signal hex5	  : std_logic_vector(6 downto 0); -- left most

begin
	
	
	clock:process begin  -- this process just continues to run as the simulation time continues
		 clk <= '0';
		 wait for CLK_PER;
		 clk <= '1';
		 wait for CLK_PER;
		 end process;
		
	
	
	vectors:process begin -- put you test vectors here, remember to advance the simulation in modelsim

		sw     <= "0000000000"; -- drive all the switch inputs to a 0
		key    <= "0000";       -- default state on the board, and reset
		wait for 5 ns; 			-- wait for a fraction of the clock so stimulus is not occuring on clock edges
		-- will want to change this large delay
		key(0) <= '1';
		
		wait for 100*clk_cycle; --  wait for a number of clock cycles,
		
		sw(6 downto 5) <= "11";
		 
		wait for 250*clk_cycle;
		
		sw(0) <= '1';
		
		wait for 100*clk_cycle;
		
		sw (6 downto 5) <= "00";
		
		wait for 10*clk_cycle;
		
		sw(0) <= '0';
		
		wait for 50*clk_cycle;
		
		
		
		
		-- add more vectors to test everything
		
		end process;

		

-- instantiate the device under test (dut)
dut :de1_top
generic map (
		simulation_wide => 2, -- make it 4 bits
		simulation_max  => 2 -- have it only count to 10 for shorter simulation
		)
port map (
  CLOCK_50 => clk,
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
	KEY => key, --	    :in     std_logic_vector( 3 downto 0);  
   -- Slider Switch
   SW  => sw--		:in	std_logic_vector( 9 downto 0 ) 
		);	
end architecture;
		
		
		
	
	