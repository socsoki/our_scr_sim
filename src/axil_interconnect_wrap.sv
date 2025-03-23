module axil_interconnect_wrap (
    input logic clk,
    input logic rst,

    axil_if.Slave imem_axil_bus,
    axil_if.Slave dmem_axil_bus,

    axil_if.Master ram_axil_bus
);
    
    axil_interconnect #(
        .M_COUNT(1),
        .S_COUNT(2),
        .DATA_WIDTH(32),
        .ADDR_WIDTH(32),
        .M_ADDR_WIDTH('d24)
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
        .s_axil_awaddr  ({imem_axil_bus.aw_addr, dmem_axil_bus.aw_addr}),
        .s_axil_awprot  ({imem_axil_bus.aw_prot, dmem_axil_bus.aw_prot}),
        .s_axil_awvalid ({imem_axil_bus.aw_valid, dmem_axil_bus.aw_valid}),
        .s_axil_awready ({imem_axil_bus.aw_ready, dmem_axil_bus.aw_ready}),
        .s_axil_wdata   ({imem_axil_bus.w_data, dmem_axil_bus.w_data}),
        .s_axil_wstrb   ({imem_axil_bus.w_strb, dmem_axil_bus.w_strb}),
        .s_axil_wvalid  ({imem_axil_bus.w_valid, dmem_axil_bus.w_valid}),
        .s_axil_wready  ({imem_axil_bus.w_ready, dmem_axil_bus.w_ready}),
        .s_axil_bresp   ({imem_axil_bus.b_resp, dmem_axil_bus.b_resp}),
        .s_axil_bvalid  ({imem_axil_bus.b_valid, dmem_axil_bus.b_valid}),
        .s_axil_bready  ({imem_axil_bus.b_ready, dmem_axil_bus.b_ready}),
        .s_axil_araddr  ({imem_axil_bus.ar_addr, dmem_axil_bus.ar_addr}),
        .s_axil_arprot  ({imem_axil_bus.ar_prot, dmem_axil_bus.ar_prot}),
        .s_axil_arvalid ({imem_axil_bus.ar_valid, dmem_axil_bus.ar_valid}),
        .s_axil_arready ({imem_axil_bus.ar_ready, dmem_axil_bus.ar_ready}),
        .s_axil_rdata   ({imem_axil_bus.r_data, dmem_axil_bus.r_data}),
        .s_axil_rresp   ({imem_axil_bus.r_resp, dmem_axil_bus.r_resp}),
        .s_axil_rvalid  ({imem_axil_bus.r_valid, dmem_axil_bus.r_valid}),
        .s_axil_rready  ({imem_axil_bus.r_ready, dmem_axil_bus.r_ready})
    );

endmodule