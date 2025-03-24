interface uart_if;
    logic rxd;
    logic txd;

    modport Master(
        input rxd, output txd
    );

    modport Slave(
        input txd, output rxd
    );
endinterface