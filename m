Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66732D535
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647261; cv=none; b=KgzPq/lAxh7+vS1NwK8WoBZL3aCNeJq7IjfD/rESR5lsFrqbY6J2XuGri8WlyJJ17oPywSf8GkWrYkRjrgHeFJd0UxttYd6DOSU0GYOdOvntwoJwy0cq2qjFfQTXtyCMdkmMusm2ErDz5CXwuJ33mspeM8yzQzBFcp/gtFmUSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647261; c=relaxed/simple;
	bh=nRcUg32FhBUVtUkgSi9nGRUtS/r3i4XGWEbRUj77x9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHgd//z3M9u9JuOWO/snvrYy3cq2v0jeEs0NjXO+zDhib7lGT03qz2bZiZVlgxivirbIJjjhuBN0J7TDCZwtk9q7XW38hMO4cmTrBW/vecI8a2bmUM5prXMi0M1s7611swliiPDZRljasEjJbgDWGnE5R1tdj2exAOtYJIjeS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=d0wZBDEG; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d0wZBDEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647257; bh=wd1U9fhPPj5arquf6HMbm+gnB5vxWYoZIYmA4HUedc4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=d0wZBDEGmNy1IEqEpheX4K7qUQDJRXvRLDmjhRthYxSsL5kSiTNFDGoyTOkmo6jg0Qhl+kikz9n4fX/+k8CydRBL8UWD3kYdoysxGeJhH+1hhr0BBAvmbC7wqjm66FBvKHGzD73V54nrXAGvAtdqr3yKalLmRxq9KMnSlgBVxVUPVbFraAKdI7yXuBbEBSXZDFH8Q+CyCIyKrdZnGPxBkyr1V8cAbqSvRzw439TNb6WazHI5dH1TnS8FRJsyzzsb/AIBc3k78FMufM0pLqkECmHfZx/uNM9G1R4uJQxiCwLONcztMwsTif1VoV9Ty0K2sEaQkRjT2KIBuTQtOAj3HA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647257; bh=X5SE7HU2mGNWYS28wM8+I6XN7iUYQRakicPYHaV/tFO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kcdyCeNK6M1fT3qexYVAigQ+ticQMQzCIgl6uPpn0nrhvCPiiG1L1PKHn8jJfZeuBpCHuSoO6E2H1q7DFIiXcGF1evHR+3ubGAg8I2/NeyX8Kb6b7fQd7UgOXb4cRmkzQweqMDsD8YJ/QnSyYpHtFRDTQu+vGLHYtwdqeddWHvj/Z9DPxzzAH2/fXGbQRvpMkUlTFaS8M6/Oqqab1B7LQq53QyfHy30f9TtHcOrLUPblrCQ2iSUJkBGdxXLPyLtRVd9Rkxx7dYA3as1CnH+g+Z92UWXu9yzbHy9tuqhhMedljgc82iGkYIVEEu606B5Yx5TpmBeNzs8MJ8AVK9HCOg==
X-YMail-OSG: V7GfGpIVM1nwP1gtTDqO4L8JNlBS2ErQR7ps2DFVBipCbIoM_0_VUiwi7NmKB7Z
 faIx5awyVNauYy7k1bemwxsC1ZGUw7G1qSiHCN5ZsTcwHrxzFS.tyK5t4jyxfI1k1RUXQuc0oQgB
 gSVfVfph4hUVFeGvxENHTut2SKOtTdNgSw.Tqg94TXM9cHMRZgmjSXPi9oqrrTgpgH4iCv4yjzzo
 ytYJ2kOUIiBOI0zPYUIA6VAZvoqZj2fVreyasaVPVBytM.yRH1zPCffm6ePiOBIjIhCgEe5jjnNo
 sHrRIrJZbmTNxxMS1rP9iywam57E6MEZJKXwjc037WBcbrv4OYavT5hVh7L_x.44DMVwzs9v7C1W
 _0uzMAzG9YCf6.0.VttAPSDX_hCzHWj_NmY0PeI8k2a6VE2iPxaX22Cu0gTHU5kIspURcvkxOgex
 W1.DfjSlIZu9jmu9rKDpVCY_axesiNVaGTeTe1cHEq9R7uCDQION62VFRDjQ_Vs3h1dymH__jcmO
 qavI0pI4mddmQplG.fKme0hx5KxSKTrDgtqOEKBwHEtL6A7L.d60KOLl8DO5u3eHP0BDJPq.EYOe
 KGO1OYFen8i6AZnTbgAAtJwXHgqFJmbnwY1Id7LEjujs8hXG2MRZ9LEK9gMCq1U3jHcd2WxZ94yV
 1L896bGBtWVM4PCiqDhlqVbKttQgfkl4RSiFbPpkWZrNtLHE3pAXRxDYw0gEvV91b0nl3nVbXrbI
 XZnurajIMBJo24grmMhwXRqTrJPBk2A8hJwDooIP_zso7t17HnC_mgffolJhpPciM1cVEyRd8rHr
 a9a5ZnDRq9oPdOgvQWpfwCzsD7qrZPFGn7cpZafw9AL03VyEGvMRRkh_Ky46e8NoN2UxriYKy1XA
 .C7GF4jfDBXWOcZ6GND7ufkiV86S851ILjdtLmGTwz2aJzKfieYTjhwmdJGtCdpY.P6BN7Ujfd8w
 NiMgTj0O4O14ztalGO2p72XTg8dd.ZshY7HvKRxSqwyL6FnqOFCH.Wt_7DKKO0nqvpYCdC4QLaMz
 RRCn1gDP58gwRnEf.PW2ikw9NCs7R9F6VidDMfGMQQG7bZnqf3rqVN7mbdk06YalgXbguZeVOFTv
 ReVaKRv4mUj2iJdlyqAN_2VzIc6sa46GyiIukSsAJcrJ6k9x9S.S8i1wxD7cqqI4QGs5EduDpWQM
 zmxgH2Lx8a0WgDd4yT.sFjxajQdO3dOFhNh9t5ry64u5lxhTiITLt3lMcDl6ufd4o.i2g9I4mZ4A
 spR2BGtU5QCzYM3oXYIAYzUk.tO0TZZhHa4OilYRWc1GFcDvVWJU4YkIn2wrgevOlq8Nl1EPpZEI
 N21y__fvRrydyZ8Ike7iXCKe7nzzVAg1YvYOPm.XZiQO8dv1rxRafG28vj2zTi7bvqTQUiMnWDzw
 pJEkqsT0D_PcnnfcLJ73bP8cT0VwdCaQWJXQK4kBLgruMfJ__wgtgz7pilvTmkeqhASap1338SgA
 Go5BpdoaBxVMf3yP0Hh9TGbXhhrg0oSYYChVFse2z4Rl86C9oUwUFxPQAxjNHGC.D4TANsvJyMtN
 3NfgrEyYU.6MfI28jlNMWXFB31igGJj9LmHUy.4tt564NXcNNqbt.TjdYd4EXwjlu_gH2DuyY94a
 qh1.HdSwvuhaxWGfyQJpST9TUVzTKjeAKzZogAPyadld4LGyPrQyTTXroR.62f7.J5fiCw4BQEaH
 GVrs5hcpfnaVZuKBHTNBufLFyIepz2whfqKex8MmjNVSV_ZILjwTlfjasd5mm9dSoz_EJktTV_Dp
 eZTeyuHdMO_juC5gj5l6VfA3pm2bPMuM7UywhO6K8x3CpQ31HS.LK5Xp1gX.srwZ6EOA44.L9zOz
 1WDQEWE1INL0GsFL1t7lZ_adGZ5AA5_te63Hf3NFyshRx88TOQBqXyPZbDkPBPT45117CPQ2vyvl
 7hIu9UV5eYtELAkBlmqB8yo7PQ8YNbk_OU8WRIsY1AImQ8qcVdicuNCQcxUBzBcv1si7kaaQ0s3J
 jZc7q3pn6Rrq9vizyZ6_RT.yLtmCcHVGSgKK0GHJOsFyv62tYiKBR6H1mkyAA1bxPgfF7XUeFflV
 wYPGIc8uermMmGmBczpLnGfgf3a0g1SZ3jy9jGHvBNmYF7.do2i2YRipkzKac5ZpPgK_ZcpdzzOA
 5XSQRVumMw0_8_wzDNlCAraMuAPWF9cxsTKHM.qG1PrDQ3c_opdNfA0aMI3KaDxvWebTgWrLcYCX
 EoHYEK1DYOxqsoxXDaJs80fhaFpyTUpY1gv3KzEhN99bNSFKfe4E4ecM_ne90RwngHHEY67QrPYo
 a2Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0a8eff31-3a28-4b34-85a7-fc5ba8efa1e3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2024 21:34:17 +0000
Received: by hermes--production-gq1-799bb7c8cf-jfh5x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e290f093598dd7cebf6712409b4ec393;
          Wed, 10 Jul 2024 21:34:11 +0000 (UTC)
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
Subject: [PATCH v2 3/6] LSM: Add helper for blob allocations
Date: Wed, 10 Jul 2024 14:32:27 -0700
Message-ID: <20240710213230.11978-4-casey@schaufler-ca.com>
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

Create a helper function lsm_blob_alloc() for general use in the hook
specific functions that allocate LSM blobs. Change the hook specific
functions to use this helper. This reduces the code size by a small
amount and will make adding new instances of infrastructure managed
security blobs easier.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 97 +++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 64 deletions(-)

diff --git a/security/security.c b/security/security.c
index 92068ebd7e2b..e5af4274b8aa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -603,27 +603,42 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
 
 /**
- * lsm_cred_alloc - allocate a composite cred blob
- * @cred: the cred that needs a blob
+ * lsm_blob_alloc - allocate a composite blob
+ * @dest: the destination for the blob
+ * @size: the size of the blob
  * @gfp: allocation type
  *
- * Allocate the cred blob for all the modules
+ * Allocate a blob for all the modules
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
+static int lsm_blob_alloc(void **dest, size_t size, gfp_t gfp)
 {
-	if (blob_sizes.lbs_cred == 0) {
-		cred->security = NULL;
+	if (size == 0) {
+		*dest = NULL;
 		return 0;
 	}
 
-	cred->security = kzalloc(blob_sizes.lbs_cred, gfp);
-	if (cred->security == NULL)
+	*dest = kzalloc(size, gfp);
+	if (*dest == NULL)
 		return -ENOMEM;
 	return 0;
 }
 
+/**
+ * lsm_cred_alloc - allocate a composite cred blob
+ * @cred: the cred that needs a blob
+ * @gfp: allocation type
+ *
+ * Allocate the cred blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
+{
+	return lsm_blob_alloc(&cred->security, blob_sizes.lbs_cred, gfp);
+}
+
 /**
  * lsm_early_cred - during initialization allocate a composite cred blob
  * @cred: the cred that needs a blob
@@ -690,15 +705,7 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
-	if (blob_sizes.lbs_task == 0) {
-		task->security = NULL;
-		return 0;
-	}
-
-	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
-	if (task->security == NULL)
-		return -ENOMEM;
-	return 0;
+	return lsm_blob_alloc(&task->security, blob_sizes.lbs_task, GFP_KERNEL);
 }
 
 /**
@@ -711,15 +718,7 @@ static int lsm_task_alloc(struct task_struct *task)
  */
 static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
 {
-	if (blob_sizes.lbs_ipc == 0) {
-		kip->security = NULL;
-		return 0;
-	}
-
-	kip->security = kzalloc(blob_sizes.lbs_ipc, GFP_KERNEL);
-	if (kip->security == NULL)
-		return -ENOMEM;
-	return 0;
+	return lsm_blob_alloc(&kip->security, blob_sizes.lbs_ipc, GFP_KERNEL);
 }
 
 #ifdef CONFIG_KEYS
@@ -733,15 +732,7 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
  */
 static int lsm_key_alloc(struct key *key)
 {
-	if (blob_sizes.lbs_key == 0) {
-		key->security = NULL;
-		return 0;
-	}
-
-	key->security = kzalloc(blob_sizes.lbs_key, GFP_KERNEL);
-	if (key->security == NULL)
-		return -ENOMEM;
-	return 0;
+	return lsm_blob_alloc(&key->security, blob_sizes.lbs_key, GFP_KERNEL);
 }
 #endif /* CONFIG_KEYS */
 
@@ -755,15 +746,8 @@ static int lsm_key_alloc(struct key *key)
  */
 static int lsm_msg_msg_alloc(struct msg_msg *mp)
 {
-	if (blob_sizes.lbs_msg_msg == 0) {
-		mp->security = NULL;
-		return 0;
-	}
-
-	mp->security = kzalloc(blob_sizes.lbs_msg_msg, GFP_KERNEL);
-	if (mp->security == NULL)
-		return -ENOMEM;
-	return 0;
+	return lsm_blob_alloc(&mp->security, blob_sizes.lbs_msg_msg,
+			      GFP_KERNEL);
 }
 
 /**
@@ -790,15 +774,8 @@ static void __init lsm_early_task(struct task_struct *task)
  */
 static int lsm_superblock_alloc(struct super_block *sb)
 {
-	if (blob_sizes.lbs_superblock == 0) {
-		sb->s_security = NULL;
-		return 0;
-	}
-
-	sb->s_security = kzalloc(blob_sizes.lbs_superblock, GFP_KERNEL);
-	if (sb->s_security == NULL)
-		return -ENOMEM;
-	return 0;
+	return lsm_blob_alloc(&sb->s_security, blob_sizes.lbs_superblock,
+			      GFP_KERNEL);
 }
 
 /**
@@ -4680,23 +4657,15 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 /**
  * lsm_sock_alloc - allocate a composite sock blob
  * @sock: the sock that needs a blob
- * @priority: allocation mode
+ * @gfp: allocation mode
  *
  * Allocate the sock blob for all the modules
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
+static int lsm_sock_alloc(struct sock *sock, gfp_t gfp)
 {
-	if (blob_sizes.lbs_sock == 0) {
-		sock->sk_security = NULL;
-		return 0;
-	}
-
-	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
-	if (sock->sk_security == NULL)
-		return -ENOMEM;
-	return 0;
+	return lsm_blob_alloc(&sock->sk_security, blob_sizes.lbs_sock, gfp);
 }
 
 /**
-- 
2.45.2

