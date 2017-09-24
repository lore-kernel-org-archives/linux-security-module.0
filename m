From: jmorris@namei.org (James Morris)
Date: Sun, 24 Sep 2017 15:00:21 +1000 (AEST)
Subject: [GIT PULL] TPM updates for v4.14
Message-ID: <alpine.LRH.2.21.1709241454480.3941@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Here are the TPM updates from Jarkko for v4.14, which I've placed in their 
own branch (next-tpm).  I ended up cherry-picking them as other changes 
had been made in Jarkko's branch after he sent me his original pull 
request.

I plan on maintaining a separate branch for TPM (and other security 
subsystems) from now on.

>From Jarkko: "Not much this time except a few fixes." 

Please pull.

---

The following changes since commit 53a2ebaaabc1eb8458796fec3bc1e0e80746b642:

  sync to Linus v4.13-rc2 for subsystem developers to work against (2017-07-25 10:44:18 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to fb154e0e0a95249459df054241a9e8f4cca56062:

  tpm: ibmvtpm: simplify crq initialization and document crq format (2017-09-23 21:51:38 -0700)

----------------------------------------------------------------
Arvind Yadav (2):
      tpm: vtpm: constify vio_device_id
      tpm: tpm_crb: constify acpi_device_id.

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
