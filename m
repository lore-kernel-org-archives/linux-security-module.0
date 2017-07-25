From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 25 Jul 2017 17:44:22 +0200
Subject: [PATCH 11/12] ima: don't report measurements if digests are included
	in the loaded lists
In-Reply-To: <20170725154423.24845-1-roberto.sassu@huawei.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
Message-ID: <20170725154423.24845-12-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Don't report measurements if the file digest has been included in
an uploaded digest list.

The advantage of this solution is that the boot time overhead, when
a TPM is available, is very small because a PCR is extended only
for unknown files. The disadvantage is that verifiers do not know
anymore which and when files are accessed (they must assume that
the worst case happened, i.e. all files have been accessed).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c329549..e289b7c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -253,6 +253,14 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 		goto out_digsig;
 	}
 
+	if (!ima_disable_digest_check) {
+		if (ima_lookup_loaded_digest(iint->ima_hash->digest)) {
+			action ^= IMA_MEASURE;
+			iint->flags |= IMA_MEASURED;
+			iint->measured_pcrs |= (0x1 << pcr);
+		}
+	}
+
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
