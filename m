From: jmorris@namei.org (James Morris)
Date: Mon, 29 Jan 2018 10:41:18 +1100 (AEDT)
Subject: [GIT PULL] Security subsystem updates for v4.16
Message-ID: <alpine.LRH.2.21.1801291040280.29680@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these updates for the security subsystem.

Summary:

- Integrity (from Mimi Zohar)

  "This pull request contains a mixture of bug fixes, code cleanup, and
  new functionality.  Of note is the integrity cache locking fix, file
  change detection, and support for a new EVM portable and immutable
  signature type.
 
  The re-introduction of the integrity cache lock (iint) fixes the
  problem of attempting to take the i_rwsem shared a second time, when it
  was previously taken exclusively.  Defining atomic flags resolves the
  original iint/i_rwsem circular locking - accessing the file data vs.
  modifying the file metadata.  Although it fixes the O_DIRECT problem as
  well, a subsequent patch is needed to remove the explicit O_DIRECT
  prevention.
 
  For performance reasons, detecting when a file has changed and needs to
  be re-measured, re-appraised, and/or re-audited, was limited to after
  the last writer has closed, and only if the file data has changed.
  Detecting file change is based on i_version.  For filesystems that do
  not support i_version, remote filesystems, or userspace filesystems,
  the file was measured, appraised and/or audited once and never
  re-evaluated.  Now local filesystems, which do not support i_version or
  are not mounted with the i_version option, assume the file has changed
  and are required to re-evaluate the file.  This change does not address
  detecting file change on remote or userspace filesystems.
 
  Unlike file data signatures, which can be included and distributed in
  software packages (eg. rpm, deb), the existing EVM signature, which
  protects the file metadata, could not be included in software packages,
  as it includes file system specific information (eg. i_ino, possibly
  the UUID).  This pull request defines a new EVM portable and immutable
  file metadata signature format, which can be included in software
  packages."


- Smack (from Casey Schaufler)

 Two minor fixes.


- TPM (from Jarkko Sakkinen)

  "* Reduced polling delays in tpm_tis.
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
      is disabled."


Note that individual trees may also be pulled via:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
        next-integrity
        next-smack
        next-tpm

FYI, I have also tested the above along with the now externally submitted 
SELinux and Smack trees, with recent -rc and KPTI enabled, with no issues 
found.


The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-v4.16

for you to fetch changes up to 400f428062af7e9200ff15dce2ef3c01ff007d96:

  Merge branch 'next-integrity' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into next-testing (2018-01-19 13:59:01 +1100)

----------------------------------------------------------------
Alexander.Steffen at infineon.com (1):
      tpm2-cmd: allow more attempts for selftest execution

Arnd Bergmann (1):
      tpm: remove unused variables

Azhar Shaikh (2):
      tpm_tis: Move ilb_base_addr to tpm_tis_data
      tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()

Bruno E. O. Meneguele (1):
      ima: log message to module appraisal error

Casey Schaufler (1):
      Smack: Privilege check on key operations

Dmitry Kasatkin (1):
      ima: re-introduce own integrity cache lock

James Morris (8):
      Merge tag 'v4.15-rc1' into next-testing
      Merge tag 'seccomp-next' of https://git.kernel.org/.../kees/linux into next-testing
      Sync to v4.15-rc3 for security subsystem developers to work against.
      Merge branch 'next-general' into next-testing
      Merge branch 'next-integrity' of git://git.kernel.org/.../zohar/linux-integrity into next-testing
      Merge tag 'tpmdd-next-20180108' of git://git.infradead.org/users/jjs/linux-tpmdd into next-testing
      Merge branch 'smack-for-4.16' of git://github.com/cschaufler/next-smack into next-testing
      Merge branch 'next-integrity' of git://git.kernel.org/.../zohar/linux-integrity into next-testing

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

Jeff Layton (1):
      integrity: remove unneeded initializations in integrity_iint_cache entries

Joe Perches (1):
      ima: Fix line continuation format

Matthew Garrett (2):
      EVM: Allow userland to permit modification of EVM-protected metadata
      EVM: Add support for portable signature format

Mike Rapoport (1):
      ima/policy: fix parsing of fsuuid

Mimi Zohar (2):
      ima: relax requiring a file signature for new files with zero length
      ima: support new "hash" and "dont_hash" policy actions

Nayna Jain (3):
      tpm: move wait_for_tpm_stat() to respective driver files
      tpm: reduce tpm polling delay in tpm_tis_core
      tpm: use tpm_msleep() value as max delay

Roberto Sassu (1):
      ima: pass filename to ima_rdwr_violation_check()

Sascha Hauer (1):
      ima: Use i_version only when filesystem supports it

Thiebaud Weksteen (5):
      tpm: move tpm_eventlog.h outside of drivers folder
      tpm: rename event log provider files
      tpm: add event log format version
      efi: call get_event_log before ExitBootServices
      tpm: parse TPM event logs based on EFI table

Tycho Andersen (2):
      seccomp: hoist out filter resolving logic
      ptrace, seccomp: add support for retrieving seccomp metadata

Vasyl Gomonovych (1):
      Smack: fix dereferenced before check

 Documentation/ABI/testing/evm                      |  54 +++--
 Documentation/ABI/testing/ima_policy               |   3 +-
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
 include/linux/integrity.h                          |   1 +
 include/linux/seccomp.h                            |   8 +
 include/linux/tpm.h                                |  39 ++--
 {drivers/char/tpm => include/linux}/tpm_eventlog.h |  34 +--
 include/uapi/linux/ptrace.h                        |   6 +
 kernel/ptrace.c                                    |   4 +
 kernel/seccomp.c                                   | 106 +++++++---
 security/integrity/evm/evm.h                       |   9 +-
 security/integrity/evm/evm_crypto.c                |  75 ++++++-
 security/integrity/evm/evm_main.c                  |  67 ++++--
 security/integrity/evm/evm_secfs.c                 |  20 +-
 security/integrity/iint.c                          |   4 +-
 security/integrity/ima/ima_api.c                   |   2 +-
 security/integrity/ima/ima_appraise.c              |  46 ++--
 security/integrity/ima/ima_crypto.c                |   2 +-
 security/integrity/ima/ima_init.c                  |   2 +-
 security/integrity/ima/ima_main.c                  |  95 ++++++---
 security/integrity/ima/ima_policy.c                |  32 ++-
 security/integrity/ima/ima_queue.c                 |   2 +-
 security/integrity/ima/ima_template.c              |  11 +-
 security/integrity/integrity.h                     |  41 ++--
 security/keys/trusted.c                            |  35 ++--
 security/smack/smack.h                             |   1 +
 security/smack/smack_access.c                      |  40 +++-
 security/smack/smack_lsm.c                         |  10 +-
 54 files changed, 1256 insertions(+), 611 deletions(-)
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
