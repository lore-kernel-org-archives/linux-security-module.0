Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9A012F38B
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647162; cv=none; b=oFx+hqwhzGCDncewvG3Yb+oWrRerOI8GlYcJ3ercnIKGD9cYFud75XiagR1DDNUUj8+eWF2XztYER9pnsUa/LKDK0+/WTWSlqvIKP+RajS57FK2cGrkUJO3B3djasqLfwCZB5wQ7Z8t2zZUC7MGVGaqeG27NTGNre4ubDsmDJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647162; c=relaxed/simple;
	bh=s/n3den+fdhxYj1+n3R7uBZdudROT0iZ8kwtNk/+J2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYlhWTEETWduthospzszWkz/5xFNPrHZh1i8Jo0wu2bV8W8vY/KlAfLPyqcGiU+778/0l/SmszzVQALXJORoCkjmI89IN7Fm/s2BSvkO3bkljk4YhtPXMulestjVeaY/zXnU2YjODHX0oUNe8xFi/xoPW2Lq1+yqp8ZeZAgnWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BBS4PLr0; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BBS4PLr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647159; bh=NGJI3yg+r6O8XjvFIsjyRNfKglWpLJo8h83/isXtWJ0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=BBS4PLr0eO6BR8+9z18sLK9Fk/KihZtctiWzCe1TMIAlkY4q1jq11cJfrA8rDlzmEJvIVWwmhffb3D3OO9KOJmsMih07sfD0SMupOZdtBB7WXMouASDJ/YFUo5adfhY6ypI0HrrikYu2j1vM9PBjDinNMUK/+8WpjOKKriFFf9CerxjX5Xfi/zWCpBRutTP6xbvI1eL4wHVU4p3qwp6sEpXIA86gb4FulvHJs5tsZwuc6naiKjT6pYTuILkMji+rRZvqfCZxIBB02UGP/rgLha8wfMYk1vZc2NwZmO+LKytxWAadyE6NEB4JdFPE2XgysPN1vXLwC7jbIDOXLQ3w4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647159; bh=uUe6T4J4Y1521ZrMcQTigaHisjFEQ4DBNs3J6+Y1Jz+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LIRm2mnPS9UKWR2yBDV4B741G5whm8P3aP8d7UEX9wJyv5eqawLnSAgaJMXZajVatIwexizGDT2RoKcu/AOQQTWRHnt+B/yAtEfvftSZI50d809Dppm8DGNqb6ZaxasqD8bQRmkhUfl0rg6eneSQNdlWu1WHX3QvavkJT0Js9v60XVO/lBXcP/9E+3VRTWmmJfTfJfyF72M/9+BuUQOKZBl8q57e3UBNq27Nndy5qhb/iO+ZsX9m58nZwxRruOFokaiVL/BSXiALF8gABRcUtR3UycB9tF855dzcBRkQg7LLPcdRrVMrmo4C1hu2enNQXQnyZB6R7oYMfZiE3rLDHg==
X-YMail-OSG: 2G4etvYVM1m.ZAfEKgJevN929tAN5qTA7Cu9tjbEUOqQBoHeZK8t0EM5uAOjMrY
 ZRgtpauOcUmpJLgdfpenJntWJzHWzCGVk9TzSCfFJidMBljv_WlejeL0Rihliri9pW66vY9S3MRE
 1ETgx4KHf0TrzFBUTg_aVG_FZ9Cimt5zeawvvaaexm8xk3o4U3XRNcwz66i03cw8n3WIRR2RElvF
 spAkon_NPUENHcBPbkrXOe9LvtG5aT1l2MDdZrMvywFixcWfYSv5WCkGXIfoQ1smrvxooMkfCAHn
 J20i3sScDzMnsw011QODfisacCyMh.MZeTHvfC6KCsmeEV_vmacKI_YB3HiPSMFQuaUFZGfYui13
 _Kb27RXGcF7wKs5EKCubOrdbirJLg5vD902oEzakvvaGZieHaQmBsl2rsYpCrxbyxWk51Hk2JBsL
 hQXaBsMQChweAysI9PPV9biL08qdgwoAHav92WZcfANL4X1EyorXI.EWvBDKWWwxxs5u1GQRYkzw
 e7HHsWtpQizWuC_qBAv0q3tsNAYblvrupSJb.5d734zzzM5asjVL3nbhyoMRwg9NuOjhCl_rFaPz
 JbgDxuGXLESnS3pr.4IkcPjdXzQkEDjYeiqcO5qMgTvocGt4g9MTFi7XNN0PqCOsmLk2ADYOJB0d
 72cVHNTESbrFZ2mLY7ebFPhc5a55uxytLt6z3WvNZq8tLpQpOjo5x9jD3NIFIBjg76AnLcLQl1X7
 R8WBS.NljZhhP6Vl.q1RFdxpc_ittubDssBRbAyCP0C.VixqUiYO4.eGJbFZN79bZUW0hl7G2EO7
 KoE6yUkEImYgxa.2Lz9aBB5wRQ4st7USTnDx3iRw.JSPkSmiKtfb3I2EKWF7JHVs.Qy9Nn96dY63
 YV5paSkLTvcX91UhPp54GuIf2lnhuoqCYXuX2hkhsarQSvlUJfBUOZ572NpfXSdUhCRccNmAGBDr
 0F.H_hIj6kVy7HAd_6xgibgigLvjgS2jL0.GBfO5X5yGKUxuMLP9J4WB9NXI4aOwI5CyxNSgJcnf
 d5LQwa_67cN88A7Tlz33WnJp3SfmucwkjFgLepzTA2_9.Xvu6XT__Q0JKawUWfiQzJFIPhvUmf_q
 iyocNkgNUIAMioP7ym4nXmVMpghnGj1hODdFVvemyutCeXYMTEgmD2tMFN.wRj2n8ADMGJeSaGO1
 UQ6wzHb.fGqCfM6KVAhd3JL5hmNnYtxbfGyDSHCdE22ksxmLVhRYleIt732ldiPgP.SGgKVvBE1U
 Y6V6_hhEphtoJKqV70H8pF._YUnGxGgfpPKQsbWfBFSfo2LD0HZ5Y0nGTs.ObbFGp5UlZ19EZOsB
 sNuttcYNJIO35XjUgApiB0N9sDHxgz8viCFf76oheK2OMvujeJDppU1ra6HTQrq8EPaLCVmmCtSI
 VEYZDCQXHrOCARO1Ho.jU2gBktAWTGvL8tQuDRcHVHNANgBP2gc1BH4oUteN4hz.5AmMVHK7YhCq
 xGPIkYw6rsAaymjsN3gNBKo.FqCkxpdqN3ZTH.CTXvzYzbDIXC7Gan6.L2ZZsxt.mf3Gshv8F.0O
 CTNoK8FTJwFmVNl9xVsLp.zHhmPoF6BtUu_X29GZJPXaCrn0KSmWsOwqJ38ZdxXjrEA5qrYL6WwK
 EtHZAGXLojUiVzCvq19alACyUfrHFFNBleTHyz8vxx.Ku4gT5r9dasQpQM4x7LjzETYNvXTfH2Y.
 72AxQxIhny13xbfcmuwcaYTv3kBTK4sce6ydjYkxFyWXKDyMxFUhP.cko92kxJoqvy8f8.w.eIuu
 z4auhrsWvZjup.T30IA9Bf0LrruaaF2Zx.LcCqMtKePrZ85t.ilPenqZAslvbfn5i64633InaHdl
 k4Ti.aOzX6e0rsw78nsvETNG.m4AJMqKYFHiw3mN1zJonNoiRmecWRw8WuzpAvtQUtniAnbSZK9s
 V9u27xNpR.XlW_S5vkybQJKxwobSa01XFwn_kz4rt8QOOlIM3kMGocNOqlbmxQUfg7d8Q9U8Zqtg
 XzfKBXbFHwBW0mpKGtNX4RXBBsojwvGegL7TCHvhQQzUbkdxqO8ACFJmaeqJxV9_K3GBpam.Jlx9
 l73Kx3bEZrTDJvfKKBAt4rV9QvTpQJ89uvqLSMJgWa2d.rAeg7qziACq2w6xrkDWm8fmiYVDRCfP
 I_U1eWeFbyJgS_FDgu8t.dGxt3zQOXqkOGQSb5tpfC_duP27i01K.SkwGmS2p1ZLJbJEiAqlJRLO
 mD4cfbSR7jMS4RpVtl.wcHmuCO.VQ.60Sk_rjZaCoQeOWehY3JgUnM2Eu5WaCwvCQWzLSkvF8GaJ
 BsZg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d565065a-3915-4bc3-9a36-b30bb40b4164
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2024 21:32:39 +0000
Received: by hermes--production-gq1-799bb7c8cf-hxpdl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6067ff4c38dc9a73b3d19ab334e8cbec;
          Wed, 10 Jul 2024 21:32:37 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	mic@digikod.net
Subject: [PATCH v2 2/6] LSM: Infrastructure management of the key security blob
Date: Wed, 10 Jul 2024 14:32:26 -0700
Message-ID: <20240710213230.11978-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710213230.11978-1-casey@schaufler-ca.com>
References: <20240710213230.11978-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move management of the key->security blob out of the individual security
modules and into the security infrastructure. Instead of allocating the
blobs from within the modules the modules tell the infrastructure how
much space is required, and the space is allocated there.  There are
no existing modules that require a key_free hook, so the call to it and
the definition for it have been removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  1 -
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 39 +++++++++++++++++++++++++++++--
 security/selinux/hooks.c          | 21 ++++-------------
 security/selinux/include/objsec.h |  7 ++++++
 security/smack/smack.h            |  7 ++++++
 security/smack/smack_lsm.c        | 31 +++++++++++-------------
 7 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 44488b1ab9a9..cc81f7f7c024 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -402,7 +402,6 @@ LSM_HOOK(int, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,
 #ifdef CONFIG_KEYS
 LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
 	 unsigned long flags)
-LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
 LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
 	 enum key_need_perm need_perm)
 LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index efd4a0655159..7233bc0737be 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -76,6 +76,7 @@ struct lsm_blob_sizes {
 	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
+	int	lbs_key;
 	int	lbs_msg_msg;
 	int	lbs_task;
 	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
diff --git a/security/security.c b/security/security.c
index 5e93a72bdca6..92068ebd7e2b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -227,6 +227,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
@@ -402,6 +403,9 @@ static void __init ordered_lsm_init(void)
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -718,6 +722,29 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
 	return 0;
 }
 
+#ifdef CONFIG_KEYS
+/**
+ * lsm_key_alloc - allocate a composite key blob
+ * @key: the key that needs a blob
+ *
+ * Allocate the key blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_key_alloc(struct key *key)
+{
+	if (blob_sizes.lbs_key == 0) {
+		key->security = NULL;
+		return 0;
+	}
+
+	key->security = kzalloc(blob_sizes.lbs_key, GFP_KERNEL);
+	if (key->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+#endif /* CONFIG_KEYS */
+
 /**
  * lsm_msg_msg_alloc - allocate a composite msg_msg blob
  * @mp: the msg_msg that needs a blob
@@ -5290,7 +5317,14 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return call_int_hook(key_alloc, key, cred, flags);
+	int rc = lsm_key_alloc(key);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(key_alloc, key, cred, flags);
+	if (unlikely(rc))
+		security_key_free(key);
+	return rc;
 }
 
 /**
@@ -5301,7 +5335,8 @@ int security_key_alloc(struct key *key, const struct cred *cred,
  */
 void security_key_free(struct key *key)
 {
-	call_void_hook(key_free, key);
+	kfree(key->security);
+	key->security = NULL;
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 19346e1817ff..986825ba1cc5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6658,11 +6658,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 			     unsigned long flags)
 {
 	const struct task_security_struct *tsec;
-	struct key_security_struct *ksec;
-
-	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
-	if (!ksec)
-		return -ENOMEM;
+	struct key_security_struct *ksec = selinux_key(k);
 
 	tsec = selinux_cred(cred);
 	if (tsec->keycreate_sid)
@@ -6670,18 +6666,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 	else
 		ksec->sid = tsec->sid;
 
-	k->security = ksec;
 	return 0;
 }
 
-static void selinux_key_free(struct key *k)
-{
-	struct key_security_struct *ksec = k->security;
-
-	k->security = NULL;
-	kfree(ksec);
-}
-
 static int selinux_key_permission(key_ref_t key_ref,
 				  const struct cred *cred,
 				  enum key_need_perm need_perm)
@@ -6722,14 +6709,14 @@ static int selinux_key_permission(key_ref_t key_ref,
 
 	sid = cred_sid(cred);
 	key = key_ref_to_ptr(key_ref);
-	ksec = key->security;
+	ksec = selinux_key(key);
 
 	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct key_security_struct *ksec = key->security;
+	struct key_security_struct *ksec = selinux_key(key);
 	char *context = NULL;
 	unsigned len;
 	int rc;
@@ -6981,6 +6968,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
+	.lbs_key = sizeof(struct key_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
@@ -7318,7 +7306,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #endif
 
 #ifdef CONFIG_KEYS
-	LSM_HOOK_INIT(key_free, selinux_key_free),
 	LSM_HOOK_INIT(key_permission, selinux_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
 #ifdef CONFIG_KEY_NOTIFICATIONS
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index b074099acbaf..83b9443d6919 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -195,6 +195,13 @@ selinux_superblock(const struct super_block *superblock)
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+#ifdef CONFIG_KEYS
+static inline struct key_security_struct *selinux_key(const struct key *key)
+{
+	return key->security + selinux_blob_sizes.lbs_key;
+}
+#endif /* CONFIG_KEYS */
+
 static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
 {
 	return sock->sk_security + selinux_blob_sizes.lbs_sock;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 297f21446f45..dbf8d7226eb5 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -360,6 +360,13 @@ static inline struct socket_smack *smack_sock(const struct sock *sock)
 	return sock->sk_security + smack_blob_sizes.lbs_sock;
 }
 
+#ifdef CONFIG_KEYS
+static inline struct smack_known **smack_key(const struct key *key)
+{
+	return key->security + smack_blob_sizes.lbs_key;
+}
+#endif /* CONFIG_KEYS */
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a931b44bc959..c57eacf1d3b1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4473,23 +4473,13 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
+	struct smack_known **blob = smack_key(key);
 	struct smack_known *skp = smk_of_task(smack_cred(cred));
 
-	key->security = skp;
+	*blob = skp;
 	return 0;
 }
 
-/**
- * smack_key_free - Clear the key security blob
- * @key: the object
- *
- * Clear the blob pointer
- */
-static void smack_key_free(struct key *key)
-{
-	key->security = NULL;
-}
-
 /**
  * smack_key_permission - Smack access on a key
  * @key_ref: gets to the object
@@ -4503,6 +4493,8 @@ static int smack_key_permission(key_ref_t key_ref,
 				const struct cred *cred,
 				enum key_need_perm need_perm)
 {
+	struct smack_known **blob;
+	struct smack_known *skp;
 	struct key *keyp;
 	struct smk_audit_info ad;
 	struct smack_known *tkp = smk_of_task(smack_cred(cred));
@@ -4540,7 +4532,9 @@ static int smack_key_permission(key_ref_t key_ref,
 	 * If the key hasn't been initialized give it access so that
 	 * it may do so.
 	 */
-	if (keyp->security == NULL)
+	blob = smack_key(keyp);
+	skp = *blob;
+	if (skp == NULL)
 		return 0;
 	/*
 	 * This should not occur
@@ -4556,8 +4550,8 @@ static int smack_key_permission(key_ref_t key_ref,
 	ad.a.u.key_struct.key = keyp->serial;
 	ad.a.u.key_struct.key_desc = keyp->description;
 #endif
-	rc = smk_access(tkp, keyp->security, request, &ad);
-	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
+	rc = smk_access(tkp, skp, request, &ad);
+	rc = smk_bu_note("key access", tkp, skp, request, rc);
 	return rc;
 }
 
@@ -4572,11 +4566,12 @@ static int smack_key_permission(key_ref_t key_ref,
  */
 static int smack_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct smack_known *skp = key->security;
+	struct smack_known **blob = smack_key(key);
+	struct smack_known *skp = *blob;
 	size_t length;
 	char *copy;
 
-	if (key->security == NULL) {
+	if (skp == NULL) {
 		*_buffer = NULL;
 		return 0;
 	}
@@ -5010,6 +5005,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
+	.lbs_key = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
@@ -5146,7 +5142,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
  /* key management security hooks */
 #ifdef CONFIG_KEYS
 	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
-	LSM_HOOK_INIT(key_free, smack_key_free),
 	LSM_HOOK_INIT(key_permission, smack_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
 #ifdef CONFIG_KEY_NOTIFICATIONS
-- 
2.45.2

