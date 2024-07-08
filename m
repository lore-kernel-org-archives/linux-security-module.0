Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA867345B
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475422; cv=none; b=PAyNX+nmbQ0Ek15yb4X+ky63qWnB4LyYZVVGUMx0xjk4mJUeDYqmTXIrO0kBJWXboZ3RPhunRS9bd3EIgDw8J8aWe32xYJ/3NMoi0J2kb9aJuLrXoJ7V6aH8T91JcZo5G6Cyt+XTsds59XOLdpUxIuUpgncmtyC4PBa7Tz0iDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475422; c=relaxed/simple;
	bh=PpUDXQ6o71azfJHrdH/OhZ2bLPF7lrV/+fSHDc2R8zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asBso1KWyTOsGXdi0NmSBqONcsJ4t4Ewjplo5uAihIP/t43ME1f04PaRDelvvrToXTO2vrKkRCMgnWtfkpDnrUbxa0fp4o1uYHJcyzGt575+SNuEq77pnxCETPWbJi9zCqvpoZsHcwlyTzIDgKxj45tTBvNCyaWUBlVRrOXbW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qCWhGIUG; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qCWhGIUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720475420; bh=jszlhQoZn4LKsPN6EY5JS78uZKZIJSkhZKtEJaT66rk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qCWhGIUGnsDh+s6fGVGqcW9Gh2cka8EQJgm1LjSb6ry/ECuet/UqCcSwplyufSA+C7wUf4wdGcEiKagW5eVsQUtOoGDlrR1wpMAl4RCCC8rNjRc5UlfwS7CVYghuEnfYjxerO729ieu4Hga/aurBkuQ8fWrOMA78a1p+degdV+fzxCag3x7qKUt8hHfiQE4sPwia4YVcVr1jzC3IOhREz3xo3pWqgEAGqqpWdqQrf7S6sg+IfbsFkR6wFiEYX/yYyatqmcCvEJR0YcR5i20avZDa/lpsROOhJgElXVG9c+RzFv7uHFQGQa0QnrkeA1d0olEmslKb5jCP1HQ0nlm36Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720475420; bh=w5ScVXwpXstTdJHkJdP0xrLTqdblac6gk9MzsSNeDBd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fkQEN735bxTXHfga/SlNqPY0eonsCmt5WXsvWko+jCpOqBG9YnxRrsoHJ6E2sM0Ek7N1BA+VoO5q9Vg5HZ7ZS3pWAv++LhMjBrmsLYzMkAgpfZPklXrditI+gNiEY2M/Ww2Dcy093+2LRIMxErpfNZcQfI1UwPgoA8gv3GurRSqXak8ZeC0accvLOQ9bN1z95WfRVE9W0fmFaAlDfx7M2WgwKs/kgYXW7N7gUo5yjlhcQgIGorexnsV87HHJrhmiVbgv3efeO3ue8xTTTmMkRn/GCpweqcbDyhmTiALMxn8whz8LsO/kBzQNnNp+YNE2ADePx6wCEthmbkxCLyyuSg==
X-YMail-OSG: nL86YncVM1m9nZCcnW30tyaU9WAj9hFswYuCIwelLBDAithlWMumE2Cxxf2L_5P
 H2lAT_El1ckLwnxza0M2bxI_RFzt5uhDNAHu4oc5IuHOhAkEfiufBFGi3XpVji_NlzJ09OUmZcCi
 lO7Di7DkyTRWf9FrlpR3LT8K.ZD8ZaJQKwaKMw4vHcUfijOYHrkWb4esnjIeth2dCJCGyUQq69EO
 MPLXFLft0Jv0R.uQw8B0D4_UVQJPiY6BRTxQhg4_Rg4VqBK962EuO4_APJ7Ldyxn5Sd5_YMO6bWB
 TXoyEhNz6tSAYiL7c9u88wbEl_zudN2NaQwBija9GNQL1xK70mu4YqDnHhfbecTkm63FdQGcAT94
 nlj1j0SEu0pCBJ5K_X3q_oTaXGFHSXoCPe.GvzKCkC_T4a51fOAfbvzoQpBti6zJ1gVIalANR3EW
 cqWAo6g0xf0GqqLUXuUAks3ik8qdK6YPLcZNvVblFb53Xa66jrGaiee.d7PJ1xhGqsf5ktIjx0tJ
 sDay4EssaKnosrQFnKDORdu6ytcxPs0UdOfrZXr0SN4PlSkiUwuRNHrszQdSZeQ366w3mGnR2YIg
 ThobdSGpXHnHmHasavzxUFsDHN2C58EPgfAOXaZNOtYAB_WzVGYeC5hyPCHE6vXFQFLYwvMjdKo7
 SvVCbHFPfuNlp2jiQcAZvXne_iY9NWZT.kFd_VsyqIrlI90ahuEUTarxbOxjiKRXkMdGGEhHVzvj
 p35SKiZM9tQvxKT5L8630nwFuTM67CaoCy9ykeabPLgVsRyMXzLFTqMalnNt9.ATlZo2IXVfKeFs
 YUPJzO.qH2CofhhRETwgpikM2.qgtR6_VG4ke8f12oiU7YJR4_XUEmZ7r32PZWA4VOP.BKFvOxQH
 DNjID83IPOLeeTVhQyf1XMaHfBJnHGLArl3JWw0rqnvquzsgEQk11I9vn6xLALJh_P.ZTHMjIsqU
 faeHgEN9jQ6xnV1DC7p7nCbbuRfWOMY.QPB3TUFX2NYNCBVNaWvtXdAOVxRNW9ZNuTYYc6tiSneF
 nozYJDbE3OOWK5Df2TKr0B2OPyaolYkt6SO19fu95eD6d3yEeUYSJtfKKudeAEabLsNNis0CQHAu
 E_GJPzvHkU37xweTOAcAwVkgKSIBDXudootymA6pD7qC31gQ1AqtJre6JJeWadIjhXWsHQYKhjX7
 CqsTKAwQdNaLJtnDhMNH6DtKuJICRVkeSHEhUzkuM6ZQSvMCGZkvQ6BuBCQhDsRzHX6Zt4YcIQUE
 Tk8eHDZb6PgHwmIsm6qVc8.UpVDsD1iUNffvEte_V9ETLZxvPuyY2JNhBTk5voUUW6uVk2WgHoEf
 3nKAQZqZEyQbZ7jq9Rpl5HfxMnvISL.AYFjOjBiQ9OExf_Rq7z0T6254Gwt5E1ng3Ij6YsXwFoOM
 RoMuEG0IErLqdMQtGvPTXZP3JDCt3xHObGObEf2ugbcESMctfmJtYR3Aj3PNx2YhKiLX1oUVbyzp
 FAjK2AvmV4JMrMydcY.YPud5XtCqAlCazTDfJU9AoBARRZWcntEDI4FkGnT3IrgH55FnLK65whuj
 DzaJakDYZs8masGaDoP5S1Oes5DSeOOYakTHs9b8Jaa18e7iNO9ocAErXvJrWYpQXT3CNWCpG5t2
 IPYeR7nvsMcVUqCpUmiL9EE0I1IPSoNG.3F1iWwstxHEd5B1MWDfl0NDykc4LDWdKVmjAUJP84z4
 yQE6HfnzvCh8DDvktvUxr9Xcf4RyALtFE_Gpk2K4BQVNcKZW0ibZcP18ePrS_nCf0kB87F5cfrES
 wQoAPgVhgPMlQUrfeVtkkzsbc0M_jwsk523H3Uzd0ntck7kmxr0hQluGLlEjBql1R_wMkBJNeg3V
 X45jAijW64A._K0DUXeuqgXu7kPc8JxKPAjwXfglUPU5UT3YeNOk.0TDNwZoxzpLaX4zxwhfoiQn
 uizk6OKJJXDKdwZRzFkaoQE0_9zcqGlIwPFtce3NjNFMn60Z_8dtuPAC1QevrA3yNaQOrynPTfGe
 Y9TNQ28JkWGgRjW4nu86_WUEZUE66Wcx0yUHPHRqeN3sR_RRZ3g2g9iuC7YaKCdmY8lBJtGb9IPN
 k_6w4FVCq5XjrEUWii4liADC5DF9xAnxnyiLg9omU9cNhbBUHlESz_r7qcI.k3y2C7zg522kyvLr
 0EEV5qkQw._NlWr9ykm9zufr94TfbhvQmgAy9gEII7OPXV7kMMEz.3GLQtxr4qznTITu6kuGrcvk
 bygpzSiCmjjSyKdgRdxfKi9rFo8EmtA7tLLW9kYx1xQVHVXk0rCbeBwioM4tAiDOfeiE5swi2igm
 4f4WirG9VFg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fa16f274-1aeb-48b7-a6f4-38aa50cfc9c9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Jul 2024 21:50:20 +0000
Received: by hermes--production-gq1-5b4c49485c-4ls9q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 493327e53f094c0d7e867cac350cba0d;
          Mon, 08 Jul 2024 21:40:09 +0000 (UTC)
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
Subject: [PATCH 2/6] LSM: Infrastructure management of the key security blob
Date: Mon,  8 Jul 2024 14:39:53 -0700
Message-ID: <20240708213957.20519-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708213957.20519-1-casey@schaufler-ca.com>
References: <20240708213957.20519-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move management of the key->security blob out of the
individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 41 +++++++++++++++++++++++++++++--
 security/selinux/hooks.c          | 23 +++++------------
 security/selinux/include/objsec.h |  7 ++++++
 security/smack/smack.h            |  7 ++++++
 security/smack/smack_lsm.c        | 33 +++++++++++--------------
 6 files changed, 75 insertions(+), 37 deletions(-)

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
index 5e93a72bdca6..aae37481b7be 100644
--- a/security/security.c
+++ b/security/security.c
@@ -227,6 +227,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
+#endif
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
@@ -402,6 +405,9 @@ static void __init ordered_lsm_init(void)
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -718,6 +724,29 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
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
@@ -5290,7 +5319,14 @@ EXPORT_SYMBOL(security_skb_classify_flow);
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
@@ -5301,7 +5337,8 @@ int security_key_alloc(struct key *key, const struct cred *cred,
  */
 void security_key_free(struct key *key)
 {
-	call_void_hook(key_free, key);
+	kfree(key->security);
+	key->security = NULL;
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 19346e1817ff..b3de2e941ef7 100644
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
@@ -6981,6 +6968,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct key_security_struct),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
@@ -7318,7 +7308,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
index a931b44bc959..17bcc9cbf584 100644
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
@@ -5010,6 +5005,9 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct smack_known *),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
@@ -5146,7 +5144,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
  /* key management security hooks */
 #ifdef CONFIG_KEYS
 	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
-	LSM_HOOK_INIT(key_free, smack_key_free),
 	LSM_HOOK_INIT(key_permission, smack_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
 #ifdef CONFIG_KEY_NOTIFICATIONS
-- 
2.41.0

