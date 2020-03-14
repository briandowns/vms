packer_virtualbox-iso_virtualbox.box:
	cd freebsd && \
	packer build -only=virtualbox-iso template.json && \
	vagrant box add freebsd12_base $@

.PHONY: freebsd
freebsd: packer_virtualbox-iso_virtualbox.box

.PHONY: freebsd-clean
freebsd-clean:
	rm -f freebsd/packer_virtualbox-iso_virtualbox.box