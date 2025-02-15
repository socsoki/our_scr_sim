/*
    from
    https://github.com/pulp-platform/axi/blob/master/src/axi_pkg.sv
*/

interface axil_if #(
  parameter int unsigned AXI_ADDR_WIDTH = 32,
  parameter int unsigned AXI_DATA_WIDTH = 32
);

  localparam int unsigned AXI_STRB_WIDTH = AXI_DATA_WIDTH / 8;

  typedef logic [AXI_ADDR_WIDTH-1:0] addr_t;
  typedef logic [AXI_DATA_WIDTH-1:0] data_t;
  typedef logic [AXI_STRB_WIDTH-1:0] strb_t;

  typedef logic [2:0]   prot_t;
  typedef logic [1:0]   resp_t;

  // AW channel
  addr_t          aw_addr;
  prot_t          aw_prot;
  logic           aw_valid;
  logic           aw_ready;

  data_t          w_data;
  strb_t          w_strb;
  logic           w_valid;
  logic           w_ready;

  resp_t          b_resp;
  logic           b_valid;
  logic           b_ready;

  addr_t          ar_addr;
  prot_t          ar_prot;
  logic           ar_valid;
  logic           ar_ready;

  data_t          r_data;
  resp_t          r_resp;
  logic           r_valid;
  logic           r_ready;

  modport Master (
    output aw_addr, aw_prot, aw_valid, input aw_ready,
    output w_data, w_strb, w_valid, input w_ready,
    input b_resp, b_valid, output b_ready,
    output ar_addr, ar_prot, ar_valid, input ar_ready,
    input r_data, r_resp, r_valid, output r_ready
  );

  modport Slave (
    input aw_addr, aw_prot, aw_valid, output aw_ready,
    input w_data, w_strb, w_valid, output w_ready,
    output b_resp, b_valid, input b_ready,
    input ar_addr, ar_prot, ar_valid, output ar_ready,
    output r_data, r_resp, r_valid, input r_ready
  );

  modport Monitor (
    input aw_addr, aw_prot, aw_valid, aw_ready,
          w_data, w_strb, w_valid, w_ready,
          b_resp, b_valid, b_ready,
          ar_addr, ar_prot, ar_valid, ar_ready,
          r_data, r_resp, r_valid, r_ready
  );

endinterface