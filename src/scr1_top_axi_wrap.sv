`define SCR1_TAP_IDCODE         'hDEB11001
`define SCR1_IPIC_EN


module scr1_top_axi_wrap (
    axil_if.Master  dmem_axi_bus,
    axil_if.Master  imem_axi_bus,
    jtag_if         jtag_bus,
    input           clk,
    input           rst
);
    wire rst_n = ~rst;

    scr1_top_axi scr1_wrppd (
        .pwrup_rst_n                (rst_n),
        .rst_n                      (rst_n),
        .cpu_rst_n                  (rst_n),

        .test_mode                  (1'b0),
        .test_rst_n                 (1'b1),
        .clk                        (clk),
        .rtc_clk                    (clk),

        // .sys_rst_n_o                (),
        // .sys_rdc_qlfy_o             (),

        .fuse_mhartid               ('0),
        .fuse_idcode                (`SCR1_TAP_IDCODE),
        .sys_rdc_qlfy_o             (),

        // IRQ
`ifdef SCR1_IPIC_EN
        .irq_lines                  ('0),
`else // SCR1_IPIC_EN
        .ext_irq                    ('0),
`endif // SCR1_IPIC_EN
        .soft_irq                   (1'b0),

        .trst_n                     (jtag_bus.trst_n),
        .tck                        (jtag_bus.tck),
        .tms                        (jtag_bus.tms),
        .tdi                        (jtag_bus.tdi),
        .tdo                        (jtag_bus.tdo),
        .tdo_en                     (jtag_bus.tdo_en),
    
        // Instruction Memory Interface
        .io_axi_imem_awid           (),
        .io_axi_imem_awaddr         (imem_axi_bus.aw_addr),
        .io_axi_imem_awlen          (),
        .io_axi_imem_awsize         (),
        .io_axi_imem_awburst        (),
        .io_axi_imem_awlock         (),
        .io_axi_imem_awcache        (),
        .io_axi_imem_awprot         (),
        .io_axi_imem_awregion       (),
        .io_axi_imem_awuser         (),
        .io_axi_imem_awqos          (),
        .io_axi_imem_awvalid        (imem_axi_bus.aw_valid),
        .io_axi_imem_awready        (imem_axi_bus.aw_ready),
        .io_axi_imem_wdata          (imem_axi_bus.w_data),
        .io_axi_imem_wstrb          (imem_axi_bus.w_strb),
        .io_axi_imem_wlast          (),
        .io_axi_imem_wuser          (),
        .io_axi_imem_wvalid         (imem_axi_bus.w_valid),
        .io_axi_imem_wready         (imem_axi_bus.w_ready),
        .io_axi_imem_bid            ('0),
        .io_axi_imem_bresp          (imem_axi_bus.b_resp),
        .io_axi_imem_bvalid         (imem_axi_bus.b_valid),
        .io_axi_imem_buser          ('0),
        .io_axi_imem_bready         (imem_axi_bus.b_ready),
        .io_axi_imem_arid           (),
        .io_axi_imem_araddr         (imem_axi_bus.ar_addr),
        .io_axi_imem_arlen          (),
        .io_axi_imem_arsize         (),
        .io_axi_imem_arburst        (),
        .io_axi_imem_arlock         (),
        .io_axi_imem_arcache        (),
        .io_axi_imem_arprot         (),
        .io_axi_imem_arregion       (),
        .io_axi_imem_aruser         (),
        .io_axi_imem_arqos          (),
        .io_axi_imem_arvalid        (imem_axi_bus.ar_valid),
        .io_axi_imem_arready        (imem_axi_bus.ar_ready),
        .io_axi_imem_rid            ('0),
        .io_axi_imem_rdata          (imem_axi_bus.r_data),
        .io_axi_imem_rresp          (imem_axi_bus.r_resp),
        .io_axi_imem_rlast          ('1),
        .io_axi_imem_ruser          ('0),
        .io_axi_imem_rvalid         (imem_axi_bus.r_valid),
        .io_axi_imem_rready         (imem_axi_bus.r_ready),
    
        // Data Memory Interface
        .io_axi_dmem_awid           (),
        .io_axi_dmem_awaddr         (dmem_axi_bus.aw_addr),
        .io_axi_dmem_awlen          (),
        .io_axi_dmem_awsize         (),
        .io_axi_dmem_awburst        (),
        .io_axi_dmem_awlock         (),
        .io_axi_dmem_awcache        (),
        .io_axi_dmem_awprot         (),
        .io_axi_dmem_awregion       (),
        .io_axi_dmem_awuser         (),
        .io_axi_dmem_awqos          (),
        .io_axi_dmem_awvalid        (dmem_axi_bus.aw_valid),
        .io_axi_dmem_awready        (dmem_axi_bus.aw_ready),
        .io_axi_dmem_wdata          (dmem_axi_bus.w_data),
        .io_axi_dmem_wstrb          (dmem_axi_bus.w_strb),
        .io_axi_dmem_wlast          (),
        .io_axi_dmem_wuser          (),
        .io_axi_dmem_wvalid         (dmem_axi_bus.w_valid),
        .io_axi_dmem_wready         (dmem_axi_bus.w_ready),
        .io_axi_dmem_bid            ('0),
        .io_axi_dmem_bresp          (dmem_axi_bus.b_resp),
        .io_axi_dmem_bvalid         (dmem_axi_bus.b_valid),
        .io_axi_dmem_buser          ('0),
        .io_axi_dmem_bready         (dmem_axi_bus.b_ready),
        .io_axi_dmem_arid           (),
        .io_axi_dmem_araddr         (dmem_axi_bus.ar_addr),
        .io_axi_dmem_arlen          (),
        .io_axi_dmem_arsize         (),
        .io_axi_dmem_arburst        (),
        .io_axi_dmem_arlock         (),
        .io_axi_dmem_arcache        (),
        .io_axi_dmem_arprot         (),
        .io_axi_dmem_arregion       (),
        .io_axi_dmem_aruser         (),
        .io_axi_dmem_arqos          (),
        .io_axi_dmem_arvalid        (dmem_axi_bus.ar_valid),
        .io_axi_dmem_arready        (dmem_axi_bus.ar_ready),
        .io_axi_dmem_rid            ('0),
        .io_axi_dmem_rdata          (dmem_axi_bus.r_data),
        .io_axi_dmem_rresp          (dmem_axi_bus.r_resp),
        .io_axi_dmem_rlast          ('1),
        .io_axi_dmem_ruser          ('0),
        .io_axi_dmem_rvalid         (dmem_axi_bus.r_valid),
        .io_axi_dmem_rready         (dmem_axi_bus.r_ready)
    );
endmodule
