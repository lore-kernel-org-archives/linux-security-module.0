From: tomas.winkler@intel.com (Tomas Winkler)
Date: Tue,  6 Mar 2018 11:30:37 +0200
Subject: [PATCH 0/4] tpm: factor out tpm1 code into tpm1-cmd.c
Message-ID: <20180306093041.11996-1-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Move tpm 1.x implementation to tpm1-cmd.c similarly to tpm2-cmd.c
This is work in progress of possible dropping compiling out
one tpm 1.x or tpm 2.x in case not needed on a target platform.

Tomas Winkler (4):
  tmp: move tpm1_pcr_extend to tpm1-cmd.c
  tmp: move tpm_getcap to tpm1-cmd.c
  tmp: factor out tpm1_get_random into tpm1-cmd.c
  tpm: move tpm1 selftest code from tpm-interface tpm1-cmd.c

 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-interface.c     | 273 +----------------------------------
 drivers/char/tpm/tpm-sysfs.c         |  50 +++----
 drivers/char/tpm/tpm.h               |  12 +-
 drivers/char/tpm/tpm1-cmd.c          | 267 +++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm_tis_core.c      |   4 +-
 6 files changed, 303 insertions(+), 305 deletions(-)

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
