# ipset-dns-tls

A lightweight DNS forwarding server that adds all resolved IPs to a given netfilter ipset, supporting **encrypted DNS (DoH)** to bypass plaintext DNS interception.

This is a fork of the original [ipset-dns](https://git.zx2c4.com/ipset-dns/about/) project by Jason A. Donenfeld (zx2c4), which adds support for secure DNS resolution. 

### Why this fork?

The original `ipset-dns` relies on plaintext UDP DNS (port 53). In some regions (like Russia), plaintext DNS queries are intercepted, spoofed, or blocked (e.g., by DPI). This results in `NXDOMAIN` responses for certain domains, breaking the ipset routing logic.

This fork solves the problem by adding **DNS over HTTPS (DoH)** support. It securely resolves domains and successfully populates the ipset, even when plaintext DNS is blocked.

### Features

*   **DoH Support**: Route queries through `https://cloudflare-dns.com/dns-query` or any other DoH provider.
*   **CURL Handle Reuse**: The TLS connection is kept alive between queries, reducing CPU load and latency.
*   **Backwards Compatible**: Plain UDP DNS is still supported. If you pass an IP as the upstream, it falls back to the original UDP behavior.
*   **Lightweight**: Fully compatible with OpenWrt and other embedded Linux systems.

### Usage

    ipset-dns-tls ipv4-ipset ipv6-ipset port upstream

*   `ipv4-ipset`: Name of the ipset for A records (or `""` to disable).
*   `ipv6-ipset`: Name of the ipset for AAAA records (or `""` to disable).
*   `port`: Local UDP port to listen on.
*   `upstream`: DoH URL (e.g., `https://cloudflare-dns.com/dns-query`) or legacy DNS IP (e.g., `8.8.8.8`).

**Example (DoH):**

    ipset-dns-tls youtube "" 53001 https://cloudflare-dns.com/dns-query

**Example (Legacy UDP):**

    ipset-dns-tls youtube "" 53001 8.8.8.8

### OpenWrt Integration

The repository includes a ready-to-use OpenWrt package. 

1. Copy the `ipset-dns-tls-openwrt` folder to your OpenWrt `package/` directory (or use it as a feed).
2. Compile it using the OpenWrt SDK.
3. Install the `.ipk/.apk` on your router.

**Configuration (`/etc/config/ipset-dns-tls`):**

    config ipset-dns-tls
        option ipset 'domain-filter-ipv4'
        option ipset6 'domain-filter-ipv6'
        option port '53001'
        option dns 'https://cloudflare-dns.com/dns-query'

**Start the service:**

    /etc/init.d/ipset-dns-tls start

### Building from source (Linux)

Dependencies: `libcurl`, `libmnl`.

    make
    sudo make install

### License

This project is licensed under the GPLv2. See `COPYING` for details.

*   Copyright (C) 2013, 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
*   DNS parsing code loosely based on uClibc's `resolv.c` (Copyright (C) 1998 Kenneth Albanowski, The Silver Hammer Group, Ltd.; Copyright (C) 1985, 1993 The Regents of the University of California).
*   Modified by Elux414 (2026): Added DoH transport via libcurl.
