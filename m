From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 3 Jul 2017 16:18:40 +0300
Subject: [GIT PULL] tpmdd fixes for 4.13
Message-ID: <20170703131840.ynsio3amf6fcg2ti@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

these are remaining fixes for 4.13 release. Will be the last PR for the
release unless major regressions show up.

/Jarkko

The following changes since commit c4758fa59285fe4dbfeab4364a6957936d040fbf:

  apparmor: put back designators in struct initialisers (2017-06-28 15:50:43 +1000)

are available in the git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20170703

for you to fetch changes up to 65bbcc19ab70d534dc40d0d3626cd986993203a5:

  tpm: do not suspend/resume if power stays on (2017-07-03 16:10:15 +0300)

----------------------------------------------------------------
tpmdd fixes for Linux 4.13

----------------------------------------------------------------
Azhar Shaikh (1):
      tpm: Enable CLKRUN protocol for Braswell systems

Colin Ian King (1):
      tpm_tis: make ilb_base_addr static

Enric Balletbo i Serra (1):
      tpm: do not suspend/resume if power stays on

Jarkko Sakkinen (2):
      tpm: fix a kernel memory leak in tpm-sysfs.c
      tpm: consolidate the TPM startup code

Josh Zimmerman (2):
      Add "shutdown" to "struct class".
      tpm: Issue a TPM2_Shutdown for TPM2 devices.

Manuel Lauss (1):
      tpm/tpm_crb: fix priv->cmd_size initialisation

Roberto Sassu (2):
      tpm: use tpm_buf functions in tpm2_pcr_read()
      tpm: use tpm2_pcr_read() in tpm2_do_selftest()

 drivers/base/core.c              |   6 +-
 drivers/char/tpm/tpm-chip.c      |  34 +++++++++++
 drivers/char/tpm/tpm-interface.c |  70 ++++++++++++++--------
 drivers/char/tpm/tpm-sysfs.c     |   6 +-
 drivers/char/tpm/tpm.h           |  11 ++--
 drivers/char/tpm/tpm2-cmd.c      | 121 ++++++++++-----------------------------
 drivers/char/tpm/tpm_crb.c       |   5 +-
 drivers/char/tpm/tpm_of.c        |   3 +
 drivers/char/tpm/tpm_tis.c       | 113 ++++++++++++++++++++++++++++++++++++
 include/linux/device.h           |   2 +
 10 files changed, 247 insertions(+), 124 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
