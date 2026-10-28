Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204144;
	b=YEmM++yx20ZOAEzegPTLjlv7BTI48yjjdZdhIVcWCHome/S8QMZLfMtcUswNN6lh6FPu
	 KB71dCd2gEFBF26NIr2UnjJ7gxtOnqcJcGJwealM9N9LulN8kAUqw85UJIolPLgI1+5gZ
	 f2xmq/ehWmXQFNRgQ2qUlmE4aP+fYS4fZMSc6JXjCWdYYAKwp7xSSNLtJM7MSmXuXAIJI
	 zR9nt/y5vGmqZykGfetwZUyXNHgIgObAiTs5D+Ls9+EtMIHZbG58CnC6njuayNfzxVZeR
	 puAdCyDFWmPPhLugKH3dpWzaF5Q7c95YQCnWNL1em9jNeAV9C9LKdhjhdUvmWz4v1zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204144;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=f0gG/oiTbPwssGFfHpUZ+eJy9vdAJDLgpDX8KfmVcHE=;
	b=TCIkdDTaYRJExMXBiMKccXAWWyo9BGMrfNt2a8U1fMlQsFmDWgxV5M2BSMe8knDSMKLC
	 o/MGfR3AEjLirn3ilQXQVbRjN/n6czjhPr4OePfhKC5BwbceQQOLkQU0nWRnzBBYapijF
	 puxRDp4kJp2U1P0SKlBTMYyl/zpFNvLPMwSsk/cUnDg5LgISOnxtvU8tKgDiiOjvC5zy4
	 VSzQkVK+rpBMfUS6EoZV1vcDNPWU6xN0A6ag0cb+rY7gv6QKXUBQFC+AzHoIOqQuvfnym
	 11YkjcVr01GeQcC71EoHTrskh9m2kHTQCCAcY7STK0oXoS86+tFo8WDM7mruQMPG1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yhkylin.cn;
	spf=none smtp.mailfrom=yhkylin.cn;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A6606A329
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 16:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB2A6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yhkylin.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yhkylin.cn
X-QQ-mid: zesmtpip2t1793204132t7dd59bea
X-QQ-Originating-IP: H9wdYdlbltiSWYhG/qHgpJqQkHrrsvFZQ13otrk+Hic=
Received: from tpk-ROG-Zephyrus-M16-GU603ZM-GU ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 00:15:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5573839828363948745
EX-QQ-RecipientCnt: 4
From: Tang Pengke <tangpengke@yhkylin.cn>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org,
	gaolong <gaolong@yhkylin.cn>,
	Tang Pengke <tangpengke@yhkylin.cn>
Subject: [PATCH v3] smack: preserve low-integrity labels across file copy via whitelist
Date: Thu, 29 Oct 2026 00:15:21 +0800
Message-ID: <684C81A1C8289709+20261028161521.925644-1-tangpengke@yhkylin.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:yhkylin.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MPJYVnIUgYPGJTj3djVL/UgH384K7IstCIsi6VliMIT75nQNWN3fYEwf
	b1+Oj0++GBYrv+/eL+4LFQHRlZn5l+9A/ZIJfTCzGQwnMqVHrS4EbqE7rifu0F0gPeEVgE2
	TLAriTlEqgi3iu2Ex0R/3XmcR13ZSYyBPFBUc89YZrPSZ72SPZ/YFXt0cF1aXgxnjTWVjb5
	2TwJZVWeg5vkvXF5VcNr2B717JFyR7YmG7XpLqZzIDNYr6QdTVrLNPT9v5ExqncRkHYPOWb
	saVJNDhSjLxaq7DYBRuRaANxMyUXT1Tj7+swihbP49Xup6E3GP4/du+ucgkOInsecKB9Do5
	1H0lzbm9+DZ8tcm7i3zE0K5vLjako8m7BWBlV5FVY2oyTQVyCLc90Wzt5wndRPcIHxxpbnr
	NtN5Mw7nMd/oaNEBhwM+Ev5BZg7M3D2a90NkjdbQxsCi3OI+cKNsYE7OnWTtabs9nLRiCy8
	edHIG5dMtujpUKW2tnYtz7E3VdLeeAynv+MmP762/JhNEx3MOy9rouqaS22FRAZGszn5fhZ
	oCqXbDmkLO+P85POlDBc1dMNBfuqkmCLD2QeMSDVM/DwpHOZnXujUxpdJ1NZ3f37NdZH3w+
	h832T08w9zQf6M2szn7Zu8e1LpDOgOdaNG042GSelb+GjHMf03zywXVCCecp4rkgzUVB2Or
	jBR7lLOTdOrTfNXzpQx8qzGJ+oDb1nJlFjqrvoTYgyyIhKu/QyMNhOx7cyJvIhUZOSg2XWZ
	cLw32k8j0E+vTz8jElzIugjHmft8nCyJ9HXTRu82UzoSpo68iGR+X36jviolbjyFPdO1V7N
	lfG0v7rSQikIJzt13JzuIXkitjIzL1BheiNLf4n8Y2XtOQkMIEFKz/21+Xr6dI2BaOZ/H/p
	2Fbfyt/FXdXdXizT0UJJuXjnc7UQrZrCt1Da6mHdfjdsJs+3zjBRsdD+2xpO0ggC9xpZDVU
	MQG8JOp5XfPMyVZYFWqgkHs+CYJ80oW5GOdtsvcbEmO6o+9NfhXxGyfqxCNhdnUQNKwOaR4
	iitLPwHYFBYkWQPje4hY8j0tAD/nTC8bjTWiVAAWgItKS8rkTD
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Files copied from an untrusted channel (USB, network, serial) inherit
the creating process's Smack label, losing the source's label.  That
breaks provenance and lets a file from an untrusted source silently
acquire a trusted label.

Record a "preserve" label when a process opens a whitelisted regular
file read-only and the read check passes.  The next inode it creates
inherits that label instead of the process label, unless transmutation
applies.  The record is one-shot: consumed on creation, dropped when
transmutation takes precedence, cleared on exec, and not inherited
across fork.

The record lives in a per-task LSM blob rather than in the cred.  A cred
is immutable once committed and is shared by every thread of a process;
writing the record there would be a data race between threads, and one
thread could consume a label another thread had just recorded.  The
copy intent belongs to a single thread, so a task blob is the right
home for it.

The preservable labels form a whitelist exposed through
/smack/preserve-whitelist.  Only untrusted-channel / low-integrity
labels should be added.  Recording happens only after a successful
read check, so a process cannot create a file with a label it could
not read (which would be a write-down primitive), and because the
whitelist holds only low labels the mechanism can only ever preserve a
low label, never a system trusted or sensitive one.  An empty
whitelist is also the fast path in smack_file_open().

Known limitation: the kernel cannot distinguish a copy from an
unrelated create, so a task that opens a whitelisted file and then
creates an unrelated file will label the latter with the preserved low
label.  Restricting the whitelist to low-integrity labels bounds the
impact.

The whole mechanism is guarded by CONFIG_SECURITY_SMACK_COPYWHITELIST,
which defaults to no, so the default Smack behavior is unchanged.

Signed-off-by: Tang Pengke <tangpengke@yhkylin.cn>
---
Changes in v3:
- Move the preserve record out of the cred into a per-task LSM blob.
  A cred is immutable once committed and is shared by all threads of a
  process; storing the record there raced between threads and violated
  the immutability contract.
- Drop a pending record when transmutation applies.  Previously the
  record survived that path and leaked into the next create in a
  non-transmutable directory.
- Clear the record on exec; it is not inherited across fork.
- Document the known limitation that a create unrelated to the copy
  still inherits the preserved low label.

 security/smack/Kconfig        | 21 ++++++++
 security/smack/smack.h        | 47 +++++++++++++++++
 security/smack/smack_access.c | 77 +++++++++++++++++++++++++++
 security/smack/smack_lsm.c    | 61 +++++++++++++++++++++
 security/smack/smackfs.c      | 99 +++++++++++++++++++++++++++++++++++
 5 files changed, 305 insertions(+)

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
index 9b9eb262f..03c83f338 100644
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
@@ -126,6 +145,19 @@ struct task_smack {
 	struct list_head	smk_relabel;	/* transit allowed labels */
 };
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/*
+ * Per-thread state for a single copy operation.  This is deliberately
+ * kept out of the cred: credentials are immutable once committed and are
+ * shared by every thread of a process, while the label to preserve
+ * belongs to one copy and must not be visible to, or raced by, the other
+ * threads.
+ */
+struct smack_task {
+	struct smack_known	*smk_preserve;	/* label to inherit on next create */
+};
+#endif
+
 #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
 #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
 #define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
@@ -312,6 +344,10 @@ bool smack_privileged(int cap);
 bool smack_privileged_cred(int cap, const struct cred *cred);
 void smk_destroy_label_list(struct list_head *list);
 int smack_populate_secattr(struct smack_known *skp);
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+bool smk_preserve_allowed(struct smack_known *skp);
+void smk_preserve_set(struct smack_known *skp, bool on);
+#endif
 
 /*
  * Shared data.
@@ -326,6 +362,10 @@ extern struct smack_known *smack_unconfined;
 #endif
 extern int smack_ptrace_rule;
 extern struct lsm_blob_sizes smack_blob_sizes;
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+extern struct list_head smk_preserve_wl;
+extern struct mutex smk_preserve_wl_lock;
+#endif
 
 extern struct smack_known smack_known_floor;
 extern struct smack_known smack_known_hat;
@@ -352,6 +392,13 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 	return cred->security + smack_blob_sizes.lbs_cred;
 }
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+static inline struct smack_task *smack_task(const struct task_struct *task)
+{
+	return task->security + smack_blob_sizes.lbs_task;
+}
+#endif
+
 static inline struct smack_known **smack_file(const struct file *file)
 {
 	return (struct smack_known **)(file->f_security +
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
index ff115068c..2ec48b932 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -906,6 +906,11 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
 	struct superblock_smack *sbsp;
 	int rc;
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	/* a new program starts with a clean copy record */
+	smack_task(current)->smk_preserve = NULL;
+#endif
+
 	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
@@ -1066,6 +1071,26 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		}
 	}
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	/*
+	 * If a whitelisted label was recorded on file open, inherit it so
+	 * the new file keeps the source's (low-integrity) label across the
+	 * copy.  Transmutation takes precedence: when it applies the record
+	 * is dropped, otherwise it would leak into a later create in a
+	 * non-transmutable directory.
+	 */
+	if (trans_cred || (trans_rule && smk_inode_transmutable(dir))) {
+		smack_task(current)->smk_preserve = NULL;
+	} else {
+		struct smack_known *skp = smack_task(current)->smk_preserve;
+
+		if (skp != NULL) {
+			issp->smk_inode = skp;
+			smack_task(current)->smk_preserve = NULL;
+		}
+	}
+#endif
+
 	if (rc == 0)
 		if (xattr_dupval(xattrs, xattr_count,
 			    XATTR_SMACK_SUFFIX,
@@ -2068,6 +2093,39 @@ static int smack_file_open(struct file *file)
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
+			smack_task(current)->smk_preserve = skp;
+	}
+#endif
 
 	return rc;
 }
@@ -5106,6 +5164,9 @@ static int smack_uring_cmd(struct io_uring_cmd *ioucmd)
 
 struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct task_smack),
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	.lbs_task = sizeof(struct smack_task),
+#endif
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
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

