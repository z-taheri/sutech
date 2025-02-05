library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------------------------
Entity WateringSystem is
	Port (T, L, CLK, RESET : in std_logic;
		M : in std_logic_vector (2 downto 0);
		OUTPUT_STATE : out std_logic_vector(1 downto 0);
                SEG : out STD_LOGIC_VECTOR (6 downto 0);
		MOIS : out std_logic_vector (2 downto 0);
		TEMP : out std_logic;
		LIGHT : out std_logic);
End WateringSystem;
-------------------------------------------------------------------------
Architecture fsm of WateringSystem is

component Seg7 
    port ( WATERSTATE: in STD_LOGIC_VECTOR (1 downto 0);
           Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0));
end component;

	subtype state_type is std_logic_vector(1 downto 0);
	constant ST0 : state_type:="00";
        constant ST1 : state_type:="01";
        constant ST2 : state_type:="11";
	Signal PRESENT_STATE, NEXT_STATE : state_type;
	Signal flag : STD_LOGIC_VECTOR (1 downto 0);
Begin

MODULE : Seg7
port map(flag,SEG);

set : process(CLK, NEXT_STATE, RESET)
Begin
	if (RESET = '1') then PRESENT_STATE <= ST0;
	elsif (rising_edge(CLK)) then PRESENT_STATE <= NEXT_STATE;
	End if;
End process set;


FSM: process(PRESENT_STATE, T, L, M)
Begin

	case PRESENT_STATE is
		when ST0 => 
			if (T = '1' or L = '1') and (M <= "001") then 
				NEXT_STATE <= ST1; MOIS <= M; TEMP <= T; LIGHT <= L;
			elsif (T = '0' and L = '0') and (M <= "011") then 
				NEXT_STATE <= ST1; MOIS <= M; TEMP <= T; LIGHT <= L;
			else 
				NEXT_STATE <= ST0; MOIS <= M; TEMP <= T; LIGHT <= L;
			End if;

		when ST1 =>
			if (M >= "111") then
				NEXT_STATE <= ST0; MOIS <= M; TEMP <= T; LIGHT <= L;
			elsif (M >= "011") and (T = '1' or L = '1') then
				NEXT_STATE <= ST0; MOIS <= M; TEMP <= T; LIGHT <= L;
			else 
				NEXT_STATE <= ST1; MOIS <= M; TEMP <= T; LIGHT <= L;
			End if;

		when others =>
			NEXT_STATE <= ST0; MOIS <= M; TEMP <= T; LIGHT <= L;
	End case;
End process FSM;

OUTPUTPROCESS : process(PRESENT_STATE)
    begin
        case PRESENT_STATE is
            when ST0 => OUTPUT_STATE <= "00"; flag <= "00";
            when ST1 => OUTPUT_STATE <= "01"; flag <= "01";
            when others => OUTPUT_STATE <= "11"; flag <= "11";
        end case;
    end process;
End fsm;