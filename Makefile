.PHONY: default
default: lua.so ;

VERSION = $(shell git describe --tags --abbrev=0 | sed -r 's/^v//g')
PKGDIR = $(shell pwd)/pkg
package:
	mkdir -p $(PKGDIR)
	git ls-files | tar -c --transform 's,^,slurm-spank-lua-$(VERSION)/,' -T - | gzip > $(PKGDIR)/slurm-spank-lua-$(VERSION).tar.gz

CFLAGS = -fPIC -g -I/usr/include/slurm -I/usr/include/lua5.3
clean:
	rm -f lua.o lib/list.o lua.so
lua.so: lua.o lib/list.o
	cc -shared -fPIC -o $@ $^ -llua5.3
