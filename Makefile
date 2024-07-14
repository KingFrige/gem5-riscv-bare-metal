CC=riscv64-unknown-elf-gcc
OBJDUP=riscv64-unknown-elf-objdump
FLAG= -g -ffreestanding -O0 -Wl,--gc-sections -nostartfiles -nostdlib -nodefaultlibs
VIRTLD=-Wl,-T,src/riscv64-virt.ld
GEM5LD=-Wl,-T,src/link.ld
TARGET=build/hello-uart

all:build-virt-elf build-gem5-elf

build-virt-elf: src/crt0-virt.s src/ns16550a.c src/main.c
		$(CC) $(FLAG) $(VIRTLD) $^ -o $(TARGET)-virt.elf
		$(OBJDUP) -S $(TARGET)-virt.elf > $(TARGET)-virt.dump

build-gem5-elf: src/crt0-gem5.s src/ns16550a.c src/main.c
		$(CC) $(FLAG) $(GEM5LD) $^ -o $(TARGET)-gem5.elf
		$(OBJDUP) -S $(TARGET)-gem5.elf > $(TARGET)-gem5.dump

qemu: build-virt-elf
	qemu-system-riscv64 -machine virt -m 128M -nographic \
		-kernel $(TARGET)-virt.elf  \
		-bios none

qemudebug: build-virt-elf
		qemu-system-riscv64 -machine virt -m 128M -nographic -gdb tcp::1234 \
		 	-kernel $(TARGET)-virt.elf  \
		 	-bios none -S

gdb: build-virt-elf
	riscv64-unknown-elf-gdb --tui $(TARGET)-virt.elf

clean:
	rm build/*.elf build/*.dump
