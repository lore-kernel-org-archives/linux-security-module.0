From: jmorris@namei.org (James Morris)
Date: Thu, 16 Aug 2018 08:37:50 +1000 (AEST)
Subject: [GIT PULL] security subsystem: TPM updates for v4.19
Message-ID: <alpine.LRH.2.21.1808160835290.19586@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

>From Jarkko:

" * Migrated away from PM runtime as explicit cmdReady/goIdle trasactions
    for every command is a spec requirement. PM runtime adds only a layer 
    of complexity on our case.
  * tpm_tis drivers can now specify the hwrng quality.
  * TPM 2.0 code uses now tpm_buf for constructing messages. I think Tomas
    Winkler has done the same for TPM 1.2. I'll start digging those
    changes from the patchwork in the near future.
  * Bug fixes and clean ups."


The following changes since commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to 5da08f7d01693433ff6bea0c3462a5173d577540:

  Merge tag 'tpmdd-next-20180728' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2018-07-30 09:30:19 -0700)

----------------------------------------------------------------
James Morris (1):
      Merge tag 'tpmdd-next-20180728' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

Jarkko Sakkinen (5):
      tpm: migrate tpm2_shutdown() to use struct tpm_buf
      tpm: migrate tpm2_probe() to use struct tpm_buf
      tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
      tpm: migrate tpm2_get_random() to use struct tpm_buf
      tpm: replace TPM_TRANSMIT_RAW with TPM_TRANSMIT_NESTED

Linus Walleij (1):
      tpm_tis_spi: Pass the SPI IRQ down to the driver

Louis Collard (1):
      tpm: Allow tpm_tis drivers to set hwrng quality.

Peter Rosin (1):
      tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Ricardo Schwarzmeier (1):
      tpm: Return the actual size when receiving an unsupported command

Stefan Berger (5):
      tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
      tpm: Implement tpm_default_chip() to find a TPM chip
      tpm: Convert tpm_find_get_ops() to use tpm_default_chip()
      ima: Use tpm_default_chip() and call TPM functions with a tpm_chip
      ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead

Tomas Winkler (1):
      tpm: separate cmd_ready/go_idle from runtime_pm

 drivers/char/tpm/tpm-chip.c         |  68 +++++++---
 drivers/char/tpm/tpm-interface.c    |  72 +++++++---
 drivers/char/tpm/tpm.h              |  31 +++--
 drivers/char/tpm/tpm2-cmd.c         | 258 +++++++++++++++---------------------
 drivers/char/tpm/tpm2-space.c       |  12 +-
 drivers/char/tpm/tpm_crb.c          | 101 ++++----------
 drivers/char/tpm/tpm_i2c_infineon.c |   8 +-
 drivers/char/tpm/tpm_tis_core.c     |   2 +
 drivers/char/tpm/tpm_tis_core.h     |   1 +
 drivers/char/tpm/tpm_tis_spi.c      |   9 +-
 drivers/char/tpm/tpm_vtpm_proxy.c   |   2 +-
 include/linux/tpm.h                 |   7 +
 security/integrity/ima/ima.h        |   2 +-
 security/integrity/ima/ima_crypto.c |   4 +-
 security/integrity/ima/ima_init.c   |  16 +--
 security/integrity/ima/ima_queue.c  |   4 +-
 16 files changed, 289 insertions(+), 308 deletions(-)
