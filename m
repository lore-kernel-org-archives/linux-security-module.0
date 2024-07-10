Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8508287E
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647262; cv=none; b=baVp+4bkdMfU/SYDLzqTmazoqwXZP5acCHpueJ9OOLYq6jtIffHtEmZSGnndc+JOxeeh5oEglTOJCLW35QIGBJryWto+8mYukLuciXE8QR4C4+n6QZh1xx3CGfj4ZeK10jpcO+cOHmuEpUrSsf5LrcMzS3Ff3Bu8L/4TeW+F6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647262; c=relaxed/simple;
	bh=G55R3/vBJCDebM8T/ZcbEMF5gpFTRFuVtpt/6RxfOIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTMwi8MLqWoViTeFebm/FB7fBB7dqIPV89uo5mg6sps+9FoklXVvWoH94Z9aoXVoE48eiCZF1IkCViUUcpy3pSTRBQuRPU/Ir2UILqTxRyrhPwDEfX9tfa1aJz3w4QMKZpNJdG7+D/am8l+Wh0czy+x++ppIQjJzyzDT0EEa1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WIDjJII2; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WIDjJII2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647254; bh=1nodLXpEIclSsfjezwcKYYJe7TxJ/g0XTF/DCRIQkm0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WIDjJII2rb+CgpemSXoGieHry1qAJifqQnJ/FFJD7o9J1L7g1qjnw41/pRewYUHdjCk0gBTZsjBkUu+tPM0QxogtmsGVms3NN1SPRmzNK9Cv7arhj2JupjKWnEY9eODuZ2eQ6XUYV9xxsw1v1Au6qtfaNqtwCrQxGu0FbmZpkNkgvJ2Nj66okzdTXQbc1I5CWZjubkD9uF25RGULsvaFLpz0SCSVLa5md629znWlpJj2J137rsMbe+vdWYEhHmz7PkIKor+4tkrT3v2r/MKyn640T6kTTb+8y2CCQkw+jqqG5MpTGFnJePWqxhfTUJlleqkDLWhP8uQkdqkIOIv+EA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647254; bh=01LKZS8+itLh3eEOV6w7nw2rsOzsyfYFQqYfv7danNW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YuIBCV93ukMXnnqZU2nIqSPt2UyXolWYq0OshZmKsRweDReC+vCwu2V+9KeYLtKryzl1IhDb488U4VkdJaUj/9/8GdTNdL3tuqurdRUdifoFTJ9IHnBe2cYH3yf4zs9/b/ESD7+nG+Zu/Jlhu0tIkEg2Xl9eep+l7yQYzJHnUcaNPOfZJL9Se8yhoie9YkBaNLwMT+rqhjxy6zHQQV29oWAk6d04HbZ9mOstrhJw1ckpxpGS/uovdoV+ghPyAuwl4V8WhwQrhXwSa3V1mjSKouZ6u2EnP/bRotJVkKZbnFwQRfl1PI+GM6Yk2Ep+i5IchMVU0MyW0fpOvb3TOhTR8Q==
X-YMail-OSG: JXXza.sVM1mj4f9ayvqAUL9v59Qdye1vZcvX0jzg4VpuzOD9xN3nxyRx3StrCQF
 Rzt5icov..3k2lHrBXqNFTFwi3ALqyIbSTrsKfbDT7MaTLOjgGggvuXphPjRHKsfbVH_14d.2xG.
 MTLM4hJIgPGaZQ84YhVjh553O0rGpA0DKK3soa2JOIm1ZlpXqYDxE7Znng_Bkb2zmOLm.s4.AsYM
 68WOkxhNNmVA6SPGZFRk.jJOTuqrtISZEGL3L86Gyv8b1jgwElR3YQ1FSE6TqtdtOhysyVaOAiPW
 VJ3uKTmYfPDxsuFhjzJb3dso1DtgzfgJQobKkFEbdPcSUYrs5yevjiqR9itMDESh9mpnuacoASDm
 .Vx2PufYZNpZFbZpv6MDZYSFKdZIFnfeIM9V04h9sSS.9fPhnE6z9GH6tffFruR3npJ9aBTEW9G8
 hv0ikDGZlT2TaBAKrpobNe4mhw4Bt2DyQN5PZXwsfsMWhtiqNpE8iKcwrEC.Ij3YHfYCvXqodK7I
 uP60UYwaLbYy_nB8VL02VnLZJJN0NxhSy.cPCM_prX02FxjSH4xpeZF.yBNN0tPdmSgeCJoas_i.
 .iHNOIdOmyX4z490PlpxggUN5lK6oCa9txzF3pQjGEUv8USiSyaH1GSxNIFxQtRLqBh8Mn.J076e
 AT.iXSHHKo.XOCP3aX9IHQqz8ms7eh9AosoalvYiOtNTNcQtSrUWKNreX2fNxkmYSclD3l4ozAcL
 NwxZcEftY0nrq1OfMfWUhw3NwQ6sGDwsL.rF3Yqrm2fhV4r4RGE.zu3Jc18QklMMJPsx39vn2BjD
 IfH.NZjTpjKPGSSTkAEa1sO8DLMMmKo79LNUoJ5FLJ6aXyXBpSvWxgX.gZ7M_S85Cy1T3tNIv8WK
 H7jQQzLJl2OBM3v9fjEYNIJYf3QeGPe5oiXS8Sv0Ixx09nMj0H0sBX3iOyZB6sIfOcwB2pzmCZuV
 km_lLk6lVPyouyFwi_nkPA6e9vt4rPqx4J69wcc7NElX25jeCobG34F5VSyJmbbLyIoxFrEK37Ua
 OVvMV.eXH.lOkkMS1_XDZUFz8PrcSiA4VBL3v8Hc0GXFolbsZ9PqYe7vzQQofhymeK3BAZaA1CJY
 ds__QcsXVE.23KtHFV8jJIv69Yj8YYZnjVy5kDpYCbs6WF7rvYcCgjFN7Qlth_vdFsIx_yFkKZgJ
 37FgCfW1Xs5HuuTiqJNh2j0dMVRLgmHaBWlQ6lWSzoUCbUqvzfHk0x8pDT5gj61eMOz6D6BX8IBp
 aUKrkaxCJaZYgAIRvl64Q5w56SCcrbji0A.A968N2Y_n6N47DkHj7FSpzwcoswXE6gdaBY__9Soh
 vJWXPxxc_zrGZPq3.e5xKvlTgZhFYuzK2kErnVJZ7kSb2rEh1u1g84HepeBlDtnS089B9Y4rQ6.7
 BVD37PPHcCyjySaeC.YHPvywGNe7.7J.41h4sW9iz7DuBV7faND27cYC1x1M2zsSSMjf_yQzI8iR
 PK.HXFOkz8r494B_2n09R0x6tTbOxqwDD9EwXWB4IF7bvFxHzWhB.qgEiZAyDnC7j.IdSEI1V5E2
 wxciTzRgH1_hCMZMpcBzqA9DMxTOS9XhoNgcby5Fw2Ry10ziDlhfXX3ZRMPH7SFHcUnrUL.vlVVn
 fj.Px766Zoc_1i8QtqqYyx6WeSTol8XW0QquK3zH2fteyEEGUXLcmnv5dfQwwtm4EeP_CHwSM5_g
 iqBahFuhNbXGtT45auJoti4ZHMMJKn1J2TkZHFHF42l4PbWQRxtZo22B6w0rsY2aT6lybput1L9a
 XjMVdN4IEuSXz1DppqYGsCAVFDUZw0oHlgL7Qez9mFd4KgKiGy6zY9wrJvRRFifz27cnCKcRMm8D
 PHIN5k2c3EnfU_cH3YqlFZjXFw3NRmgowa4om2tmNK4MepBkDVEUR6dmKqZlNUYSks_qnvLejFAz
 TclA_uvcKKZ88bKsAQjtdfhxHa2nLhpU_PWRoG5LhI7euBWWuQlGk_1Aj0X2AmBUT2PMUrlMDRy5
 cUDEuj.n1k1n6H45Qn.hLOjYgSbFvXWQ9ISdYfWXJLsJgorsxcJ..2XhJuk2Itcc0szplz8zW2OU
 BuVEnbdSbTwTvIUTzm.qsOekJ23VM7jocMn8Q.lxGSS3k4tckw7FqccSd2oRJiYCtpUkgKWdZ.P6
 ozUG8vYNG73aXZeam9fOhSyzUutYGb.zql2uvTlJe8kzlEZN37yJ6.xF02HMRTVtFHqUobxGH7yb
 ix1SetanGqDT8xmWpITxnBrpHjw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fdd195ef-bf7d-46e0-bb1f-612825356727
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2024 21:34:14 +0000
Received: by hermes--production-gq1-799bb7c8cf-jfh5x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e290f093598dd7cebf6712409b4ec393;
          Wed, 10 Jul 2024 21:34:13 +0000 (UTC)
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
Subject: [PATCH v2 4/6] LSM: Infrastructure management of the dev_tun blob
Date: Wed, 10 Jul 2024 14:32:28 -0700
Message-ID: <20240710213230.11978-5-casey@schaufler-ca.com>
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

Move management of the dev_tun security blob out of the individual
security modules and into the LSM infrastructure.  The security modules
tell the infrastructure how much space they require at initialization.
There are no longer any modules that require the dev_tun_free hook.
The hook definition has been removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  3 +--
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 17 +++++++++++++++--
 security/selinux/hooks.c          | 22 ++++++----------------
 security/selinux/include/objsec.h |  6 ++++++
 5 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index cc81f7f7c024..f1e0d6138845 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -352,8 +352,7 @@ LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_inc, void)
 LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
 LSM_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct request_sock *req,
 	 struct flowi_common *flic)
-LSM_HOOK(int, 0, tun_dev_alloc_security, void **security)
-LSM_HOOK(void, LSM_RET_VOID, tun_dev_free_security, void *security)
+LSM_HOOK(int, 0, tun_dev_alloc_security, void *security)
 LSM_HOOK(int, 0, tun_dev_create, void)
 LSM_HOOK(int, 0, tun_dev_attach_queue, void *security)
 LSM_HOOK(int, 0, tun_dev_attach, struct sock *sk, void *security)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7233bc0737be..0ff14ff128c8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -80,6 +80,7 @@ struct lsm_blob_sizes {
 	int	lbs_msg_msg;
 	int	lbs_task;
 	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
+	int	lbs_tun_dev;
 };
 
 /**
diff --git a/security/security.c b/security/security.c
index e5af4274b8aa..f1eb93b65ae9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -232,6 +232,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
 	lsm_set_blob_size(&needed->lbs_xattr_count,
 			  &blob_sizes.lbs_xattr_count);
 }
@@ -410,6 +411,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 
 	/*
@@ -4849,7 +4851,18 @@ EXPORT_SYMBOL(security_secmark_refcount_dec);
  */
 int security_tun_dev_alloc_security(void **security)
 {
-	return call_int_hook(tun_dev_alloc_security, security);
+	int rc;
+
+	rc = lsm_blob_alloc(security, blob_sizes.lbs_tun_dev, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	rc = call_int_hook(tun_dev_alloc_security, *security);
+	if (rc) {
+		kfree(*security);
+		*security = NULL;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_tun_dev_alloc_security);
 
@@ -4861,7 +4874,7 @@ EXPORT_SYMBOL(security_tun_dev_alloc_security);
  */
 void security_tun_dev_free_security(void *security)
 {
-	call_void_hook(tun_dev_free_security, security);
+	kfree(security);
 }
 EXPORT_SYMBOL(security_tun_dev_free_security);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 986825ba1cc5..34ed787a4bfa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5573,24 +5573,14 @@ static void selinux_req_classify_flow(const struct request_sock *req,
 	flic->flowic_secid = req->secid;
 }
 
-static int selinux_tun_dev_alloc_security(void **security)
+static int selinux_tun_dev_alloc_security(void *security)
 {
-	struct tun_security_struct *tunsec;
+	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 
-	tunsec = kzalloc(sizeof(*tunsec), GFP_KERNEL);
-	if (!tunsec)
-		return -ENOMEM;
 	tunsec->sid = current_sid();
-
-	*security = tunsec;
 	return 0;
 }
 
-static void selinux_tun_dev_free_security(void *security)
-{
-	kfree(security);
-}
-
 static int selinux_tun_dev_create(void)
 {
 	u32 sid = current_sid();
@@ -5608,7 +5598,7 @@ static int selinux_tun_dev_create(void)
 
 static int selinux_tun_dev_attach_queue(void *security)
 {
-	struct tun_security_struct *tunsec = security;
+	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 
 	return avc_has_perm(current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
 			    TUN_SOCKET__ATTACH_QUEUE, NULL);
@@ -5616,7 +5606,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
 {
-	struct tun_security_struct *tunsec = security;
+	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* we don't currently perform any NetLabel based labeling here and it
@@ -5634,7 +5624,7 @@ static int selinux_tun_dev_attach(struct sock *sk, void *security)
 
 static int selinux_tun_dev_open(void *security)
 {
-	struct tun_security_struct *tunsec = security;
+	struct tun_security_struct *tunsec = selinux_tun_dev(security);
 	u32 sid = current_sid();
 	int err;
 
@@ -6973,6 +6963,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
+	.lbs_tun_dev = sizeof(struct tun_security_struct),
 };
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7283,7 +7274,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
 	LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
 	LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
-	LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
 	LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
 	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 83b9443d6919..461c6985977d 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -207,4 +207,10 @@ static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
 	return sock->sk_security + selinux_blob_sizes.lbs_sock;
 }
 
+static inline struct tun_security_struct *
+selinux_tun_dev(void *security)
+{
+	return security + selinux_blob_sizes.lbs_tun_dev;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.45.2

