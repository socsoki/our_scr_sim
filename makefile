
.PHONY: all sim clean_trancript clean_all build_vpi

all: sim # default target

build_vpi:
	gcc -c -m32 -I /home/phenom/intelFPGA/20.1/modelsim_ase/include -I /home/phenom/git/our_scr_sim/jtag_vpi/include /home/phenom/git/our_scr_sim/jtag_vpi/src/jtag_vpi.c /home/phenom/git/our_scr_sim/jtag_vpi/src/jtag_common.c -fPIC
	ld -m elf_i386 -shared -E -o jtag.so jtag_vpi.o jtag_common.o

sim:
	vsim -do "scripts/questa.tcl"

clean_transcript:
	ifeq ($(OS),Windows_NT):
		python -c "import pathlib; pathlib.Path('transcript').unlink()"
	else
		rm -rf transcript
	endif

clean_all:
	$(MAKE) clean_transcript
	ifeq ($(OS),Windows_NT):
		python -c "import shutil; shutil.rmtree('work')"
	else
		rm -rf work
	endif

help:
	@echo -e "  		\n\
    Targets				\n\
    +----------+		\n\
    help 				\n\
	build_vpi 		    \n\
    clean_transcript	\n\
    clean_all			\n\
	sim					\n\
    "