module uart_wrap(
    input logic clk,
    input logic rst,

    axil_if.Master uart_axil_bus,

    uart_if.Master uart_bus
);

    dbg_bridge uart_inst (
        .clk_i          (clk),
        .rst_i          (rst),

        // Inputs
        .uart_rxd_i     (uart_bus.rxd),
        .mem_awready_i  (uart_axil_bus.aw_ready),
        .mem_wready_i   (uart_axil_bus.w_ready),
        .mem_bvalid_i   (uart_axil_bus.b_valid),
        .mem_bresp_i    (uart_axil_bus.b_resp),
        .mem_bid_i      ('d0),
        .mem_arready_i  (uart_axil_bus.ar_ready),
        .mem_rvalid_i   (uart_axil_bus.r_valid),
        .mem_rdata_i    (uart_axil_bus.r_data),
        .mem_rresp_i    (uart_axil_bus.r_resp),
        .mem_rid_i      ('d0),
        .mem_rlast_i    (1'b1),
        .gpio_inputs_i  ('d0),

        // Outputs
        .uart_txd_o     (uart_bus.txd),
        .mem_awvalid_o  (uart_axil_bus.aw_valid),
        .mem_awaddr_o   (uart_axil_bus.aw_addr),
        .mem_awid_o     (),
        .mem_awlen_o    (),
        .mem_awburst_o  (),
        .mem_wvalid_o   (uart_axil_bus.w_valid),
        .mem_wdata_o    (uart_axil_bus.w_data),
        .mem_wstrb_o    (uart_axil_bus.w_strb),
        .mem_wlast_o    (),
        .mem_bready_o   (uart_axil_bus.b_ready),
        .mem_arvalid_o  (uart_axil_bus.ar_valid),
        .mem_araddr_o   (uart_axil_bus.ar_addr),
        .mem_arid_o     (),
        .mem_arlen_o    (),
        .mem_arburst_o  (),
        .mem_rready_o   (uart_axil_bus.r_ready),
        .gpio_outputs_o ()
    );

endmodule