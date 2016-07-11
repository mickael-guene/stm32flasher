DESTDIR?=/usr/local/bin
INSTALL=install
SOURCE:=$(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

install:
	install $(SOURCE)/bin/stm32flasher $(DESTDIR)/stm32flasher

uninstall:
	rm -f $(DESTDIR)/stm32flasher
