From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 8 Jan 2018 13:18:34 +0200
Subject: [GIT PULL] tpmdd updates for v4.16
Message-ID: <20180108111834.azjo6hdbm62el4qj@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Sorry for a late PR.

Summary of the content:

* Reduced polling delays in tpm_tis.
* Support for retrieving TPM 2.0 Event Log through EFI before
  ExitBootServices.
* Replaced tpm-rng.c with a hwrng device managed by the driver for each
  TPM device.
* TPM resource manager synthesizes TPM_RC_COMMAND_CODE response instead
  of returning -EINVAL for unknown TPM commands. This makes user space
  more sound.
* CLKRUN fixes:
  * Keep #CLKRUN disable through the entier TPM command/response flow.
  * Check whether #CLKRUN is enabled before disabling and enabling it
    again because enabling it breaks PS/2 devices on a system where it
    is disabled.

/Jarkko

The following changes since commit d21bd6898336a7892914d308d5e0868f0b863571:

  Sync to v4.15-rc3 for security subsystem developers to work against. (2017-12-11 17:01:08 +1100)

are available in the git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180108

for you to fetch changes up to 68021bf4734d15c9a9ed1c1072b9ebcfda3e39cc:

  tpm: remove unused variables (2018-01-08 12:58:54 +0200)

----------------------------------------------------------------
tpmdd updates for Linux 4.16

----------------------------------------------------------------
Alexander.Steffen at infineon.com (1):
      tpm2-cmd: allow more attempts for selftest execution

Arnd Bergmann (1):
      tpm: remove unused variables

Azhar Shaikh (2):
      tpm_tis: Move ilb_base_addr to tpm_tis_data
      tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()

Jarkko Sakkinen (1):
      tpm: use struct tpm_chip for tpm_chip_find_get()

Jason Gunthorpe (2):
      tpm: Move Linux RNG connection to hwrng
      tpm: Update MAINTAINERS for Jason Gunthorpe

Javier Martinez Canillas (5):
      tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented
      tpm: delete the TPM_TIS_CLK_ENABLE flag
      tpm: follow coding style for variable declaration in tpm_tis_core_init()
      tpm: only attempt to disable the LPC CLKRUN if is already enabled
      tpm: remove unused data fields from I2C and OF device ID tables

Nayna Jain (3):
      tpm: move wait_for_tpm_stat() to respective driver files
      tpm: reduce tpm polling delay in tpm_tis_core
      tpm: use tpm_msleep() value as max delay

Thiebaud Weksteen (5):
      tpm: move tpm_eventlog.h outside of drivers folder
      tpm: rename event log provider files
      tpm: add event log format version
      efi: call get_event_log before ExitBootServices
      tpm: parse TPM event logs based on EFI table

 MAINTAINERS                                        |   3 +-
 arch/x86/boot/compressed/eboot.c                   |   1 +
 drivers/char/hw_random/Kconfig                     |  13 --
 drivers/char/hw_random/Makefile                    |   1 -
 drivers/char/hw_random/tpm-rng.c                   |  50 -----
 drivers/char/tpm/Kconfig                           |  11 +
 drivers/char/tpm/Makefile                          |   5 +-
 drivers/char/tpm/tpm-chip.c                        |  67 ++++--
 drivers/char/tpm/tpm-interface.c                   | 231 +++++++++------------
 drivers/char/tpm/tpm.h                             |  52 ++++-
 drivers/char/tpm/tpm1_eventlog.c                   |  13 +-
 drivers/char/tpm/tpm2-cmd.c                        |  12 +-
 drivers/char/tpm/tpm2_eventlog.c                   |   2 +-
 .../char/tpm/{tpm_acpi.c => tpm_eventlog_acpi.c}   |   4 +-
 drivers/char/tpm/tpm_eventlog_efi.c                |  66 ++++++
 drivers/char/tpm/{tpm_of.c => tpm_eventlog_of.c}   |   6 +-
 drivers/char/tpm/tpm_i2c_infineon.c                |  27 +--
 drivers/char/tpm/tpm_tis.c                         | 108 ----------
 drivers/char/tpm/tpm_tis_core.c                    | 193 ++++++++++++++++-
 drivers/char/tpm/tpm_tis_core.h                    |  16 ++
 drivers/char/tpm/xen-tpmfront.c                    |  61 ++++++
 drivers/firmware/efi/Makefile                      |   2 +-
 drivers/firmware/efi/efi.c                         |   4 +
 drivers/firmware/efi/libstub/Makefile              |   3 +-
 drivers/firmware/efi/libstub/tpm.c                 |  81 ++++++++
 drivers/firmware/efi/tpm.c                         |  40 ++++
 include/linux/efi.h                                |  46 ++++
 include/linux/tpm.h                                |  39 ++--
 {drivers/char/tpm => include/linux}/tpm_eventlog.h |  34 +--
 security/integrity/ima/ima_crypto.c                |   2 +-
 security/integrity/ima/ima_init.c                  |   2 +-
 security/integrity/ima/ima_queue.c                 |   2 +-
 security/keys/trusted.c                            |  35 ++--
 33 files changed, 789 insertions(+), 443 deletions(-)
 delete mode 100644 drivers/char/hw_random/tpm-rng.c
 rename drivers/char/tpm/{tpm_acpi.c => tpm_eventlog_acpi.c} (97%)
 create mode 100644 drivers/char/tpm/tpm_eventlog_efi.c
 rename drivers/char/tpm/{tpm_of.c => tpm_eventlog_of.c} (93%)
 create mode 100644 drivers/firmware/efi/tpm.c
 rename {drivers/char/tpm => include/linux}/tpm_eventlog.h (78%)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
