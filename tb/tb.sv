`timescale 1ns/1ps
module testbench;

    parameter CLK_PERIOD = 20;

    logic clk;
    logic rst;

    jtag_if jtag_bus();

    top top_with_scr1 (jtag_bus, clk, rst);

    jtag_vpi #(.DEBUG_INFO(0), .TCK_HALF_PERIOD(20 * 12))
    jtag_vpi0 
    (
        .tms(jtag_bus.tms),
        .tck(jtag_bus.tck),
        .tdi(jtag_bus.tdi),
        .tdo(jtag_bus.tdo),
        .enable(1'b1),
        .init_done(jtag_bus.trst_n)
    );

    initial begin
        clk <= 0;
        forever begin
            #(CLK_PERIOD/2) clk <= ~clk;
        end
    end

    task reset();
        rst = 0;
        jtag_bus.trst_n = 1'b0; 
        #100 rst = 1'b1;
        #100 jtag_bus.trst_n = 1'b1;
    endtask

    initial begin
        reset();
    end
    
endmodule