LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mult4x4 IS
PORT ( dataa, datab : IN UNSIGNED (3 downto 0);
	product : OUT UNSIGNED (7 downto 0));
END ENTITY mult4x4;

ARCHITECTURE logic OF mult4x4 IS 
  
BEGIN
product <= dataa * datab;
END ARCHITECTURE logic;
