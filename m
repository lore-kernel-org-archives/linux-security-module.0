From: tomas.winkler@intel.com (Tomas Winkler)
Date: Mon,  5 Mar 2018 22:20:11 +0200
Subject: [PATCH 0/6] tpm: timeouts revamp
Message-ID: <20180305202017.24008-1-tomas.winkler@intel.com>
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

Last, is to factor out tpm1.2 commands out of tpm-interface.c

Tomas Winkler (6):
  tpm: sort objects in the Makefile
  tpm: factor out tpm 1.2 duration calculation to tpm1-cmd.c
  tpm2: add longer timeouts for creation commands.
  tpm2: add new tpm2 commands according to TCG 1.36
  tmp: factor out tpm_get_timeouts
  tpm: tpm-interface: drop unused tpm_input_header headers.

 drivers/char/tpm/Makefile            |  15 +-
 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-interface.c     | 424 +----------------------------------
 drivers/char/tpm/tpm.h               |  74 +++---
 drivers/char/tpm/tpm1-cmd.c          | 416 ++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c          | 220 ++++++++----------
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  10 +-
 drivers/char/tpm/tpm_tis_core.c      |   2 +-
 drivers/char/tpm/xen-tpmfront.c      |   2 +-
 9 files changed, 582 insertions(+), 583 deletions(-)
 create mode 100644 drivers/char/tpm/tpm1-cmd.c

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
