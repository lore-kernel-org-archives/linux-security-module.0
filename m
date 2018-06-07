From: jmorris@namei.org (James Morris)
Date: Fri, 8 Jun 2018 03:51:26 +1000 (AEST)
Subject: [GIT PULL] Security subsystem: TPM updates for v4.18
Message-ID: <alpine.LRH.2.21.1806080346090.27121@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these updates for the TPM subsystem.

>From Jarkko: "this purely a bug fix release. The only major change is to 
move the event log code to its own subdirectory because there starts to be 
so much of it."

---

The following changes since commit 890e2abe1028c39e5399101a2c277219cd637aaa:

  dh key: get rid of stack allocated array for zeroes (2018-05-11 13:07:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to 2d06236ab3276000665ef55eccc111c3bbf90589:

  Merge tag 'tpmdd-next-20180602' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2018-06-04 09:08:21 -0700)

----------------------------------------------------------------
Colin Ian King (2):
      tpm: st33zp24: remove redundant null check on chip
      tpm/st33zp24: Fix spelling mistake in macro ST33ZP24_TISREGISTER_UKNOWN

James Morris (2):
      Merge tag 'tpmdd-next-20180518' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm
      Merge tag 'tpmdd-next-20180602' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

Jerry Snitselaar (1):
      tpm_tis: verify locality released before returning from release_locality

Ji-Hun Kim (2):
      tpm: replace kmalloc() + memcpy() with kmemdup()
      tpm: replace kmalloc() + memcpy() with kmemdup()

Nayna Jain (3):
      tpm: move the delay_msec increment after sleep in tpm_transmit()
      tpm: reduce poll sleep time in tpm_transmit()
      tpm: reduce polling time to usecs for even finer granularity

Tadeusz Struk (2):
      tpm: fix use after free in tpm2_load_context()
      tpm: fix race condition in tpm_common_write()

Thiebaud Weksteen (4):
      tpm: Add explicit endianness cast
      tpm: Move eventlog files to a subdirectory
      tpm: Move shared eventlog functions to common.c
      tpm: Move eventlog declarations to its own header

Winkler, Tomas (1):
      tpm: tpm_crb: relinquish locality on error path.

 drivers/char/tpm/Makefile                          |  10 +-
 .../tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c}   |   3 +-
 drivers/char/tpm/eventlog/common.c                 | 195 ++++++++++++++++++++
 drivers/char/tpm/eventlog/common.h                 |  35 ++++
 .../tpm/{tpm_eventlog_efi.c => eventlog/efi.c}     |   6 +-
 .../char/tpm/{tpm_eventlog_of.c => eventlog/of.c}  |  11 +-
 .../char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c}  | 200 ++-------------------
 .../char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c}  |   3 +-
 drivers/char/tpm/st33zp24/spi.c                    |   4 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |   2 -
 drivers/char/tpm/tpm-dev-common.c                  |  40 ++---
 drivers/char/tpm/tpm-dev.h                         |   2 +-
 drivers/char/tpm/tpm-interface.c                   |   5 +-
 drivers/char/tpm/tpm.h                             |  32 +---
 drivers/char/tpm/tpm2-space.c                      |   3 +-
 drivers/char/tpm/tpm_crb.c                         |  10 +-
 drivers/char/tpm/tpm_tis_core.c                    |  58 +++++-
 17 files changed, 350 insertions(+), 269 deletions(-)
 rename drivers/char/tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c} (98%)
 create mode 100644 drivers/char/tpm/eventlog/common.c
 create mode 100644 drivers/char/tpm/eventlog/common.h
 rename drivers/char/tpm/{tpm_eventlog_efi.c => eventlog/efi.c} (91%)
 rename drivers/char/tpm/{tpm_eventlog_of.c => eventlog/of.c} (91%)
 rename drivers/char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c} (58%)
 rename drivers/char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c} (99%)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
