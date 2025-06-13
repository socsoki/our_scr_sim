/*
* Copyright by Syntacore LLC © 2016, 2017. See LICENSE for details
* @file       <link.ld>
* @brief      bare metal tests' linker script
*/

OUTPUT_ARCH( "riscv" )
ENTRY(_start)

MEMORY {
  RAM (rwx) : ORIGIN = 0x0, LENGTH = 16K
  TCM (rwx) : ORIGIN = 0x00480000, LENGTH = 16K
}

STACK_SIZE = 256;

CL_SIZE = 32;

SECTIONS {

  /* code segment */
  .text.init ORIGIN(TCM) : { 
    LONG(0x2000006f); /* j 0x200 | Jump to _start*/
    FILL(0);
    . = 0x100 - 12;
    SIM_EXIT = .;
    LONG(0x13);
    FILL(0);
    . = 0x100;
    *scr1TCMcrt.o(.text .text.*)
    *(.text.init)
    . = ALIGN(CL_SIZE);
  } >TCM 

  .text : {
    PROVIDE(__TEXT_START__ = .);
    *(.text .text.*)
    *(sc_test_section)
    . = ALIGN(CL_SIZE);
     PROVIDE(__TEXT_END__ = .);
  } >TCM 

  .rodata ALIGN(CL_SIZE) : {
    __global_pointer$ = . + 0x800;
    *(.rodata) *(.rodata.*) *(.gnu.linkonce.r.*)
    . = ALIGN(CL_SIZE);
    LONG(0x13);
    . = ALIGN(CL_SIZE);
  } >TCM

  __reloc_start = .;

  /* data segment */
  .data ALIGN(CL_SIZE) : {
    PROVIDE(__DATA_START__ = .);
    *(.data .data.*)
    PROVIDE(__DATA_END__ = .);
    . = ALIGN(CL_SIZE);
  } >TCM

  .sdata : {
    __global_pointer$ = . + 0x800;
    *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2) *(.srodata*)
    *(.sdata .sdata.* .gnu.linkonce.s.*)
    . = ALIGN(CL_SIZE);
  } >TCM

  /* thread-local data segment */
  .tdata ALIGN(CL_SIZE) : {
    PROVIDE(_tls_data = .);
    PROVIDE(_tdata_begin = .);
    *(.tdata .tdata.*)
    PROVIDE(_tdata_end = .);
    . = ALIGN(CL_SIZE);
  } >TCM 

  .tbss ALIGN(CL_SIZE) : {
    PROVIDE(_tbss_begin = .);
    *(.tbss .tbss.*)
    . = ALIGN(CL_SIZE);
    PROVIDE(_tbss_end = .);
    PROVIDE(__BSS_START__ = .);

  } >TCM

  /* bss segment */


  .bss ALIGN(CL_SIZE) : {
    *(.dynbss) *(.bss .bss.* .gnu.linkonce.b.*) *(COMMON)
    . = ALIGN(CL_SIZE);
  } >TCM 
  
  .sbss ALIGN(CL_SIZE) : {
    __global_pointer$ = . + 0x800;
    *(.sbss) *(.sbss.*) *(.gnu.linkonce.r.*)
    . = ALIGN(CL_SIZE);
    LONG(0x13);
    . = ALIGN(CL_SIZE);
    PROVIDE(__BSS_END__ = .);

  } >TCM 


  _end = .;
  PROVIDE(__end = .);

  /* End of uninitalized data segement */


  .stack ORIGIN(TCM) + LENGTH(TCM) - STACK_SIZE : {
    FILL(0);
    PROVIDE(__STACK_START__ = .);
    . += STACK_SIZE;
    PROVIDE(__C_STACK_TOP__ = .);
    PROVIDE(__STACK_END__ = .);
  } >TCM
  
  /DISCARD/ : {
    *(.eh_frame .eh_frame.*)
  }
}
