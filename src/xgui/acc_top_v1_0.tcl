# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S00_AXIS_TDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DIG_MAX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DWIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAX_LENGTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAX_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MIN_LENGTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MIN_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_S00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_S00_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DIG_MAX { PARAM_VALUE.DIG_MAX } {
	# Procedure called to update DIG_MAX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DIG_MAX { PARAM_VALUE.DIG_MAX } {
	# Procedure called to validate DIG_MAX
	return true
}

proc update_PARAM_VALUE.DWIDTH { PARAM_VALUE.DWIDTH } {
	# Procedure called to update DWIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DWIDTH { PARAM_VALUE.DWIDTH } {
	# Procedure called to validate DWIDTH
	return true
}

proc update_PARAM_VALUE.MAX_LENGTH { PARAM_VALUE.MAX_LENGTH } {
	# Procedure called to update MAX_LENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_LENGTH { PARAM_VALUE.MAX_LENGTH } {
	# Procedure called to validate MAX_LENGTH
	return true
}

proc update_PARAM_VALUE.MAX_WIDTH { PARAM_VALUE.MAX_WIDTH } {
	# Procedure called to update MAX_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_WIDTH { PARAM_VALUE.MAX_WIDTH } {
	# Procedure called to validate MAX_WIDTH
	return true
}

proc update_PARAM_VALUE.MIN_LENGTH { PARAM_VALUE.MIN_LENGTH } {
	# Procedure called to update MIN_LENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MIN_LENGTH { PARAM_VALUE.MIN_LENGTH } {
	# Procedure called to validate MIN_LENGTH
	return true
}

proc update_PARAM_VALUE.MIN_WIDTH { PARAM_VALUE.MIN_WIDTH } {
	# Procedure called to update MIN_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MIN_WIDTH { PARAM_VALUE.MIN_WIDTH } {
	# Procedure called to validate MIN_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.MAX_WIDTH { MODELPARAM_VALUE.MAX_WIDTH PARAM_VALUE.MAX_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAX_WIDTH}] ${MODELPARAM_VALUE.MAX_WIDTH}
}

proc update_MODELPARAM_VALUE.MIN_WIDTH { MODELPARAM_VALUE.MIN_WIDTH PARAM_VALUE.MIN_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MIN_WIDTH}] ${MODELPARAM_VALUE.MIN_WIDTH}
}

proc update_MODELPARAM_VALUE.MAX_LENGTH { MODELPARAM_VALUE.MAX_LENGTH PARAM_VALUE.MAX_LENGTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAX_LENGTH}] ${MODELPARAM_VALUE.MAX_LENGTH}
}

proc update_MODELPARAM_VALUE.MIN_LENGTH { MODELPARAM_VALUE.MIN_LENGTH PARAM_VALUE.MIN_LENGTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MIN_LENGTH}] ${MODELPARAM_VALUE.MIN_LENGTH}
}

proc update_MODELPARAM_VALUE.DWIDTH { MODELPARAM_VALUE.DWIDTH PARAM_VALUE.DWIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DWIDTH}] ${MODELPARAM_VALUE.DWIDTH}
}

proc update_MODELPARAM_VALUE.DIG_MAX { MODELPARAM_VALUE.DIG_MAX PARAM_VALUE.DIG_MAX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DIG_MAX}] ${MODELPARAM_VALUE.DIG_MAX}
}

