library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------
entity Seg7 is
    Port ( WATERSTATE: in STD_LOGIC_VECTOR (1 downto 0);
           Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0)); 
end Seg7;

-------------------------------------------------------------------
architecture Behavioral of Seg7 is
 
begin
 
process(WATERSTATE)
begin
	case WATERSTATE is 
		when "00" =>
			Seven_Segment <= "1000000";
	
		when "01" =>
			Seven_Segment <= "1110110";
		when others =>
   			null;
	end case;
end process;

end Behavioral;
