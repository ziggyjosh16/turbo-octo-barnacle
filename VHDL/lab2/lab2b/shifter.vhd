LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY shifter IS
PORT ( 
	shift_cntrl : IN UNSIGNED (1 downto 0);
	input : IN UNSIGNED (7 downto 0);
	shift_out : OUT UNSIGNED (15 downto 0));
END ENTITY shifter;

ARCHITECTURE logic OF shifter IS 
BEGIN
	PROCESS (input, shift_cntrl)
   BEGIN
		shift_out <= "0000000000000000"; --default value
		CASE shift_cntrl IS
		WHEN "01" =>
		shift_out (11 downto 4) <= input (7 downto 0);
		WHEN "10" =>
		shift_out (15 downto 8) <= input (7 downto 0);
		WHEN OTHERS =>
		shift_out (7 downto 0) <= input  (7 downto 0);
		END CASE;
	END PROCESS;
END ARCHITECTURE logic;