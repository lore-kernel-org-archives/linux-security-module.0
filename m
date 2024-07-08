Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60834EB2B
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474911; cv=none; b=WI+HP8UPjxy/D9KO73xCSYoxuS8dYbHkCdO9HFEOeJ/2dbqps3HcWHdyVstG7STUXpUyve+cdfh49S0c9+h0P3YwHPrmJG7lI/IUndG1/0nbbtA61MDGMQUD6xf3Qr8OIZayU18BCqpTDynruMtSOWN3eX71TOcuNK1S3wyV8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474911; c=relaxed/simple;
	bh=kEicifXjp/pHDSOUVrWvb+Y4W7vCgUM+hf8ejKvwxk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQVu+womECNUzPiMCOsz6mIh0ruwsWXgRZR1tDV2xroA8E1oENrqTZKTss88l+tyuFs30CLqrFLlitupLBXbW+Pvt+X+NawXFEnrsZk1Xu5HBNLD17V2FlVFZbUC5KJT/f8wCINnrjsslx50fmu7IU/+8zxsCazoVo3HhhiP5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Yaa3jzS3; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Yaa3jzS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720474908; bh=lPYxJS3I8UNcr8IGIWNo3TVvaFSGbQmk54XmLfp0ZvE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Yaa3jzS3Jxh/UzfCtZj4UWrWJIYZhvdwkrbPaky98Q1VhWPBnTy3UQcxhprNAIXHZ3ujd9uPucbTgMld4dd+UNfT7c3LydTYLb6p8o/TptYLpa0hOqP3FYk3y1J0wqj9IYtjeaqSBqD3+mc9UCI1pmsHYBXPgBF338iPGX+uFYwVNa6aN6WT0mcEL/ZeepEIk9h7MR32CeMLsJaYsKp7s7J2iTjpNMbMcmladJ419Z4MPE5UlWrx+j1mIV+wzRe5+89Ex+RcU2DSi0Xy5rqzfNLgeY7D/rSIQme//3JcospOIFijdwZ9pV8GfYLYCimrLmXCPYP0VQa3eT6CAjNAlw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720474908; bh=Cfhq2Ei5arqwizPih7w/fSirEqnfGrSc8yn4Qw1mtdb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JM1Da8zMO1zvdcVNWjlyyVS9oCpbySkNlX6m0qiS30IRd/CTUz/gKsjAuZi451UiGdS0bO+51NXcoBmTx7BKxi7FKS3/V3hEjRAtWfX7CC4oPq8QpnfIxZUwMsBsT9tYh7B8TOPyzCOvx9aA78gXas/bElQ5aQchehzwS9vlaJZEUXIfXcgq83xGKTDiz2Xn4YCq127Xh9SAVokfCUcdYnH95VrXL9SZzwTQzxRrWydpwXnjcm7Hfvg20pVujEFOwsW9Dud+p47FWYUKt2f8L9MQp0DzLQ8ADsJMWm145qWoCOCBZIhdvs3LTBG3SnGVgPO6AX4Ue0smMxlj1Tiv/w==
X-YMail-OSG: mcbKEFkVM1mYkzW.IhUI_Y87GNVC77Ps0wGBrP2rGM.DX.9_Kt4EK6XWCwY1.UI
 NRvewR7Vv3oSGsfYbSMtDcrB4CnYu5OB.63555I0Apbsjx02JyGJ0zCQjsu4ZgMIMJPbMSfwCdYr
 svxJcbZAxdAUGBupRal.oW53.DW3PzMvfYSHJrNI_oxR2nmQ8fNs2Vwx83BB.f4BQAR2IyDq0L3O
 Ha23JUVjiSkxA8Jm7qR9.3sMgbfY_BGWIVL.gyKlPvEDBtl9lpptOzTKgFrkVfmm.Xqqcx1N7N8S
 d6nMLIswEHLQsQIPtqOVkcnJCBeglt7xgUTDKBBGujf7A4CCzWpDjE6nFRnsW7MgKpSQOOFoq04a
 9BAfHB_.gjUNHehPG_sEDONJUyGlb16cB.L4DpLFKo5fHJU9guCVQXacGh6FZNwnrCSH2sBuvDuq
 pAsVSz0P.3PLrvuymE8tECA5KFWa2ezI8wNvCtm1d84tw6DdpKsW3.LJCh6KwPu0tlvLPQ2otfm2
 _ZBtGrkAC2OwKBdLjAcJUSB25vI0XBD806YlmY5IBVRHr5.r1FbdGRB4_rxDGVMK190.rvqggcUU
 L.VFuTRRxIATBDWKqn6Bgf61xeaR5gfp85O7VXw1t2k0vjUKhEILU0BpDfchhOjVloU1Gr5Rx.Qd
 KU43GsIVibmTR9xP21zL5va3bYD_O0IGTapefJmKrBiPE4yFRh5Asnh1DyCMlfm1M0YtwoTh4sLo
 2pLhjxY6XkHnIrRMTVKXltAbfHuBd807vZMCuRcBMUmQfeDgaWYNbhsfDwpp6ZpPX_Qr6xTdL4vc
 mif9IbQNhqNgBkb5jVzWUKWBDaiewJaI5nZn_EFxAHg40jGgP0Ii6IFT6tsQluo8C0KMJhyq.T8O
 0qzxGZ4YF1UfBTB_iew4P0I71VIE7PrfA8jt09NrnIRP2.l0p6g2JuCkfAYALzD9irmBaKfncUX0
 GcTgKC6L8JVVHZAx4TlAUV3HvYaHY0slCnqm28n02NUmydU7IweR1TVYl8eht92syZaokVUZbfLi
 auuabQrr18heFuVmeB82SyqjqBkYf3XbinNwunDCsAYOEcEOK81oqAzwvL0Y88QxoPtuXS1llccg
 k2rI.FJK5wezPegHigqB5OeZk3xZImLTZCc0Xok0ZbgtHG5kDNY9e2TeKa01YehwMGXwGsSQBe_f
 yOnhioQcq8U709wZZCrD4EYmqRJi_H5uAweqJzOg2fIFumF8zYX8b8d7G_VE6Qlh7Vu11estH0c3
 XZSfol9zeIHNUcyTErJF0XaMwNWREt7THPgZ9arx_9obWdbn7HuAfFQnLJmDT1q530CXp4Es865X
 aw7IIMKmaDIU4SKjX8QkAQVf6j5n2Y6K48mgJjpnWH9.mn3v33sKjlV4eQOAoJsukW1SWQzgF0_d
 3SsoTu0GDZ5HTav3..YlzQLSKI_qp_VV3hCoNZRQxbxVEtySXnAtwJMvJP2tfQeADApk_1TIDDcE
 1uprhUhWZGwuJ0EQRMiOZfgZI9FgXuSIw8K7Ze3IEfVr5bfNCEnCnuLNpKrpYZho3AdbQwvzNVhU
 L6y0C_uTU16fJnbzrDcdS8.XSfY3bRBy9YkRcHPtUJCrMGYq26O1lriCEpMWyLoMG7IqBlr.KLeK
 Wqhnd.ZW4QkXFzo9POsIZMtGcgLywCaisG.a_xQZraIOqDiBk0vx7BdTGp3OTj2RglFJEjun7QqT
 TspowOOSr4MwiGHKENz1o.Re5CmuLzdk55VChoHQhdxiW6wAgYjaesFmrI9vQxYirtyB_fU7psMv
 8L_IDO2MY3zifAKwiGH.KWkla0ra8OTdfMtFW08ZnBmscTBguKEneXZIyKqU3AZkeSnJen1XTsxF
 tV3TNLJZOfj_vx.hZdzpMJVLwEiHHbc.gMBndh6c1Pm2BlRl3UXvW.h0.MV.q_vh9z.CM9TdSYYp
 hCkNnYFUf.TteaxkFwvepmFo2cLraf161N8dvHK_wx21a1Txpc8_2xnPPNjAJkT2.jTSMYdpKj3F
 mPye887HQpUoYFSsjCnylOnnU8vr8pe.Wsfwnho5n8Uw8Nq11aOuY.2spAeKps.IysUz1DgSlADw
 1jVvMZQb_BnENPLCckFLFExyAjQnV.hUCMtewo8SJQfAM9EFGqmjcCsuyDNA5DZRBdnwaV.yCwR5
 2k_2.z2eOAljLuOm3VVwHBrk5KixB0lHnSoDbPCZBixUUsV.0pNiFpyLECOfaXQnzfsSjkrIyNao
 E9R8XtwUKWlbci8W4_5wd2.pT7XEx
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4925b188-25ee-4405-b864-506f4ddb8809
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Jul 2024 21:41:48 +0000
Received: by hermes--production-gq1-5b4c49485c-sbfr9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 804657d20aca575d276c2f9208c57a78;
          Mon, 08 Jul 2024 21:41:42 +0000 (UTC)
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
Subject: [PATCH 3/6] LSM: Add helper for blob allocations
Date: Mon,  8 Jul 2024 14:39:54 -0700
Message-ID: <20240708213957.20519-4-casey@schaufler-ca.com>
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

Create a helper function lsm_blob_alloc() for general use in the hook
specific functions that allocate LSM blobs. Change the hook specific
functions to use this helper. This reduces the code size by a small
amount and will make adding new instances of infrastructure managed
security blobs easier.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 97 +++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 64 deletions(-)

diff --git a/security/security.c b/security/security.c
index aae37481b7be..438ec6708eb3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -605,27 +605,42 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb)
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
@@ -692,15 +707,7 @@ int lsm_inode_alloc(struct inode *inode)
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
@@ -713,15 +720,7 @@ static int lsm_task_alloc(struct task_struct *task)
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
@@ -735,15 +734,7 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
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
 
@@ -757,15 +748,8 @@ static int lsm_key_alloc(struct key *key)
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
@@ -792,15 +776,8 @@ static void __init lsm_early_task(struct task_struct *task)
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
@@ -4682,23 +4659,15 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
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
2.41.0

