LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity DE1_top is

Port(


   -- 7 Segment Display
	-- driving the the individual bit loicall low will
	-- light up the segment.
	HEX0		:out	std_logic_vector( 6 downto 0); -- right most
	HEX1		:out	std_logic_vector( 6 downto 0);	
	HEX2		:out	std_logic_vector( 6 downto 0); -- dont use	
	HEX3		:out	std_logic_vector( 6 downto 0);	
	HEX4		:out	std_logic_vector( 6 downto 0);	
	HEX5		:out	std_logic_vector( 6 downto 0); -- left most
   
	-- Red LEDs above Slider switches
	-- driving the LEDR signal logically high will light up the Red LED
	-- driving the LEDR signal logically low will turn off the Red LED 
   LEDR		:out	std_logic_vector( 9 downto 0);	

	-- Push Button
	-- the KEY input is normally high, pressing the KEY
	-- will drive the input low.
	
	KEY		:in   std_logic_vector( 3 downto 0);  
   -- Slider Switch
	-- when the Slider switch is pushed up, away from the board edge
	-- the input signal is logically high, when pushed towards the
	-- board edge, the signal is loically low.
	SW			:in	std_logic_vector( 9 downto 0 ) 
    
);

end DE1_top;

architecture struct of DE1_top is

-- signal and component declarations
	
	--seven segment inputs
	SIGNAL c5 : unsigned(3 downto 0);
	SIGNAL c4 : unsigned(3 downto 0);
	SIGNAL c3 : unsigned(3 downto 0);
	SIGNAL c1 : unsigned(3 downto 0);
	SIGNAL c0 : unsigned(3 downto 0);
	
	--sel
	SIGNAL mux_sel_2 : std_logic;
	SIGNAL mux_sel_1 : std_logic;
	
	--mux 4 and 3 inputs
	--SIGNAL mux_in_a4 : unsigned(3 downto 0);
	SIGNAL mux_in_b4 : unsigned(3 downto 0);
	--SIGNAL mux_in_a3 : unsigned(3 downto 0);
	SIGNAL mux_in_b3 : unsigned(3 downto 0);
	
	--subtract 4 bits inputs
	SIGNAL data_sa1 : unsigned(3 downto 0);
	--SIGNAL data_sb1 : unsigned(3 downto 0);
	SIGNAL data_sa2 : unsigned(3 downto 0);
	--SIGNAL data_sb2 : unsigned(3 downto 0);
	SIGNAL data_c : unsigned(3 downto 0);
	
	--mux 2 and 1 inputs:
	SIGNAL data_02 : unsigned (3 downto 0);
	SIGNAL data_01 : unsigned (3 downto 0);
	SIGNAL data_bmux : unsigned (3 downto 0);
	SIGNAL data_a : unsigned (3 downto 0);
	
	-- adder
	--SIGNAL  data_a : unsigned (3 downto 0); reused
	SIGNAL  add_b : unsigned (3 downto 0);
	
	--multiplier
	SIGNAL mult_a : unsigned (1 downto 0);
	--SIGNAL mult_b : unsigned (1 downto 0);
	
	--shifter temp/final signals
	SIGNAL LED1 : std_logic_vector (3 downto 0);
	SIGNAL LED2 : std_logic_vector (3 downto 0);
	SIGNAL LED3 : std_logic_vector (3 downto 0);
	
	
	
-- you will need to create the component declaration for the 7 segment control.
-- DO NOT ADD ANY OTHER COMPONENTS, ONLY THE 7 SEGMENT CONTROLLER COMPONENT
COMPONENT seven_segment_cntrl
	PORT (
		input : IN UNSIGNED(3 DOWNTO 0);
		hex : OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END COMPONENT seven_segment_cntrl;

begin

    c5 <= unsigned(SW (9 downto 6));
	 c4 <= '0' & '0' & unsigned(SW (5 downto 4));
	 c3 <= '0' & '0' & unsigned (SW (3 downto 2));
	
-- processes, component instantiations, general logic.

--mux 4 (top right)
	--PROCESS (data_sa1, mux_in_b4, mux_sel_2)
	--BEGIN
	WITH mux_sel_2 SELECT
	c1 <= data_sa1 WHEN '0',
	      mux_in_b4 WHEN OTHERS;
	--END PROCESS;
--mux 3	(bottom right)
	PROCESS (data_sa2, mux_in_b3, mux_sel_2)
	BEGIN
	IF mux_sel_2 = '0' THEN c0 <=data_sa2;
	ELSE c0 <= mux_in_b3;
	END IF;
	END PROCESS;
--mux 2 (top left)
	PROCESS (data_a, data_02, mux_sel_1)
	BEGIN
	IF mux_sel_1 = '0' THEN  data_sa1<=data_a;
	ELSE  data_sa1<= data_02;
	END IF;
	END PROCESS;
--mux 1 (bottom left)
	PROCESS (data_bmux, data_01 ,mux_sel_1)
	BEGIN
	CASE mux_sel_1 IS
		WHEN '0' =>
			data_sa2 <= data_bmux;
		WHEN OTHERS =>
			data_sa2 <= data_01;
	END CASE;
	END PROCESS;
	
--------------------------------------------------------------------	
--subtract 1
	PROCESS (data_sa1, data_c)
	BEGIN
	mux_in_b4 <= data_sa1 - data_c;
	END PROCESS;
--subtract 2
	PROCESS (data_sa2, data_c)
	BEGIN
	mux_in_b3 <= data_sa2 - data_c;
	END PROCESS;
	
---------------------------------------------------------------------	

-- adder	
	PROCESS (data_a, add_b)
	BEGIN 
	data_02 <= data_a + add_b;
	END PROCESS;
--multiplier 
	PROCESS (mult_a, data_a)
	BEGIN
	data_01 <= unsigned(mult_a * data_a(1 downto 0));
	END PROCESS;
	
---------------------------------------------------------------------
--shifters
	PROCESS (KEY(1),KEY(0), SW)
	BEGIN
	IF (KEY(1) = '0') THEN
		LEDR <= (OTHERS => '0');
		LED3 <= (OTHERS => '0');
		LED2 <= (OTHERS => '0');
		LED1 <= (OTHERS => '0');
		mux_sel_2 <=  '0'; 
	   mux_sel_1 <= '0';
		data_c <= (OTHERS => '0');
		data_a <= (OTHERS => '0');
		mult_a <= (OTHERS => '0');
		data_bmux <= (OTHERS => '0');
		add_b <= (OTHERS => '0');
	ELSIF RISING_EDGE(KEY(0)) THEN
		LEDR (3 downto 0) <= LED3;
		LED3 <= LED2;
		LED2 <= LED1;
		LED1 <= SW(9 downto 6);
		mux_sel_2 <= STD_LOGIC(SW(0)); 
	   mux_sel_1 <= STD_LOGIC(SW(1)); 
		data_c <= '0' & '0' & unsigned(SW(3 downto 2));
		data_a <= unsigned(SW(9 downto 6));
		mult_a <= unsigned(SW(5 downto 4));
		data_bmux <= '0' & '0' & unsigned(SW(5 downto 4));
		add_b <= '0' & '0' & unsigned(SW(5 downto 4));
	END IF;
	END PROCESS;

	

h5: seven_segment_cntrl PORT MAP ( input => c5, 
											   hex => HEX5 (6 downto 0)
);
h4: seven_segment_cntrl PORT MAP ( input =>  c4,
												hex => HEX4 (6 downto 0)
);
h3: seven_segment_cntrl PORT MAP ( input =>  c3,
												hex => HEX3 (6 downto 0)
);
--has mux input
h1: seven_segment_cntrl PORT MAP ( input => c1, 
											   hex => HEX1 (6 downto 0)
);
--has mux input
h0: seven_segment_cntrl PORT MAP ( input => c0, 
										   hex => HEX0 (6 downto 0)
);


end;








