module axil_ram_wrap (
    axil_if.Slave   axil,
    input  wire     clk,
    input  wire     rst
);

    axil_ram wrap_inst (
        .clk,
        .rst,
        .s_axil_awaddr (axil.aw_addr ),
        .s_axil_awprot (axil.aw_prot ),
        .s_axil_awvalid(axil.aw_valid),
        .s_axil_awready(axil.aw_ready),
        .s_axil_wdata  (axil.w_data  ),
        .s_axil_wstrb  (axil.w_strb  ),
        .s_axil_wvalid (axil.w_valid ),
        .s_axil_wready (axil.w_ready ),
        .s_axil_bresp  (axil.b_resp  ),
        .s_axil_bvalid (axil.b_valid ),
        .s_axil_bready (axil.b_ready ),
        .s_axil_araddr (axil.ar_addr ),
        .s_axil_arprot (axil.ar_prot ),
        .s_axil_arvalid(axil.ar_valid),
        .s_axil_arready(axil.ar_ready),
        .s_axil_rdata  (axil.r_data  ),
        .s_axil_rresp  (axil.r_resp  ),
        .s_axil_rvalid (axil.r_valid ),
        .s_axil_rready (axil.r_ready )
    );
    
endmodule
