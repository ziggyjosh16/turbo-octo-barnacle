set_global_assignment -entity "clocka_pll" -library "lib_clocka_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clocka_pll" -library "lib_clocka_pll" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "clocka_pll" -library "lib_clocka_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clocka_pll" -name SPD_FILE [file join $::quartus(sip_path) "clocka_pll.spd"]

set_global_assignment -library "lib_clocka_pll" -name MISC_FILE [file join $::quartus(sip_path) "clocka_pll_sim/clocka_pll.vho"]
