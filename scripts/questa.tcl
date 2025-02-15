vlib work

set defines +define+SCR1_DBG_EN

set scr1_inc  scr1/src/includes/
set scr1_prim {
    scr1/src/core/primitives/scr1_reset_cells.sv
    scr1/src/core/primitives/scr1_cg.sv
}
set scr1_pipe {
    scr1/src/core/pipeline/scr1_pipe_hdu.sv
    scr1/src/core/pipeline/scr1_pipe_tdu.sv
    scr1/src/core/pipeline/scr1_ipic.sv
    scr1/src/core/pipeline/scr1_pipe_csr.sv
    scr1/src/core/pipeline/scr1_pipe_exu.sv
    scr1/src/core/pipeline/scr1_pipe_ialu.sv
    scr1/src/core/pipeline/scr1_pipe_idu.sv
    scr1/src/core/pipeline/scr1_pipe_ifu.sv
    scr1/src/core/pipeline/scr1_pipe_lsu.sv
    scr1/src/core/pipeline/scr1_pipe_mprf.sv
    scr1/src/core/pipeline/scr1_pipe_top.sv
}
set scr1_core {
    scr1/src/core/scr1_clk_ctrl.sv
    scr1/src/core/scr1_tapc_shift_reg.sv
    scr1/src/core/scr1_tapc.sv
    scr1/src/core/scr1_tapc_synchronizer.sv
    scr1/src/core/scr1_core_top.sv
    scr1/src/core/scr1_dm.sv
    scr1/src/core/scr1_dmi.sv
    scr1/src/core/scr1_scu.sv    
}
set scr1_src_dop {
    scr1/src/top/scr1_dmem_router.sv     
    scr1/src/top/scr1_imem_router.sv     
    scr1/src/top/scr1_dp_memory.sv       
    scr1/src/top/scr1_tcm.sv             
    scr1/src/top/scr1_timer.sv           
    scr1/src/top/scr1_mem_axi.sv         
    scr1/src/top/scr1_top_axi.sv
}
set scr1_src_s [concat $scr1_pipe $scr1_prim $scr1_core $scr1_src_dop]

# compile scr1
foreach file_sv $scr1_src_s {
    vlog -mfcu -sv +incdir+$scr1_inc +nowarnSVCHK $defines +acc  $file_sv
}

# set scr1_src_s {                         
#     scr1/src/top/include/*.svh           
#     scr1/src/top/core/primirimitives/*.sv
#     scr1/src/top/core/pipeline/*.sv      
#     scr1/src/top/core/*.sv               
#     scr1/src/top/scr1_dmem_router.sv     
#     scr1/src/top/scr1_imem_router.sv     
#     scr1/src/top/scr1_dp_memory.sv       
#     scr1/src/top/scr1_tcm.sv             
#     scr1/src/top/scr1_timer.sv           
#     scr1/src/top/scr1_mem_axi.sv         
#     scr1/src/top/scr1_top_axi.sv         
#     }

set ifs   {src/interfaces/*.sv}
set src_s {src/*.sv}
set tbi   {tb/tb.sv}

set all_files [concat $ifs $src_s $tbi]

# compile other
foreach file_sv $all_files {
    vlog +acc $file_sv
}

vsim work.testbench