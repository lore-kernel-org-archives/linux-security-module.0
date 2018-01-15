From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 15 Jan 2018 11:20:36 -0500
Subject: [PATCH] ima: define new policy condition based on the filesystem name
Message-ID: <1516033236.6607.6.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Some filesystems do not export the filesystem's magic number, as it is
considered internal, private data.  In other cases, the policy rule
needs to identify a specifically mounted filesystem (eg. rootfs).

This patch defines a new IMA policy condition named "fsname", based on
the superblock's file_system_type (sb->s_type) name.

By defining a policy rule in terms of the filesystem magic number and
the superblock filesystem name, files on the rootfs filesystem are only
appraised, when rootfs is a tmpfs filesystem, which supports xattrs.

Sample rules:
measure func=FILE_CHECK fsname=xfs
appraise fsmagic=0x01021994 fsname=rootfs

Suggested-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_policy.c  | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index b0e8143c681f..281b88d17a37 100644
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
 			option:	[[appraise_type=]] [permit_directio] [force]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 878ae1a06e1e..ceffb98d79ca 100644
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
@@ -763,6 +769,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
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
 
@@ -1094,6 +1111,12 @@ int ima_policy_show(struct seq_file *m, void *v)
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
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
