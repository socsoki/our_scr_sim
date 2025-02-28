`define SCR1_DBG_EN
`timescale 1ns/1ps

module top (
    jtag_if jtag_curr_if,
    input clk,
    input rst
);

    axil_if dmem_axil_if();
    axil_if imem_axil_if();


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