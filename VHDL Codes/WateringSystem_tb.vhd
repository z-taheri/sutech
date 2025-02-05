library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity WateringSystem_tb is
End WateringSystem_tb;
----------------------------------------------------------------------
Architecture Behavioral of WateringSystem_tb is

component WateringSystem 
    Port (T, L, CLK, RESET : in std_logic;
		M : in std_logic_vector (2 downto 0);
		OUTPUT_STATE : out std_logic_vector(1 downto 0);
                SEG : out STD_LOGIC_VECTOR (6 downto 0);
		MOIS : out std_logic_vector (2 downto 0);
		TEMP : out std_logic;
		LIGHT : out std_logic);
end component;

	Type state_type is (ST0, ST1);
	Signal PRESENT_STATE, NEXT_STATE : state_type;
	Signal flag : STD_LOGIC_VECTOR (2 downto 0);

	signal T :  std_logic := '0';
	signal L :  std_logic := '0';
	signal CLK :  std_logic := '0';
	signal RESET :  std_logic := '0';
	signal M : std_logic_vector(2 downto 0) :="000";
	signal OUTPUT_STATE : std_logic_vector(1 downto 0) :="00";
	signal SEG : std_logic_vector(6 downto 0) :="0000000";
	signal MOIS : std_logic_vector(2 downto 0) := "000";
	signal TEMP : std_logic := '0';
	signal LIGHT : std_logic := '0';

	signal CLK_PERIOD : time := 20 ns;
begin

RUNCLK : process
begin
	CLK <= '1';
	wait for CLK_PERIOD / 2;
	CLK <= '0';
	wait for CLK_PERIOD / 2;
END process;

MODULE1 : WateringSystem
port map(T =>T, L=>L, CLK =>CLK , RESET =>RESET,M=>M, OUTPUT_STATE=>OUTPUT_STATE ,SEG => SEG, MOIS => MOIS , TEMP => TEMP, LIGHT => LIGHT);

stim_proc : process
begin

T <= '0';
L <= '0';
M <= "111";

wait for 20 ns;

T <= '0';
L <= '0';
M <= "011";

wait for 20 ns;

T <= '1';
L <= '1';
M <= "011";

wait for 20 ns;

T <= '1';
L <= '0';
M <= "001";

wait for 20 ns;

T <= '0';
L <= '1';
M <= "001";

wait for 20 ns;

T <= '0';
L <= '0';
M <= "001";

wait for 20 ns;

T <= '0';
L <= '0';
M <= "111";

wait;

end process;
end Behavioral;