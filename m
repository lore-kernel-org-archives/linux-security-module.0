From: brdeoliv@redhat.com (Bruno E. O. Meneguele)
Date: Tue,  5 Dec 2017 11:35:32 -0200
Subject: [PATCH v3] ima: log message to module appraisal error
Message-ID: <20171205133532.23509-1-brdeoliv@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: "Bruno E. O. Meneguele" <bmeneguele@gmail.com>

Simple but useful message log to the user in case of module appraise is
forced and fails due to the lack of file descriptor, that might be
caused by kmod calls to compressed modules.

Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>
---
 security/integrity/ima/ima_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 770654694efc..e0e1dc4c520c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -366,8 +366,10 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 
 	if (!file && read_id == READING_MODULE) {
 		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 		return 0;	/* We rely on module signature checking */
 	}
 	return 0;
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
