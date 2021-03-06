# dvbpsi

DVBPSI_VERSION := 1.1.2
DVBPSI_URL := $(VIDEOLAN)/libdvbpsi/$(DVBPSI_VERSION)/libdvbpsi-$(DVBPSI_VERSION).tar.bz2

PKGS += dvbpsi
ifeq ($(call need_pkg,"libdvbpsi"),)
PKGS_FOUND += dvbpsi
endif

$(TARBALLS)/libdvbpsi-$(DVBPSI_VERSION).tar.bz2:
	$(call download,$(DVBPSI_URL))

.sum-dvbpsi: libdvbpsi-$(DVBPSI_VERSION).tar.bz2

libdvbpsi: libdvbpsi-$(DVBPSI_VERSION).tar.bz2 .sum-dvbpsi
	$(UNPACK)
	$(UPDATE_AUTOCONFIG) && cd $(UNPACK_DIR) && mv config.guess config.sub .auto
	$(APPLY) $(SRC)/dvbpsi/dvbpsi-noexamples.patch
	$(MOVE)

.dvbpsi: libdvbpsi
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE) install
	touch $@
