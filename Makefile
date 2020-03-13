.PHONY: freebsd
freebsd:
	cd $@ && \
	packer build -only=virtualbox-iso template.json && \
	vagrant box add freebsd12_base packer_virtualbox-iso_virtualbox.box
