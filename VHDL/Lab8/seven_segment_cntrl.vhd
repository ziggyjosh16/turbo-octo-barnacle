--***********************************************************************************
--                                                                                  *
--                  Copyright (C) 2014 Altera Corporation                           *
--                                                                                  *
-- ALTERA, ARRIA, CYCLONE, HARDCOPY, MAX, MEGACORE, NIOS, QUARTUS & STRATIX         *
-- are Reg. U.S. Pat. & Tm. Off. and Altera marks in and outside the U.S.           *
--                                                                                  *
-- All information provided herein is provided on an "as is" basis,                 *
-- without warranty of any kind.                                                    *
--                                                                                  *
-- Module Name: seven_segment_cntrl         File Name: seven_segment_cntrl.vhd      *
--                                                                                  *
-- Module Function: This file implements control logic for the 7-segment display    *
--                                                                                  *
-- REVISION HISTORY:                                                                *
--***********************************************************************************

-- Insert library and use clauses
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Begin entity declaration for "seven_segment_cntrl"
ENTITY seven_segment_cntrl IS
	-- Begin port declaration
	PORT (
		-- Declare data input "input"
		input : IN UNSIGNED(3 DOWNTO 0);
		
		-- Declare the seven segment output
		hex : OUT STD_LOGIC_VECTOR(6 downto 0)
	);
-- End entity		
END ENTITY seven_segment_cntrl;

-- Begin architecture
ARCHITECTURE logic OF seven_segment_cntrl IS
signal seven_seg : std_logic_vector (6 downto 0);  -- upper bit is seg_a, lower bit is seg_g
BEGIN
    hex(6 downto 0) <= not seven_seg(0) & not seven_seg(1) & not seven_seg(2)&
	                    not seven_seg(3) & not seven_seg(4) & not seven_seg(5)& 
							  not seven_seg(6);
							  
	-- Begin process sensitive to input
	PROCESS (input)
	BEGIN
		--  Case statement to control segments of seven segment display
		--  logic 1 should up the segment
		CASE input IS
			WHEN "0001" =>
				seven_seg <= "1000110";
			WHEN "0010" =>
				seven_seg <= "0111011";
			WHEN "0011" =>
				seven_seg <= "1111011";
			WHEN "0100" =>
				seven_seg <= "0001110";
			WHEN OTHERS =>  -- it will display nothing
			  seven_seg <= "0000000";
		END CASE;
	-- End process
	END PROCESS;
-- End architecture
END ARCHITECTURE logic;
