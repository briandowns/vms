#!/bin/sh

set -e

mkdir -p /root/kernel

cd /usr/src/sys/amd64/conf
cp GENERIC /root/kernel/custom_kernel
ln -s /root/kernel/custom_kernel

echo "
cpu		HAMMER
ident   custom_kernel
makeoptions	DEBUG=-g
makeoptions	WITH_CTF=1	
options 	SCHED_ULE	
options 	NUMA		
options 	PREEMPTION
options 	VIMAGE		
options 	INET		
options 	INET6		
options 	IPSEC			
options 	IPSEC_SUPPORT		
options 	TCP_OFFLOAD		
options 	TCP_BLACKBOX		
options 	TCP_HHOOK		
options		TCP_RFC7413		
options 	SCTP		
options 	FFS			
options 	SOFTUPDATES		
options 	UFS_ACL			
options 	UFS_DIRHASH		
options 	UFS_GJOURNAL		
options 	QUOTA			
options 	MD_ROOT			
options 	NFSCL			
options 	NFSD			
options 	NFSLOCKD		
options 	NFS_ROOT		
options 	MSDOSFS			
options 	PROCFS			
options 	PSEUDOFS		
options 	GEOM_RAID		
options 	GEOM_LABEL		
options 	EFIRT			
options 	SCSI_DELAY=5000		
options 	KTRACE			
options 	STACK			
options 	SYSVSHM			
options 	SYSVMSG			
options 	SYSVSEM			
options 	_KPOSIX_PRIORITY_SCHEDULING 
options 	PRINTF_BUFR_SIZE=128	
options 	KBD_INSTALL_CDEV	
options 	HWPMC_HOOKS		
options 	AUDIT			
options 	CAPABILITY_MODE		
options 	CAPABILITIES		
options 	MAC			
options 	KDTRACE_FRAME		
options 	KDTRACE_HOOKS		
options 	DDB_CTF			
options 	INCLUDE_CONFIG_FILE	
options 	RACCT			
options 	RCTL			
options 	KDB			
options 	KDB_TRACE		
options 	EKCD			
options 	GZIO			
options 	ZSTDIO			
options 	NETDUMP			
options 	SMP			
options 	EARLY_AP_STARTUP
options         SC_DISABLE_REBOOT
device carp
options        IPFIREWALL
options        IPFIREWALL_DEFAULT_TO_ACCEPT
device		cpufreq
device		acpi
options 	ACPI_DMAR
device		pci
options 	PCI_HP			
options		PCI_IOV			
device		fdc
device		ahci			
device		ata			
device		mpt			
device		scbus			
device		da			
device		nvme			
device		nvd			
device		atkbdc			
device		atkbd			
device		psm			
device		kbdmux			
device		vga			
options 	VESA			
device		splash			
device		sc
options 	SC_PIXEL_MODE		
device		vt
device		vt_vga
device		vt_efifb
device		agp			
device		uart			
device		em	
device      iflib		
device		crypto			
device		loop			
device		random			
device		padlock_rng		
device		rdrand_rng		
device		ether			
device		vlan			
device		tun			
device		md			
device		gif	
device		firmware
device		bpf
device		virtio
device		virtio_pci
device		vtnet			
device		virtio_blk
device		virtio_scsi
device		virtio_balloon
device		netmap
" > /root/kernel/custom_kernel

cd /usr/src
make buildkernel KERNCONF=custom_kernel && \
make installkernel KERNCONF=custom_kernel

exit 0
