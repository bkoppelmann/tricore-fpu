JOBS=$(shell echo `nproc`)
BU_CONFIGURE_FLAGS=--target=tricore --prefix=$(shell pwd)/tricore-binutils/install/

AS = tricore-binutils/install/bin/tricore-as
LD = tricore-binutils/install/bin/tricore-ld

binutils:binutils/build.ok

binutils/build.ok: 
	@echo "Building Binutils..."
	@rm -rf tricore-binutils/build/
	@rm -rf tricore-binutils/install/
	@mkdir -p tricore-binutils/build/
	@mkdir -p tricore-binutils/install
	@cd tricore-binutils/build && ../configure $(BU_CONFIGURE_FLAGS) && make -j$(JOBS) && make install && touch ../build.ok

fpu-test: fpu-test.elf

fpu-test.elf: fpu-test/ftoi.o
	$(LD) -T fpu-test/target.ld $< -o $@

%.o: %.S
	$(AS) $< -o $@

clean:
	rm -rf fpu-test/*.o *.elf 

mrpropper: clean
	rm -rf tricore-binutils/build
	rm -rf tricore-binutils/install
	rm -rf tricore-binutils/build.ok
