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
signal enable_pulse_every_half_second, twelve_signal, reset, clocky  : std_logic;
signal signal_sudo_count: std_logic_vector (4 downto 0);
signal signal_count: unsigned (4 downto 0);
signal i0, i1, i2, i3, i4, i5 : unsigned (3 downto 0);

signal s5first, s5final, s6first, s6final, s0first, s0final: std_logic;
---states
TYPE state_type IS (night_mode, ns_s, ns_l,ew_s, ew_l, break_state);

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
		reset	 => reset, 
		count	 => open,  
		term	 => enable_pulse_every_half_second -- goes high for 1 clock cycle max value hit
		);	

-- this counter will count for the red green and yellow lights		
twelve_second_counter : gen_counter 
generic map (
		wide => 5,  -- created a 2 bit counter (max count could be 3)
		max  => 24   -- stop counting after 3, go back to 0
		)
port map (
		clk	 => clock_50,
		data	 => (others => '0'), 
		load	 => '0',   
		enable => enable_pulse_every_half_second,
		reset	 => reset,
		count	 => signal_sudo_count,
		term	 => twelve_signal
		); 


process(clock_50, sw)
	begin
	if rising_edge(clock_50) then
		s5first <= sw(5);
		s5final <= s5first;
		s6first <= sw(6);
		s6final <= s6first;
		s0first <= sw(0);
		s0final <= s0first;
	end if;
end process;

process (current_state, sw, key) 
	begin
		if sw(0) = '1' then 
			next_state <= night_mode;
		else
			case current_state is
				when night_mode =>
					next_state <= ew_s;
				when break_state =>
					if s6final = '1' then 
						next_state <= ns_l;
					else
						next_state <= ns_s;
					end if;
				when ns_s =>
					if s6final = '1' then 
						next_state <= ew_l;
					else
						next_state <= ew_s;
					end if;
				when ew_s =>
					if s5final = '1' then 
						next_state <= ns_l;
					else
						next_state <= ns_s;
					end if;
				when ns_l =>
					next_state <= ns_s;
				when ew_l =>
					next_state <= ew_s;
				when others =>
					next_state <= break_state;
			END case;
		END IF;
END process;


process (clock_50, key, twelve_signal) --check sensitivity list and if/else statements
begin
	if key(0) = '0' THEN
		current_state <= break_state;
	else
		if  rising_edge(clock_50) and twelve_signal = '1' THEN 
				current_state <= next_state;
		end if;
	end if;
end process;



reset <= not key(0);
signal_count <= unsigned(signal_sudo_count);

display_control: process(current_state, sw, signal_count)
begin
		case current_state is
			when break_state =>
				ledr <= "1111111111";
				i5 <= "0001";
				i4 <= "0001";
				i3 <= "1111";
				i2 <= "0001";
				i1 <= "0001";
				i0 <= "1111";
			when night_mode =>
			 ledr <= "0000000000";
				if signal_count(1) = '1' then --every half second
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "1111";
					i2 <= "0010";
					i1 <= "0010";
					i0 <= "1111";
				else 
					i5 <= "1111";
					i4 <= "1111";
					i3 <= "1111";
					i2 <= "1111";
					i1 <= "1111";
					i0 <= "1111";
				end if;
			when ns_s =>
			ledr <= "0000000000";
				if signal_count < "01111" then 
					i5 <= "0011";
					i4 <= "0011";
					i3 <= "0001";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0001";
				elsif ((signal_count >= "01111") and (signal_count <= "10100")) then
					i5 <= "0010";
					i4 <= "0010";
					i3 <= "0001";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0001";
				else
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0001";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0001";
				end if;
			when ew_s =>
			ledr <= "0000000000";
				if signal_count < "01111" then 
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0001";
					i2 <= "0011";
					i1 <= "0011";
					i0 <= "0001";
				elsif ((signal_count >= "01111") and (signal_count <= "10100")) then
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0001";
					i2 <= "0010";
					i1 <= "0010";
					i0 <= "0001";
				else
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0001";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0001";
				end if;
			when ns_l =>
			ledr <= "0000000000";
					if signal_count < "01111" then 
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0100";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0001";
				elsif ((signal_count >= "01111") and (signal_count <="10100")) then
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0010";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0001";
				else
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0001";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0001";
				end if;
			when ew_l =>
			ledr <= "0000000000";
				if signal_count < "01111" then 
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0001";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0100";
				elsif signal_count >= "01111" and signal_count <="10100" then
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0001";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0010";
				else
					i5 <= "0001";
					i4 <= "0001";
					i3 <= "0001";
					i2 <= "0001";
					i1 <= "0001";
					i0 <= "0001";
				end if;
			end case;
			
end process;


		

hex0_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i0,
	 hex   => hex0); 

hex1_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i1,
	 hex   => hex1); 
	 
hex2_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i2,
	 hex   => hex2); 

hex3_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i3,
	 hex   => hex3); 
	 
hex4_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i4,
	 hex   => hex4); 
	 
hex5_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i5,
	 hex   => hex5); 
	 
end; -- end the design









