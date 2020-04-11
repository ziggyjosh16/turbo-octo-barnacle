library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity timing_tb is
end entity;

architecture tb of timing_tb is

component de1_soc_top is

Port(


--////////////////////////	Clock Input	 	////////////////////////
	TD_CLK27 	:in		std_logic;						-- 27 MHz
	CLOCK_50	:in		std_logic;						-- 50 MHz

-- ////////////////////////	Push Button		////////////////////////
	KEY			:in		std_logic_vector( 3 downto 0);	--Pushbutton[3:0]

	LEDR		:out	std_logic_vector(9 downto 0)	 --LED Red[17:0]
	
	);
	
	end component;
	
	signal		rst			:std_logic;
	signal		clock_50	:std_logic;
	signal		clock_27	:std_logic;
	signal		keys		:std_logic_vector( 3 downto 0 );
	
	
	begin
	
	r: process is begin
		rst <= '0';
		wait for 300 ns;
		rst <= '1';
		wait;
		end process;
		
	c50: process is begin
		clock_50 <= '0';
		wait for 10 ns;
		clock_50 <= '1';
		wait for 10 ns;
		end process;
		
	c27: process is begin
		clock_27 <= '0';
		wait for 18.52 ns;
		clock_27 <= '1';
		wait for 18.52 ns;
		end process;
	
	keys <=	("101" & rst);
dut: de1_soc_top

Port map (

--////////////////////////	Clock Input	 	////////////////////////
	TD_CLK27 	=> clock_27,						-- 27 MHz
	CLOCK_50	=> clock_50,						-- 50 MHz

-- ////////////////////////	Push Button		////////////////////////
	KEY			=> keys ,	--Pushbutton[3:0]

	LEDR		=> open	 --LED Red[17:0]
	
	);
	

end;