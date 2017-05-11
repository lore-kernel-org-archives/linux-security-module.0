From: guilherme.magalhaes@hpe.com (Guilherme Magalhaes)
Date: Thu, 11 May 2017 10:59:53 -0300
Subject: [RFC 01/11] ima: qualify pathname in audit info record
In-Reply-To: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
References: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
Message-ID: <1494511203-8397-2-git-send-email-guilherme.magalhaes@hpe.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adding new field (mount namespace id, along with already existent file
inode and device name) to uniquely identify a pathname considering
different mount namespaces. The file inode on a given device is unique
and these fields are required to identify a namespace id since this
id can be released and later reused by a different namespace.

Signed-off-by: Guilherme Magalhaes <guilherme.magalhaes@hpe.com>
---
 security/integrity/integrity_audit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 90987d1..e675e42 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/audit.h>
+#include <linux/proc_ns.h>
 #include "integrity.h"
 
 static int integrity_audit_info;
@@ -52,8 +53,12 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 	audit_log_format(ab, " comm=");
 	audit_log_untrustedstring(ab, get_task_comm(name, current));
 	if (fname) {
+		struct ns_common *ns;
 		audit_log_format(ab, " name=");
 		audit_log_untrustedstring(ab, fname);
+		ns = mntns_operations.get(current);
+		audit_log_format(ab, " mnt_ns=%u", ns->inum);
+		mntns_operations.put(ns);
 	}
 	if (inode) {
 		audit_log_format(ab, " dev=");
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
