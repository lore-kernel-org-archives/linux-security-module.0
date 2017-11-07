From: fengguang.wu@intel.com (Fengguang Wu)
Date: Tue, 7 Nov 2017 20:28:48 +0800
Subject: [apparmor_mmap_file] WARNING: bad unlock balance detected!
In-Reply-To: <20171107013821.2b34a6i6uez37stu@wfg-t540p.sh.intel.com>
References: <20171107013821.2b34a6i6uez37stu@wfg-t540p.sh.intel.com>
Message-ID: <20171107122848.zkzccd67wimkxn2h@wfg-t540p.sh.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Sorry please ignore this report -- according to Peter:

This is fixed by commit:

  02a7c234e540 ("rcu: Suppress lockdep false-positive ->boost_mtx complaints")

The problem is that RCU boosting was mixing futex and !futex rt_mutex
ops.

On Tue, Nov 07, 2017 at 09:38:21AM +0800, Fengguang Wu wrote:
>Hi,
>
>Here is a warning in 4.14-rc8 -- it's not necessarily a new bug.
>
>Please press Enter to activate this console.
>[   45.117766] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>[   45.122174] 8021q: adding VLAN 0 to HW filter on device eth0
>[   45.247159]
>[   45.247451] =====================================
>[   45.248021] WARNING: bad unlock balance detected!
>[   45.248608] 4.14.0-rc8 #158 Not tainted
>[   45.249087] -------------------------------------
>[   45.249672] fw3/1183 is trying to release lock (rcu_preempt_state) at:
>[   45.250443] [<c10e4348>] rcu_read_unlock_special+0x5f8/0x620
>[   45.251136] but there are no more locks to release!
>[   45.251752]
>[   45.251752] other info that might help us debug this:
>[   45.252561] 1 lock held by fw3/1183:
>[   45.253019]  #0:  (rcu_read_lock){....}, at: [<c16e24c0>] aa_file_perm+0x0/0x460
>[   45.253925]
>[   45.253925] stack backtrace:
>[   45.254526] CPU: 0 PID: 1183 Comm: fw3 Not tainted 4.14.0-rc8 #158
>[   45.255275] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[   45.256266] Call Trace:
>[   45.256628]  dump_stack+0x16/0x1c
>[   45.257082]  print_unlock_imbalance_bug+0xb9/0xd0
>[   45.257676]  ? rcu_read_unlock_special+0x5f8/0x620
>[   45.258259]  ? rcu_read_unlock_special+0x5f8/0x620
>[   45.258871]  lock_release+0x1cc/0x490
>[   45.259347]  ? rcu_read_unlock_special+0x5f8/0x620
>[   45.259969]  ? _raw_spin_unlock_irqrestore+0x86/0xd0
>[   45.260581]  rt_mutex_unlock+0x1e/0xb0
>[   45.261054]  rcu_read_unlock_special+0x5f8/0x620
>[   45.261643]  __rcu_read_unlock+0xa7/0xb0
>[   45.262152]  aa_file_perm+0x5a/0x460
>[   45.262633]  ? pvclock_clocksource_read+0xd5/0x230
>[   45.263203]  ? pvclock_clocksource_read+0xd5/0x230
>[   45.263797]  common_file_perm+0x81/0x240
>[   45.264308]  ? kvm_sched_clock_read+0x9/0x20
>[   45.264843]  common_mmap+0x93/0xd0
>[   45.265283]  ? apparmor_file_mprotect+0x30/0x30
>[   45.265867]  apparmor_mmap_file+0x12/0x20
>[   45.266388]  security_mmap_file+0xaf/0x170
>[   45.266903]  vm_mmap_pgoff+0x35/0x100
>[   45.267381]  ? __fget+0x1c3/0x1d0
>[   45.267831]  SyS_mmap_pgoff+0x16d/0x370
>[   45.268318]  do_int80_syscall_32+0x95/0x290
>[   45.268840]  entry_INT80_32+0x2f/0x2f
>[   45.269313] EIP: 0xb7f7c2d4
>[   45.269713] EFLAGS: 00000202 CPU: 0
>[   45.270169] EAX: ffffffda EBX: b7f63000 ECX: 000002ad EDX: 00000003
>[   45.270901] ESI: 00000012 EDI: 00000003 EBP: 00000004 ESP: bff29f24
>[   45.271637]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b
>[   45.351763] 8021q: adding VLAN 0 to HW filter on device eth0
>LKP: HOSTNAME vm-lkp-nhm-dp1-openwrt-ia32-6, MAC , kernel 4.14.0-rc8 158, serial console /dev/ttyS0
>[   47.390581] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>
>Thanks,
>Fengguang

>early console in setup code
>Probing EDD (edd=off to disable)... ok
>early console in extract_kernel
>input_data: 0x0464f069
>input_len: 0x01e03d0d
>output: 0x01000000
>output_len: 0x03cdd89c
>kernel_total_size: 0x05469000
>
>Decompressing Linux... Parsing ELF... done.
>Booting the kernel.
>[    0.000000] Linux version 4.14.0-rc8 (kbuild at lkp-ib03) (gcc version 5.4.1 20160904 (Debian 5.4.1-2)) #158 PREEMPT Mon Nov 6 13:47:12 CST 2017
>[    0.000000] x86/fpu: x87 FPU will use FXSAVE
>[    0.000000] e820: BIOS-provided physical RAM map:
>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
>[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
>[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001a3dffff] usable
>[    0.000000] BIOS-e820: [mem 0x000000001a3e0000-0x000000001a3fffff] reserved
>[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
>[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
>[    0.000000] debug: ignoring loglevel setting.
>[    0.000000] bootconsole [earlyser0] enabled
>[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
>[    0.000000] random: fast init done
>[    0.000000] SMBIOS 2.8 present.
>[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[    0.000000] Hypervisor detected: KVM
>[    0.000000] tsc: Fast TSC calibration using PIT
>[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
>[    0.000000] e820: last_pfn = 0x1a3e0 max_arch_pfn = 0x100000
>[    0.000000] MTRR default type: write-back
>[    0.000000] MTRR fixed ranges enabled:
>[    0.000000]   00000-9FFFF write-back
>[    0.000000]   A0000-BFFFF uncachable
>[    0.000000]   C0000-FFFFF write-protect
>[    0.000000] MTRR variable ranges enabled:
>[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
>[    0.000000]   1 disabled
>[    0.000000]   2 disabled
>[    0.000000]   3 disabled
>[    0.000000]   4 disabled
>[    0.000000]   5 disabled
>[    0.000000]   6 disabled
>[    0.000000]   7 disabled
>[    0.000000] x86/PAT: PAT not supported by CPU.
>[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
>[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
>[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
>[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
>[    0.000000] found SMP MP-table at [mem 0x000f6aa0-0x000f6aaf] mapped at [ffda3aa0]
>[    0.000000]   mpc: f6ab0-f6b80
>[    0.000000] initial memory mapped: [mem 0x00000000-0x067fffff]
>[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
>[    0.000000] BRK [0x0635e000, 0x0635efff] PGTABLE
>[    0.000000] RAMDISK: [mem 0x1a0b1000-0x1a3dffff]
>[    0.000000] ACPI: Early table checksum verification disabled
>[    0.000000] ACPI: RSDP 0x00000000000F68D0 000014 (v00 BOCHS )
>[    0.000000] ACPI: RSDT 0x000000001A3E15CE 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
>[    0.000000] ACPI: FACP 0x000000001A3E142A 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
>[    0.000000] ACPI: DSDT 0x000000001A3E0040 0013EA (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
>[    0.000000] ACPI: FACS 0x000000001A3E0000 000040
>[    0.000000] ACPI: APIC 0x000000001A3E151E 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
>[    0.000000] ACPI: HPET 0x000000001A3E1596 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
>[    0.000000] ACPI: Local APIC address 0xfee00000
>[    0.000000] mapped APIC to         ffffc000 (        fee00000)
>[    0.000000] 419MB LOWMEM available.
>[    0.000000]   mapped low ram: 0 - 1a3e0000
>[    0.000000]   low ram: 0 - 1a3e0000
>[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
>[    0.000000] kvm-clock: cpu 0, msr 0:1a0b0001, primary cpu clock
>[    0.000000] kvm-clock: using sched offset of 350242606 cycles
>[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>[    0.000000] Zone ranges:
>[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>[    0.000000]   Normal   [mem 0x0000000001000000-0x000000001a3dffff]
>[    0.000000] Movable zone start for each node
>[    0.000000] Early memory node ranges
>[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
>[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001a3dffff]
>[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001a3dffff]
>[    0.000000] On node 0 totalpages: 107390
>[    0.000000] free_area_init_node: node 0, pgdat c4401fa0, node_mem_map d9d68020
>[    0.000000]   DMA zone: 32 pages used for memmap
>[    0.000000]   DMA zone: 0 pages reserved
>[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
>[    0.000000]   Normal zone: 808 pages used for memmap
>[    0.000000]   Normal zone: 103392 pages, LIFO batch:31
>[    0.000000] Using APIC driver default
>[    0.000000] ACPI: PM-Timer IO Port: 0x608
>[    0.000000] ACPI: Local APIC address 0xfee00000
>[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
>[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
>[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
>[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
>[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
>[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
>[    0.000000] ACPI: IRQ0 used by override.
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
>[    0.000000] ACPI: IRQ5 used by override.
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
>[    0.000000] ACPI: IRQ9 used by override.
>[    0.000000] ACPI: IRQ10 used by override.
>[    0.000000] ACPI: IRQ11 used by override.
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
>[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
>[    0.000000] Using ACPI (MADT) for SMP configuration information
>[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
>[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
>[    0.000000] KVM setup async PF for cpu 0
>[    0.000000] kvm-stealtime: cpu 0, msr 410ccc0
>[    0.000000] e820: [mem 0x1a400000-0xfeffbfff] available for PCI devices
>[    0.000000] Booting paravirtualized kernel on KVM
>[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
>[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
>[    0.000000] pcpu-alloc: [0] 0
>[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 106550
>[    0.000000] Kernel command line: ip=::::vm-lkp-nhm-dp1-openwrt-ia32-6::dhcp root=/dev/ram0 user=lkp job=/lkp/scheduled/vm-lkp-nhm-dp1-openwrt-ia32-6/trinity-300s-openwrt-i386-2016-03-16.cgz-39dae59d66acd86d1de24294bd2f343fd5e7a625-20171106-69114-np2qmk-0.yaml ARCH=i386 kconfig=i386-randconfig-b0-11061302 branch=linus/master commit=39dae59d66acd86d1de24294bd2f343fd5e7a625 BOOT_IMAGE=/pkg/linux/i386-randconfig-b0-11061302/gcc-5/39dae59d66acd86d1de24294bd2f343fd5e7a625/vmlinuz-4.14.0-rc8 max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-nhm-dp1-openwrt-ia32/openwrt-i386-2016-03-16.cgz/i386-randconfig-b0-11061302/gcc-5/39dae59d66acd86d1de24294bd2f343fd5e7a625/0 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga
>[    0.000000] sysrq: sysrq always enabled.
>[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
>[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>[    0.000000] Initializing CPU#0
>[    0.000000] Memory: 337032K/429560K available (34357K kernel code, 10936K rwdata, 15732K rodata, 1120K init, 22936K bss, 92528K reserved, 0K cma-reserved)
>[    0.000000] virtual kernel memory layout:
>[    0.000000]     fixmap  : 0xfffa2000 - 0xfffff000   ( 372 kB)
>[    0.000000]     vmalloc : 0xdabe0000 - 0xfffa0000   ( 595 MB)
>[    0.000000]     lowmem  : 0xc0000000 - 0xda3e0000   ( 419 MB)
>[    0.000000]       .init : 0xc4bc5000 - 0xc4cdd000   (1120 kB)
>[    0.000000]       .data : 0xc318d714 - 0xc4b9a180   (26674 kB)
>[    0.000000]       .text : 0xc1000000 - 0xc318d714   (34357 kB)
>[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
>[    0.004000] Preemptible hierarchical RCU implementation.
>[    0.004000] 	RCU priority boosting: priority 1 delay 500 ms.
>[    0.004000] 	RCU callback double-/use-after-free debug enabled.
>[    0.004000] 	RCU debug extended QS entry/exit.
>[    0.004000] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
>[    0.004000] 	Tasks RCU enabled.
>[    0.004000] NR_IRQS: 2304, nr_irqs: 256, preallocated irqs: 16
>[    0.004000] CPU 0 irqstacks, hard=d9834000 soft=d9836000
>[    0.004000] 	Offload RCU callbacks from CPUs: .
>[    0.004000] Console: colour VGA+ 80x25
>[    0.004000] console [tty0] enabled
>[    0.004000] console [ttyS0] enabled
>[    0.004000] bootconsole [earlyser0] disabled
>[    0.004000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
>[    0.004000] ... MAX_LOCKDEP_SUBCLASSES:  8
>[    0.004000] ... MAX_LOCK_DEPTH:          48
>[    0.004000] ... MAX_LOCKDEP_KEYS:        8191
>[    0.004000] ... CLASSHASH_SIZE:          4096
>[    0.004000] ... MAX_LOCKDEP_ENTRIES:     32768
>[    0.004000] ... MAX_LOCKDEP_CHAINS:      65536
>[    0.004000] ... CHAINHASH_SIZE:          32768
>[    0.004000]  memory used by lock dependency info: 4639 kB
>[    0.004000]  per task-struct memory footprint: 2112 bytes
>[    0.004000] ------------------------
>[    0.004000] | Locking API testsuite:
>[    0.004000] ----------------------------------------------------------------------------
>[    0.004000]                                  | spin |wlock |rlock |mutex | wsem | rsem |
>[    0.004000]   --------------------------------------------------------------------------
>[    0.004000]                      A-A deadlock:failed|failed|  ok  |failed|failed|failed|failed|
>[    0.004000]                  A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|failed|
>[    0.004000]              A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|failed|
>[    0.004000]              A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|failed|
>[    0.004000]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|failed|
>[    0.004000]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|failed|
>[    0.004000]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|failed|
>[    0.004000]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>[    0.004000]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>[    0.004000]   --------------------------------------------------------------------------
>[    0.004000]               recursive read-lock:             |  ok  |             |failed|
>[    0.004000]            recursive read-lock #2:             |  ok  |             |failed|
>[    0.004000]             mixed read-write-lock:             |failed|             |failed|
>[    0.004000]             mixed write-read-lock:             |failed|             |failed|
>[    0.004000]   mixed read-lock/lock-write ABBA:             |failed|             |failed|
>[    0.004000]    mixed read-lock/lock-read ABBA:             |  ok  |             |failed|
>[    0.004000]  mixed write-lock/lock-write ABBA:             |failed|             |failed|
>[    0.004000]   --------------------------------------------------------------------------
>[    0.004000]      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
>[    0.004000]      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
>[    0.004000]      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
>[    0.004000]      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
>[    0.004000]        sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
>[    0.004000]        sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
>[    0.004000]          hard-safe-A + irqs-on/12:failed|failed|  ok  |
>[    0.004000]          soft-safe-A + irqs-on/12:failed|failed|  ok  |
>[    0.004000]          hard-safe-A + irqs-on/21:failed|failed|  ok  |
>[    0.004000]          soft-safe-A + irqs-on/21:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
>[    0.004000]     hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
>[    0.004000]     soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
>[    0.004000]       hard-irq lock-inversion/123:failed|failed|  ok  |
>[    0.004000]       soft-irq lock-inversion/123:failed|failed|  ok  |
>[    0.004000]       hard-irq lock-inversion/132:failed|failed|  ok  |
>[    0.004000]       soft-irq lock-inversion/132:failed|failed|  ok  |
>[    0.004000]       hard-irq lock-inversion/213:failed|failed|  ok  |
>[    0.004000]       soft-irq lock-inversion/213:failed|failed|  ok  |
>[    0.004000]       hard-irq lock-inversion/231:failed|failed|  ok  |
>[    0.004000]       soft-irq lock-inversion/231:failed|failed|  ok  |
>[    0.004000]       hard-irq lock-inversion/312:failed|failed|  ok  |
>[    0.004000]       soft-irq lock-inversion/312:failed|failed|  ok  |
>[    0.004000]       hard-irq lock-inversion/321:failed|failed|  ok  |
>[    0.004000]       soft-irq lock-inversion/321:failed|failed|  ok  |
>[    0.004000]       hard-irq read-recursion/123:  ok  |
>[    0.004000]       soft-irq read-recursion/123:  ok  |
>[    0.004000]       hard-irq read-recursion/132:  ok  |
>[    0.004000]       soft-irq read-recursion/132:  ok  |
>[    0.004000]       hard-irq read-recursion/213:  ok  |
>[    0.004000]       soft-irq read-recursion/213:  ok  |
>[    0.004000]       hard-irq read-recursion/231:  ok  |
>[    0.004000]       soft-irq read-recursion/231:  ok  |
>[    0.004000]       hard-irq read-recursion/312:  ok  |
>[    0.004000]       soft-irq read-recursion/312:  ok  |
>[    0.004000]       hard-irq read-recursion/321:  ok  |
>[    0.004000]       soft-irq read-recursion/321:  ok  |
>[    0.004000]   --------------------------------------------------------------------------
>[    0.004000]   | Wound/wait tests |
>[    0.004000]   ---------------------
>[    0.004000]                   ww api failures:  ok  |  ok  |  ok  |
>[    0.004000]                ww contexts mixing:failed|  ok  |
>[    0.004000]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
>[    0.004000]                locking mismatches:  ok  |  ok  |  ok  |
>[    0.004000]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>[    0.004000]            spinlock nest unlocked:  ok  |
>[    0.004000]   -----------------------------------------------------
>[    0.004000]                                  |block | try  |context|
>[    0.004000]   -----------------------------------------------------
>[    0.004000]                           context:failed|  ok  |  ok  |
>[    0.004000]                               try:failed|  ok  |failed|
>[    0.004000]                             block:failed|  ok  |failed|
>[    0.004000]                          spinlock:failed|  ok  |failed|
>[    0.004000] --------------------------------------------------------
>[    0.004000] 153 out of 262 testcases failed, as expected. |
>[    0.004000] ----------------------------------------------------
>[    0.004000] ODEBUG: selftest passed
>[    0.004000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
>[    0.004000] hpet clockevent registered
>[    0.004012] tsc: Detected 2925.998 MHz processor
>[    0.004609] Calibrating delay loop (skipped) preset value.. 5851.99 BogoMIPS (lpj=11703992)
>[    0.005040] pid_max: default: 32768 minimum: 301
>[    0.005680] ACPI: Core revision 20170728
>[    0.013474] ACPI: 1 ACPI AML tables successfully acquired and loaded
>[    0.014404] Security Framework initialized
>[    0.014941] LoadPin: ready to pin (currently disabled)
>[    0.015040] AppArmor: AppArmor initialized
>[    0.016085] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
>[    0.016900] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
>[    0.018271] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
>[    0.018943] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
>[    0.019677] CPU: Intel QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
>[    0.021342] Performance Events: PMU not available due to virtualization, using software events only.
>[    0.025247] Hierarchical SRCU implementation.
>[    0.026271] NMI watchdog: Perf event create on CPU 0 failed with -2
>[    0.027046] NMI watchdog: Perf NMI watchdog permanently disabled
>[    0.028092] Enabling APIC mode:  Flat.  Using 1 I/O APICs
>[    0.028823] enabled ExtINT on CPU#0
>[    0.029929] ENABLING IO-APIC IRQs
>[    0.030396] init IO_APIC IRQs
>[    0.030815]  apic 0 pin 0 not connected
>[    0.032040] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Active:0 Dest:1)
>[    0.033051] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
>[    0.034045] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Active:0 Dest:1)
>[    0.035032] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 Active:0 Dest:1)
>[    0.036000] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 Active:0 Dest:1)
>[    0.036000]  apic 0 pin 16 not connected
>[    0.036000]  apic 0 pin 17 not connected
>[    0.036000]  apic 0 pin 18 not connected
>[    0.036000]  apic 0 pin 19 not connected
>[    0.036000]  apic 0 pin 20 not connected
>[    0.036000]  apic 0 pin 21 not connected
>[    0.036000]  apic 0 pin 22 not connected
>[    0.036000]  apic 0 pin 23 not connected
>[    0.036000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>[    0.036000] Using local APIC timer interrupts.
>[    0.036000] calibrating APIC timer ...
>[    0.036000] ... lapic delta = 6251801
>[    0.036000] ... PM-Timer delta = 358057
>[    0.036000] ... PM-Timer result ok
>[    0.036000] ..... delta 6251801
>[    0.036000] ..... mult: 268512808
>[    0.036000] ..... calibration result: 4001152
>[    0.036000] ..... CPU clock speed is 2926.3366 MHz.
>[    0.036000] ..... host bus clock speed is 1000.1152 MHz.
>[    0.036395] devtmpfs: initialized
>[    0.039032] evm: security.ima
>[    0.039459] evm: security.capability
>[    0.041926] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
>[    0.043094] futex hash table entries: 256 (order: 1, 13312 bytes)
>[    0.044044] prandom: seed boundary self test passed
>[    0.045215] prandom: 100 self tests passed
>[    0.046291] regulator-dummy: Failed to create debugfs directory
>[    0.047120] RTC time: 14:42:58, date: 11/06/17
>[    0.048435] NET: Registered protocol family 16
>[    0.051919] cpuidle: using governor menu
>[    0.053833] ACPI: bus type PCI registered
>[    0.054556] PCI: Using configuration type 1 for base access
>[    0.120178] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
>[    0.121698] gpio-f7188x: Not a Fintek device at 0x0000002e
>[    0.122400] gpio-f7188x: Not a Fintek device at 0x0000004e
>[    0.123582] ACPI: Added _OSI(Module Device)
>[    0.124025] ACPI: Added _OSI(Processor Device)
>[    0.124598] ACPI: Added _OSI(3.0 _SCP Extensions)
>[    0.125190] ACPI: Added _OSI(Processor Aggregator Device)
>[    0.132146] ACPI: Interpreter enabled
>[    0.132684] ACPI: (supports S0 S3 S5)
>[    0.133170] ACPI: Using IOAPIC for interrupt routing
>[    0.133845] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
>[    0.135591] ACPI: Enabled 2 GPEs in block 00 to 0F
>[    0.155889] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>[    0.156014] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
>[    0.156750] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
>[    0.157727] PCI host bridge to bus 0000:00
>[    0.158266] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>[    0.159068] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>[    0.160008] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>[    0.160925] pci_bus 0000:00: root bus resource [mem 0x1a400000-0xfebfffff window]
>[    0.161866] pci_bus 0000:00: root bus resource [bus 00-ff]
>[    0.162584] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
>[    0.164672] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
>[    0.166310] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
>[    0.169527] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
>[    0.171463] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
>[    0.172007] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
>[    0.172773] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
>[    0.173615] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
>[    0.174975] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
>[    0.176342] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
>[    0.177223] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
>[    0.179342] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
>[    0.181571] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
>[    0.184699] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
>[    0.192016] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
>[    0.193753] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
>[    0.195642] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
>[    0.197107] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
>[    0.204601] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
>[    0.208099] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
>[    0.209337] pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
>[    0.214377] pci_bus 0000:00: on NUMA node 0
>[    0.217640] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
>[    0.219002] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
>[    0.220379] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
>[    0.221468] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
>[    0.222353] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
>[    0.224817] pci 0000:00:02.0: vgaarb: setting as boot VGA device
>[    0.225546] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
>[    0.226569] pci 0000:00:02.0: vgaarb: bridge control possible
>[    0.227263] vgaarb: loaded
>[    0.229071] SCSI subsystem initialized
>[    0.229651] libata version 3.00 loaded.
>[    0.230361] ACPI: bus type USB registered
>[    0.230966] usbcore: registered new interface driver usbfs
>[    0.231681] usbcore: registered new interface driver hub
>[    0.232066] usbcore: registered new device driver usb
>[    0.233085] pps_core: LinuxPPS API ver. 1 registered
>[    0.233704] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
>[    0.235474] FPGA manager framework
>[    0.236165] Advanced Linux Sound Architecture Driver Initialized.
>[    0.237021] PCI: Using ACPI for IRQ routing
>[    0.237557] PCI: pci_cache_line_size set to 64 bytes
>[    0.238263] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
>[    0.238982] e820: reserve RAM buffer [mem 0x1a3e0000-0x1bffffff]
>[    0.242786] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
>[    0.243669] clocksource: Switched to clocksource kvm-clock
>[    0.250405] Warning: could not register all branches stats
>[    0.252292] Warning: could not register annotated branches stats
>[    0.357052] VFS: Disk quotas dquot_6.6.0
>[    0.357678] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>[    0.359294] AppArmor: AppArmor Filesystem Enabled
>[    0.360027] pnp: PnP ACPI init
>[    0.360701] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
>[    0.361643] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
>[    0.362579] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
>[    0.363393] pnp 00:03: [dma 2]
>[    0.363892] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
>[    0.364940] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
>[    0.365942] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
>[    0.366951] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
>[    0.368819] pnp: PnP ACPI: found 7 devices
>[    0.412405] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
>[    0.413569] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
>[    0.414302] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
>[    0.415034] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
>[    0.415986] pci_bus 0000:00: resource 7 [mem 0x1a400000-0xfebfffff window]
>[    0.417323] NET: Registered protocol family 1
>[    0.417902] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
>[    0.418618] pci 0000:00:01.0: PIIX3: Enabling Passive Release
>[    0.419326] pci 0000:00:01.0: Activating ISA DMA hang workarounds
>[    0.420110] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>[    0.421212] PCI: CLS 0 bytes, default 64
>[    0.422158] Unpacking initramfs...
>[    1.464778] Freeing initrd memory: 3260K
>[    1.468397] cryptomgr_test (29) used greatest stack depth: 7376 bytes left
>[    1.469286] The force parameter has not been set to 1. The Iris poweroff handler will not be installed.
>[    1.470438] spin_lock-torture:--- Start of test [debug]: nwriters_stress=2 nreaders_stress=0 stat_interval=60 verbose=1 shuffle_interval=3 stutter=5 shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
>[    1.472445] spin_lock-torture: Creating torture_shuffle task
>[    1.473260] spin_lock-torture: Creating torture_stutter task
>[    1.474004] spin_lock-torture: torture_shuffle task started
>[    1.474707] spin_lock-torture: Creating lock_torture_writer task
>[    1.475479] spin_lock-torture: torture_stutter task started
>[    1.476196] spin_lock-torture: Creating lock_torture_writer task
>[    1.477018] spin_lock-torture: lock_torture_writer task started
>[    1.477756] spin_lock-torture: Creating lock_torture_stats task
>[    1.478508] spin_lock-torture: lock_torture_writer task started
>[    1.479272] torture_init_begin: Refusing rcu init: spin_lock running.
>[    1.480048] torture_init_begin: One torture test at a time!
>[    1.481371] audit: initializing netlink subsys (disabled)
>[    1.482104] spin_lock-torture: lock_torture_stats task started
>[    1.483297] Key type blacklist registered
>[    1.483933] audit: type=2000 audit(1509950580.909:1): state=initialized audit_enabled=0 res=1
>[    1.485069] workingset: timestamp_bits=30 max_order=17 bucket_order=0
>[    1.485908] zbud: loaded
>[    1.487251] ntfs: driver 2.1.32 [Flags: R/O DEBUG].
>[    1.488024] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
>[    1.490627] qnx6: QNX6 filesystem 1.0.0 registered.
>[    1.491264] fuse init (API version 7.26)
>[    1.492187] orangefs_debugfs_init: called with debug mask: :none: :0:
>[    1.493197] orangefs_init: module version upstream loaded
>[    1.493982] JFS: nTxBlock = 2658, nTxLock = 21268
>[    1.495655] NILFS version 2 loaded
>[    1.496114] befs: version: 0.9.3
>[    1.496763] ocfs2: Registered cluster interface o2cb
>[    1.497490] OCFS2 User DLM kernel interface loaded
>[    1.501954] cryptomgr_test (48) used greatest stack depth: 7256 bytes left
>[    1.509022] NET: Registered protocol family 38
>[    1.509787] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
>[    1.510715] io scheduler noop registered
>[    1.511281] io scheduler cfq registered (default)
>[    1.511876] io scheduler kyber registered
>[    1.512387] test_string_helpers: Running tests...
>[    1.517349] test_hexdump: all 1184 tests passed
>[    1.518084] test_firmware: interface ready
>[    1.518613] Running rhashtable test nelem=8, max_size=0, shrinking=0
>[    1.519358] Test 00:
>[    1.521423]   Adding 50000 keys
>[    1.648848]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[    1.714411]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[    1.715457]   Deleting 50000 keys
>[    1.772173]   Duration of test: 250266402 ns
>[    1.772886] Test 01:
>[    1.774602]   Adding 50000 keys
>[    1.916676]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[    1.985191]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[    1.986242]   Deleting 50000 keys
>[    2.044385]   Duration of test: 269204598 ns
>[    2.045127] Test 02:
>[    2.046756]   Adding 50000 keys
>[    2.184562]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[    2.254898]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[    2.255980]   Deleting 50000 keys
>[    2.314461]   Duration of test: 267223552 ns
>[    2.315163] Test 03:
>[    2.316783]   Adding 50000 keys
>[    2.441843]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[    2.493030] tsc: Refined TSC clocksource calibration: 2926.001 MHz
>[    2.493787] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2a2d3530f19, max_idle_ns: 440795230140 ns
>[    2.510073]   Traversal complete: counted=50000, nelems=50000, entries=50000, table-jumps=0
>[    2.511088]   Deleting 50000 keys
>[    2.567098]   Duration of test: 249816329 ns
>[    2.567775] Average test time: 259127720
>[    2.568296] Testing concurrent rhashtable access from 10 threads
>[    7.237652] rhashtable_thra (109) used greatest stack depth: 7088 bytes left
>[    7.239095] Started 10 threads, 0 failed
>[    7.242413] rhashtable_thra (108) used greatest stack depth: 7012 bytes left
>[    7.243556] test passed
>[    7.243934] test_uuid: all 18 tests passed
>[    7.249050] crc32: CRC_LE_BITS = 1, CRC_BE BITS = 1
>[    7.249663] crc32: self tests passed, processed 225944 bytes in 2185662 nsec
>[    7.253185] crc32c: CRC_LE_BITS = 1
>[    7.253660] crc32c: self tests passed, processed 225944 bytes in 1333835 nsec
>[    7.374895] crc32_combine: 8373 self tests passed
>[    7.496042] crc32c_combine: 8373 self tests passed
>[    7.497224] interval tree insert/remove
>[    8.881293]  -> 40497 cycles
>[    8.882231] interval tree search
>[    9.664598]  -> 228915 cycles (2692 results)
>[    9.668567] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>[    9.669461] switchtec: loaded.
>[    9.671738] no IO addresses supplied
>[    9.672430] hgafb: HGA card not detected.
>[    9.672965] hgafb: probe of hgafb.0 failed with error -22
>[    9.673885] usbcore: registered new interface driver udlfb
>[    9.675081] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
>[    9.676125] ACPI: Power Button [PWRF]
>[    9.677115] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
>[    9.678074] ACPI: Power Button [PWRF]
>[    9.678772] Warning: Processor Platform Limit event detected, but not handled.
>[    9.679698] Consider compiling CPUfreq support into your kernel.
>[    9.737372] r3964: Philips r3964 Driver $Revision: 1.10 $
>[    9.738056] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>[    9.761752] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>[    9.763634] console [ttyS0] disabled
>[    9.787166] console [ttyS0] enabled
>[    9.810358] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
>[    9.834603] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
>[    9.839324] lp: driver loaded but no devices found
>[    9.840008] DoubleTalk PC - not found
>[    9.840517] Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
>[    9.841389] ac.o: No PCI boards found.
>[    9.841904] ac.o: For an ISA board you must supply memory and irq parameters.
>[    9.842782] sonypi: Sony Programmable I/O Controller Driver v1.26.
>[    9.843595] toshiba: not a supported Toshiba laptop
>[    9.844509] nsc_gpio initializing
>[    9.844998] telclk_interrupt = 0xf non-mcpbl0010 hw.
>[    9.845659] Linux agpgart interface v0.103
>[    9.847314] drm_mm: Testing DRM range manger (struct drm_mm), with random_seed=0xba26273f max_iterations=8192 max_prime=128
>[    9.848686] drm_mm: igt_sanitycheck - ok!
>[   35.614773] drm_mm: lookup failed for node 0 + 1
>[   35.616788] [drm] radeon kernel modesetting enabled.
>[   35.617603] [drm] amdgpu kernel modesetting enabled.
>[   35.618941] [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
>[   35.620308] [drm] Found bochs VGA, ID 0xb0c0.
>[   35.620878] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
>[   35.621875] [TTM] Zone  kernel: Available graphics memory: 170146 kiB
>[   35.622709] [TTM] Initializing pool allocator
>[   35.623647] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 1
>[   35.625042] [TTM] Finalizing pool allocator
>[   35.625788] [TTM] Zone  kernel: Used memory at exit: 0 kiB
>[   35.627727] [drm] Found bochs VGA, ID 0xb0c0.
>[   35.628292] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
>[   35.629258] [TTM] Zone  kernel: Available graphics memory: 170146 kiB
>[   35.630040] [TTM] Initializing pool allocator
>[   35.630961] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 1
>[   35.632797] parport_pc 00:04: reported by Plug and Play ACPI
>[   35.633686] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
>[   35.730901] lp0: using parport0 (interrupt-driven).
>[   35.731543] lp0: console ready
>[   35.731970] console [lp0] disabled
>[   35.732628] parport_pc 00:04: reported by Plug and Play ACPI
>[   35.733443] parport1: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
>[   35.830891] lp1: using parport1 (interrupt-driven).
>[   35.833583] MM: desc_per_page = 128
>[   35.834152] mtip32xx Version 1.3.1
>[   35.835866] null: module loaded
>[   35.836353] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
>[   35.837147] dummy-irq: no IRQ given.  Use irq=N
>[   35.837862] Phantom Linux Driver, version n0.9.8, init OK
>[   35.838908] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
>[   35.839956] c2port c2port0: C2 port uc added
>[   35.840503] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 bytes total)
>[   35.841947] Guest personality initialized and is inactive
>[   35.842799] VMCI host device registered (name=vmci, major=10, minor=60)
>[   35.843597] Initialized host personality
>[   35.845708] usbcore: registered new interface driver dln2
>[   35.846483] Loading iSCSI transport class v2.0-870.
>[   35.847599] st: Version 20160209, fixed bufsize 32768, s/g segs 256
>[   35.848642] SCSI Media Changer driver v0.25
>[   35.850409] Rounding down aligned max_sectors from 4294967295 to 4294967288
>[   35.851999] mtdoops: mtd device (mtddev=name/number) must be supplied
>[   35.852786] device id = 2440
>[   35.853188] device id = 2480
>[   35.853594] device id = 24c0
>[   35.853997] device id = 24d0
>[   35.854395] device id = 25a1
>[   35.854825] device id = 2670
>[   35.855300] SBC-GXx flash: IO:0x258-0x259 MEM:0xdc000-0xdffff
>[   35.856204] slram: not enough parameters.
>[   35.856726] Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000 Nortel Networks.
>[   35.857651] pmc551: not detected
>[   35.859241] ftl_cs: FTL header not found.
>[   35.861230] parport1: cannot grant exclusive access for device spi-lm70llp
>[   35.862094] spi_lm70llp: spi_lm70llp probe fail, status -12
>[   35.863033] MACsec IEEE 802.1AE
>[   35.865623] mdio_bus fixed-0: GPIO lookup for consumer reset
>[   35.866325] mdio_bus fixed-0: using lookup tables for GPIO lookup
>[   35.867120] mdio_bus fixed-0: lookup for GPIO reset failed
>[   35.867847] libphy: Fixed MDIO Bus: probed
>[   35.870332] arcnet: arcnet loaded
>[   35.870833] arcnet:rfc1201: RFC1201 "standard" (`a') encapsulation support loaded
>[   35.873704] arcnet:com90io: COM90xx IO-mapped mode support (by David Woodhouse et el.)
>[   35.874692] arcnet:com90io: E-mail me if you actually test this driver, please!
>[   35.875581] (unnamed net_device) (uninitialized): No autoprobe for IO mapped cards; you must specify the base address!
>[   35.876850] arcnet:arc_rimi: RIM I (entirely mem-mapped) support
>[   35.877573] arcnet:arc_rimi: E-mail me if you actually test the RIM I driver, please!
>[   35.878513] arcnet:arc_rimi: Given: node 00h, shmem 0h, irq 0
>[   35.879261] arcnet:arc_rimi: No autoprobe for RIM I; you must specify the shmem and irq!
>[   35.880350] ena: Elastic Network Adapter (ENA) v1.2.0k
>[   35.881404] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
>[   35.882475] vxge: Copyright(c) 2002-2010 Exar Corp.
>[   35.883175] vxge: Driver version: 2.5.3.22640-k
>[   35.883917] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
>[   35.884795] e1000: Copyright (c) 1999-2006 Intel Corporation.
>[   36.222479] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
>[   36.562670] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
>[   36.563523] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
>[   37.622887] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
>[   37.623738] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
>[   37.624641] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
>[   37.625350] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>[   37.626124] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
>[   37.626939] igb: Copyright (c) 2007-2014 Intel Corporation.
>[   37.627695] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
>[   37.628669] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
>[   37.629431] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
>[   37.630350] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
>[   37.631246] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver - version 4.1.0-k
>[   37.632365] ixgbevf: Copyright (c) 2009 - 2015 Intel Corporation.
>[   37.633233] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 2.1.14-k
>[   37.634200] i40e: Copyright (c) 2013 - 2014 Intel Corporation.
>[   37.635050] Intel(R) Ethernet Switch Host Interface Driver - version 0.21.7-k
>[   37.635907] Copyright(c) 2013 - 2017 Intel Corporation.
>[   37.636691] jme: JMicron JMC2XX ethernet driver version 1.0.8
>[   37.637486] sky2: driver version 1.30
>[   37.638621] pch_gbe: EG20T PCH Gigabit Ethernet Driver - version 1.01
>[   37.639491] QLogic 1/10 GbE Converged/Intelligent Ethernet Driver v5.3.66
>[   37.640354] QLogic/NetXen Network Driver v4.0.82
>[   37.640986] QLogic FastLinQ 4xxxx Core Module qed 8.10.11.21
>[   37.641786] atp.c:v1.09=ac 2002/10/01 Donald Becker <becker@scyld.com>
>[   37.642846] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
>[   37.643576] tehuti: Options: hw_csum
>[   37.644121] tlan: ThunderLAN driver v1.17
>[   37.644689] tlan: 0 devices installed, PCI: 0  EISA: 0
>[   37.645609] AX.25: Z8530 SCC driver version 3.0.dl1bke
>[   37.646564] AX.25: bpqether driver version 004
>[   37.647146] baycom_ser_fdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
>[   37.647146] baycom_ser_fdx: version 0.10
>[   37.649486] hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA
>[   37.650192] hdlcdrv: version 0.8
>[   37.650628] baycom_epp: (C) 1998-2000 Thomas Sailer, HB9JNX/AE4WA
>[   37.650628] baycom_epp: version 0.7
>[   37.652906] PPP generic driver version 2.4.2
>[   37.653633] PPP BSD Compression module registered
>[   37.654226] PPP Deflate Compression module registered
>[   37.654880] PPP MPPE Compression module registered
>[   37.655490] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
>[   37.656520] usbcore: registered new interface driver ath9k_htc
>[   37.657272] usbcore: registered new interface driver ar5523
>[   37.658038] usbcore: registered new interface driver usb8xxx
>[   37.658763] libertas_sdio: Libertas SDIO driver
>[   37.659361] libertas_sdio: Copyright Pierre Ossman
>[   37.659999] libertas_spi: Libertas SPI driver
>[   37.660701] usbcore: registered new interface driver lbtf_usb
>[   37.661614] usbcore: registered new interface driver rt2800usb
>[   37.662361] usbcore: registered new interface driver rtl8187
>[   37.663355] usbcore: registered new interface driver zd1211rw
>[   37.664106] usbcore: registered new interface driver zd1201
>[   37.664788] qtnfmac_pearl_pcie: qtnf_pcie_register: register Quantenna QSR10g FullMAC PCIE driver
>[   37.665909] usbcore: registered new interface driver rndis_wlan
>[   37.666690] mac80211_hwsim: initializing netlink
>[   37.668009] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>[   37.669564] ieee80211 phy0: hwaddr 02:00:00:00:00:00 registered
>[   37.670921] ieee80211 phy1: Selected rate control algorithm 'minstrel_ht'
>[   37.672503] ieee80211 phy1: hwaddr 02:00:00:00:01:00 registered
>[   37.673626] usbcore: registered new interface driver i2400m_usb
>[   37.674381] usbcore: registered new interface driver catc
>[   37.675081] usbcore: registered new interface driver kaweth
>[   37.675794] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
>[   37.676754] usbcore: registered new interface driver pegasus
>[   37.677473] usbcore: registered new interface driver r8152
>[   37.678175] usbcore: registered new interface driver lan78xx
>[   37.678938] usbcore: registered new interface driver asix
>[   37.679667] usbcore: registered new interface driver cdc_ether
>[   37.680413] usbcore: registered new interface driver cdc_eem
>[   37.681151] usbcore: registered new interface driver dm9601
>[   37.681872] usbcore: registered new interface driver sr9700
>[   37.682602] usbcore: registered new interface driver smsc75xx
>[   37.683369] usbcore: registered new interface driver smsc95xx
>[   37.684111] usbcore: registered new interface driver gl620a
>[   37.684825] usbcore: registered new interface driver net1080
>[   37.685555] usbcore: registered new interface driver plusb
>[   37.686255] usbcore: registered new interface driver rndis_host
>[   37.687008] usbcore: registered new interface driver cdc_subset
>[   37.687774] usbcore: registered new interface driver zaurus
>[   37.688493] usbcore: registered new interface driver cdc_phonet
>[   37.689255] usbcore: registered new interface driver ipheth
>[   37.689966] usbcore: registered new interface driver sierra_net
>[   37.690713] usbcore: registered new interface driver cx82310_eth
>[   37.691498] usbcore: registered new interface driver cdc_ncm
>[   37.692219] usbcore: registered new interface driver huawei_cdc_ncm
>[   37.693003] usbcore: registered new interface driver qmi_wwan
>[   37.693751] usbcore: registered new interface driver cdc_mbim
>[   37.694455] Fusion MPT base driver 3.04.20
>[   37.694976] Copyright (c) 1999-2008 LSI Corporation
>[   37.695608] Fusion MPT FC Host driver 3.04.20
>[   37.696226] Fusion MPT SAS Host driver 3.04.20
>[   37.697347] panel: panel driver not yet registered
>[   37.698457] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>[   37.699289] ohci-pci: OHCI PCI platform driver
>[   37.699915] ohci-platform: OHCI generic platform driver
>[   37.700611] uhci_hcd: USB Universal Host Controller Interface driver
>[   37.701652] fotg210_hcd: FOTG210 Host Controller (EHCI) Driver
>[   37.702360] Warning! fotg210_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
>[   37.703580] usbcore: registered new interface driver cdc_acm
>[   37.704274] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
>[   37.705284] usbcore: registered new interface driver usblp
>[   37.705999] usbcore: registered new interface driver cdc_wdm
>[   37.706730] usbcore: registered new interface driver usbtmc
>[   37.707464] usbcore: registered new interface driver uas
>[   37.708191] usbcore: registered new interface driver usb-storage
>[   37.708961] usbcore: registered new interface driver ums-alauda
>[   37.709714] usbcore: registered new interface driver ums-cypress
>[   37.710475] usbcore: registered new interface driver ums-datafab
>[   37.711268] usbcore: registered new interface driver ums_eneub6250
>[   37.712050] usbcore: registered new interface driver ums-freecom
>[   37.712810] usbcore: registered new interface driver ums-karma
>[   37.713543] usbcore: registered new interface driver ums-onetouch
>[   37.714303] usbcore: registered new interface driver ums-sddr09
>[   37.715053] usbcore: registered new interface driver ums-sddr55
>[   37.715824] usbcore: registered new interface driver mdc800
>[   37.716502] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
>[   37.717482] usbcore: registered new interface driver microtekX6
>[   37.718308] usbcore: registered new interface driver usbserial
>[   37.719067] usbcore: registered new interface driver usbserial_generic
>[   37.719908] usbserial: USB Serial support registered for generic
>[   37.720682] usbcore: registered new interface driver ark3116
>[   37.721412] usbserial: USB Serial support registered for ark3116
>[   37.722186] usbcore: registered new interface driver cypress_m8
>[   37.722938] usbserial: USB Serial support registered for DeLorme Earthmate USB
>[   37.723881] usbserial: USB Serial support registered for HID->COM RS232 Adapter
>[   37.724821] usbserial: USB Serial support registered for Nokia CA-42 V2 Adapter
>[   37.725760] usbcore: registered new interface driver usb_debug
>[   37.726492] usbserial: USB Serial support registered for debug
>[   37.727270] usbserial: USB Serial support registered for xhci_dbc
>[   37.728050] usbcore: registered new interface driver digi_acceleport
>[   37.728855] usbserial: USB Serial support registered for Digi 2 port USB adapter
>[   37.729817] usbserial: USB Serial support registered for Digi 4 port USB adapter
>[   37.730775] usbcore: registered new interface driver io_edgeport
>[   37.731549] usbserial: USB Serial support registered for Edgeport 2 port adapter
>[   37.732496] usbserial: USB Serial support registered for Edgeport 4 port adapter
>[   37.733442] usbserial: USB Serial support registered for Edgeport 8 port adapter
>[   37.734399] usbserial: USB Serial support registered for EPiC device
>[   37.735220] usbcore: registered new interface driver f81534
>[   37.735946] usbserial: USB Serial support registered for Fintek F81532/F81534
>[   37.736841] usbcore: registered new interface driver ftdi_sio
>[   37.737582] usbserial: USB Serial support registered for FTDI USB Serial Device
>[   37.740438] usbcore: registered new interface driver garmin_gps
>[   37.741199] usbserial: USB Serial support registered for Garmin GPS usb/tty
>[   37.742053] usbcore: registered new interface driver ipaq
>[   37.742751] usbserial: USB Serial support registered for PocketPC PDA
>[   37.743564] usbcore: registered new interface driver ipw
>[   37.744256] usbserial: USB Serial support registered for IPWireless converter
>[   37.745133] usbcore: registered new interface driver keyspan
>[   37.745859] usbserial: USB Serial support registered for Keyspan - (without firmware)
>[   37.746857] usbserial: USB Serial support registered for Keyspan 1 port adapter
>[   37.747807] usbserial: USB Serial support registered for Keyspan 2 port adapter
>[   37.748760] usbserial: USB Serial support registered for Keyspan 4 port adapter
>[   37.749698] usbcore: registered new interface driver keyspan_pda
>[   37.750454] usbserial: USB Serial support registered for Keyspan PDA
>[   37.751269] usbserial: USB Serial support registered for Keyspan PDA - (prerenumeration)
>[   37.752289] usbserial: USB Serial support registered for Xircom / Entrega PGS - (prerenumeration)
>[   37.753395] usbcore: registered new interface driver kl5kusb105
>[   37.754144] usbserial: USB Serial support registered for KL5KUSB105D / PalmConnect
>[   37.755112] usbcore: registered new interface driver kobil_sct
>[   37.755887] usbserial: USB Serial support registered for KOBIL USB smart card terminal
>[   37.756873] usbcore: registered new interface driver mct_u232
>[   37.757613] usbserial: USB Serial support registered for MCT U232
>[   37.758389] usbcore: registered new interface driver metro_usb
>[   37.759150] usbserial: USB Serial support registered for Metrologic USB to Serial
>[   37.760106] usbcore: registered new interface driver mos7720
>[   37.760846] usbserial: USB Serial support registered for Moschip 2 port adapter
>[   37.761787] usbcore: registered new interface driver mos7840
>[   37.762510] usbserial: USB Serial support registered for Moschip 7840/7820 USB Serial Driver
>[   37.763607] usbcore: registered new interface driver mxuport
>[   37.764319] usbserial: USB Serial support registered for MOXA UPort
>[   37.765114] usbcore: registered new interface driver omninet
>[   37.765844] usbserial: USB Serial support registered for ZyXEL - omni.net lcd plus usb
>[   37.766845] usbcore: registered new interface driver opticon
>[   37.767577] usbserial: USB Serial support registered for opticon
>[   37.768344] usbcore: registered new interface driver pl2303
>[   37.769066] usbserial: USB Serial support registered for pl2303
>[   37.769824] usbcore: registered new interface driver safe_serial
>[   37.770606] usbserial: USB Serial support registered for safe_serial
>[   37.771412] usbcore: registered new interface driver sierra
>[   37.772130] usbserial: USB Serial support registered for Sierra USB modem
>[   37.772965] usbcore: registered new interface driver spcp8x5
>[   37.773695] usbserial: USB Serial support registered for SPCP8x5
>[   37.774452] usbcore: registered new interface driver upd78f0730
>[   37.775223] usbserial: USB Serial support registered for upd78f0730
>[   37.776024] usbcore: registered new interface driver visor
>[   37.776736] usbserial: USB Serial support registered for Handspring Visor / Palm OS
>[   37.777707] usbserial: USB Serial support registered for Sony Clie 5.0
>[   37.778521] usbserial: USB Serial support registered for Sony Clie 3.5
>[   37.779354] usbcore: registered new interface driver wishbone_serial
>[   37.780153] usbserial: USB Serial support registered for wishbone_serial
>[   37.781005] usbcore: registered new interface driver xsens_mt
>[   37.781740] usbserial: USB Serial support registered for xsens_mt
>[   37.782510] usbcore: registered new interface driver appledisplay
>[   37.783276] usbcore: registered new interface driver cypress_cy7c63
>[   37.784063] usbcore: registered new interface driver cytherm
>[   37.784780] usbcore: registered new interface driver emi62 - firmware loader
>[   37.785602] ftdi_elan: driver ftdi-elan
>[   37.786138] usbcore: registered new interface driver ftdi-elan
>[   37.786893] usbcore: registered new interface driver isight_firmware
>[   37.787711] usbcore: registered new interface driver ldusb
>[   37.788416] usbcore: registered new interface driver rio500
>[   37.789156] usbcore: registered new interface driver usb_ehset_test
>[   37.789946] usbcore: registered new interface driver usbsevseg
>[   37.790716] usbcore: registered new interface driver yurex
>[   37.791427] usbcore: registered new interface driver chaoskey
>[   37.792175] usbcore: registered new interface driver sisusb
>[   37.792896] usbcore: registered new interface driver lvs
>[   37.794182] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, driver 02 May 2005
>[   37.795130] dummy_hcd dummy_hcd.0: Dummy host controller
>[   37.795968] dummy_hcd dummy_hcd.0: new USB bus registered, assigned bus number 1
>[   37.797599] hub 1-0:1.0: USB hub found
>[   37.798156] hub 1-0:1.0: 1 port detected
>[   37.799012] hub 1-0:1.0: USB hub found
>[   37.799586] hub 1-0:1.0: 1 port detected
>[   37.800931] hub 1-0:1.0: USB hub found
>[   37.801463] hub 1-0:1.0: 1 port detected
>[   37.802239] hub 1-0:1.0: USB hub found
>[   37.802776] hub 1-0:1.0: 1 port detected
>[   37.803636] dummy_hcd dummy_hcd.0: remove, state 1
>[   37.804272] usb usb1: USB disconnect, device number 1
>[   37.806012] dummy_hcd dummy_hcd.0: stopped
>[   37.806558] dummy_hcd dummy_hcd.0: USB bus 1 deregistered
>[   37.807573] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, driver 02 May 2005
>[   37.808486] dummy_hcd dummy_hcd.0: Dummy host controller
>[   37.809301] dummy_hcd dummy_hcd.0: new USB bus registered, assigned bus number 1
>[   37.810845] hub 1-0:1.0: USB hub found
>[   37.811415] hub 1-0:1.0: 1 port detected
>[   37.812179] hub 1-0:1.0: USB hub found
>[   37.812712] hub 1-0:1.0: 1 port detected
>[   37.813876] hub 1-0:1.0: USB hub found
>[   37.814409] hub 1-0:1.0: 1 port detected
>[   37.815256] hub 1-0:1.0: USB hub found
>[   37.815787] hub 1-0:1.0: 1 port detected
>[   37.816974] dummy_udc dummy_udc.0: unregistering gadget
>[   37.817872] udc dummy_udc.0: releasing 'dummy_udc.0'
>[   37.818544]  gadget: usb_udc_nop_release
>[   37.819773] userial_init: registered 4 ttyGS* devices
>[   37.820733] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
>[   37.821653] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 2
>[   37.822609] vhci_hcd: created sysfs vhci_hcd.0
>[   37.823794] hub 2-0:1.0: USB hub found
>[   37.824347] hub 2-0:1.0: 8 ports detected
>[   37.826212] hub 2-0:1.0: USB hub found
>[   37.826744] hub 2-0:1.0: 8 ports detected
>[   37.829007] hub 2-0:1.0: USB hub found
>[   37.829548] hub 2-0:1.0: 8 ports detected
>[   37.831394] hub 2-0:1.0: USB hub found
>[   37.831938] hub 2-0:1.0: 8 ports detected
>[   37.833372] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
>[   37.834259] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 3
>[   37.835285] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
>[   37.836849] hub 3-0:1.0: USB hub found
>[   37.837384] hub 3-0:1.0: 8 ports detected
>[   37.839683] hub 3-0:1.0: USB hub found
>[   37.840233] hub 3-0:1.0: 8 ports detected
>[   37.842855] hub 3-0:1.0: USB hub found
>[   37.843428] hub 3-0:1.0: 8 ports detected
>[   37.845661] hub 3-0:1.0: USB hub found
>[   37.846196] hub 3-0:1.0: 8 ports detected
>[   37.847792] vhci_hcd vhci_hcd.0: remove, state 1
>[   37.848389] usb usb3: USB disconnect, device number 1
>[   37.850551] vhci_hcd: stop threads
>[   37.851019] vhci_hcd: release socket
>[   37.851579] vhci_hcd: disconnect device
>[   37.852117] vhci_hcd: stop threads
>[   37.852623] vhci_hcd: release socket
>[   37.853098] vhci_hcd: disconnect device
>[   37.853646] vhci_hcd: stop threads
>[   37.854107] vhci_hcd: release socket
>[   37.854615] vhci_hcd: disconnect device
>[   37.855144] vhci_hcd: stop threads
>[   37.855639] vhci_hcd: release socket
>[   37.856125] vhci_hcd: disconnect device
>[   37.856640] vhci_hcd: stop threads
>[   37.857098] vhci_hcd: release socket
>[   37.857579] vhci_hcd: disconnect device
>[   37.858094] vhci_hcd: stop threads
>[   37.858563] vhci_hcd: release socket
>[   37.859041] vhci_hcd: disconnect device
>[   37.859628] vhci_hcd: stop threads
>[   37.860090] vhci_hcd: release socket
>[   37.860570] vhci_hcd: disconnect device
>[   37.861086] vhci_hcd: stop threads
>[   37.861578] vhci_hcd: release socket
>[   37.862070] vhci_hcd: disconnect device
>[   37.862648] vhci_hcd vhci_hcd.0: USB bus 3 deregistered
>[   37.863607] vhci_hcd vhci_hcd.0: remove, state 1
>[   37.864200] usb usb2: USB disconnect, device number 1
>[   37.866151] vhci_hcd: stop threads
>[   37.866626] vhci_hcd: release socket
>[   37.867101] vhci_hcd: disconnect device
>[   37.867675] vhci_hcd: stop threads
>[   37.868134] vhci_hcd: release socket
>[   37.868614] vhci_hcd: disconnect device
>[   37.869126] vhci_hcd: stop threads
>[   37.869612] vhci_hcd: release socket
>[   37.870090] vhci_hcd: disconnect device
>[   37.870628] vhci_hcd: stop threads
>[   37.871092] vhci_hcd: release socket
>[   37.871603] vhci_hcd: disconnect device
>[   37.872113] vhci_hcd: stop threads
>[   37.874477] vhci_hcd: release socket
>[   37.874957] vhci_hcd: disconnect device
>[   37.875557] vhci_hcd: stop threads
>[   37.876021] vhci_hcd: release socket
>[   37.876497] vhci_hcd: disconnect device
>[   37.877012] vhci_hcd: stop threads
>[   37.877460] vhci_hcd: release socket
>[   37.877941] vhci_hcd: disconnect device
>[   37.878451] vhci_hcd: stop threads
>[   37.878923] vhci_hcd: release socket
>[   37.879410] vhci_hcd: disconnect device
>[   37.879922] vhci_hcd vhci_hcd.0: USB bus 2 deregistered
>[   37.880869] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
>[   37.881745] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 2
>[   37.882681] vhci_hcd: created sysfs vhci_hcd.0
>[   37.883874] hub 2-0:1.0: USB hub found
>[   37.884406] hub 2-0:1.0: 8 ports detected
>[   37.886227] hub 2-0:1.0: USB hub found
>[   37.886777] hub 2-0:1.0: 8 ports detected
>[   37.889014] hub 2-0:1.0: USB hub found
>[   37.889548] hub 2-0:1.0: 8 ports detected
>[   37.891459] hub 2-0:1.0: USB hub found
>[   37.892038] hub 2-0:1.0: 8 ports detected
>[   37.893456] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
>[   37.894346] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 3
>[   37.895372] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
>[   37.896937] hub 3-0:1.0: USB hub found
>[   37.897474] hub 3-0:1.0: 8 ports detected
>[   37.899803] hub 3-0:1.0: USB hub found
>[   37.900353] hub 3-0:1.0: 8 ports detected
>[   37.902954] hub 3-0:1.0: USB hub found
>[   37.903556] hub 3-0:1.0: 8 ports detected
>[   37.905759] hub 3-0:1.0: USB hub found
>[   37.906292] hub 3-0:1.0: 8 ports detected
>[   37.908030] usbcore: registered new device driver usbip-host
>[   37.909195] usbip-vudc usbip-vudc.0: unregistering gadget
>[   37.910005] udc usbip-vudc.0: releasing 'usbip-vudc.0'
>[   37.910698]  gadget: usb_udc_nop_release
>[   37.911599] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
>[   37.913370] serio: i8042 KBD port at 0x60,0x64 irq 1
>[   37.914174] serio: i8042 AUX port at 0x60,0x64 irq 12
>[   37.915262] usb usb1: dummy_bus_suspend
>[   37.919209] hub 1-0:1.0: hub_ext_port_status failed (err = -113)
>[   37.955643] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
>[   37.957913] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
>[   37.959727] usbcore: registered new interface driver appletouch
>[   37.960488] usbcore: registered new interface driver bcm5974
>[   37.962021] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input6
>[   37.963772] usbcore: registered new interface driver xpad
>[   37.964725] i2c /dev entries driver
>[   37.965535] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
>[   37.966912] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input5
>[   37.969688] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input8
>[   37.971424] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input7
>[   37.979778] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
>[   37.991949] usbcore: registered new interface driver i2c-diolan-u2c
>[   37.992754] i2c-parport: adapter type unspecified
>[   37.993342] i2c-parport-light: adapter type unspecified
>[   37.994028] usbcore: registered new interface driver RobotFuzz Open Source InterFace, OSIF
>[   37.995080] usbcore: registered new interface driver i2c-tiny-usb
>[   37.996265] isa i2c-pca-isa.0: Please specify I/O base
>[   37.997194] pps_ldisc: PPS line discipline registered
>[   37.997829] pps_parport: parallel port PPS client
>[   37.998406] parport1: cannot grant exclusive access for device pps_parport
>[   37.999228] pps_parport: couldn't register with parport1
>[   37.999969] Driver for 1-wire Dallas network protocol.
>[   38.000782] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
>[   38.001587] w1_f0d_init()
>[   38.011331] hub 3-0:1.0: hub_ext_port_status failed (err = -113)
>[   38.095410] w83781d: Detection failed at step 2
>[   38.731560] applesmc: supported laptop not found!
>[   38.732180] applesmc: driver init failed (ret=-19)!
>[   39.783998] pc87360: PC8736x not detected, module not inserted
>[   39.785641] sch56xx_common: Unsupported device id: 0xff
>[   39.786895] sch56xx_common: Unsupported device id: 0xff
>[   39.980572] mixcomwd: No card detected, or port not available
>[   39.981411] usbcore: registered new interface driver pcwd_usb
>[   39.982271] acquirewdt: WDT driver for Acquire single board computer initialising
>[   39.983450] acquirewdt: I/O address 0x0043 already in use
>[   39.984145] acquirewdt: probe of acquirewdt failed with error -5
>[   39.984994] advantechwdt: WDT driver for Advantech single board computer initialising
>[   39.986329] advantechwdt: initialized. timeout=60 sec (nowayout=0)
>[   39.987144] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
>[   39.987844] alim7101_wdt: ALi M7101 PMU not present - WDT not set
>[   39.988581] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
>[   39.989831] geodewdt: No timers were available
>[   39.990533] wafer5823wdt: WDT driver for Wafer 5823 single board computer initialising
>[   39.991505] wafer5823wdt: I/O address 0x0443 already in use
>[   39.992195] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
>[   39.993090] iTCO_vendor_support: vendor-support=0
>[   39.994108] it87_wdt: no device
>[   39.994599] sc1200wdt: build 20020303
>[   39.995138] sc1200wdt: io parameter must be specified
>[   39.995825] pc87413_wdt: Version 1.1 at io 0x2E
>[   39.996424] pc87413_wdt: cannot register miscdev on minor=130 (err=-16)
>[   39.997296] sbc60xxwdt: I/O address 0x0443 already in use
>[   39.997996] sbc7240_wdt: I/O address 0x0443 already in use
>[   39.998731] cpu5wdt: misc_register failed
>[   39.999263] smsc37b787_wdt: SMsC 37B787 watchdog component driver 1.1 initialising...
>[   40.001390] smsc37b787_wdt: Unable to register miscdev on minor 130
>[   40.002488] w83877f_wdt: I/O address 0x0443 already in use
>[   40.003245] machzwd: MachZ ZF-Logic Watchdog driver initializing
>[   40.004027] machzwd: no ZF-Logic found
>[   40.004546] sbc_epx_c3: cannot register miscdev on minor=130 (err=-16)
>[   40.005794] watchdog: Software Watchdog: cannot register miscdev on minor=130 (err=-16).
>[   40.006853] watchdog: Software Watchdog: a legacy watchdog module is probably present.
>[   40.008082] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
>[   40.018137] ISDN subsystem Rev: 1.1.2.3/
>[   40.018143] 1.1.2.2/
>[   40.018730] none/
>[   40.019072] none/
>[   40.019388] 1.1.2.2
>[   40.019705]
>[   40.020390] Modular ISDN core version 1.1.29
>[   40.021200] NET: Registered protocol family 34
>[   40.021798] DSP module 2.0
>[   40.022194] mISDN_dsp: DSP clocks every 64 samples. This equals 2 jiffies.
>[   40.024463] mISDN: Layer-1-over-IP driver Rev. 2.00
>[   40.025288] 0 virtual devices registered
>[   40.025832] mISDN: HFC-multi driver 2.03
>[   40.026472] usbcore: registered new interface driver HFC-S_USB
>[   40.027215] AVM Fritz PCI driver Rev. 2.3
>[   40.027830] Infineon ISDN Driver Rev. 1.0
>[   40.028420] Winbond W6692 PCI driver Rev. 2.0
>[   40.029073] Netjet PCI driver Rev. 2.0
>[   40.029649] mISDNipac module version 2.0
>[   40.030187] HiSax: Linux Driver for passive ISDN cards
>[   40.030866] HiSax: Version 3.5 (kernel)
>[   40.031392] HiSax: Layer1 Revision 2.46.2.5
>[   40.032030] HiSax: Layer2 Revision 2.30.2.4
>[   40.032616] HiSax: TeiMgr Revision 2.20.2.3
>[   40.033180] HiSax: Layer3 Revision 2.22.2.3
>[   40.033754] HiSax: LinkLayer Revision 2.59.2.4
>[   40.034378] HiSax: Total 1 card defined
>[   40.035004] HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
>[   40.035675] HiSax: Traverse Tech. NETspider-U driver Rev. 2.14.2.3
>[   40.036611] NETspider-U: No PCI card found
>[   40.037226] HiSax: Card NETspider-U not installed !
>[   40.037875] HFC-S USB: driver module revision 2.3.2.24 date 2007/10/14 loaded, (debug=0)
>[   40.038991] usbcore: registered new interface driver hfc_usb
>[   40.039730] HFC-4S/8S: Layer 1 driver module for HFC-4S/8S isdn chips, Revision: 1.10
>[   40.040834] HFC-4S/8S: (C) 2003 Cornelius Consult, www.cornelius-consult.de
>[   40.041802] HFC-4S/8S: found 0 cards
>[   40.042309] hisax_isac: ISAC-S/ISAC-SX ISDN driver v0.1.0
>[   40.043000] hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1
>[   40.043875] Error: Driver 'fcpci' is already registered, aborting...
>[   40.044866] sdhci: Secure Digital Host Controller Interface driver
>[   40.045640] sdhci: Copyright(c) Pierre Ossman
>[   40.046257] wbsd: Winbond W83L51xD SD/MMC card interface driver
>[   40.047005] wbsd: Copyright(c) Pierre Ossman
>[   40.047703] usbcore: registered new interface driver ushc
>[   40.048554] sdhci-pltfm: SDHCI platform and OF driver helper
>[   40.050738] ledtrig-cpu: registered to indicate activity on CPUs
>[   40.052384] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
>[   40.053499] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
>[   40.054512] cs5535-clockevt: Could not allocate MFGPT timer
>[   40.060097] usbcore: registered new interface driver usbhid
>[   40.060834] usbhid: USB HID core driver
>[   40.061745] NET: Registered protocol family 40
>[   40.062554] usbcore: registered new interface driver prism2_usb
>[   40.063300] comedi: version 0.7.76 - http://www.comedi.org
>[   40.065503] usbcore: registered new interface driver ni6501
>[   40.066291] usbcore: registered new interface driver usbduxfast
>[   40.067103] usbcore: registered new interface driver usbduxsigma
>[   40.067957] usbcore: registered new interface driver vmk80xx
>[   40.079990] no options.
>[   40.080689] input: Speakup as /devices/virtual/input/input9
>[   40.081828] initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
>[   40.082749] speakup 3.1.6: initialized
>[   40.083291] synth name on entry is: (null)
>[   40.084101] ashmem: initialized
>[   40.084642] FPGA DOWNLOAD --->
>[   40.085085] FPGA image file name: xlinx_fpga_firmware.bit
>[   40.086018] GPIO INIT FAIL!!
>[   40.087726] mostcore: init()
>[   40.088329] aim_cdev: init()
>[   40.088827] mostcore: registered new application interfacing module cdev
>[   40.089783] usbcore: registered new interface driver hdm_usb
>[   40.090709] usbcore: registered new interface driver es2_ap_driver
>[   40.091573] greybus: registered new driver gb-firmware
>[   40.092267] greybus: registered new driver hid
>[   40.092915] greybus: registered new driver loopback
>[   40.093595] greybus: registered new driver power_supply
>[   40.094311] greybus: registered new driver gbphy
>[   40.094939] gb_gbphy: registered new driver gpio
>[   40.095564] gb_gbphy: registered new driver i2c
>[   40.096200] gb_gbphy: registered new driver sdio
>[   40.096835] gb_gbphy: registered new driver spi
>[   40.097468] gb_gbphy: registered new driver uart
>[   40.098100] gb_gbphy: registered new driver usb
>[   40.099463] Software Queue-Pair Transport over NTB, version 4
>[   40.109292] ASIHPI driver 4.14.03
>[   40.111542] usbcore: registered new interface driver snd-ua101
>[   40.112366] usbcore: registered new interface driver snd-usb-us122l
>[   40.113196] usbcore: registered new interface driver snd-usb-6fire
>[   40.114016] usbcore: registered new interface driver snd-usb-hiface
>[   40.114844] usbcore: registered new interface driver snd-bcd2000
>[   40.115650] usbcore: registered new interface driver snd_usb_pod
>[   40.116492] usbcore: registered new interface driver snd_usb_podhd
>[   40.117320] usbcore: registered new interface driver snd_usb_toneport
>[   40.118169] usbcore: registered new interface driver snd_usb_variax
>[   40.118951] oprofile: using NMI interrupt.
>[   40.119650] NET: Registered protocol family 26
>[   40.120327] NET: Registered protocol family 17
>[   40.120945] NET: Registered protocol family 15
>[   40.121622] NET: Registered protocol family 5
>[   40.125156] NET: Registered protocol family 11
>[   40.125841] NET: Registered protocol family 3
>[   40.126443] NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team
>[   40.127578] DECnet: Routing cache hash table of 512 buckets, 22Kbytes
>[   40.128474] NET: Registered protocol family 12
>[   40.129154] NET: Registered protocol family 35
>[   40.129839] 8021q: 802.1Q VLAN Support v1.8
>[   40.130443] lib80211: common routines for IEEE802.11 drivers
>[   40.131173] lib80211_crypt: registered algorithm 'NULL'
>[   40.131882] 9pnet: Installing 9P2000 support
>[   40.132563] Key type dns_resolver registered
>[   40.133248] start plist test
>[   40.138357] end plist test
>[   40.140662] ... APIC ID:      00000000 (0)
>[   40.141219] ... APIC VERSION: 01050014
>[   40.141748] 0000000000000000000000000000000000000000000000000000000000000000
>[   40.142655] 0000000000000000000000000000000000000000000000000000000000000000
>[   40.143561] 0000000000000000000000000000000000000000000000000000000000000000
>[   40.144493] number of MP IRQ sources: 15.
>[   40.145046] number of IO-APIC #0 registers: 24.
>[   40.145643] testing the IO APIC.......................
>[   40.146325] IO APIC #0......
>[   40.146777] .... register #00: 00000000
>[   40.147295] .......    : physical APIC id: 00
>[   40.147895] .......    : Delivery Type: 0
>[   40.148438] .......    : LTS          : 0
>[   40.148981] .... register #01: 00170011
>[   40.149501] .......     : max redirection entries: 17
>[   40.150152] .......     : PRQ implemented: 0
>[   40.150768] .......     : IO APIC version: 11
>[   40.151339] .... register #02: 00000000
>[   40.151869] .......     : arbitration: 00
>[   40.152409] .... IRQ redirection table:
>[   40.152933] IOAPIC 0:
>[   40.153296]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.154285]  pin01, enabled , edge , high, V(31), IRR(0), S(0), logical , D(01), M(1)
>[   40.155286]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(1)
>[   40.156306]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.157314]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.158315]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.159306]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.160323]  pin07, enabled , edge , high, V(37), IRR(0), S(0), logical , D(01), M(1)
>[   40.161340]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.162345]  pin09, enabled , level, high, V(39), IRR(0), S(0), logical , D(01), M(1)
>[   40.163339]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.164376]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.165369]  pin0c, enabled , edge , high, V(3C), IRR(0), S(0), logical , D(01), M(1)
>[   40.166370]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.167394]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.168405]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.169413]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.170412]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.171413]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.172428]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.173436]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.174435]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.175444]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.176452]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
>[   40.177446] IRQ to pin mappings:
>[   40.177906] IRQ0 -> 0:2
>[   40.178284] IRQ1 -> 0:1
>[   40.178664] IRQ3 -> 0:3
>[   40.179045] IRQ4 -> 0:4
>[   40.179423] IRQ5 -> 0:5
>[   40.179802] IRQ6 -> 0:6
>[   40.180208] IRQ7 -> 0:7
>[   40.180593] IRQ8 -> 0:8
>[   40.180967] IRQ9 -> 0:9
>[   40.181341] IRQ10 -> 0:10
>[   40.181736] IRQ11 -> 0:11
>[   40.182135] IRQ12 -> 0:12
>[   40.182535] IRQ13 -> 0:13
>[   40.182928] IRQ14 -> 0:14
>[   40.183326] IRQ15 -> 0:15
>[   40.183723] .................................... done.
>[   40.184396] Using IPI Shortcut mode
>[   40.184906] sched_clock: Marking stable (40184390540, 0)->(40597043268, -412652728)
>[   40.186432] page_owner is disabled
>[   40.187785] cryptomgr_probe (149) used greatest stack depth: 6780 bytes left
>[   40.188724] Key type big_key registered
>[   40.189456] Key type trusted registered
>[   40.190219] Key type encrypted registered
>[   40.190785] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
>[   40.191647] evm: HMAC attrs: 0x0
>[   40.192485] RIO: rio_register_scan for mport_id=-1
>[   40.193307]   Magic number: 9:649:737
>[   40.193828] stm dummy_stm.2: hash matches
>[   40.194765] console [netcon0] enabled
>[   40.195274] netconsole: network logging started
>[   40.196045] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
>[   40.196816] EDD information not available.
>[   40.197477] ALSA device list:
>[   40.197916]   No soundcards found.
>[   40.199775] Freeing unused kernel memory: 1120K
>[   40.201478] Write protecting the kernel text: 34360k
>[   40.202910] Write protecting the kernel read-only data: 15736k
>[   40.203638] rodata_test: all tests were successful
>[   40.265418] init: Console is alive
>[   40.267465] init: - watchdog -
>[   41.272460] init: - preinit -
>[   41.287479] procd: - early -
>[   41.288552] procd: - watchdog -
>[   41.397305] hotplug-call (169) used greatest stack depth: 6728 bytes left
>[   41.657548] hotplug-call (227) used greatest stack depth: 6600 bytes left
>[   41.968387] udevtrigger (161) used greatest stack depth: 6548 bytes left
>[   42.466238] procd: - ubus -
>[   43.473608] procd: - init -
>Please press Enter to activate this console.
>[   45.117766] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>[   45.122174] 8021q: adding VLAN 0 to HW filter on device eth0
>[   45.247159]
>[   45.247451] =====================================
>[   45.248021] WARNING: bad unlock balance detected!
>[   45.248608] 4.14.0-rc8 #158 Not tainted
>[   45.249087] -------------------------------------
>[   45.249672] fw3/1183 is trying to release lock (rcu_preempt_state) at:
>[   45.250443] [<c10e4348>] rcu_read_unlock_special+0x5f8/0x620
>[   45.251136] but there are no more locks to release!
>[   45.251752]
>[   45.251752] other info that might help us debug this:
>[   45.252561] 1 lock held by fw3/1183:
>[   45.253019]  #0:  (rcu_read_lock){....}, at: [<c16e24c0>] aa_file_perm+0x0/0x460
>[   45.253925]
>[   45.253925] stack backtrace:
>[   45.254526] CPU: 0 PID: 1183 Comm: fw3 Not tainted 4.14.0-rc8 #158
>[   45.255275] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>[   45.256266] Call Trace:
>[   45.256628]  dump_stack+0x16/0x1c
>[   45.257082]  print_unlock_imbalance_bug+0xb9/0xd0
>[   45.257676]  ? rcu_read_unlock_special+0x5f8/0x620
>[   45.258259]  ? rcu_read_unlock_special+0x5f8/0x620
>[   45.258871]  lock_release+0x1cc/0x490
>[   45.259347]  ? rcu_read_unlock_special+0x5f8/0x620
>[   45.259969]  ? _raw_spin_unlock_irqrestore+0x86/0xd0
>[   45.260581]  rt_mutex_unlock+0x1e/0xb0
>[   45.261054]  rcu_read_unlock_special+0x5f8/0x620
>[   45.261643]  __rcu_read_unlock+0xa7/0xb0
>[   45.262152]  aa_file_perm+0x5a/0x460
>[   45.262633]  ? pvclock_clocksource_read+0xd5/0x230
>[   45.263203]  ? pvclock_clocksource_read+0xd5/0x230
>[   45.263797]  common_file_perm+0x81/0x240
>[   45.264308]  ? kvm_sched_clock_read+0x9/0x20
>[   45.264843]  common_mmap+0x93/0xd0
>[   45.265283]  ? apparmor_file_mprotect+0x30/0x30
>[   45.265867]  apparmor_mmap_file+0x12/0x20
>[   45.266388]  security_mmap_file+0xaf/0x170
>[   45.266903]  vm_mmap_pgoff+0x35/0x100
>[   45.267381]  ? __fget+0x1c3/0x1d0
>[   45.267831]  SyS_mmap_pgoff+0x16d/0x370
>[   45.268318]  do_int80_syscall_32+0x95/0x290
>[   45.268840]  entry_INT80_32+0x2f/0x2f
>[   45.269313] EIP: 0xb7f7c2d4
>[   45.269713] EFLAGS: 00000202 CPU: 0
>[   45.270169] EAX: ffffffda EBX: b7f63000 ECX: 000002ad EDX: 00000003
>[   45.270901] ESI: 00000012 EDI: 00000003 EBP: 00000004 ESP: bff29f24
>[   45.271637]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b
>[   45.351763] 8021q: adding VLAN 0 to HW filter on device eth0
>LKP: HOSTNAME vm-lkp-nhm-dp1-openwrt-ia32-6, MAC , kernel 4.14.0-rc8 158, serial console /dev/ttyS0
>[   47.390581] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
>[   47.488179] 8021q: adding VLAN 0 to HW filter on device eth0
>[   48.930277] sysrq: SysRq : Emergency Sync
>[   48.930957] sysrq: SysRq : Resetting
>
>Elapsed time: 50
>
>initrds=(
>	/osimage/openwrt/openwrt-i386-2016-03-16.cgz
>	/lkp/scheduled/vm-lkp-nhm-dp1-openwrt-ia32-6/trinity-300s-openwrt-i386-2016-03-16.cgz-39dae59d66acd86d1de24294bd2f343fd5e7a625-20171106-69114-np2qmk-0.cgz
>	/lkp/lkp/lkp-i386.cgz
>	/osimage/pkg/static/trinity-i386.cgz
>)
>
>cat "${initrds[@]}" > /fs/sda3/initrd-vm-lkp-nhm-dp1-openwrt-ia32-6
>
>kvm=(
>	qemu-system-x86_64
>	-enable-kvm
>	-kernel /pkg/linux/i386-randconfig-b0-11061302/gcc-5/39dae59d66acd86d1de24294bd2f343fd5e7a625/vmlinuz-4.14.0-rc8
>	-initrd /fs/sda3/initrd-vm-lkp-nhm-dp1-openwrt-ia32-6
>	-m 420
>	-smp 1
>	-device e1000,netdev=net0
>	-netdev user,id=net0
>	-boot order=nc
>	-no-reboot
>	-watchdog i6300esb
>	-watchdog-action debug
>	-rtc base=localtime
>	-pidfile /dev/shm/kboot/pid-vm-lkp-nhm-dp1-openwrt-ia32-6
>	-serial file:/dev/shm/kboot/vm-lkp-nhm-dp1-openwrt-ia32-6/serial
>	-serial file:/dev/shm/kboot/vm-lkp-nhm-dp1-openwrt-ia32-6/kmsg
>	-daemonize
>	-display none
>	-monitor null
>)
>
>append=(
>	ip=::::vm-lkp-nhm-dp1-openwrt-ia32-6::dhcp
>	root=/dev/ram0
>	user=lkp
>	job=/lkp/scheduled/vm-lkp-nhm-dp1-openwrt-ia32-6/trinity-300s-openwrt-i386-2016-03-16.cgz-39dae59d66acd86d1de24294bd2f343fd5e7a625-20171106-69114-np2qmk-0.yaml
>	ARCH=i386
>	kconfig=i386-randconfig-b0-11061302
>	branch=linus/master
>	commit=39dae59d66acd86d1de24294bd2f343fd5e7a625
>	BOOT_IMAGE=/pkg/linux/i386-randconfig-b0-11061302/gcc-5/39dae59d66acd86d1de24294bd2f343fd5e7a625/vmlinuz-4.14.0-rc8
>	max_uptime=1500
>	RESULT_ROOT=/result/trinity/300s/vm-lkp-nhm-dp1-openwrt-ia32/openwrt-i386-2016-03-16.cgz/i386-randconfig-b0-11061302/gcc-5/39dae59d66acd86d1de24294bd2f343fd5e7a625/0
>	LKP_SERVER=inn
>	debug
>	apic=debug
>	sysrq_always_enabled
>	rcupdate.rcu_cpu_stall_timeout=100
>	net.ifnames=0
>	printk.devkmsg=on
>	panic=-1
>	softlockup_panic=1
>	nmi_watchdog=panic
>	oops=panic
>	load_ramdisk=2
>	prompt_ramdisk=0
>	drbd.minor_count=8
>	systemd.log_level=err
>	ignore_loglevel
>	console=tty0
>	earlyprintk=ttyS0,115200
>	console=ttyS0,115200
>	vga=normal
>	rw
>	drbd.minor_count=8
>)
>
>"${kvm[@]}" -append "${append[*]}"

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
