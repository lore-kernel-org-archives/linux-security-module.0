Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BB36B904
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737506; cv=none; b=minXt8QKz0fs/eAq+DMRCqfuHp8ntZRQQVhQhmM3wBxpqFP6RnywA5qb+/nBXrvHc5aqlfIyF+CJWH2RwFGCNyok1ysc7Ap9T7EvIMcK3f1+vcAaUbVumb7OtEL7i25ZEllE51rV+Lnr2x2ZH3xPAb2QHkup2fGPEYT6NgGUXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737506; c=relaxed/simple;
	bh=gBq9+vwXHvGLi4OG6lcPjoRvu1NA/CknztxxsQ9b8NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuTn6nqwvhCaAOkE+8qHp1673bltZUP6/QKsyT3Eq6Y9E/XVQfTAMfM9YOgsel9IckU2LNHpoNdXEBQJxpAkt9fT0JeeqjAM5l4x7m56YwMGUW7zKhw4a0teg5uxn1o5sa/iv8l++daypp8ROCAh3rpCQ1R643sUq1bOMJ/8Zjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yhkylin.cn; spf=none smtp.mailfrom=yhkylin.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yhkylin.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yhkylin.cn
X-QQ-mid: zesmtpip2t1790737479t63fee913
X-QQ-Originating-IP: q5yzl1RL3kvUZb/gYDMAYjob/gjWxqjNQSEUGHAXZQc=
Received: from tpk-ROG-Zephyrus-M16-GU603ZM-GU ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 30 Sep 2026 11:04:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15423255181184407270
EX-QQ-RecipientCnt: 4
From: Tang Pengke <tangpengke@yhkylin.cn>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org,
	gaolong <gaolong@yhkylin.cn>,
	Tang Pengke <tangpengke@yhkylin.cn>
Subject: [PATCH] smack: preserve low-integrity labels across file copy via whitelist
Date: Wed, 30 Sep 2026 11:04:25 +0800
Message-ID: <9EAFC73B591799F5+20260930030425.496501-1-tangpengke@yhkylin.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:yhkylin.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NnUe5RRjRaP4w6iqJ/A7itMHAdy5qsztFP1TlS+NqXFGNU0ipzHAYYvd
	gjHGXcmsCMq3BfBMbEShDkJ9i2bRc7CNEUeE/SxN1Ur/GekZk92WGdZIpkwA2PT1B/gOFmU
	ibtlF0Kp1vGoA2MoIVwQfS+KEc2Cl2HhlYawtjrUEjJRTuJwsNLwrkcMXdx3IqOZMDEHB6o
	VP6CO9V8D46x8a+LHGkTCkQ4s8+P9si8gRxYzkMyWGorCTLf2MeCciLM9oE8RA33tGlCPqT
	ni/q1uJa+Mz1LzYay2xHhgylkrSLwJiNNXDSWmMc6iKlrSPkN1QMDvY5emRBGQxWncRKP0u
	wadhpAiL7htG7K+bXKoPTkGeqZsvMdQdBfHKO5HMGZO8xcuA+n/LE2XHGVX4bp6DGX8R07p
	vL68ibY7xSzJcLOG+1eO0MSTlfJWKThDwzAAhSyfTMhwLv//bVTClYNpBD7e/JMuff35PF6
	dJqozWBnHutcpNCpWn9UVUxIR1J4w8NKruPqds0emA412stO2m50znFQHJCUl0UHofrk/T/
	wAFTeYgG4StFMsajOmkU+1tlcqHgsCqm1SwsXy4rBiv6cA1yyoB7bsNTiHaLCNXLvrJfOAm
	drdtdigKGdmC9M41usFKkKry5RJS7H9qZttlgb6QjbRPhSX4a60SZ7m5Qw6JpxPwmupo/ux
	r95Xmvv1ccpksDcCKUtxzOrzDCojmYAiS30lUV/TgYFxg70M7Vh7pswYwz47NtEordFnnTQ
	ZP5fR387ZcXD5yfUcN2aPw6lbz4SEjiw1BaHd0k7cP7ppXZFFm3Nt7wkvogQ8QWMLgAZzPW
	KLYQ51ayHlXCVnl6daGGmx01YYQMT4n1+7DefKbLOtqRKzd56nC7R+DKrABpt65fgv02YW/
	tHvdkZhZAha5rMHCEMW6wZADFXV2fUsbQ7eI7b8wjDAFMBqEkv4eQBzAlgvgp/FhEeSBfLt
	t/xrvBEesyx6sf9lcwCpH7FYIoUuZ/Zw9hAAZQJghJBpxzniN7e9K56M+haqCKhxUFslh+q
	anZTYiYJiZ7E0p7EjAOj/JnfWiTwKc/cIKd0spNw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Files copied from an untrusted channel (USB, network, serial) inherit
the creating process's Smack label, losing the source's label.  That
breaks provenance and lets a file from an untrusted source silently
acquire a trusted label.

Record a "preserve" label in task_smack when a process opens a
whitelisted regular file read-only and the read check passes.  The next
inode it creates inherits that label instead of the process label,
unless transmutation applies.  The record is one-shot: consumed on
creation and cleared on fork and exec, so it never outlives a single
copy operation.

The preservable labels form a whitelist exposed through
/smack/preserve-whitelist.  Only untrusted-channel / low-integrity
labels should be added.  Recording happens only after a successful
read check, so a process cannot create a file with a label it could
not read (which would be a write-down primitive), and because the
whitelist holds only low labels the mechanism can only ever preserve a
low label, never a system trusted or sensitive one.  An empty
whitelist is also the fast path in smack_file_open().

The whole mechanism is guarded by CONFIG_SECURITY_SMACK_COPYWHITELIST,
which defaults to no, so the default Smack behavior is unchanged.

Signed-off-by: Tang Pengke <tangpengke@yhkylin.cn>
---
 security/smack/Kconfig        | 21 ++++++++
 security/smack/smack.h        | 30 +++++++++++
 security/smack/smack_access.c | 77 +++++++++++++++++++++++++++
 security/smack/smack_lsm.c    | 53 +++++++++++++++++++
 security/smack/smackfs.c      | 99 +++++++++++++++++++++++++++++++++++
 5 files changed, 280 insertions(+)

diff --git a/security/smack/Kconfig b/security/smack/Kconfig
index 5a8dfad46..134449fb6 100644
--- a/security/smack/Kconfig
+++ b/security/smack/Kconfig
@@ -53,3 +53,24 @@ config SECURITY_SMACK_APPEND_SIGNALS
 	  to differentiate between delivering a network packet and
 	  delivering a signal in the Smack rules.
 	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_SMACK_COPYWHITELIST
+	bool "Preserve low-integrity labels when copying files"
+	depends on SECURITY_SMACK
+	default n
+	help
+	  Enable a whitelist of labels that are preserved when a file is
+	  copied. When a process reads a file whose label is on the
+	  whitelist and then creates a new file, the new file inherits
+	  the source label instead of the process label. This is useful
+	  for tracking the provenance of data copied from untrusted
+	  sources such as removable media or network mounts, where the
+	  filesystem cannot store a per-file label.
+
+	  Only low-integrity labels should be placed on the whitelist,
+	  so that a process can only ever preserve a low label and never
+	  a trusted or sensitive one. The whitelist is managed through
+	  the /smack/preserve-whitelist interface.
+
+	  If you are unsure how to answer this question, answer N.
+
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 9b9eb262f..bb16c197f 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -73,6 +73,25 @@ struct smack_known {
 	struct mutex			smk_rules_lock;	/* lock for rules */
 };
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/*
+ * An entry in the preserve whitelist.
+ *
+ * The whitelist is the single source of truth for which labels are
+ * preservable.  Its emptiness is the fast path in smack_file_open(),
+ * and membership is tested by walking the list.
+ *
+ * Only untrusted-channel / low-integrity labels should be added, so a
+ * process can only ever preserve a low label and never a system trusted
+ * label (which would be a write-down primitive and let shared-library
+ * loads pollute the record).
+ */
+struct smk_preserve_wl {
+	struct list_head		list;
+	struct smack_known		*skp;
+};
+#endif
+
 /*
  * Maximum number of bytes for the levels in a CIPSO IP option.
  * Why 23? CIPSO is constrained to 30, so a 32 byte buffer is
@@ -121,6 +140,9 @@ struct task_smack {
 	struct smack_known	*smk_task;	/* label for access control */
 	struct smack_known	*smk_forked;	/* label when forked */
 	struct smack_known	*smk_transmuted;/* label when transmuted */
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	struct smack_known	*smk_preserve;	/* label to inherit on next create */
+#endif
 	struct list_head	smk_rules;	/* per task access rules */
 	struct mutex		smk_rules_lock;	/* lock for the rules */
 	struct list_head	smk_relabel;	/* transit allowed labels */
@@ -312,6 +334,10 @@ bool smack_privileged(int cap);
 bool smack_privileged_cred(int cap, const struct cred *cred);
 void smk_destroy_label_list(struct list_head *list);
 int smack_populate_secattr(struct smack_known *skp);
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+bool smk_preserve_allowed(struct smack_known *skp);
+void smk_preserve_set(struct smack_known *skp, bool on);
+#endif
 
 /*
  * Shared data.
@@ -326,6 +352,10 @@ extern struct smack_known *smack_unconfined;
 #endif
 extern int smack_ptrace_rule;
 extern struct lsm_blob_sizes smack_blob_sizes;
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+extern struct list_head smk_preserve_wl;
+extern struct mutex smk_preserve_wl_lock;
+#endif
 
 extern struct smack_known smack_known_floor;
 extern struct smack_known smack_known_hat;
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 350b88d58..5bb75e2ec 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -53,6 +53,83 @@ static u32 smack_next_secid = 10;
 int log_policy = SMACK_AUDIT_DENIED;
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/*
+ * Preserve whitelist: only labels on this list are preserved on copy.
+ *
+ * The list is the single source of truth for "which labels are
+ * preservable". It also lets smack_file_open() take a plain
+ * list_empty() fast path.
+ *
+ * Only untrusted-channel / low-integrity labels should be added, so
+ * that a process can only ever preserve a low label -- never a system
+ * trusted or sensitive label -- which would otherwise be a write-down
+ * primitive (and would let shared-library loads pollute the record).
+ *
+ * Entries hold raw smack_known pointers. SMACK global labels are never
+ * freed at runtime (smk_destroy_label_list frees list elements, not the
+ * label objects), so these pointers stay valid for the life of the
+ * system.
+ */
+LIST_HEAD(smk_preserve_wl);
+DEFINE_MUTEX(smk_preserve_wl_lock);
+
+bool smk_preserve_allowed(struct smack_known *skp)
+{
+	struct smk_preserve_wl *e;
+
+	mutex_lock(&smk_preserve_wl_lock);
+	list_for_each_entry(e, &smk_preserve_wl, list) {
+		if (e->skp == skp) {
+			mutex_unlock(&smk_preserve_wl_lock);
+			return true;
+		}
+	}
+	mutex_unlock(&smk_preserve_wl_lock);
+	return false;
+}
+
+/*
+ * Add or remove a label from the preserve whitelist.
+ *
+ * The sysfs interface (preserve-whitelist) calls this with on=true for
+ * a plain label, and on=false for a label prefixed with '-'.
+ */
+void smk_preserve_set(struct smack_known *skp, bool on)
+{
+	struct smk_preserve_wl *e, *new = NULL;
+
+	if (on) {
+		new = kzalloc_obj(*new, GFP_KERNEL);
+		if (!new)
+			return;
+		new->skp = skp;
+	}
+
+	mutex_lock(&smk_preserve_wl_lock);
+	if (on) {
+		list_for_each_entry(e, &smk_preserve_wl, list) {
+			if (e->skp == skp) {
+				kfree(new);
+				new = NULL;
+				break;
+			}
+		}
+		if (new)
+			list_add_tail(&new->list, &smk_preserve_wl);
+	} else {
+		list_for_each_entry(e, &smk_preserve_wl, list) {
+			if (e->skp == skp) {
+				list_del(&e->list);
+				kfree(e);
+				break;
+			}
+		}
+	}
+	mutex_unlock(&smk_preserve_wl_lock);
+}
+#endif /* CONFIG_SECURITY_SMACK_COPYWHITELIST */
+
 /**
  * smk_access_entry - look up matching access rule
  * @subject_label: a pointer to the subject's Smack label
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c..e7c3a8473 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -325,6 +325,9 @@ static void init_task_smack(struct task_smack *tsp, struct smack_known *task,
 {
 	tsp->smk_task = task;
 	tsp->smk_forked = forked;
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	tsp->smk_preserve = NULL;
+#endif
 	INIT_LIST_HEAD(&tsp->smk_rules);
 	INIT_LIST_HEAD(&tsp->smk_relabel);
 	mutex_init(&tsp->smk_rules_lock);
@@ -906,6 +909,10 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
 	struct superblock_smack *sbsp;
 	int rc;
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	bsp->smk_preserve = NULL;
+#endif
+
 	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
@@ -1066,6 +1073,19 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		}
 	}
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	/*
+	 * If a whitelisted label was recorded on file open and no
+	 * transmutation applies, inherit it so the new file keeps the
+	 * source's (low-integrity) label across the copy.
+	 */
+	if (!trans_cred && tsp->smk_preserve != NULL &&
+	    !(trans_rule && smk_inode_transmutable(dir))) {
+		issp->smk_inode = tsp->smk_preserve;
+		tsp->smk_preserve = NULL;
+	}
+#endif
+
 	if (rc == 0)
 		if (xattr_dupval(xattrs, xattr_count,
 			    XATTR_SMACK_SUFFIX,
@@ -2068,6 +2088,39 @@ static int smack_file_open(struct file *file)
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 	rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
 	rc = smk_bu_credfile(file->f_cred, file, MAY_READ, rc);
+	if (rc)
+		return rc;
+
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	/*
+	 * Record a whitelisted label after a successful read check so the
+	 * next file create (smack_inode_init_security) can inherit it.
+	 *
+	 * The record must happen only after the read check passes;
+	 * otherwise a process without read access to the source could
+	 * create a file with that label without ever reading it, which
+	 * would be a write-down primitive.
+	 *
+	 * The whitelist must only hold untrusted-channel / low-integrity
+	 * labels (peripheral, network, serial, and other external
+	 * sources), never system trusted labels (system binaries, shared
+	 * libraries, etc.) -- otherwise shared-library loads would pollute
+	 * the record.  Because of this constraint no library path
+	 * filtering is needed here: the whitelist check already excludes
+	 * every non-whitelisted file, including shared libraries.
+	 *
+	 * The whitelist is read-only after configuration, so the
+	 * list_empty() fast path needs no locking.
+	 */
+	if (!list_empty(&smk_preserve_wl) &&
+	    (file->f_flags & O_ACCMODE) == O_RDONLY &&
+	    S_ISREG(inode->i_mode)) {
+		struct smack_known *skp = smk_of_inode(inode);
+
+		if (smk_preserve_allowed(skp))
+			tsp->smk_preserve = skp;
+	}
+#endif
 
 	return rc;
 }
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 6e62dcb36..b1a350365 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -62,6 +62,9 @@ enum smk_inos {
 	SMK_NET6ADDR	= 23,	/* single label IPv6 hosts */
 #endif /* CONFIG_IPV6 */
 	SMK_RELABEL_SELF = 24, /* relabel possible without CAP_MAC_ADMIN */
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	SMK_PRESERVE_WL	= 25,	/* preserve whitelist labels */
+#endif
 };
 
 /*
@@ -2867,6 +2870,97 @@ static const struct file_operations smk_ptrace_ops = {
 	.llseek		= default_llseek,
 };
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/*
+ * Seq_file operations for /smack/preserve-whitelist.
+ * Iterates the whitelist and shows each preservable label.
+ */
+static void *preserve_wl_seq_start(struct seq_file *s, loff_t *pos)
+{
+	mutex_lock(&smk_preserve_wl_lock);
+	return seq_list_start(&smk_preserve_wl, *pos);
+}
+
+static void *preserve_wl_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &smk_preserve_wl, pos);
+}
+
+static void preserve_wl_seq_stop(struct seq_file *s, void *v)
+{
+	mutex_unlock(&smk_preserve_wl_lock);
+}
+
+static int preserve_wl_seq_show(struct seq_file *s, void *v)
+{
+	struct smk_preserve_wl *e = list_entry(v, struct smk_preserve_wl, list);
+
+	seq_printf(s, "%s\n", e->skp->smk_known);
+	return 0;
+}
+
+static const struct seq_operations preserve_wl_seq_ops = {
+	.start = preserve_wl_seq_start,
+	.next  = preserve_wl_seq_next,
+	.stop  = preserve_wl_seq_stop,
+	.show  = preserve_wl_seq_show,
+};
+
+static int smk_open_preserve_wl(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &preserve_wl_seq_ops);
+}
+
+static ssize_t smk_write_preserve_wl(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct smack_known *skp;
+	char *data, *label;
+	bool on = true;
+
+	if (!smack_privileged(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	data = memdup_user_nul(buf, count);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	label = strim(data);
+	if (!label[0]) {
+		kfree(data);
+		return -EINVAL;
+	}
+
+	/* A leading '-' removes the label (same convention as revoke-subject). */
+	if (label[0] == '-') {
+		on = false;
+		label = strim(label + 1);
+		if (!label[0]) {
+			kfree(data);
+			return -EINVAL;
+		}
+	}
+
+	skp = smk_find_entry(label);
+	if (!skp) {
+		kfree(data);
+		return -ENOENT;
+	}
+
+	smk_preserve_set(skp, on);
+	kfree(data);
+	return count;
+}
+
+static const struct file_operations smk_preserve_wl_ops = {
+	.open		= smk_open_preserve_wl,
+	.read		= seq_read,
+	.write		= smk_write_preserve_wl,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+#endif /* CONFIG_SECURITY_SMACK_COPYWHITELIST */
+
 /**
  * smk_fill_super - fill the smackfs superblock
  * @sb: the empty superblock
@@ -2933,6 +3027,11 @@ static int smk_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SMK_RELABEL_SELF] = {
 			"relabel-self", &smk_relabel_self_ops,
 				S_IRUGO|S_IWUGO},
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+		[SMK_PRESERVE_WL] = {
+			"preserve-whitelist", &smk_preserve_wl_ops,
+				S_IRUGO|S_IWUSR},
+#endif
 		/* last one */
 			{""}
 	};
-- 
2.43.0

