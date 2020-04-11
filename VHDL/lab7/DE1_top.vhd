LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity de1_top is
generic (
   simulation_wide : positive := 28;    -- used for simulation to overide width
	simulation_max  : positive := 25000000); -- used for simulaiton to override max value
port
(
	-- 50Mhz clock, i.e. 25 Million rising edges per half/second
   clock_50 :in  std_logic; 
   -- 7 Segment Display
	hex0     :out std_logic_vector(6 downto 0); -- right most
	hex1     :out std_logic_vector(6 downto 0);	
	hex2     :out std_logic_vector(6 downto 0);	
	hex3     :out std_logic_vector(6 downto 0);	
	hex4     :out std_logic_vector(6 downto 0);	
	hex5     :out std_logic_vector(6 downto 0); -- left most
   -- Red LEDs above Slider switches
	-- drive the ledr's high to light them up
   ledr     :out std_logic_vector(9 downto 0);
	-- key/Push Button, push button to drive a signal low, normally high
	key      :in  std_logic_vector(3 downto 0);  
   -- Slider Switch, logic 0 when slide down, logic 1 when pushed towards 7 segments
	sw       :in	 std_logic_vector(9 downto 0) 
);

end de1_top;

architecture struct of de1_top is

-- define signals to be used
signal enable_pulse_every_half_second, one_signal, one_half_signal, reset, clocky  : std_logic;
signal half_second_count_value : positive;
signal i0, i1, i2, i3, i4, i5 : unsigned (3 downto 0);

---states
TYPE state_type IS (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);

signal current_state: state_type;
signal next_state: state_type;

-- define the component
component gen_counter is
generic (
		wide :positive; -- how many bits is the counter
		max  :positive  -- what is the max count
		);
port (
		clk	 :in	std_logic;
		data	 :in  std_logic_vector(wide-1 downto 0 );
		load	 :in  std_logic;
		enable :in  std_logic;
		reset	 :in  std_logic;
		count	 :out std_logic_vector(wide-1 downto 0 );
		term	 :out std_logic);
	end component;
	

component seven_segment_cntrl IS
	-- Begin port declaration
	port (
		-- Declare data input "input"
		input : in unsigned(3 downto 0);
		-- Declare the seven segment output
		hex   : out std_logic_vector(6 downto 0));
-- End entity		
end component;

begin


-- first use an instance of counter to get clock enable
-- never ever use the term output as clock, always use as an enable 
large_counter : gen_counter
generic map (
		wide => simulation_wide, -- need 28 bits do divide 50Mhz down to 1 second
		max  => simulation_max   -- terminate the count when you hit 50Million
		)
port map (
		clk    => clock_50,
		data	 => (others => '0'),
		load	 => '0',   -- not loadable
		enable => '1',   -- always enabled
		reset	 => reset, --do we want this?
		count	 => open,  
		term	 => enable_pulse_every_half_second -- goes high for 1 clock cycle max value hit
		);	

-- this counter will count half seconds.			
half_second_counter : gen_counter 
generic map (
		wide => 2,  -- created a 2 bit counter (max count could be 3)
		max  => 2   -- stop counting after 3, go back to 0
		)
port map (
		clk	 => clock_50,
		data	 => (others => '0'), 
		load	 => '0',   
		enable => enable_pulse_every_half_second,
		reset	 => reset,
		count	 => open,
		term	 => one_half_signal); 
		
one_second_counter : gen_counter
generic map (
	wide => 2, 
	max => 1
	)
port map (
	clk => clock_50,
	data => (others => '0'),
	load => '0',
	enable => enable_pulse_every_half_second,
	reset => reset,
	count => open,
	term => one_signal
	);

process (clock_50, key, clocky) --check sensitivity list and if/else statements
begin
	if key(0) = '0' THEN
		current_state <= s0;
	else
		if rising_edge(clocky) THEN 
				current_state <= next_state;
		end if;
	end if;
end process;

process (sw, one_signal)
begin
	if sw(0) = '0' then
		clocky <= one_signal;
	else
		clocky <= one_half_signal;
	end if;
end process;


reset <= not key(0);

display_control: process(current_state, sw)
begin
	if sw(1) = '0' then
		case current_state is
		--15 is free in seven segment "1111"
			when s0 =>
				i0 <= "1110";
				i1 <= "1110";
				i2 <= "0100";
				i3 <= "0101";
				i4 <= "0111";
				i5 <= "0000";
			when s1 =>
				i0 <= "1111";
				i1 <= "1110";
				i2 <= "1110";
				i3 <= "0100";
				i4 <= "0101";
				i5 <= "0001";
			when s2 =>
				i0 <= "1111";
				i1 <= "1111";
				i2 <= "1110";
				i3 <= "1110";
				i4 <= "0100";
				i5 <= "0010";
			when s3 =>
				i0 <= "1111";
				i1 <= "1111";
				i2 <= "1111";
				i3 <= "1110";
				i4 <= "1110";
				i5 <= "0011";
			when s4 =>
				i0 <= "1111";
				i1 <= "1111";
				i2 <= "1111";
				i3 <= "1111";
				i4 <= "1110";
				i5 <= "0100";
			when s5 =>
				i0 <= "1111";
				i1 <= "1111";
				i2 <= "1111";
				i3 <= "1111";
				i4 <= "1111";
				i5 <= "0101";
			when s6 =>
				i0 <= "0111";
				i1 <= "1111";
				i2 <= "1111";
				i3 <= "1111";
				i4 <= "1111";
				i5 <= "0110";
			when s7 =>
				i0 <= "0101";
				i1 <= "0111";
				i2 <= "1111";
				i3 <= "1111";
 				i4 <= "1111";
				i5 <= "0111";
			when s8 =>
				i0 <= "0100";
				i1 <= "0101";
				i2 <= "0111";
				i3 <= "1111";
				i4 <= "1111";
				i5 <= "1000";
			when s9 =>
				i0 <= "1110";
				i1 <= "0100";
				i2 <= "0101";
				i3 <= "0111";
				i4 <= "1111";
				i5 <= "1001";
		end case;
	--change seven segment display inputs
	else
		case current_state is
				when s0 => --ABCDE0
				i0 <= "1010";
				i1 <= "1011";
				i2 <= "1100";
				i3 <= "1101";
				i4 <= "1110";
				i5 <= "0000";
				when s1 => --bABCD1
				i0 <= "1111";
				i1 <= "1010";
				i2 <= "1011";
				i3 <= "1100";
				i4 <= "1101";
				i5 <= "0001";
				when s2 => --bbABC2
				i0 <= "1111";
				i1 <= "1111";
				i2 <= "1010";
				i3 <= "1011";
				i4 <= "1100";
				i5 <= "0010";
				when s3 => --bbbAB3
				i0 <= "1111";
				i1 <= "1111";
				i2 <= "1111";
				i3 <= "1010";
				i4 <= "1011";
				i5 <= "0011";
				when s4 => --bbbbA4
				i0 <= "1111";
				i1 <= "1111";
				i2 <= "1111";
				i3 <= "1111";
				i4 <= "1010";
				i5 <= "0100";
				when s5 => --bbbbb5
				i0 <= "1111";
				i1 <= "1111";
				i2 <= "1111";
				i3 <= "1111";
				i4 <= "1111";
				i5 <= "0101";
				when s6 => --Ebbbb6
				i0 <= "1110";
				i1 <= "1111";
				i2 <= "1111";
				i3 <= "1111";
				i4 <= "1111";
				i5 <= "0110";
				when s7 => --DEbbb7
				i0 <= "1101";
				i1 <= "1110";
				i2 <= "1111";
				i3 <= "1111";
				i4 <= "1111";
				i5 <= "0111";
				when s8 => --CDEbb8
				i0 <= "1100";
				i1 <= "1101";
				i2 <= "1110";
				i3 <= "1111";
				i4 <= "1111";
				i5 <= "1000";
				when s9 => --BCDEb9
				i0 <= "1011";
				i1 <= "1100";
				i2 <= "1101";
				i3 <= "1110";
				i4 <= "1111";
				i5 <= "1001";
			end case;
	end if;
end process;


process (current_state,key) --check list and sequential statements
begin
	if key(2) = '0' then
		next_state <= current_state;
	else
		case current_state is
			WHEN s0 =>
				if key(1) = '0' then 
					next_state <= s9;
				else
					next_state <= s1;
				end if;
			WHEN s1 =>
				if key(1) = '0' then 
					next_state <= s0;
				else
					next_state <= s2;
				end if;
			WHEN s2 =>
				if key(1) = '0' then 
					next_state <= s1;
				else
					next_state <= s3;
				end if;
			WHEN s3 =>
				if key(1) = '0' then 
					next_state <= s2;
				else
					next_state <= s4;
				end if;
			WHEN s4 =>
				if key(1) = '0' then 
					next_state <= s3;
				else
					next_state <= s5;
				end if;
			WHEN s5 =>
				if key(1) = '0' then 
					next_state <= s4;
				else
					next_state <= s6;
				end if;
			WHEN s6 =>
				if key(1) = '0' then 
					next_state <= s5;
				else
					next_state <= s7;
				end if;
			WHEN s7 =>
				if key(1) = '0' then 
					next_state <= s6;
				else
					next_state <= s8;
				end if;
			WHEN s8 =>
				if key(1) = '0' then 
					next_state <= s7;
				else
					next_state <= s9;
				end if;
			WHEN s9 =>
				if key(1) = '0' then 
					next_state <= s8;
				else
					next_state <= s0;
				end if;
		END case;
	END IF;
END process;
		

hex0_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i0,
	 hex   => hex5); 

hex1_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i1,
	 hex   => hex4); 
	 
hex2_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i2,
	 hex   => hex3); 

hex3_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i3,
	 hex   => hex2); 
	 
hex4_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i4,
	 hex   => hex1); 
	 
hex5_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i5,
	 hex   => hex0); 
	 
end; -- end the design









