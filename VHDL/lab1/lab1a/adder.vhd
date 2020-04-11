LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY adder IS
PORT ( dataa, datab : IN UNSIGNED (15 downto 0);
	sum : OUT UNSIGNED (15 downto 0));
END ENTITY adder;

ARCHITECTURE logic OF adder IS 
  
BEGIN
sum <= dataa + datab;
END ARCHITECTURE logic;

