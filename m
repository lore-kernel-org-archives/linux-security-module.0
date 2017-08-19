From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 19 Aug 2017 20:27:08 +0300
Subject: [GIT PULL] tpmdd updates for Linux 4.14
Message-ID: <20170819172708.opyeyort3pebklje@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Not much this time except a few fixes.

/Jarkko

The following changes since commit 76e22e212a850bbd16cf49f9c586d4635507e0b5:

  apparmor: fix incorrect type assignment when freeing proxies (2017-08-18 06:45:37 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20170819

for you to fetch changes up to 08f49ffce0522ae4738308f400795ee4d92f6e3d:

  tpm: ibmvtpm: simplify crq initialization and document crq format (2017-08-19 20:23:44 +0300)

----------------------------------------------------------------
tpmdd updates for Linux 4.14

----------------------------------------------------------------
Arvind Yadav (2):
      tpm: tpm_crb: constify acpi_device_id.
      tpm: vtpm: constify vio_device_id

Enric Balletbo i Serra (1):
      Documentation: tpm: add powered-while-suspended binding documentation

Hamza Attak (1):
      tpm: replace msleep() with  usleep_range() in TPM 1.2/2.0 generic drivers

Michal Suchanek (1):
      tpm: ibmvtpm: simplify crq initialization and document crq format

 .../devicetree/bindings/security/tpm/tpm-i2c.txt   |  6 ++
 drivers/char/tpm/tpm-interface.c                   | 10 +--
 drivers/char/tpm/tpm.h                             |  9 +-
 drivers/char/tpm/tpm2-cmd.c                        |  2 +-
 drivers/char/tpm/tpm_crb.c                         |  2 +-
 drivers/char/tpm/tpm_ibmvtpm.c                     | 98 ++++++++++++++--------
 drivers/char/tpm/tpm_infineon.c                    |  6 +-
 drivers/char/tpm/tpm_tis_core.c                    |  8 +-
 8 files changed, 89 insertions(+), 52 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
