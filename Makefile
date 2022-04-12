all: build

tarball = nvbit-Linux-ppc64le-1.5.4.tar.bz2
tooldir = nvbit_release/tools/detect_fp_exceptions

sources = \
	$(tooldir)/detect_fp_exceptions.cu \
	$(tooldir)/common.h \
	$(tooldir)/inject_funcs.cu

$(tarball):
	curl -LO https://github.com/NVlabs/NVBit/releases/download/1.5.4/$@

nvbit_release: $(tarball)
	tar -xjf $<

$(tooldir)/detect_fp_exceptions.cu: nvbit_release
	cp -r nvbit_release/tools/record_reg_vals $(tooldir)
	mv $(tooldir)/record_reg_vals.cu $(tooldir)/detect_fp_exceptions.cu
	cd nvbit_release && patch -p1 <../binfpe-nvbit.patch

patch: $(tooldir)/detect_fp_exceptions.cu

$(tooldir)/detect_fp_exceptions.so: $(sources)
	make -C $(tooldir)
	cp -r ./tests $(tooldir)/

build: $(tooldir)/detect_fp_exceptions.so

clean:
	rm -rf nvbit_release $(tarball)
