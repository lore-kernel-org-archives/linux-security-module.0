From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 18 Oct 2017 18:48:24 +0300
Subject: [GIT PULL] tpmdd updates for Linux 4.15
Message-ID: <20171018154824.5mgrgr7jnlfwgujt@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi

Contains mostly minor fixes.

Selected more essential changes:

* Essential clean up for tpm_crb so that ARM64 and x86 versions do not
  distract each other as much as before.
* /dev/tpm0 rejects now too short writes (shorter buffer than specified in
  the command header.
* Use DMA-safe buffer in tpm_tis_spi.

/Jarkko

The following changes since commit 25eabb13c7d67ae32298015c5e28d00f604f412c:

  Merge tag 'v4.14-rc2' into next-general (2017-09-24 22:41:55 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20171018

for you to fetch changes up to 33957a104c86985f087b08a363590a948c9ff08c:

  tpm, tpm_tis: use ARRAY_SIZE() to define TPM_HID_USR_IDX (2017-10-18 18:28:49 +0300)

----------------------------------------------------------------
tpmdd updates for Linux 4.15

----------------------------------------------------------------
Alexander Steffen (5):
      tpm_tis_spi: Use DMA-safe memory for SPI transfers
      tpm: Trigger only missing TPM 2.0 self tests
      tpm: Use dynamic delay to wait for TPM 2.0 self test result
      tpm: React correctly to RC_TESTING from TPM 2.0 self tests
      tpm-dev-common: Reject too short writes

Arnd Bergmann (1):
      tpm: constify transmit data pointers

Colin Ian King (1):
      tpm_tis: make array cmd_getticks static const to shrink object code size

Jarkko Sakkinen (4):
      tpm: migrate pubek_show to struct tpm_buf
      tpm: fix type of a local variable in tpm2_get_cc_attrs_tbl()
      tpm: fix type of a local variable in tpm2_map_command()
      tpm: fix type of a local variables in tpm_tis_spi.c

Jiandi An (1):
      tpm/tpm_crb: Use start method value from ACPI table directly

J?r?my Lefaure (1):
      tpm, tpm_tis: use ARRAY_SIZE() to define TPM_HID_USR_IDX

Ruben Roy (1):
      tpm: fix duplicate inline declaration specifier

 drivers/char/tpm/tpm-dev-common.c |  6 +++
 drivers/char/tpm/tpm-sysfs.c      | 87 +++++++++++++++++++++------------------
 drivers/char/tpm/tpm.h            | 15 +------
 drivers/char/tpm/tpm2-cmd.c       | 73 ++++++++++----------------------
 drivers/char/tpm/tpm2-space.c     |  4 +-
 drivers/char/tpm/tpm_crb.c        | 59 +++++++++++++-------------
 drivers/char/tpm/tpm_tis.c        |  5 ++-
 drivers/char/tpm/tpm_tis_core.c   |  6 +--
 drivers/char/tpm/tpm_tis_core.h   |  4 +-
 drivers/char/tpm/tpm_tis_spi.c    | 73 +++++++++++++++++++-------------
 10 files changed, 161 insertions(+), 171 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
