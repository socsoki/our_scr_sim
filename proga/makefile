PREF 				= riscv64-unknown-elf-
override CC 		= $(PREF)gcc
override OBJCOPY 	= $(PREF)objcopy

START_FILE_NAME 	= start.S
PROG_NAME 			?= proga.c

.PHONY: all
all: proga.hex

proga.hex: proga.bin
	hexdump -v -e '"%08x\n"' $^ > $@

proga.bin: proga.elf
	$(OBJCOPY) -O binary $^ $@
	
proga.elf: $(START_FILE_NAME) $(PROG_NAME)
	$(CC) -march=rv32imc -mabi=ilp32 -Tscr1TCM.ld -nostdlib -nostartfiles $^ -o $@

.PHONY: clean
clean:
	rm -f proga.elf
	rm -f proga.bin
	rm -f proga.hex
