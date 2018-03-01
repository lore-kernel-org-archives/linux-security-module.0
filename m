From: dhowells@redhat.com (David Howells)
Date: Thu, 01 Mar 2018 11:06:55 +0000
Subject: linux-next: UEFI Secure boot lockdown patchset
Message-ID: <26787.1519902415@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Hi Stephen,

Can you pull the following branch into linux-next please?  It does three
things:

 (1) It restricts various accesses userspace may make upon the kernel when the
     kernel is locked down.

 (2) It engages the lockdown if UEFI Secure Boot mode is detected.

 (3) It passes the UEFI Secure Boot mode indication across kexec.

The restrictions include:

 - Enforcing the use of module signatures
 - Enforcing the use of kexec image signatures
 - Requring IMA to use secure boot rules
 - Disabling:
   - The kexec_load() syscall
   - Use of /dev/{mem,kmem,port,kcore}
   - Hibernation
   - PCI BAR access
   - Direct I/O port access
 - Preventing direct port specification in drivers:
   - SCSI EATA
   - TIOCSSERIAL
   - Module parameters
 - Restricting:
   - MSR access
   - Certain ACPI features
   - kprobes
   - BPF
   - Perf
   - Debugfs

The aim of the restrictions is twofold:

  (1) Prevent userspace from altering the kernel image directly (eg. by
      /dev/mem) or indirectly (eg. by manipulating a device to do DMA);

  (2) Prevent userspace from accessing crypto data stored in the kernel
      (eg. filesystem keys).

A warning is logged if a restriction is triggered for which I've written a
manpage that is referenced in the message (see attached).

David
