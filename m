From: tomas.winkler@intel.com (Tomas Winkler)
Date: Tue,  6 Mar 2018 11:34:15 +0200
Subject: [PATCH V2] tpm_crb: use __le64 annotated variable for response buffer
	address
Message-ID: <20180306093415.12356-1-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

use __le64 annotated variable for response buffer address as this is
read in little endian format form the register.

This suppresses sparse warning
drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: Add more info into the commit message

 drivers/char/tpm/tpm_crb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index acfcdc6f31af..29fecdea0b2d 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -489,6 +489,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 pa_high, pa_low;
 	u64 cmd_pa;
 	u32 cmd_size;
+	__le64 __rsp_pa;
 	u64 rsp_pa;
 	u32 rsp_size;
 	int ret;
@@ -554,8 +555,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		goto out;
 	}
 
-	memcpy_fromio(&rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
-	rsp_pa = le64_to_cpu(rsp_pa);
+	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
+	rsp_pa = le64_to_cpu(__rsp_pa);
 	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
 				      ioread32(&priv->regs_t->ctrl_rsp_size));
 
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
