
.PHONY: all sim clean_trancript clean_all

all: sim # default target

sim:
	vsim -do "scripts/questa.tcl"

clean_transcript:
	python -c "import pathlib; pathlib.Path('transcript').unlink()"

clean_all:
	$(MAKE) clean_transcript
	python -c "import shutil; shutil.rmtree('work')"
