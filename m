From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 14 Feb 2018 08:35:14 -0500
Subject: [RFC PATCH 3/4] ima: define a new policy option named "fail"
In-Reply-To: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1518615315-7162-3-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Verifying file signatures on untrusted filesystems is meaningless, as
the filesystem can change the file at any time.  This patch defines a
new policy option named "fail", which fails signature verification on
untrusted filesystems.

Like any other signature verification failure, the measurement is still
added to the measurement list and audited based on policy.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 Documentation/ABI/testing/ima_policy  |  2 +-
 security/integrity/ima/ima_appraise.c |  8 ++++++--
 security/integrity/ima/ima_policy.c   | 12 +++++++++++-
 security/integrity/integrity.h        |  1 +
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index aeb5c6326b9b..7c9529eb0f91 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -24,7 +24,7 @@ Description:
 				[euid=] [fowner=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
-			option:	[[appraise_type=]] [permit_directio]
+			option:	[[appraise_type=]] [permit_directio] [fail]
 
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index af8add31fe26..511448867f02 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -292,9 +292,13 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 out:
-	/* Fail untrusted and unpriviliged filesystems (eg FUSE) */
+	/*
+	 * Fail untrusted filesystems (eg. FUSE) that are either
+	 * unprivileged or based on policy.
+	 */
 	if ((inode->i_sb->s_type->fs_flags & FS_UNTRUSTED) &&
-	    (inode->i_sb->s_user_ns != &init_user_ns)) {
+	    ((inode->i_sb->s_user_ns != &init_user_ns) ||
+	     (iint->flags & IMA_FAIL_UNTRUSTED))) {
 		status = INTEGRITY_FAIL;
 		cause = "untrusted-filesystem";
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 54847e08e6c8..1130c6deee41 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -538,7 +538,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr
+	Opt_pcr, Opt_fail
 };
 
 static match_table_t policy_tokens = {
@@ -572,6 +572,7 @@ static match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_fail, "fail"},
 	{Opt_err, NULL}
 };
 
@@ -912,6 +913,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->flags |= IMA_PCR;
 
 			break;
+		case Opt_fail:
+			if (entry->action != APPRAISE) {
+				result = -EINVAL;
+				break;
+			}
+			entry->flags |= IMA_FAIL_UNTRUSTED;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1191,6 +1199,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_type=imasig ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->flags & IMA_FAIL_UNTRUSTED)
+		seq_puts(m, "fail ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 50a8e3365df7..5c052258fd73 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -35,6 +35,7 @@
 #define IMA_PERMIT_DIRECTIO	0x02000000
 #define IMA_NEW_FILE		0x04000000
 #define EVM_IMMUTABLE_DIGSIG	0x08000000
+#define IMA_FAIL_UNTRUSTED	0x10000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
