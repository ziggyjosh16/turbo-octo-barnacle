LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY counter IS
PORT ( clk, aclr_n: IN STD_LOGIC;
count_out: OUT UNSIGNED (1 downto 0));
END ENTITY counter;

ARCHITECTURE logic OF counter IS 
BEGIN
	PROCESS (clk, aclr_n)
	VARIABLE count : UNSIGNED (1 downto 0);
	BEGIN
	
	IF aclr_n = '0' THEN
	count := (OTHERS => '0');
	ELSIF rising_edge(clk) THEN 
		count := count + 1;
	END IF;
	count_out <= count;
	END PROCESS;
END ARCHITECTURE logic;