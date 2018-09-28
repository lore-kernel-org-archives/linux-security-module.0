From: tomas.winkler@intel.com (Tomas Winkler)
Date: Sat, 29 Sep 2018 01:30:29 +0300
Subject: [PATCH v5 15/21] tpm: tpm-space.c remove unneeded semicolon
In-Reply-To: <20180928223035.14471-1-tomas.winkler@intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
Message-ID: <20180928223035.14471-16-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Remove unneeded semicolon in tpm2_map_response_header()

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---

V3: New in the series.
V4-V5: Resend.

 drivers/char/tpm/tpm2-space.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index d2e101b32482..dcdfde3c253e 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -373,7 +373,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
 		dev_err(&chip->dev, "%s: unknown handle 0x%08X\n",
 			__func__, phandle);
 		break;
-	};
+	}
 
 	return 0;
 out_no_slots:
-- 
2.14.4
