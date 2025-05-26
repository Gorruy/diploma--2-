set_time_format -unit ns -decimal_places 3

create_clock 4 -name clk_250 -waveform {0.000 3.333} [get_ports clk_i]

derive_pll_clocks