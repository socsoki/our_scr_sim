module axil_interconnect_wrap (
    input logic clk,
    input logic rst,

    axil_if.Slave imem_axil_bus,
    axil_if.Slave dmem_axil_bus,
    axil_if.Slave uart_axil_bus,

    axil_if.Master ram_axil_bus
);
    
    axil_interconnect #(
        .M_COUNT(1),
        .S_COUNT(3),
        .DATA_WIDTH(32),
        .ADDR_WIDTH(32)
    ) axil_interconnect (
        .clk                                  (clk),
        .rst                                  (rst),

        // AXI lite slave interface
        .m_axil_awvalid (ram_axil_bus.aw_valid),
        .m_axil_awaddr  (ram_axil_bus.aw_addr),
        .m_axil_awprot  (ram_axil_bus.aw_prot),
        .m_axil_awready (ram_axil_bus.aw_ready),
        .m_axil_wdata   (ram_axil_bus.w_data),
        .m_axil_wstrb   (ram_axil_bus.w_strb),
        .m_axil_wvalid  (ram_axil_bus.w_valid),
        .m_axil_wready  (ram_axil_bus.w_ready),
        .m_axil_bresp   (ram_axil_bus.b_resp),
        .m_axil_bvalid  (ram_axil_bus.b_valid),  
        .m_axil_bready  (ram_axil_bus.b_ready),
        .m_axil_araddr  (ram_axil_bus.ar_addr),
        .m_axil_arprot  (ram_axil_bus.ar_prot),
        .m_axil_arvalid (ram_axil_bus.ar_valid),
        .m_axil_arready (ram_axil_bus.ar_ready),
        .m_axil_rdata   (ram_axil_bus.r_data),
        .m_axil_rresp   (ram_axil_bus.r_resp),
        .m_axil_rvalid  (ram_axil_bus.r_valid),
        .m_axil_rready  (ram_axil_bus.r_ready),

        // AXI lite master interface
        .s_axil_awaddr  ({uart_axil_bus.aw_addr, imem_axil_bus.aw_addr, dmem_axil_bus.aw_addr}),
        .s_axil_awprot  ({uart_axil_bus.aw_prot, imem_axil_bus.aw_prot, dmem_axil_bus.aw_prot}),
        .s_axil_awvalid ({uart_axil_bus.aw_valid, imem_axil_bus.aw_valid, dmem_axil_bus.aw_valid}),
        .s_axil_awready ({uart_axil_bus.aw_ready, imem_axil_bus.aw_ready, dmem_axil_bus.aw_ready}),
        .s_axil_wdata   ({uart_axil_bus.w_data, imem_axil_bus.w_data, dmem_axil_bus.w_data}),
        .s_axil_wstrb   ({uart_axil_bus.w_strb, imem_axil_bus.w_strb, dmem_axil_bus.w_strb}),
        .s_axil_wvalid  ({uart_axil_bus.w_valid, imem_axil_bus.w_valid, dmem_axil_bus.w_valid}),
        .s_axil_wready  ({uart_axil_bus.w_ready, imem_axil_bus.w_ready, dmem_axil_bus.w_ready}),
        .s_axil_bresp   ({uart_axil_bus.b_resp, imem_axil_bus.b_resp, dmem_axil_bus.b_resp}),
        .s_axil_bvalid  ({uart_axil_bus.b_valid, imem_axil_bus.b_valid, dmem_axil_bus.b_valid}),
        .s_axil_bready  ({uart_axil_bus.b_ready, imem_axil_bus.b_ready, dmem_axil_bus.b_ready}),
        .s_axil_araddr  ({uart_axil_bus.ar_addr, imem_axil_bus.ar_addr, dmem_axil_bus.ar_addr}),
        .s_axil_arprot  ({uart_axil_bus.ar_prot, imem_axil_bus.ar_prot, dmem_axil_bus.ar_prot}),
        .s_axil_arvalid ({uart_axil_bus.ar_valid, imem_axil_bus.ar_valid, dmem_axil_bus.ar_valid}),
        .s_axil_arready ({uart_axil_bus.ar_ready, imem_axil_bus.ar_ready, dmem_axil_bus.ar_ready}),
        .s_axil_rdata   ({uart_axil_bus.r_data, imem_axil_bus.r_data, dmem_axil_bus.r_data}),
        .s_axil_rresp   ({uart_axil_bus.r_resp, imem_axil_bus.r_resp, dmem_axil_bus.r_resp}),
        .s_axil_rvalid  ({uart_axil_bus.r_valid, imem_axil_bus.r_valid, dmem_axil_bus.r_valid}),
        .s_axil_rready  ({uart_axil_bus.r_ready, imem_axil_bus.r_ready, dmem_axil_bus.r_ready})
    );

endmodule