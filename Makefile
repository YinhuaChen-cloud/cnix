CC=gcc
LD=ld
OBJCOPY=objcopy
BUILD=build
IMG=$(BUILD)/mbr.img

image: mbr.S
	mkdir -p $(BUILD)
	$(CC) -c mbr.S -o $(BUILD)/mbr.o
	$(LD) $(BUILD)/mbr.o -Ttext 0x7c00 -o $(BUILD)/mbr
	$(OBJCOPY) -S -O binary -j .text $(BUILD)/mbr $(IMG)

.PHONY: run
run: image
	qemu-system-x86_64 $(IMG)

.PHONY: clean
clean:
	rm -rf $(BUILD)

