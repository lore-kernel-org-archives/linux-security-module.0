Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792D13212D
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474917; cv=none; b=LxpspIs73Kp5Rpl/6iuFmvhZOKNsfwyHIwAtTfBJnxMA0PUOQWqqyZjEb553ye8KJb/4e3A9VSEwn0bHM/1SvBTGUp+vqx9BJyK0Hvdx1bAihBNcEkUPzMUgxDjX2EZmpKP6Uz9L3Yn7LoJwwgGPUHURdTbVrTpv3c7Uc20DVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474917; c=relaxed/simple;
	bh=WlDPBWtAe+vohVHn09w+pp/aJE3z0jAg9v8tdhWttlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLi7DGzJRuYPjEAMhIHgOImHbo+pPFZlDi9g8z0pPDwFVMFp+3ClnrFNSiZF7SFZYlEdXzBtY6l5q0fMil8rpHW3nbcT/FP9q8MUkgpfSsx6WvGK/tOFxC+zxYEHDYKZLeZHQu9gOT2zdm48J3RaF6V3+SBc77ANaVk4sNGQwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pxfSzDbL; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pxfSzDbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720474908; bh=HeDsojGfdn2NlECpMitD7wHLjOIidFnK6XNZ01fQDjA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pxfSzDbLScewDUDHSfDJIXtp2HppcGTurQngJxjNqpCGU//zgNCO/J5aH611BXl+JWrHFsbx8H2D3cRdpbg6dagMWG3MMbMJM60sSAYROxDsD7/uIj/x6pFSuCKvYAMXPpPBQYM8gmt/YSuRR4od87r94w7M6Vk4rm4EdlRP1pTHyhm8fkgvfch4SjZouDEVmqVQO45jSGuMB2inJ+4ugVbuNSl94r+h2e7oeVy4daH51LR8/3X7YYamMI2aY0Zz5LPCI5iLXt13jEJeyRd7m2saSh7vA/4jIZ1SdBnoJFlVcd25z9v2Rt5dGw3ketbySU+LiNSvyjJFui30BwtmAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720474908; bh=B0PZiSz1Go29OLKmyOl0PLbkcFKhXevRwzDUYlQIeZk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZZVY0yixS6UwxlesM6bIes3kjdQmO09VER61D1foSaiWoJi9JLIQiclIs03N0+SyGA87FG6uqUUjyE3QWPw120M5qOo8Fnm4NLtfjcH3u/XH0fkZ5mf8gGlhszkFuBTmR8yG7C3Sd7b3i5xK5dzvR2vJvKR2bWElB6OtslnZNabC8dKe5jpbmQ7iLr3bNs+He41ItIGG6oPimwGoqykLpN4IEO2X28KyqvfbnEJweTKAzq5iszCOXkaSXH81zYvuYoY2E0QjDjU7Eahn4VUsbmQmWg7ifWiGXsd1UWl6uB5S24tXy5GharGhcAv2wib4Nchd8ICXONcTg8DaGSg0aw==
X-YMail-OSG: XujUTXkVM1lYBsPHx2iyTxpThxR7x22qDOQd08v9Txr1JaTuYowmSHABfxSK6mJ
 iNTk45xcmyHW6GO6H5YHUqgiIN.mUAMuDMKHQ60WlCRFf9ySPuADde83aw0j79t50R4.pdHZdv.a
 fDkPp7jn2g8TdruqRrrxgwj91L0Usc0F4Wm1Q9_bqnUALGuDjyjkN1LWLysgqBwK2n6wbRgrykSQ
 2bFUf03L3cNitbADZ4UtLfjJncjsLat1h4v4po2DwO.hGjyjPuJK.ULIwksZ1sEdiuDQGRdddcLB
 rtdaqtNYTKMqTkSTcCDo2N0mCEhell.y9hRIAl6gLqpj2YQp_r_Z6cQQ8QuFz_wtVteZ36XWHO0r
 _tZJnHMFC_tAnZ8c3Is1EmG1R84naj9fIi0eJGXRkgxAbwUO5Qm.WORpMKtFfrSl9v4Kj8lM96Id
 Xsfq.82TIWa0Q1keVCiPbSGSo55CFs2mO1Ft3b_cZpqsNwBtIOUIijSiaGe1RTQvYxj0GuvWtRcL
 _nD..oFuzyFcekwt25HLtREamEy7nqmRlIKcV9LQIzIEKOqWr6HsOb.2eOBFfN9pBQCENGL.spwT
 DT5H4Q1tC67C9Sx58K95gbVOxU4aIW1ghlmnHWwFo5iGe94nXPQEkIWADItSTEAouxLHp.drb8dB
 xK64cHTvP9mMaX.lAHQsc0_Jar8shc1mrUSYNZ7PCJcZ3hPLNMM.5nXtrMO_JM98R1K7GpRrHQa2
 799_ieptl81WjDWfdf0oQB2Eg9HKxLXnY7Cq7jPegaCfQfy6S5m1HplVBQynzASSC.g6V33T0Oyw
 sBxivloZa20Ly.s.8vEc6QT01hvgSnbjGaWzE_9UjLQpWfD3gTavWdPyJ3qYPoo_BfOAPHoGH9ri
 JlzAKdMIYYMuOarMUneNK7rkU7_RrmKQMksC8iLX3n1DZZ3HIa8yD7NGKTWWnKIy4r0m_TZi3.W6
 4C.hku5zvrYOI_0.NEg3LJ3xG3TYy9gmeoYXvzpnXyWeBvEIVXfr8rl6.tSBryCIDKQYhod3Ex0_
 q1XQ5ZJwB8jotQ1mPl2NSZAuYGPgXIaziBe6AiLXw7Rnk1bWSCgwhJCDQiW6A60k.brGUsfWlkug
 rIcg6r4H7SOqG2XZPx7grCJf0NUGFLPauRcAs1g7TGCqACFxJBrcTfxxRYFAcQEQnPa3X5ABe354
 Sr6OVelnNg0MsescA_5TZ7zf.X_42c4UxqUHeONz5MZL3kkjyPbaPcxqgoP3wTSs8F9BUShjCVYs
 OpgVC1Z3fSbdY0xaeB7hNzvduZKYTPzVSbecuTVWpEidWzaiuZZeOUXytWbcIka6an1A_sZYROb8
 VL4A6XeFlxiu80ZX1peGpEVV9C5DzrJzy3F5LbASMg5CbI5lXkz4qSZ0WxahPYjRWFaTTJ47wO2k
 Ojhy0UC4kfOXPA6GU4QKJRIxvVuVc9R0XZ6ooUoVfSvB_LIrpEouZURYMUpZ2rCIn9K2kx_HEJXQ
 FTrkJyuIUje1WGRdOD3BEIvUOBO0UmIgH9104fEp6SddkaA5wcASQREm8u_eqPKiKY6hPfDXpwcD
 y7nvw844DlBeL45M6MY.reHbwE.gKyQk1nYNDZFoLIptvu7a5Iz7xXEAJqdkWpNqUAcaepzK5x6k
 gVZFlvNcxSkuvuyv7G0rgxoenRPVnaAzEem1OhE4M3KUY3AvW2aXh7lGZQ7S5YuPHPksS8zPZ7Wl
 _MbEHdz90O8p2Cy_WohrzpDjCtIH2sn.3S3LUwiLNQpdcVdDqhwswceqTMsBpHk_ZEk0B7XxsCOG
 CA2r1SW2836eGECHhv0g9K3bBiNB9o5j_KuObHYZcclc.v78OPMQNH6a1SBupz3PSAa3vzCPd0yX
 fK2GajCZ8NQo1IvTmGoZYjg5juV8iz.aKFDOhf0VFEtojt3XkdPNdpJgwYeDdR0HekV_K11UpcrR
 .1fix5ihxK2SmZ7Mkjisgy8YNo9Uadde_uhfGEAHSSavsr0B1JxpNr1rkOmQOx.L3HRWCx0ULqg.
 gpkeM24v1KVBIR.3WZwlYEB_1vSEfSECStKNdSG5Ubotbj1QsiKcqVlPpq7hbSXBdJEy6.8977DL
 PHcdHLNcEOWRdxoNkaJ8.fTqSVQiiWmplL_IyP5sc0CEsId6uOWASly_FUeWnuuQTimScEFcR3dF
 J8lojNkaIOEEo9SUPBAy5tlgrxVIzfCbWxc2b0XH5QfkfgGOLrrV8GJUNF8K.Al1rBiekhTgllek
 2.ds62aNrw4JOfK2V4qnhck8MTpn9YZmfHv1VphA.r.xGOVI4J_lfkn1isyRJCgpQs09FLuvLRTU
 amxcaK_la
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 22756152-0e60-4e0d-acd6-857e20d7ef9a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Jul 2024 21:41:48 +0000
Received: by hermes--production-gq1-5b4c49485c-sbfr9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 804657d20aca575d276c2f9208c57a78;
          Mon, 08 Jul 2024 21:41:44 +0000 (UTC)
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
Subject: [PATCH 4/6] LSM: Infrastructure management of the dev_tun blob
Date: Mon,  8 Jul 2024 14:39:55 -0700
Message-ID: <20240708213957.20519-5-casey@schaufler-ca.com>
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

Move management of the dev_tun security blob out of the individual
security modules and into the LSM infrastructure.  The security modules
tell the infrastructure how much space they require at initialization.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 11 ++++++++++-
 security/selinux/hooks.c          | 22 ++++++----------------
 security/selinux/include/objsec.h |  6 ++++++
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 44488b1ab9a9..601e3092a7ed 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -352,7 +352,7 @@ LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_inc, void)
 LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
 LSM_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct request_sock *req,
 	 struct flowi_common *flic)
-LSM_HOOK(int, 0, tun_dev_alloc_security, void **security)
+LSM_HOOK(int, 0, tun_dev_alloc_security, void *security)
 LSM_HOOK(void, LSM_RET_VOID, tun_dev_free_security, void *security)
 LSM_HOOK(int, 0, tun_dev_create, void)
 LSM_HOOK(int, 0, tun_dev_attach_queue, void *security)
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
index 438ec6708eb3..2c9d075f5f92 100644
--- a/security/security.c
+++ b/security/security.c
@@ -234,6 +234,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
 	lsm_set_blob_size(&needed->lbs_xattr_count,
 			  &blob_sizes.lbs_xattr_count);
 }
@@ -412,6 +413,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 
 	/*
@@ -4851,7 +4853,13 @@ EXPORT_SYMBOL(security_secmark_refcount_dec);
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
+	return call_int_hook(tun_dev_alloc_security, *security);
 }
 EXPORT_SYMBOL(security_tun_dev_alloc_security);
 
@@ -4864,6 +4872,7 @@ EXPORT_SYMBOL(security_tun_dev_alloc_security);
 void security_tun_dev_free_security(void *security)
 {
 	call_void_hook(tun_dev_free_security, security);
+	kfree(security);
 }
 EXPORT_SYMBOL(security_tun_dev_free_security);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b3de2e941ef7..7f1d8358922a 100644
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
 
@@ -6975,6 +6965,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
+	.lbs_tun_dev = sizeof(struct tun_security_struct),
 };
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7285,7 +7276,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
2.41.0

