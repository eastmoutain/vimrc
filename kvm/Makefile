
#ccflags-y += -I../arch/x86/kvm

KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

KVM := ../virt/kvm
ARCH := ../arch/x86/kvm
ccflags-y += -Iarch/x86/kvm
#ccflags-y += -I$(ARCH)

kvm-y  += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
          $(KVM)/eventfd.o $(KVM)/irqchip.o $(KVM)/vfio.o
kvm-y  += $(KVM)/async_pf.o

kvm-y  += $(ARCH)/x86.o $(ARCH)/emulate.o $(ARCH)/i8259.o $(ARCH)/irq.o $(ARCH)/lapic.o \
          $(ARCH)/i8254.o $(ARCH)/ioapic.o $(ARCH)/irq_comm.o $(ARCH)/cpuid.o $(ARCH)/pmu.o \
		  $(ARCH)/mtrr.o $(ARCH)/hyperv.o $(ARCH)/debugfs.o $(ARCH)/mmu/mmu.o \
		  $(ARCH)/mmu/page_track.o $(ARCH)/mmu/spte.o $(ARCH)/mmu/tdp_iter.o \
		  $(ARCH)/mmu/tdp_mmu.o

#kvm-intel-y     += vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
#               vmx/evmcs.o vmx/nested.o vmx/posted_intr.o
#
kvm-amd-y += $(ARCH)/svm/svm.o $(ARCH)/svm/vmenter.o $(ARCH)/svm/pmu.o $(ARCH)/svm/nested.o \
	         $(ARCH)/svm/avic.o $(ARCH)/svm/sev.o

obj-m   += kvm.o
#obj-$(CONFIG_KVM_INTEL) += kvm-intel.o
obj-m   += kvm-amd.o

CC := $(CROSS_COMPILE)gcc

all:
	$(MAKE) -C $(KDIR) M=${shell pwd} modules

clean:
		-$(MAKE) -C $(KDIR) M=${shell pwd} clean || true
		-rm *.o *.ko *.mod.{c,o} modules.order Module.symvers || true
