
.PHONY: all sim clean_trancript clean_all

all: sim # default target

sim:
	gcc -c -m32 -I /home/phenom/intelFPGA/20.1/modelsim_ase/include -I /home/phenom/git/our_scr_sim/jtag_vpi/include /home/phenom/git/our_scr_sim/jtag_vpi/src/jtag_vpi.c /home/phenom/git/our_scr_sim/jtag_vpi/src/jtag_common.c -fPIC
	ld -m elf_i386 -shared -E -o jtag.so jtag_vpi.o jtag_common.o
	vsim -do "scripts/questa.tcl"

clean_transcript:
	python -c "import pathlib; pathlib.Path('transcript').unlink()"

clean_all:
	$(MAKE) clean_transcript
	python -c "import shutil; shutil.rmtree('work')"

help:
	@echo -e "  		\n\
    Targets				\n\
    +----------+		\n\
    help 				\n\
    clean_transcript	\n\
    clean_all			\n\
	sim					\n\
    "