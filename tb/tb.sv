`timescale 1ns/1ps
module testbench;

    parameter CLK_PERIOD = 40;

    logic clk;
    logic rst;

    top top_with_scr1 (clk, rst);

    initial begin
        forever begin
            #(CLK_PERIOD/2) clk <= ~clk;
        end
    end

    task reset();
        rst <= 1;
        #(100*CLK_PERIOD);
        rst <= 0;
    endtask

    initial begin
        fork
            reset();
        join_none
        repeat(5000) @(posedge clk);
        reset();
    end
    
endmodule