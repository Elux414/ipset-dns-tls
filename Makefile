CC ?= cc
CFLAGS ?= -O2 -pipe -fomit-frame-pointer -march=native

ifeq ($(OLD_IPSET),1)
	CFLAGS += -DOLD_IPSET
else
	LDLIBS += -lmnl
endif
LDLIBS += -lcurl

.PHONY: all clean

all: ipset-dns-tls

ipset-dns-tls: ipset-dns.c
	$(CC) $(CFLAGS) -o $@ $< $(LDLIBS)

clean:
	rm -f ipset-dns-tls
