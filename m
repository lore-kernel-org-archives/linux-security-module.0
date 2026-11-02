Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608812;
	b=P1Vp5XIQKKJc0QHi//1sHEAEC8yYd4dFU2vq6PY/g/pvsPBv2qZy0K4HL1I5QCsYlBD4
	 lZqufp5oyBdTUl9Nyo8C2i26/HzDue1aHSgm7PeJG9vUr+f6HI8pQL/y75NkXkdeId/ad
	 i4Xwaf22b8TX+yXDkPEGTiqFGyn21G+Dj0DJn7GCMbrgWG5DKckN8obXykjQcW90rNu/0
	 1nWAlAHh9jauQtI9lWDLdhS76YDuk0gCa3V9YJn2TMGn7BsbulWLnfdGeUL6/CNcHrTuD
	 IyYzUDMufJq+myD3tzKBd83iJNpE4hEsr9K3625git9Vk30Hw0cDGQDtiJnzikUcceA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608812;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Cgrhvo3VxJJJmAKt6I0+VM3NFlM3+bYGNW/fAtAfebI=;
	b=LOeKj0h/YKON33JB8RHwsdUAD213/CaGYQC9ZOyLDETGKhBillunpg1qxfyM39nQ4/D/
	 9uUDyigP4/7kz2FcKZMo+1cNFL1JWcRPlwORiPKCtwUJWteXykSxNGGpg0KvsSrtMldmj
	 CMC0AaBFxehJDXfQ3rpGZGjEWJDFBV+MuCaWOmFgLhSKo9kvQo4kP8BZLDlFfyen5txYy
	 Vt6XDtD+Pnj5p3FjTSj3AO+uUlpddc8lbLsb2tULnhk4xRchwYwN1SPhlyPIaFlWW12eM
	 ARA1dbXVaf5F0dHMQuIXZyh39rTGgF3k3EqjZg6SC6ucBT/xApEBj2QjgKa3Vx2OEdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yhkylin.cn;
	spf=none smtp.mailfrom=yhkylin.cn;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C4606A326
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 08:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 971C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yhkylin.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yhkylin.cn
X-QQ-mid: zesmtpip4t1793608795tbd75e08c
X-QQ-Originating-IP: ba0SaUM+gAXFcKv8x4jHoVimitiYyMbxt+qnEFHnioU=
Received: from tpk-ROG-Zephyrus-M16-GU603ZM-GU ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 02 Nov 2026 16:39:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12032853667310488715
EX-QQ-RecipientCnt: 4
From: Tang Pengke <tangpengke@yhkylin.cn>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org,
	gaolong <gaolong@yhkylin.cn>,
	Tang Pengke <tangpengke@yhkylin.cn>
Subject: [PATCH v4] smack: preserve low-integrity labels across file copy via whitelist
Date: Mon,  2 Nov 2026 16:39:48 +0800
Message-ID: <E15125BD8A613CBE+20261102083948.205176-1-tangpengke@yhkylin.cn>
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
X-QQ-XMAILINFO: OCzrAMkunIir75N7ipFh/237u2J1NNQhetQD6pa6U/9LCd+9YBqr8FHp
	hBhyeJ17TFL+G5Q1IkufjEvTrA/Gf6fI7MxdRtMbKw6IfAg4mQmrU+f4UiCSS7H4qcZnwVB
	cmuR3t28bP163Be0EXwApXVwZxEcYpqw0kkIcNM3qD0Kf0cDQJdYMYcijmYI9nd9LDKnRBU
	lxMRFXUXUtV86Bvo+rGjNzPmBDLu0eDh+HxGcE7Axq8cVFSdYfP3kltyzqC5AMKsMjqWNvx
	+yfkmSkzt5hG24vg/WSnWaVzPfJm8xFeo3HUQDRtIsRTIG5Wm6aiq7jHHQt0Ua6y/4hXoBl
	PpKBfIZTPTXuli1uiIFVsG0W12xqa/S6kgEftq59Ol/WXeXeMjwA5bRl2HzjEjjDJOBfbf2
	sG5dvQGxXvslNTc5T1a37miqkTRz75QEPnl8g/LE9fge//ot+odQaT1/BB+sOgeDbQMFN4L
	0U8H6cQAeUwHNgeS7cSVPvvZf/De6ClqmEnO7XeQZSJge4/c7Z2hzJL3M/ag1jJvCZgpnqQ
	IHpEWAy9C9OLdSo8fndtkPwix9Kvy4fPvE1nposeDhrErcPypyK1y1Tp9qhiXOI4Y34tUeH
	t5i3yOOjmmZBCYaJMIQ3Fq0CkRdP8JjastO7LYhXtOoWqY1Ya2VmtOqJqJWyedp+PvCY8qm
	KWErFv8DSARxsYOzKPBjY8NEsjHS3ciVQmvnIMSc/fpJi9aa6fTFeqb9tbD/oz35hfo2fGf
	6XY/A7cCwJn/CjyxNrjRjnMuXac6mLKiOYQFVYbj6zq1G5cqoSs6wxq9roBkPredrsw3mkm
	zgq08hiBjnJ7LidNH6Um+Bv+KEVSi1TtYAQhF7XxUHxGHZsdZaRvGmWOvdObV1IAwZcFF9k
	PI9kYwDif08XA58wA/P4s33j4iMREAt5E2OF4zRau/k5i63isasr4CWI+9H9a6ZYdERuHe9
	/1JmIp3neXRX953qHTEAUnWdDQWEya5IeXfQL7N0Iwt/2vyhOqcG35YwWHKiLSmy7BTe1EU
	Kv5y11D5m+wtZZOkmAH3hwcUK4rPYccl5sXRdpnD5drNEFm1+IP/+bTnQU9C4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Files copied from an untrusted channel (USB, network, serial) inherit the
creating process's Smack label, losing the source's label.  That breaks
provenance and lets a file from an untrusted source silently acquire a
trusted label.

Record a "preserve" label when a process opens a whitelisted regular file
read-only and the read check passes.  The next inode it creates inherits
that label instead of the process label, unless transmutation applies.
The record is one-shot: consumed on creation, dropped when transmutation
takes precedence, cleared on exec, and not inherited across fork.

An overwrite -- O_TRUNC on a file that already exists -- never reaches
inode_init_security(), so the contents would come from the untrusted
source while the file kept its old label.  The record is therefore also
handed to an overwrite target at open time and written back when the file
is released, which is the first point where the inode lock is gone and
the xattr can be updated.  Only a target that carries the task's own
label, or one already carrying a preservable label, is relabelled; a
trusted file keeps its label.

The source record lives in a per-task LSM blob rather than in the cred.  A
cred is immutable once committed and is shared by every thread of a
process; writing the record there would be a data race between threads,
and one thread could consume a label another thread had just recorded.
The overwrite record lives in the file blob instead, so two overwrites in
flight cannot clobber each other.

The preservable labels form a whitelist exposed through
/smack/preserve-whitelist.  Only untrusted-channel / low-integrity labels
should be added.  Recording happens only after a successful read check, so
a process cannot create a file with a label it could not read (which
would be a write-down primitive), and because the whitelist holds only low
labels the mechanism can only ever preserve a low label, never a system
trusted or sensitive one.  An empty whitelist is also the fast path in
smack_file_open().

Known limitation: the kernel cannot distinguish a copy from an unrelated
create, so a task that opens a whitelisted file and then creates an
unrelated file will label the latter with the preserved low label.
Restricting the whitelist to low-integrity labels bounds the impact.

The whole mechanism is guarded by CONFIG_SECURITY_SMACK_COPYWHITELIST,
which defaults to no.  With the option off nothing is compiled in: no
hooks are registered, the file blob keeps its original size, and the
existing accessors are unchanged, so the default Smack behavior is
unaffected and the patch is purely additive.

Signed-off-by: Tang Pengke <tangpengke@yhkylin.cn>
---
Changes in v4:
- Narrow the preserve-label scope: only labels listed on preserve-whitelist
  are recorded, and the list holds untrusted-channel labels only.  This
  keeps shared-library loads from ever arming a record and makes the
  write-down primitive impossible by construction rather than by policy.
- Move record clearing from bprm_creds_for_exec to bprm_committing_creds.
  The former also runs for AT_EXECVE_CHECK and for execs that fail later,
  which would discard a still-valid record.
- Skip FMODE_EXEC opens in smack_file_open so the exec path never arms a
  record.
- Require MAY_WRITE on the recorded label before inheriting it in
  smack_inode_init_security.  A task that may read a label but not write
  it must not be able to mint a file carrying that label.
- Skip FMODE_CREATED opens in smack_file_open: the create already consumed
  the record, and re-arming it there would turn the one-shot record into
  an endless source.
- Handle overlayfs copy-up: set a one-shot smk_copy_up marker in
  smack_inode_copy_up and skip both transmutation and any pending record
  in smack_inode_init_security, so the upper inode keeps the lower label
  instead of being relabelled with the upper directory's label.
- Propagate allocation failure from smk_preserve_set() instead of
  silently ignoring it.
- Validate the preserve-whitelist write path: reject ppos != 0 and
  count == 0 or count > SMK_LONGLABEL, and import the label so it is
  interned like every other label.
- Carry the label across an overwrite too.  Opening an existing file with
  O_TRUNC never reaches inode_init_security(), so the contents could come
  from an untrusted source while the file kept its old label; an
  executable file would then run untrusted content.  Hand the record to
  the target at open time and write it back in file_free_security(),
  which runs outside the inode lock.  Only a target carrying the task's
  own label, or one already carrying a preservable label, is relabelled,
  so a trusted file cannot be downgraded this way.  The record lives in
  the file blob rather than the task blob, so two overwrites in flight in
  one task cannot clobber each other's record.
- Drop a preserve record when its source file is released.  If the copy
  never creates anything, the record survived and was then inherited by
  an unrelated later create.  Store the source inode with the record and
  clear both in a new file_free_security hook.
- Take smk_preserve_wl_lock in the seq_file iterator.
- Take the inode lock around the release-time setxattr.  Filesystems such
  as UBIFS assert inode_is_locked() in their xattr_set handler, so calling
  __vfs_setxattr_noperm() without it trips the assertion and puts the
  filesystem into read-only mode.
- All of the above is inside CONFIG_SECURITY_SMACK_COPYWHITELIST.  With the
  option off nothing is compiled in: no hooks are registered, the file blob
  keeps its original size, and smack_file() and its callers are unchanged.

 security/smack/Kconfig        |  21 +++
 security/smack/smack.h        |  61 +++++++++
 security/smack/smack_access.c |  78 +++++++++++
 security/smack/smack_lsm.c    | 250 ++++++++++++++++++++++++++++++++++
 security/smack/smackfs.c      | 120 ++++++++++++++++
 5 files changed, 530 insertions(+)

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
index 9b9eb262f..fd366425d 100644
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
@@ -126,6 +145,21 @@ struct task_smack {
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
+	struct inode		*smk_preserve_inode;	/* inode the record came from */
+	bool			smk_copy_up;	/* overlayfs copy-up in progress */
+};
+#endif
+
 #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
 #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
 #define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
@@ -312,6 +346,10 @@ bool smack_privileged(int cap);
 bool smack_privileged_cred(int cap, const struct cred *cred);
 void smk_destroy_label_list(struct list_head *list);
 int smack_populate_secattr(struct smack_known *skp);
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+bool smk_preserve_allowed(struct smack_known *skp);
+int smk_preserve_set(struct smack_known *skp, bool on);
+#endif
 
 /*
  * Shared data.
@@ -326,6 +364,10 @@ extern struct smack_known *smack_unconfined;
 #endif
 extern int smack_ptrace_rule;
 extern struct lsm_blob_sizes smack_blob_sizes;
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+extern struct list_head smk_preserve_wl;
+extern struct mutex smk_preserve_wl_lock;
+#endif
 
 extern struct smack_known smack_known_floor;
 extern struct smack_known smack_known_hat;
@@ -352,12 +394,31 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
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
 				       smack_blob_sizes.lbs_file);
 }
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/*
+ * Per-file overwrite record, stored right after smack_file().  Keeping it
+ * separate leaves the existing blob layout untouched when the feature is
+ * off, and two overwrites in flight cannot clobber each other's record.
+ */
+static inline struct smack_known **smack_file_overwrite(const struct file *file)
+{
+	return smack_file(file) + 1;
+}
+#endif
+
 static inline struct inode_smack *smack_inode(const struct inode *inode)
 {
 	return inode->i_security + smack_blob_sizes.lbs_inode;
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 350b88d58..421d76212 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -53,6 +53,84 @@ static u32 smack_next_secid = 10;
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
+int smk_preserve_set(struct smack_known *skp, bool on)
+{
+	struct smk_preserve_wl *e, *new = NULL;
+
+	if (on) {
+		new = kzalloc_obj(*new, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
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
+	return 0;
+}
+#endif /* CONFIG_SECURITY_SMACK_COPYWHITELIST */
+
 /**
  * smk_access_entry - look up matching access rule
  * @subject_label: a pointer to the subject's Smack label
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c..e18f06f03 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -944,6 +944,23 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/**
+ * smack_bprm_committing_creds - exec is about to commit the new creds
+ * @bprm: the exec information
+ *
+ * Every failure path has been passed at this point, so a pending copy
+ * record is stale.  Clearing it here rather than in the earlier
+ * bprm_creds_for_exec hook matters: that hook also runs for
+ * AT_EXECVE_CHECK and for execs that fail afterwards, and clearing there
+ * would drop the record even though no exec happened.
+ */
+static void smack_bprm_committing_creds(const struct linux_binprm *bprm)
+{
+	smack_task(current)->smk_preserve = NULL;
+}
+#endif
+
 /*
  * Inode hooks
  */
@@ -998,6 +1015,31 @@ xattr_dupval(struct xattr *xattrs, int *xattr_count,
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/**
+ * smack_copy_up_begin - consume the one-shot overlayfs copy-up marker
+ *
+ * Overlayfs creates the upper inode through inode_init_security() and must
+ * keep the lower label.  The marker makes that path leave both the inode
+ * and any pending copy record alone, so it is consumed here, before either
+ * branch below can look at it.
+ */
+static bool smack_copy_up_begin(void)
+{
+	struct smack_task *stp = smack_task(current);
+	bool copy_up = stp->smk_copy_up;
+
+	if (copy_up)
+		stp->smk_copy_up = false;
+	return copy_up;
+}
+#else
+static inline bool smack_copy_up_begin(void)
+{
+	return false;
+}
+#endif
+
 /**
  * smack_inode_init_security - copy out the smack from an inode
  * @inode: the newly created inode
@@ -1019,6 +1061,10 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	int transflag = 0;
 	bool trans_cred;
 	bool trans_rule;
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	bool transmutes;
+	bool copy_up = smack_copy_up_begin();
+#endif
 
 	/*
 	 * UNIX domain sockets use lower level socket data. Let
@@ -1037,6 +1083,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	trans_cred = (tsp->smk_task == tsp->smk_transmuted);
 	if (!trans_cred)
 		trans_rule = smk_rule_transmutes(smk_of_task(tsp), dsp);
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	transmutes = trans_cred || (trans_rule && smk_inode_transmutable(dir));
+#endif
 
 	/*
 	 * In addition to having smk_task equal to smk_transmuted,
@@ -1044,7 +1093,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	 * requests transmutation then by all means transmute.
 	 * Mark the inode as changed.
 	 */
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	if (!copy_up && transmutes) {
+#else
 	if (trans_cred || (trans_rule && smk_inode_transmutable(dir))) {
+#endif
 		/*
 		 * The caller of smack_dentry_create_files_as()
 		 * should have overridden the current cred, so the
@@ -1066,6 +1119,33 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		}
 	}
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	/*
+	 * If a whitelisted label was recorded on file open, inherit it so
+	 * the new file keeps the source's (low-integrity) label across the
+	 * copy.  Two cases take precedence, and the record is one-shot so
+	 * it is dropped either way:
+	 *
+	 *  - a copy-up, which must keep the lower label untouched;
+	 *  - a transmutation, otherwise the record would leak into a later
+	 *    create in a non-transmutable directory.
+	 *
+	 * The record is only inherited when the task may also write the
+	 * label.  A task that can read skp but not write it must not be
+	 * able to mint a file carrying skp -- that would be a write into a
+	 * domain the policy keeps it out of.
+	 */
+	if (!copy_up) {
+		struct smack_known *skp = smack_task(current)->smk_preserve;
+
+		if (skp != NULL && !transmutes &&
+		    smk_tskacc(tsp, skp, MAY_WRITE, NULL) == 0)
+			issp->smk_inode = skp;
+		smack_task(current)->smk_preserve = NULL;
+		smack_task(current)->smk_preserve_inode = NULL;
+	}
+#endif
+
 	if (rc == 0)
 		if (xattr_dupval(xattrs, xattr_count,
 			    XATTR_SMACK_SUFFIX,
@@ -2068,10 +2148,160 @@ static int smack_file_open(struct file *file)
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 	rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
 	rc = smk_bu_credfile(file->f_cred, file, MAY_READ, rc);
+	if (rc)
+		return rc;
+
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	struct smack_task *stp = smack_task(current);
+
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
+	 * Skip files this open created (FMODE_CREATED): the create already
+	 * consumed the record, and re-arming it here would turn the
+	 * one-shot into an endless source of copies.  Skip exec opens
+	 * (FMODE_EXEC) as well; the exec path must not arm a record, and
+	 * an exec that later fails would otherwise leave one behind.
+	 *
+	 * The list_empty() check is a lockless fast path.  A concurrent
+	 * whitelist update can only make us miss recording once; it can
+	 * never make us record a label that is not on the list, because
+	 * the authoritative test is smk_preserve_allowed() below, which
+	 * does take the lock.
+	 */
+	if (!(file->f_mode & (FMODE_CREATED | FMODE_EXEC)) &&
+	    !list_empty(&smk_preserve_wl) &&
+	    (file->f_flags & O_ACCMODE) == O_RDONLY &&
+	    S_ISREG(inode->i_mode)) {
+		struct smack_known *skp = smk_of_inode(inode);
+
+		if (smk_preserve_allowed(skp)) {
+			stp->smk_preserve = skp;
+			stp->smk_preserve_inode = inode;
+		}
+	}
+
+	/*
+	 * An overwrite skips inode_init_security(), so hand the record to
+	 * the file and apply it on release.  O_TRUNC is still set here:
+	 * do_dentry_open() prunes it only after security_file_open(), and
+	 * handle_truncate() runs later still.  That is why the
+	 * file_truncate hook cannot serve instead -- by then the flag is
+	 * gone and ftruncate(2) is indistinguishable.
+	 *
+	 * Only a file carrying the task's own label, or a preservable one,
+	 * is relabelled; a trusted file keeps its label.
+	 */
+	if (stp->smk_preserve != NULL &&
+	    !(file->f_mode & FMODE_CREATED) &&
+	    (file->f_flags & O_ACCMODE) == O_WRONLY &&
+	    (file->f_flags & O_TRUNC) &&
+	    S_ISREG(inode->i_mode)) {
+		struct smack_known *tgt = smk_of_inode(inode);
+
+		if ((tgt == smk_of_task(tsp) || smk_preserve_allowed(tgt)) &&
+		    smk_tskacc(tsp, tgt, MAY_WRITE, NULL) == 0)
+			*smack_file_overwrite(file) = stp->smk_preserve;
+		stp->smk_preserve = NULL;
+		stp->smk_preserve_inode = NULL;
+	}
+#endif
 
 	return rc;
 }
 
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/**
+ * smk_relabel_on_release - give a file the label of what was copied into it
+ * @file: the file being released
+ * @skp: label to apply
+ *
+ * Write the xattr before adopting the label in memory, so a failed write
+ * leaves the inode matching the disk.
+ *
+ * __vfs_setxattr_noperm() skips security_inode_setxattr() on purpose:
+ * vfs_setxattr() would reach smack_inode_setxattr() and demand
+ * CAP_MAC_ADMIN, while the label was already vetted in smack_file_open()
+ * against a narrower rule.
+ */
+static void smk_relabel_on_release(struct file *file, struct smack_known *skp)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct inode *inode = d_inode(dentry);
+	struct inode_smack *isp = smack_inode(inode);
+	int rc;
+
+	if (isp->smk_inode == skp)
+		return;
+
+	/*
+	 * __vfs_setxattr_noperm() requires the inode lock: filesystems such
+	 * as UBIFS assert inode_is_locked() in their xattr_set handler.
+	 * __fput() runs from task_work, so taking the lock here is safe.
+	 */
+	inode_lock(inode);
+	rc = __vfs_setxattr_noperm(file_mnt_idmap(file), dentry,
+				   XATTR_NAME_SMACK,
+				   skp->smk_known, strlen(skp->smk_known), 0);
+	inode_unlock(inode);
+
+	if (rc == 0)
+		isp->smk_inode = skp;
+}
+#endif
+
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+/**
+ * smack_file_free_security - finish a copy, drop stale records
+ * @file: the file being freed
+ *
+ * Two records can be outstanding:
+ *
+ *  - the overwrite label, kept in the file blob.  Its contents are
+ *    complete and the inode lock is gone, so this is the first safe
+ *    point to write it back;
+ *  - a source record, kept in the task blob, whose source is released
+ *    before any create consumed it.  It is stale; dropping it keeps an
+ *    unrelated later create from inheriting a label it never read.
+ *
+ * The task blob lookup uses current.  fput() normally defers to
+ * task_work on the closing task, which is correct; should it fall back
+ * to ____fput() from a workqueue the lookup misses and the stale record
+ * survives until the next open of a whitelisted file replaces it.  The
+ * overwrite record is unaffected because it lives in the file blob.
+ */
+static void smack_file_free_security(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct smack_task *stp = smack_task(current);
+	struct smack_known *skp = *smack_file_overwrite(file);
+
+	if (skp != NULL) {
+		*smack_file_overwrite(file) = NULL;
+		smk_relabel_on_release(file, skp);
+	}
+
+	if (stp->smk_preserve_inode == inode) {
+		stp->smk_preserve = NULL;
+		stp->smk_preserve_inode = NULL;
+	}
+}
+#endif
+
 /*
  * Task hooks
  */
@@ -4983,6 +5213,15 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	isp = smack_inode(d_inode(dentry));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	/*
+	 * The copy-up creates upper inodes through the normal create
+	 * path.  Tell smack_inode_init_security() to leave those alone:
+	 * they must keep the lower label, and a pending copy record
+	 * would otherwise be consumed by an internal overlayfs create.
+	 */
+	smack_task(current)->smk_copy_up = true;
+#endif
 	*new = new_creds;
 	return 0;
 }
@@ -5106,7 +5345,12 @@ static int smack_uring_cmd(struct io_uring_cmd *ioucmd)
 
 struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct task_smack),
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	.lbs_task = sizeof(struct smack_task),
+	.lbs_file = 2 * sizeof(struct smack_known *),
+#else
 	.lbs_file = sizeof(struct smack_known *),
+#endif
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_key = sizeof(struct smack_known *),
@@ -5137,6 +5381,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_set_mnt_opts, smack_set_mnt_opts),
 
 	LSM_HOOK_INIT(bprm_creds_for_exec, smack_bprm_creds_for_exec),
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	LSM_HOOK_INIT(bprm_committing_creds, smack_bprm_committing_creds),
+#endif
 
 	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
 	LSM_HOOK_INIT(inode_init_security, smack_inode_init_security),
@@ -5172,6 +5419,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_receive, smack_file_receive),
 
 	LSM_HOOK_INIT(file_open, smack_file_open),
+#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
+	LSM_HOOK_INIT(file_free_security, smack_file_free_security),
+#endif
 
 	LSM_HOOK_INIT(cred_alloc_blank, smack_cred_alloc_blank),
 	LSM_HOOK_INIT(cred_free, smack_cred_free),
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 6e62dcb36..5023c30fb 100644
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
@@ -2867,6 +2870,118 @@ static const struct file_operations smk_ptrace_ops = {
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
+	int rc;
+
+	if (!smack_privileged(CAP_MAC_ADMIN))
+		return -EPERM;
+
+	if (*ppos != 0)
+		return -EINVAL;
+
+	if (count == 0 || count > SMK_LONGLABEL)
+		return -EINVAL;
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
+	/*
+	 * Import the label when adding.  Boot-time policy may name a label
+	 * that no inode, rule or mount has referenced yet, in which case it
+	 * is not in smack_known_hash.  Removal only needs the existing entry.
+	 */
+	if (on) {
+		skp = smk_import_entry(label, 0);
+		if (IS_ERR(skp)) {
+			rc = PTR_ERR(skp);
+			kfree(data);
+			return rc;
+		}
+	} else {
+		skp = smk_find_entry(label);
+		if (!skp) {
+			kfree(data);
+			return -ENOENT;
+		}
+	}
+
+	rc = smk_preserve_set(skp, on);
+	kfree(data);
+	return rc ? rc : count;
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
@@ -2933,6 +3048,11 @@ static int smk_fill_super(struct super_block *sb, struct fs_context *fc)
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

