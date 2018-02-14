From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 14 Feb 2018 08:35:12 -0500
Subject: [RFC PATCH 1/4] ima: define a new policy condition based on the
	filesystem name
Message-ID: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Some filesystems, like fuse, don't export the filesystem magic number.

In addition, when files in the initramfs will be properly labeled with
file signatures, we will need the ablity to differentiate between
rootfs that require file signatures from those don't.

This patch defines a new IMA policy condition named "fsname", based on
the superblock's file_system_type (sb->s_type) name. This allows policy
rules to be expressed in terms of the filesystem name.

Example rules:
measure func=FILE_CHECK fsname=fuse
appraise func=BPRM_CHECK fsname=rootfs
appraise func=FILE_MMAP fsname=rootfs

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_policy.c  | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 2028f2d093b2..aeb5c6326b9b 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -21,7 +21,7 @@ Description:
 			audit | hash | dont_hash
 		condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=]]
+				[euid=] [fowner=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [permit_directio]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 915f5572c6ff..54847e08e6c8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -33,6 +33,7 @@
 #define IMA_INMASK	0x0040
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
+#define IMA_FSNAME	0x0200
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -74,6 +75,7 @@ struct ima_rule_entry {
 		void *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
+	char *fsname;
 };
 
 /*
@@ -267,6 +269,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_FSMAGIC)
 	    && rule->fsmagic != inode->i_sb->s_magic)
 		return false;
+	if ((rule->flags & IMA_FSNAME)
+	    && strcmp(rule->fsname, inode->i_sb->s_type->name))
+		return false;
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
@@ -528,7 +533,7 @@ enum {
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
@@ -553,6 +558,7 @@ static match_table_t policy_tokens = {
 	{Opt_func, "func=%s"},
 	{Opt_mask, "mask=%s"},
 	{Opt_fsmagic, "fsmagic=%s"},
+	{Opt_fsname, "fsname=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
@@ -762,6 +768,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			if (!result)
 				entry->flags |= IMA_FSMAGIC;
 			break;
+		case Opt_fsname:
+			ima_log_string(ab, "fsname", args[0].from);
+
+			entry->fsname = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->fsname) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_FSNAME;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1090,6 +1107,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_FSNAME) {
+		snprintf(tbuf, sizeof(tbuf), "%s", entry->fsname);
+		seq_printf(m, pt(Opt_fsname), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
