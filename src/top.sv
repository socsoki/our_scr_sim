`define SCR1_DBG_EN
`timescale 1ns/1ps

module top (
    jtag_if jtag_curr_if,
    input clk,
    input rst_n
);
    wire rst = ~rst_n;

    axil_if dmem_axil_if();
    axil_if imem_axil_if();
    axil_if ram_axil_bus();

    axil_if uart_axil_bus();
    uart_if uart_bus();

    scr1_top_axi_wrap our_scr1 (
        .dmem_axi_bus(dmem_axil_if),
        .imem_axi_bus(imem_axil_if),
        .jtag_bus(jtag_curr_if),
        .clk,
        .rst_n
    );

    axil_interconnect_wrap scr1_interconnect(
        .clk,
        .rst,
        .imem_axil_bus(imem_axil_if),
        .dmem_axil_bus(dmem_axil_if),
        .ram_axil_bus(ram_axil_bus),
        .uart_axil_bus(uart_axil_bus)
    );
    
    uart_wrap uart (
        .clk,
        .rst,
        .uart_axil_bus(uart_axil_bus),
        .uart_bus(uart_bus)
    );

    axil_ram_wrap axil_ram (
        .clk,
        .rst,
        .axil(ram_axil_bus)
    );


endmodule