From: tomas.winkler@intel.com (Tomas Winkler)
Date: Sat, 10 Mar 2018 10:24:20 +0200
Subject: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
Message-ID: <20180310082428.31519-1-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Move TPM1 implementation from tpm-interface.c to tpm1-cmd.c
similarly to tpm2-cmd.c, as well as move TPM2 open code flows
into new functions to tpm2-cmd.c
The functions in tpm-interface.c should now be in form:


int tpm_func(struct tpm_chip *chip)
{
 if (chip->flags & TPM_CHIP_FLAG_TPM2)
                return tpm2_func(chip);
        else
                return tpm1_func(chip);
}

This is work in progress of possible dropping compiling out one tpm 1.x or tpm 2.x in case
not needed on a target platform.

V2: 1. This resend includes more patches that cleans the tpm-interface.c
completely 
    2. Fix notorious typo tmp -> tpm, in some patches

Tomas Winkler (8):
  tpm: move tpm1_pcr_extend to tpm1-cmd.c
  tpm: move tpm_getcap to tpm1-cmd.c
  tpm: factor out tpm1_get_random into tpm1-cmd.c
  tpm: move tpm1 selftest code from tpm-interface tpm1-cmd.c
  tpm: factor out tpm1 pm suspend flow into tpm1-cmd.c
  tpm: factor out tpm_startup function
  tpm: Move pcr extend to tpm2-cmd.c
  tpm: move tpm2 code validation to tpm2-space.c

 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-interface.c     | 425 ++---------------------------------
 drivers/char/tpm/tpm-sysfs.c         |  50 ++---
 drivers/char/tpm/tpm.h               |  18 +-
 drivers/char/tpm/tpm1-cmd.c          | 358 ++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm2-cmd.c          |  60 ++++-
 drivers/char/tpm/tpm2-space.c        |  32 +++
 drivers/char/tpm/tpm_tis_core.c      |   4 +-
 8 files changed, 496 insertions(+), 453 deletions(-)

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
