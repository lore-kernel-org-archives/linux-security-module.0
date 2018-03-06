From: tomas.winkler@intel.com (Tomas Winkler)
Date: Tue,  6 Mar 2018 11:24:58 +0200
Subject: [PATCH 0/5 V2] tpm: timeouts revamp
Message-ID: <20180306092503.11568-1-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This series cleans up tpm timeouts setting and handling.

First motivation was to fix failures coming from too short timeouts
for commands that creates keys.
Key generation may take significant time depending on the underlying
hardware. Rather than increasing default timeout a new constant is
added, to not stall too long on regular commands failures.

Second is to define timeouts for new tpm2 commands
defined in TCG 1.36 spec.

Tomas Winkler (5):
  tpm: sort objects in the Makefile
  tpm: factor out tpm 1.2 duration calculation to tpm1-cmd.c
  tpm2: add longer timeouts for creation commands.
  tpm2: add new tpm2 commands according to TCG 1.36
  tmp: factor out tpm_get_timeouts

V2: 1. Makefile go back tpm-y construct.
    2. Add more info to longer timouts patch
    3. Rebase other patches
    4. Remove patch not connected to timouts from the series.

 drivers/char/tpm/Makefile            |  16 +-
 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-interface.c     | 408 +---------------------------------
 drivers/char/tpm/tpm.h               |  74 ++++---
 drivers/char/tpm/tpm1-cmd.c          | 416 +++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c          | 220 ++++++++----------
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  10 +-
 drivers/char/tpm/tpm_tis_core.c      |   2 +-
 drivers/char/tpm/xen-tpmfront.c      |   2 +-
 9 files changed, 582 insertions(+), 568 deletions(-)
 create mode 100644 drivers/char/tpm/tpm1-cmd.c

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
