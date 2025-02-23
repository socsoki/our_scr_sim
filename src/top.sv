`define SCR1_DBG_EN
`timescale 1ns/1ps

module top (
    input clk,
    input rst
);

    // logic clk;
    // logic rst;

    axil_if dmem_axil_if();
    axil_if imem_axil_if();
    jtag_if jtag_curr_if();

    jtag_vpi #(.DEBUG_INFO(0), .TCK_HALF_PERIOD(20*12))
    jtag_vpi0 
    (
        .tms(jtag_curr_if.tms),
        .tck(jtag_curr_if.tck),
        .tdi(jtag_curr_if.tdi),
        .tdo(jtag_curr_if.tdo),
        .enable(1'b1),
        .init_done(jtag_curr_if.trst_n)
    );

    initial begin
        jtag_curr_if.trst_n = 1'b0; 
        #100 jtag_curr_if.trst_n = 1'b1;

    end

    scr1_top_axi_wrap our_scr1 (
        .dmem_axi_bus(dmem_axil_if),
        .imem_axi_bus(imem_axil_if),
        .jtag_bus(jtag_curr_if),
        .clk,
        .rst
    );

    axil_ram_wrap imem_to_ram (
        .clk,
        .rst,
        .axil(imem_axil_if)
    );
    axil_ram_wrap dmem_to_ram (
        .clk,
        .rst,
        .axil(dmem_axil_if)
    );

endmodule