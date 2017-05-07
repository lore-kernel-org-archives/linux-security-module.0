From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 7 May 2017 15:43:16 +0200
Subject: [PATCH 3/3] ima: Replace nine seq_puts() calls by seq_putc()
In-Reply-To: <416e6b01-7abb-d894-3bd6-d8bda05ed6b2@users.sourceforge.net>
References: <416e6b01-7abb-d894-3bd6-d8bda05ed6b2@users.sourceforge.net>
Message-ID: <1e549540-9160-6f9f-af39-d06b1c75a24d@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 May 2017 15:23:44 +0200

Nine single characters should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/integrity/ima/ima_policy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 83446a383ace..b1ec6f2ce0ad 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1035,7 +1035,7 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 		seq_printf(m, pt(Opt_func), tbuf);
 		break;
 	}
-	seq_puts(m, " ");
+	seq_putc(m, ' ');
 }
 
 int ima_policy_show(struct seq_file *m, void *v)
@@ -1057,7 +1057,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	if (entry->action & AUDIT)
 		seq_puts(m, pt(Opt_audit));
 
-	seq_puts(m, " ");
+	seq_putc(m, ' ');
 
 	if (entry->flags & IMA_FUNC)
 		policy_func_show(m, entry->func);
@@ -1071,19 +1071,19 @@ int ima_policy_show(struct seq_file *m, void *v)
 			seq_printf(m, pt(Opt_mask), mt(mask_read));
 		if (entry->mask & MAY_APPEND)
 			seq_printf(m, pt(Opt_mask), mt(mask_append));
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
 
 	if (entry->flags & IMA_FSMAGIC) {
 		snprintf(tbuf, sizeof(tbuf), "0x%lx", entry->fsmagic);
 		seq_printf(m, pt(Opt_fsmagic), tbuf);
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
 
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
 
 	if (entry->flags & IMA_FSUUID)
@@ -1097,7 +1097,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 			seq_printf(m, pt(Opt_uid_lt), tbuf);
 		else
 			seq_printf(m, pt(Opt_uid_eq), tbuf);
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
 
 	if (entry->flags & IMA_EUID) {
@@ -1108,7 +1108,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 			seq_printf(m, pt(Opt_euid_lt), tbuf);
 		else
 			seq_printf(m, pt(Opt_euid_eq), tbuf);
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
 
 	if (entry->flags & IMA_FOWNER) {
@@ -1119,7 +1119,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 			seq_printf(m, pt(Opt_fowner_lt), tbuf);
 		else
 			seq_printf(m, pt(Opt_fowner_eq), tbuf);
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
@@ -1157,7 +1157,7 @@ int ima_policy_show(struct seq_file *m, void *v)
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
 	rcu_read_unlock();
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 #endif	/* CONFIG_IMA_READ_POLICY */
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
