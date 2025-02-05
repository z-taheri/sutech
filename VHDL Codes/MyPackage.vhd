library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------------
Package MyPackage is
component WateringSystem 
    Port (T, L, CLK, RESET : in std_logic;
		M : in std_logic_vector (2 downto 0);
		OUTPUT_STATE : out std_logic_vector(1 downto 0);
                SEG : out STD_LOGIC_VECTOR (6 downto 0);
		MOIS : out std_logic_vector (2 downto 0);
		TEMP : out std_logic;
		LIGHT : out std_logic);
end component;
------------------------------------------------------------------
component Seg7 
    port ( WATERSTATE: in STD_LOGIC_VECTOR (1 downto 0);
           Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0));
end component;

	subtype state_type is std_ulogic_vector(1 downto 0);
	constant ST0 : state_type:="00";
        constant ST1 : state_type:="01";
        constant ST2 : state_type:="11";


end MyPackage;
