
#ccflags-y += -I../arch/x86/kvm

KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

VIRT := ../virt/kvm
ARCH := ../arch/x86/kvm
ccflags-y += -Iarch/x86/kvm

virt_obj  += $(VIRT)/kvm_main.o $(VIRT)/coalesced_mmio.o \
             $(VIRT)/eventfd.o $(VIRT)/irqchip.o $(VIRT)/vfio.o \
			 $(VIRT)/async_pf.o

arch_obj  += $(ARCH)/x86.o $(ARCH)/emulate.o $(ARCH)/i8259.o $(ARCH)/irq.o $(ARCH)/lapic.o \
             $(ARCH)/i8254.o $(ARCH)/ioapic.o $(ARCH)/irq_comm.o $(ARCH)/cpuid.o $(ARCH)/pmu.o \
		     $(ARCH)/mtrr.o $(ARCH)/hyperv.o $(ARCH)/debugfs.o $(ARCH)/mmu/mmu.o \
		     $(ARCH)/mmu/page_track.o $(ARCH)/mmu/spte.o $(ARCH)/mmu/tdp_iter.o \
		     $(ARCH)/mmu/tdp_mmu.o


kvm-y += $(virt_obj) $(arch_obj)

arch_amd_obj += $(ARCH)/svm/svm.o $(ARCH)/svm/vmenter.o $(ARCH)/svm/pmu.o \
				$(ARCH)/svm/nested.o $(ARCH)/svm/avic.o $(ARCH)/svm/sev.o

kvm-amd-y += $(arch_amd_obj)

obj-m   += kvm.o
#obj-$(CONFIG_KVM_INTEL) += kvm-intel.o
obj-m   += kvm-amd.o

CC := $(CROSS_COMPILE)gcc

all:
	$(MAKE) -C $(KDIR) M=${shell pwd} modules

clean:
		-$(MAKE) -C $(KDIR) M=${shell pwd} clean || true
		@-rm -rf *.o *.ko *.mod.{c,o} modules.order Module.symvers \
		 $(virt_obj) $(arch_obj) $(arch_amd_obj) || true
