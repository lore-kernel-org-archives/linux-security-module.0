Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BA145B06
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474912; cv=none; b=kTLMfGeIvnG//lGcezwsHelGqzFDA5rw3VIbZQyGSUQ7OwQFpGFZRvrkyCWNOmXGoISOLAA85tEUhjCxZiI2v/TBe/fKracotc3XPQ1lhH68x1mVgaE+ome1XH7FgBa4r0QJvnv0fXgPCfgw3ZlNWzqX/EaCeGrbTCorjssTCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474912; c=relaxed/simple;
	bh=2kKbApZ8VNdp5LJWIxY5MczgE9fV+9NFzSqEBwluunY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCI4GpKu3i+cyXTPwIvcwfAENkKu4uWAElx/9TvIMkwEpiwCpzySjgGRlMKq7Pkj8HNv9YQ02amdHydYeRey9epcqo6unH3REAjt25QXr13U0FEHq4xV8YnL4VtAapIcG24JYPyxwHOm9NMN+z4sSsRN+DefMUVZkyvUqgoYxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kUDpNNkI; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kUDpNNkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720474910; bh=8y2z/d+6I4YpKqXefk3RtDIccNNeS3FGmh/J4Ac8WyU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kUDpNNkIDB2sYLlH1mImDPkEgcjziqr2a5KsmLqaMSWL9Exkv4yiXhQ9DhWrRDi1fACnKBWvXBAkHfpmZURPOEg62EClsxY88Fu3tk7QF6nuRVQ4vdA3IKshqK1+2cR6ZIn/eaZAUDM8RifKHMRCcrtLooce49/cWsnrBUfck5q0/6FgwbSYgoMmrT8CjHUY0UrhACHJCoNpV5/mDDOuyvotellfYGO6+44xhCer0bi+RIeGHG/0biZC4q+ezTp6oh1c2KKiGsO8yH+JQTuVHqFnFPkvQFYwEMbGpbkwCKuGYq/tYr0atS58yzFkwtf+7+th+0mFq3nVWMzIKQAt5Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720474910; bh=WJXApjthi3Krm4JA4TRtk/mF15CaZBPAaIEYPye9g8n=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Jhfzow5k7X/RwV5qLDkx9CzbGpM4qNHhpB7TQu/ulLYquOMdWbdkwhAxSrhY4xNvFO0/sFitnzAt1oUdtxpsX3tS5cYih/Wxqtmc5xrH2t1Ju26rBCJE/itsM/2AHFOV4KfscR5FCnJimkv+RXJar/jH84w0BsqEbjaIvuR1MNfpyB36/8OB4Z4dDUiWqyOP2CnIjPDf16Lg3ucjftQNBtE2MMIz8oA1pzpyB5yvHph0hg//BO75E8Ox5IEc8tfjqL1hdPirrT6nf5iVu8zodGLYxhcqw168ycOX98eS+MVJo0XIhQ6g2Lx8KQevwRSCaoXeg7gQjjQ6Xm8eXdrXmQ==
X-YMail-OSG: gMTCo2EVM1ljwVNBwmLsp91XnyTqkYqTIokXWBLNhnIlKDzpI7tMO4qlWYbfg6.
 pOXZ4K6GRInkH.sy6ZB96gjYpPtWcRFQ9OkIK4vFqtBSa71TKZI7q6ZMRAK56BGGVZUloKx4Tsdi
 fjYzxvuqdDKbOvzramYX6s6O9Dr9xoFFq4nwB3aiFOyA9XvsY8cHlB8N8KZF5ySjpXl2nfwdfCnh
 gyuNGBHjZt0LmZd7c4LustNsry.5Me0ygP2ECMuy.S4xCldkEPRrX.nNlxbVJc5XRsxWq7rKCWv1
 GS3uSKlvB2_q_mHVUldn0.6QAib5LwcGFhVvdPemmcr3ssye7HhrXMoI1nm97pU0ABfr9OecchEs
 H.lGpCHK32cEIQHmzWixKzAwGIhQOIwUWkweoZaM6EKeKF2cMDTAZtE0av.YysyIR9G9wzL0gkLW
 HY7_ohhnKNjQ_.EJliDrBDCA5HgYcTZU4AhowuIOgZEkEAyeXrld4OyNj5cy8wxfDV.LUa.vCgpj
 rlMTQsbTbuYOyTs19pOOINTDVYIx1G4kJEh6HnBKHTgQzwGD4Q8wRMp9ystnElr4C2mHXOnp0Or1
 mYllFdCjOdUII_.u8i6W73gP73u5MuAJ5fH.lhIEXF3kcfW_IluZLkqWxIKINlnV9ErMBBsgoGhL
 HmnxjLR3OQHQ9H3VT40Vcq7fMJ4n05izktZHxoAqwPaOQPvQA4fix7tYnSJwMJ_BhURBjrfnE3aS
 aChgsJ6etojSFhSv.dhE_jQDnO4utZyzHgPb0JAp6UhZCYUlEr.EyL02mldgFdcW7WCa.E0MUYL6
 FBV9TJhie5H2J2xYGlT1dEJ6nHIEuVrQki_sMAMO4z141TWZzc8chnCG0jY_f6iXbqZ4.Sf6._8G
 7a4X9DmRNeO1Ixw0AG6kCJmKBVWATMPBZrGsxjCp8T_Pgog4xjsH3ROBAcv6DMhlPxO__zZPtm8X
 mHkm5bOOFazkc0aUeFlnlBr_66nKcI8WabRaxR8s0gnv5RhacZUe0YZ5VSmup7f6h_beSEQJAtXn
 Co1vEKP6HiCiPIsNXxKLBGpvw3kDidBP3NkFu05PINrtgVJs5YKaEoZSY7MuHCXCoeID27rh85TC
 m8o8BVUf.94NESCbVxN38Ia2Ajw_TJtuJDFVO0nWBW24lo9e3zglbKJVgv3Aj2mxLQ2qBVac2ZPa
 N84TSUgx2zPuAjNL_vmrEtrC0I8yeJwWl1bGhnrO6.REQN4yh9nicB5lj.vHNgg2ik_WSMm8DxJ1
 Rr156.CeELXzBZ2QvBaqQo.zxoePMDXCQGplZNXyYdA_gpT.9oS9QMGJv2FPw1sb7Tc_bMxQPQIz
 cKlg8ZFrl8MxCJ8epJFgLeq6dWaa1IAty6jk6KEomxbZqjOVQSYxxMFOZv2IG9pkr589EQo7IJc_
 ZdiaG50p6aOurKwnSGrUOCTQGk3lzs5VJpQ3E30tPXYx1Eou2OQA0A5_Xy5KaihVSfP0Wdsi0TCE
 fdkJsI6wlj_rIwNcCTA5r9BzicolOceD3WUQ1SAN.VBuLn25S_cJjr1AZrCLorSAHN71HK7GYuj6
 ArCXpqcgctchAaU1Jk2IguyDPUo7DOolxlKqKXfsOZPNWWuDCLUj0hHctcIt8_bXwbnihd2Ighgj
 DofTm1YHbzmo1mz2spF_9XYgtpjao1LZCBIHvnL09NT5MbJfzuIGGxCcJwzKcQbB_klY1eKJOZ6C
 EdQqUOVCagwzI.Dudu0drthfqkqnMPclkLS7BEKfnkyjq88EJPWWjS.3hG1rYSPPxuC4KWxoeDDe
 BUGw45bvE1IkWeZHX04blyQtdvGL_rqy16_ELTJaMlt6pznbU2obKaR7qXMpzebPKZ4GId2xkRMo
 k_7gdQ1PSxKxkRiHXokcZXLRj8k_qTfgIiuBG9Xbo25Hi7GaTO7qWKteVhkYAHuKBozrosPA7fHs
 78L0AVKfZJpwrnBP9dKdl0gxsFz1QLvaO3PDqEjnhwn4IoUjXRsRSQ8MfZ9mVxOrxJVg46hfJiS9
 JBqDuPmHU2fNET07N6qUOsUH07P52QUPJxDIeNxLFLnYbKAVaJ7bNPCFX3gW9zedJOZ2NydIYgAv
 rVeC0.BH6Y7BZLAKbz9gFzxg6G8z9YqyL06CClJkxuuCAugE4NcOeO6IQ0prlv75AfcDFsk0Fjec
 qOjiKRJxqKk0q.yLv3_GDiswnDmkS1_5GznVLQMFdXQMEXWIqSsncBNrzdLqpCqlzXV4ZbTTANOI
 .o5IkDx0SAtt95GzCxd4JlqKRqmW7xX1FQC0bovOZb8Fe5xwZeQLFlufqSVSBBExLipxMc97oC4Y
 OM8j2sE6t
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f3c842fa-d5cc-48e0-a22c-04b676a8fada
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Jul 2024 21:41:50 +0000
Received: by hermes--production-gq1-5b4c49485c-sbfr9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 804657d20aca575d276c2f9208c57a78;
          Mon, 08 Jul 2024 21:41:45 +0000 (UTC)
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
Subject: [PATCH 5/6] LSM: Infrastructure management of the infiniband blob
Date: Mon,  8 Jul 2024 14:39:56 -0700
Message-ID: <20240708213957.20519-6-casey@schaufler-ca.com>
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

Move management of the infiniband security blob out of the individual
security modules and into the LSM infrastructure.  The security modules
tell the infrastructure how much space they require at initialization.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 11 ++++++++++-
 security/selinux/hooks.c          | 16 +++-------------
 security/selinux/include/objsec.h |  6 ++++++
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 601e3092a7ed..796ab400e992 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -373,7 +373,7 @@ LSM_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
 LSM_HOOK(int, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
 LSM_HOOK(int, 0, ib_endport_manage_subnet, void *sec, const char *dev_name,
 	 u8 port_num)
-LSM_HOOK(int, 0, ib_alloc_security, void **sec)
+LSM_HOOK(int, 0, ib_alloc_security, void *sec)
 LSM_HOOK(void, LSM_RET_VOID, ib_free_security, void *sec)
 #endif /* CONFIG_SECURITY_INFINIBAND */
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0ff14ff128c8..b6fc6ac88723 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -72,6 +72,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
+	int	lbs_ib;
 	int	lbs_inode;
 	int	lbs_sock;
 	int	lbs_superblock;
diff --git a/security/security.c b/security/security.c
index 2c9d075f5f92..731a54fabc79 100644
--- a/security/security.c
+++ b/security/security.c
@@ -219,6 +219,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 
 	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
 	/*
 	 * The inode blob gets an rcu_head in addition to
 	 * what the modules might need.
@@ -404,6 +405,7 @@ static void __init ordered_lsm_init(void)
 
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
+	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
 #ifdef CONFIG_KEYS
@@ -5068,7 +5070,13 @@ EXPORT_SYMBOL(security_ib_endport_manage_subnet);
  */
 int security_ib_alloc_security(void **sec)
 {
-	return call_int_hook(ib_alloc_security, sec);
+	int rc;
+
+	rc = lsm_blob_alloc(sec, blob_sizes.lbs_ib, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	return call_int_hook(ib_alloc_security, *sec);
 }
 EXPORT_SYMBOL(security_ib_alloc_security);
 
@@ -5081,6 +5089,7 @@ EXPORT_SYMBOL(security_ib_alloc_security);
 void security_ib_free_security(void *sec)
 {
 	call_void_hook(ib_free_security, sec);
+	kfree(sec);
 }
 EXPORT_SYMBOL(security_ib_free_security);
 #endif	/* CONFIG_SECURITY_INFINIBAND */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7f1d8358922a..79fe75603881 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6776,23 +6776,13 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 			    INFINIBAND_ENDPORT__MANAGE_SUBNET, &ad);
 }
 
-static int selinux_ib_alloc_security(void **ib_sec)
+static int selinux_ib_alloc_security(void *ib_sec)
 {
-	struct ib_security_struct *sec;
+	struct ib_security_struct *sec = selinux_ib(ib_sec);
 
-	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
-	if (!sec)
-		return -ENOMEM;
 	sec->sid = current_sid();
-
-	*ib_sec = sec;
 	return 0;
 }
-
-static void selinux_ib_free_security(void *ib_sec)
-{
-	kfree(ib_sec);
-}
 #endif
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -6966,6 +6956,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
+	.lbs_ib = sizeof(struct ib_security_struct),
 };
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7284,7 +7275,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
 	LSM_HOOK_INIT(ib_endport_manage_subnet,
 		      selinux_ib_endport_manage_subnet),
-	LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
 #endif
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 461c6985977d..b1878f9395b5 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -213,4 +213,10 @@ selinux_tun_dev(void *security)
 	return security + selinux_blob_sizes.lbs_tun_dev;
 }
 
+static inline struct ib_security_struct *
+selinux_ib(void *ib_sec)
+{
+	return ib_sec + selinux_blob_sizes.lbs_ib;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.41.0

