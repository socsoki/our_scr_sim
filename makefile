
VPI_H_PATH ?= /tools/Mentor/questasim/include
VPI_COMP_FLAGS ?= -m64       #  -m32
VPI_LINK_FLAGS ?= elf_x86_64 # elf_i386

# VPI_CSRC = jtag_vpi/src/jtag_vpi.c jtag_vpi/src/jtag_common.c
VPI_CHS = jtag_vpi/include
C_OBJ = jtag_vpi.o jtag_common.o 

ifeq ($(origin OS),environment)
  DEL_TS_COMM = python -c "import pathlib; pathlib.Path('transcript').unlink()"
  DEL_WORK_D_COMM = python -c "import shutil; shutil.rmtree('work')"
  DEL_OBJ_COMM = python -c "import pathlib; pathlib.Path('jtag_vpi.o').unlink(); pathlib.Path('jtag_common.o').unlink()"
else
  DEL_TS_COMM = rm -rf transcript
  DEL_WORK_D_COMM = rm -rf work
  DEL_OBJ_COMM = rm -rf $(C_OBJ)
endif

.PHONY: all
all: sim 		# default target

.PHONY: build_vpi
build_vpi: jtag.so

$(C_OBJ): %.o: jtag_vpi/src/%.c
	gcc -c $(VPI_COMP_FLAGS) -I $(VPI_H_PATH) -I $(VPI_CHS) -fPIC $^ -o $@

jtag.so : $(C_OBJ)
	ld -m $(VPI_LINK_FLAGS) -shared -E -o $@ $^

.PHONY: sim
sim:
	vsim -do "scripts/questa.tcl"

.PHONY: clean_transcript
clean_transcript:
	$(DEL_TS_COMM)

.PHONY: clean_all
clean_all:
	$(MAKE) clean_transcript
	$(DEL_WORK_D_COMM)

.PHONY: clean_objs
clean_objs:
	$(DEL_OBJ_COMM) 

.PHONY: help
help:
	@echo -e "			\n\
	Targets				\n\
	+----------+		\n\
	help				\n\
	build_vpi			\n\
	clean_transcript	\n\
	clean_all			\n\
	clean_objs			\n\
	sim					\n\
	"