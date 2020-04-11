LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY reg16 IS
PORT ( 
	clk, sclr_n, clk_ena	: IN STD_LOGIC;
	datain: IN UNSIGNED (15 downto 0);
	reg_out : OUT UNSIGNED (15 downto 0));
END ENTITY reg16;
-- 1 = high 0 -= low
ARCHITECTURE logic OF reg16 IS 
BEGIN
	PROCESS (clk)
	BEGIN
		IF rising_edge(clk)  THEN -- nothing else on this line
			IF clk_ena = '1' THEN
				IF sclr_n = '0' THEN
				-- clear output registers
				reg_out <= "0000000000000000";
				ELSE
				reg_out <= datain;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE logic;
