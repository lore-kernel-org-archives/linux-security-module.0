From: jmorris@namei.org (James Morris)
Date: Fri, 7 Jul 2017 10:06:32 +1000 (AEST)
Subject: [GIT PULL] security susbsytem updates #2: TPM and SELinux fixes
Message-ID: <alpine.LRH.2.20.1707071004180.10938@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these bugfixes for TPM and SELinux.

---

The following changes since commit b4b8cbf679c4866a523a35d1454884a31bd5d8dc:

  Cavium CNN55XX: fix broken default Kconfig entry (2017-07-05 13:03:05 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-linus

Azhar Shaikh (1):
      tpm: Enable CLKRUN protocol for Braswell systems

Colin Ian King (1):
      tpm_tis: make ilb_base_addr static

Daniel Jurgens (2):
      IB/core: Fix uninitialized variable use in check_qp_port_pkey_settings
      IB/core: Fix static analysis warning in ib_policy_change_task

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

 drivers/base/core.c                |    6 ++-
 drivers/char/tpm/tpm-chip.c        |   34 ++++++++++
 drivers/char/tpm/tpm-interface.c   |   70 +++++++++++++--------
 drivers/char/tpm/tpm-sysfs.c       |    6 ++-
 drivers/char/tpm/tpm.h             |   11 ++--
 drivers/char/tpm/tpm2-cmd.c        |  121 +++++++++--------------------------
 drivers/char/tpm/tpm_crb.c         |    5 +-
 drivers/char/tpm/tpm_of.c          |    3 +
 drivers/char/tpm/tpm_tis.c         |  113 +++++++++++++++++++++++++++++++++
 drivers/infiniband/core/device.c   |    3 +-
 drivers/infiniband/core/security.c |   20 ++++---
 include/linux/device.h             |    2 +
 12 files changed, 261 insertions(+), 133 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
