vlib work


set scr1_inc  scr1/src/includes/


vlog -work work -O1 -mfcu -sv -svinputport=relaxed +incdir+$scr1_inc "+nowarnSVCHK" +acc "+define+SCR1_DBG_EN +define+SCR1_TRGT_SIMULATION +define+jtag_vpi_enable=1" "+define+SCR1_TRACE_LOG_DIS" "+define+SCR1_CFG_RV32IMC_MAX" scr1/src/core/pipeline/scr1_pipe_hdu.sv scr1/src/core/pipeline/scr1_pipe_tdu.sv scr1/src/core/pipeline/scr1_ipic.sv scr1/src/core/pipeline/scr1_pipe_csr.sv scr1/src/core/pipeline/scr1_pipe_exu.sv scr1/src/core/pipeline/scr1_pipe_ialu.sv scr1/src/core/pipeline/scr1_pipe_idu.sv scr1/src/core/pipeline/scr1_pipe_ifu.sv scr1/src/core/pipeline/scr1_pipe_lsu.sv scr1/src/core/pipeline/scr1_pipe_mprf.sv scr1/src/core/pipeline/scr1_pipe_top.sv scr1/src/core/primitives/scr1_reset_cells.sv scr1/src/core/primitives/scr1_cg.sv scr1/src/core/scr1_clk_ctrl.sv scr1/src/core/scr1_tapc_shift_reg.sv scr1/src/core/scr1_tapc.sv scr1/src/core/scr1_tapc_synchronizer.sv scr1/src/core/scr1_core_top.sv scr1/src/core/scr1_dm.sv scr1/src/core/scr1_dmi.sv scr1/src/core/scr1_scu.sv scr1/src/top/scr1_dmem_router.sv scr1/src/top/scr1_imem_router.sv scr1/src/top/scr1_dp_memory.sv scr1/src/top/scr1_tcm.sv scr1/src/top/scr1_timer.sv scr1/src/top/scr1_mem_axi.sv scr1/src/top/scr1_top_axi.sv scr1/src/core/pipeline/scr1_tracelog.sv 

set ifs   {src/interfaces/*.sv}
set src_s {src/*.sv}
set tbi   {jtag_vpi/src/jtag_vpi.v tb/tb.sv}

set all_files [concat $ifs $src_s $tbi]

# compile other
foreach file_sv $all_files {
    vlog +acc $file_sv
}

vsim -pli jtag.so work.testbench