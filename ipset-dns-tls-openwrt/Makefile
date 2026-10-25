#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ipset-dns-tls-tls
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Elux414/ipset-dns-tls.git
PKG_SOURCE_VERSION:=<хэш твоего коммита>
PKG_MAINTAINER:=Elux414

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define Package/ipset-dns-tls/Default
endef

define Package/ipset-dns-tls
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A lightweight DNS forwarder to populate ipsets
  URL:=https://github.com/Elux414/ipset-dns-tls/blob/main/README.md
  DEPENDS:=+libmnl +libcurl
endef

define Package/ipset-dns-tls/description
 The ipset-dns-tls daemon is a lightweight DNS forwarding server that adds all
 resolved IPs via UDP or DoH to a given netfilter ipset. It is designed to be used in
 conjunction with dnsmasq's upstream server directive.

 Practical use cases include routing over a given gateway traffic for
 particular web services or webpages that do not have a priori predictable
 IP addresses and instead rely on dizzying arrays of DNS resolutions.
endef

define Package/ipset-dns-tls/conffiles
/etc/config/ipset-dns-tls
endef

define Package/ipset-dns-tls/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ipset-dns-tls $(1)/usr/sbin/ipset-dns-tls
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/ipset-dns-tls.init $(1)/etc/init.d/ipset-dns-tls
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/ipset-dns-tls.config $(1)/etc/config/ipset-dns-tls
endef

$(eval $(call BuildPackage,ipset-dns-tls))
