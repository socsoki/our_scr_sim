module uart_wrap(
    input logic clk,
    input logic rst,

    axil_if.Slave uart_axil_bus,

    uart_if.Master uart_bus
);

    uart_lite #(
        .CLK_FREQ(50_000000)
    ) uart_inst (
        // Input
        .clk_i           (clk),
        .rst_i           (rst),
        .cfg_awvalid_i   (uart_axil_bus.aw_valid),
        .cfg_awaddr_i    (uart_axil_bus.aw_addr),
        .cfg_wvalid_i    (uart_axil_bus.w_valid),
        .cfg_wdata_i     (uart_axil_bus.w_data),
        .cfg_wstrb_i     (uart_axil_bus.w_strb),
        .cfg_bready_i    (uart_axil_bus.b_ready),
        .cfg_arvalid_i   (uart_axil_bus.ar_valid),
        .cfg_araddr_i    (uart_axil_bus.ar_addr),
        .cfg_rready_i    (uart_axil_bus.r_ready),
        .rx_i            (uart_bus.rxd),

        // Outputs
        .cfg_awready_o   (uart_axil_bus.aw_ready),
        .cfg_wready_o    (uart_axil_bus.w_ready),
        .cfg_bvalid_o    (uart_axil_bus.b_valid),
        .cfg_bresp_o     (uart_axil_bus.b_resp),
        .cfg_arready_o   (uart_axil_bus.ar_ready),
        .cfg_rvalid_o    (uart_axil_bus.r_valid),
        .cfg_rdata_o     (uart_axil_bus.r_data),
        .cfg_rresp_o     (uart_axil_bus.r_resp),
        .tx_o            (uart_bus.txd),
        .intr_o          ()
    );

endmodule