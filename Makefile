WORK_DIR := work

$(WORK_DIR)/runsim: hdl/d_flip_flop.sv sim/d_flip_flop_tb.sv | $(WORK_DIR)
	cd sim; iverilog -g2012 -o ../$(WORK_DIR)/runsim d_flip_flop_tb.sv
	cd $(WORK_DIR); vvp runsim
	
$(WORK_DIR):
	mkdir $(WORK_DIR)

clean:
	rm -rf ./$(WORK_DIR)/*

PHONY: clean