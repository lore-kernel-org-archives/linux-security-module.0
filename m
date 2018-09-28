From: tomas.winkler@intel.com (Tomas Winkler)
Date: Sat, 29 Sep 2018 01:30:28 +0300
Subject: [PATCH v5 14/21] tpm: tpm-interface.c drop unused macros
In-Reply-To: <20180928223035.14471-1-tomas.winkler@intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
Message-ID: <20180928223035.14471-15-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The commit:
"tpm_tis: further simplify calculation of ordinal duration"
left unused macros, we can drop them now.

Fixes compilation warnings:
tpm-interface.c:37:0: warning: macro "TPM_PROTECTED_COMMAND" is not used [-Wunused-macros]
tpm-interface.c:36:0: warning: macro "TSC_MAX_ORDINAL" is not used [-Wunused-macros]
tpm-interface.c:38:0: warning: macro "TPM_CONNECTION_COMMAND" is not used [-Wunused-macros]

Fixes: f72864300139 ("tpm_tis: further simplify calculation of ordinal duration")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---

V3: New in the series.
V4: Fix the commit message.
V5: Resend.

 drivers/char/tpm/tpm-interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index fb142e229f95..98f9a0bbeed9 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -33,10 +33,6 @@
 
 #include "tpm.h"
 
-#define TSC_MAX_ORDINAL 12
-#define TPM_PROTECTED_COMMAND 0x00
-#define TPM_CONNECTION_COMMAND 0x40
-
 /*
  * Bug workaround - some TPM's don't flush the most
  * recently changed pcr on suspend, so force the flush
-- 
2.14.4
