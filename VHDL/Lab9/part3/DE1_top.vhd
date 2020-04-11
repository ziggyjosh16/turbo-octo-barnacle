LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity de1_top is
generic (
   simulation_wide : positive := 28;    -- used for simulation to overide width
	simulation_max  : positive := 50000000); -- used for simulaiton to oreride max value
port
(
	-- 50Mhz clock, i.e. 50 Million rising edges per second
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
--signal enable_pulse_every_second  : std_logic;
--signal reset                      : std_logic;
--signal     : std_logic_vector(3 downto 0);
--signal ten_second_count_value     : std_logic_vector(3 downto 0);
--signal enable_10_second           : std_logic;
--signal load_counter               : std_logic;

signal clk : std_logic;
signal readaddress, q_rdaddress, q2_rdaddress, writeaddress, q_wraddress, q2_wraddress : std_logic_vector(4 downto 0);
signal ram_in, q_ram_in, q2_ram_in : std_logic_vector(3 downto 0);
signal ram_out : std_logic_vector(3 downto 0);
signal write_data, q_write_data, q2_write_data : std_logic;
signal address3, address2, address5, address4 : std_logic_vector(3 downto 0);
signal i5,i4,i3,i2,i1,i0 : unsigned(3 downto 0);
signal reset : std_logic;
signal enable_pulse_every_second : std_logic;
signal countto32 : std_logic_vector (4 downto 0);

-- define the component	
component seven_segment_cntrl IS
	-- Begin port declaration
	port (
		-- Declare data input "input"
		input : in unsigned(3 downto 0);
		-- Declare the seven segment output
		hex   : out std_logic_vector(6 downto 0));
-- End entity		
end component;

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


component ram32x4
	PORT
	(
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		wraddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		wren		: IN STD_LOGIC  ;
		q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
end component;

begin
oneseccounter : gen_counter
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
		term	 => enable_pulse_every_second -- goes high for 1 clock cycle max value hit
		);	
		
		
thirtytwoseccounter : gen_counter
generic map (
		wide => 5, -- need 28 bits do divide 50Mhz down to 1 second
		max  => 32   -- terminate the count when you hit 50Million
		)
port map (
		clk    => clock_50,
		data	 => (others => '0'),
		load	 => '0',   -- not loadable
		enable => enable_pulse_every_second,   -- always enabled
		reset	 => reset, 
		count	 => countto32,  
		term	 => open -- goes high for 1 clock cycle max value hit
		);	
-- turn off the other 7 segments, drive high to turn off
--hex1 <= (others => '1');

-- turn off unused LEDs, drive 0 to keep off
ledr(9 downto 0) <= (others =>'0');

-- use key 0 as the clock, normally high, push and release for rising edge
-- for lab7 memory lab, use key (0) as clock for parts I through III
-- for Part IV you will use clock_50 as the clock
clk <= key(0); 
reset <= not key(0);


i0 <= unsigned(ram_out); 
i1 <= unsigned(ram_in); --write data
i2 <= unsigned(address2); --read address
i3 <= unsigned(address3); -- read address
i4 <= unsigned(address4); --write address
i5 <= unsigned(address5); --write address

q_wraddress <= sw(8 downto 4);
q_rdaddress <= countto32;

q_ram_in <= sw(3 downto 0);
q_write_data <= sw(9);




---for HEX displays---
address3 <= "000" & q_rdaddress(4);
address2 <= q_rdaddress(3 downto 0);

address5 <= "000" & q_wraddress(4);
address4 <= q_wraddress(3 downto 0);






process (clock_50, reset)
begin
	IF rising_edge(clock_50) then
	
	readaddress <= q2_rdaddress;
	q2_rdaddress <= q_rdaddress;
	
	writeaddress <= q2_wraddress;
	q2_wraddress <= q_wraddress;
	
	ram_in <= q2_ram_in;
	q2_ram_in <= q_ram_in;
	
	write_data<= q2_write_data;
	q2_write_data <= q_write_data;
	
	END IF;
end process;

wumpus: ram32x4
	-- Begin port declaration
  port map(
    
	 clock => clock_50,
	 data => ram_in ,
	 rdaddress => readaddress,
    wraddress => writeaddress,	
	 wren => write_data,
	 q => ram_out
	 ); 



hex5_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i5,
	 hex   => hex5); 
	 
hex4_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i4,
	 hex   => hex4);
 
hex3_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i3,
	 hex   => hex3);	
	 
hex2_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(
    input => i2,
	 hex   => hex2);
	 
hex1_driver: seven_segment_cntrl
	port map(
	input => i1,
	hex => hex1);

hex0_driver: seven_segment_cntrl
	-- Begin port declaration
  port map(  
    input => i0,
	 hex   => hex0);
 
end; -- end the design









