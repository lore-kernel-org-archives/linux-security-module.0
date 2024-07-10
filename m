Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677D8287E
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647259; cv=none; b=sB+hbjcOxjXk7qyDgvndaMxEzBG5N9Wuw466HcYLthFm/a3LgHHVwPCMQyMrq0kwT650bOXv8hP+Pte2q8doEnBSP+5xpFATRejUysT/Lp+8coZzDxX0elzBSFjRqd6rDq189pOf0Ar2QMFVjj+rIPM9ePfZiJ+Dzkiv6pYtKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647259; c=relaxed/simple;
	bh=pQ6D/eVGREMzto47KUSU68nUJJbqR88VG/lLRjhPmMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGnRfE+2l6FJL+dGpRD62/Ytt56Ts3i+b4+7p6IoBIa26/61vjF6jOEg4lGMKGhTah1dzPMurdmyyBIyIIA6cbgwpk5dzYqZqI4YEnbGfQ51dMDFIzsPQw8hmkyccr+nsxOSNVXh5lFLALtbjQoskrUReL90+R8A2/hYo1Mo78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=afrN0grw; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="afrN0grw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647257; bh=E9cLMQVnTwQkpUE1vZbyi+mBC4SmZ1s2+PXuFp1S1H4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=afrN0grw9l5dQVjGGZ0i7xH5iLaWtJIbSeQBcl+pHgSck7oo0s4/xLlIA6Dg1WLyIZTsIg0Zfv+ytKBxyuHgQ7Nd0GSwzz+qN66pf0POW6c86pYWJyJNEZkr2Pf2uOxSLqhyUPfHjqMTdELNWKGE8jZBuzGTq1TxWZR+U1LObdDvFup6reZHn6SnvRkXXMJZH8P5hUL2i1RkCFvffuh+PDAkq/TsbV87YNYyEXnbuaBPmOZI0Q0SdEDA3onIA84jp9g2ihoJsBSa0bCjGk4U8W/1ktLA2EOUhyLJTeE15IPDX21UmQwaDY8CBdOvWOB540z+lxBEcM9zz5LZGJe0rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647257; bh=ZVuDFNemB7ivI6qWSLbN/JW6Jpw6hzjR1JHTU7vtXW5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=c9aCCUnm1lcHnE6zb4jhjUZsm3r/e2BxtUn1o541FKYBeXanAZPpvHn47Gv3xBGNeCpcBHCcjgquSSIxx7ZzGlh68b0apuh0D+YElRRm3CmMjo0aX1f+xe10Zz0ZTuXWqlPH5mCaK5mRRzY1779FCBJ9bfHoBPMGy4mSOAVJyKfauOo/2UyI7uG4Q4d7fSRRZfB062abhMCSo0cHievCop6jW+byqdQnM10EprnWFJtGDTAPBXXIQsbT26B2Dcrnb3vUiGuLv1VwUgpBvixaCz6/qYX/swGU7OMoPuxjvkyXEeEjQ/lhP+FhOTddYyvtMOPL/FaEIz50Bx/Ly10r+w==
X-YMail-OSG: OKTaUN4VM1lqhaB_Q9dzYM_Nrsmj58hHbVadINMymuqgQFxPHWorjKCjBZXd1rD
 q53nrPrOGVaMXFEsk4RKinVjfotl5hn1dPk4socetU4TopFcCzFzJtIQqYLPigWcn4LjI7apXKbX
 uP.2l5px5kMCpgkocn6G.jTtySB39XGcgIv96QV0SF7zdSBE65U1Bp51VOLeqs8NkRysngAYhsTJ
 F6IDdgLh8TjFg9U5OcJXVojfODCJj4xnHjq8jlgVGGAfvDxJGmzdV85XkvxBZMowduQlCGjaY2me
 rQ3MqyoQ8EZH5IxwdCx2Zv8WNlij24dHuwki5JrchMMg65yPMpRjsZE_9IrkWGHpe4mqg747SX2f
 woDnhs1dzq3WabylJ4jVyBRKUL_2RyccGqu76DPmgFYa9f5DnphHk8K29dYzZcDVKzZxjHIr_Jnw
 .yYVg_GBKYPLLAAnwhz2gebSUUeyFT2Kg3D_tdvW6hGePVfj_LdOxA.CFR_q3zvVw5JLLOhUNDGw
 oNdnFyycaOATOXOLEM7LtPw9xAtb1PjbVPVEKVtgzYreZviT7aZdePDfx67CGrdQgnBd1DQUC54c
 colBD2OtUmJ0qV3fG_ee.JTloL6E_LOz891ZWQ.uasbqapfHm_kmtmQCXMarSRP1zrLCms5H_8kt
 U93Upa7ve9IIJeSVCogK8uvG50Q3hJsSJfeT04zeiFu2vQxK.zHeuz8woQ_YHyZCS55tl.d.0jPe
 eFV8Fbc.ajpIpNlJQCXE95bRAhyCLGTOqV60JqltF4CGxr5UOQQvAzXjCz6eQlTq1aqAaVtHPtS2
 m2hn.bIo.H3p7wvW.Zncyd0d7dXfm5beyGyKEZ1uuGjHoJ4gCLS43O7R6uDPaOINBlb4O4jNYaj7
 EjZxHzxMoNgXsDM7AExE2A_uKHYXE7zAfn5pHOEnDzgr_XtVlce4dZUIQ2z_EH08.Ey5f1bA8R5e
 J3k0cC_1W.rWamEPgiH1ScR9ZJ_LBvG30AsM4j7iBSuYltMwe.24T.PHUi9ZVRML.bjxyH3lcX6t
 pOL0DIBA5C_2_6jtPGnvqa26i.SRcHZ.rnKvGCsTlHRN6KOUBCL4Edqutuv28ISEqx.kvpzi.I.U
 uTdahtssGDuCZ9rg_35.9zacqcnB7lN2e_v72Y1jWeGWizRV_1PcfU4o.iiQ2aAPFe3IQuH7LCnh
 tmvuI3HPBh46D7OQwA1xVsNlDdsMu4z5iOeQ09AYliDqux7EjY73t9Rm38lJPbHl40Wpn7X9ozOW
 H0e9o316nFO7d7YYnZdR4rsq0lLgSxWoseeCH._PAZcLVTs1m1bUxK2WIuiDlKvbKfBtOFRy5ruk
 q9xob.nbHrusH2roCEHxr.BTe.LafLGKBVajcM21c73oXYPwzRE13Gh3zg0BAG8sxW1J1nD.oQdY
 QCzG8QbMMgJr0aRKcsk8mP4MB8rcKHJRoTjP5XxSMaE3gVG.rGzHKUnPxDI2sy7EHFS.nm_m8fyU
 341ivfMUjp_iJW._TJHYqF7uYC8glF1Ug3q4fc_YvRFhu1ab61unYq7WVez0dCuqMKInVjfxJlJI
 WrrpCpr5RDisSXp8_JlQ06UQ9Yfzl4j6QEPe3RZTVy1wTjnXqUlrH8GKrBrz0ZfPPbazbPWxDPaO
 PmuV_jgZz3a4rg.PdPSDIAMjt3YVLHKQgCTKDA59DvWixwqJQA0QSmuVgxC2gXGfAw2E_9MJllq4
 maN07VnerF2tYwT3Ozv1BEYahPzpTgJDnLd13IMN9itxPhmPq_eA4gA9sgcIPi50.20wq8cDZyV.
 mPRXzgdBWylquGXM6aSM2UUT10mrUGFmvT4diTUh1ujXbJioRiSheWQsn_LychrohvsAOQdkeGPC
 KvJ0CqTzikhUvLpLY0grfbL6pV1Sy7W8Dr09z1_uVlnxwTTjzRyZQKc90Um2tlPXo0TN0orAVuS1
 p9GjTMugh3HQ5p5PdTrl13375InWfoDmRLtmP2BNOgKvvbLpH.TUUO81MtiZ6fIxpaPzDpxN1kbv
 VG0OZ2Hd1XJef4ccQgR2h0EUkQbhLGVT9St3ofZX3QsGrzwwc5J0oBtt685UX1Osz2b1BTditPne
 qeei5LDHyzme986qtEVyk0XYfIwO7JzOlqNYAO1czXx4n4y6Ipj6dG1WS7BDak8puWCYSt08UdbE
 xeN18wrtMO2pA4_jdq7dwibLTCcil64eC4a7GQ0MUcWWZUlgXfEZi6aW6kRETFlPs95S9DjcLTb1
 DCN10ug1ufR0tTALf_Cnn610C
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 429c8445-fc75-4698-a56d-dd9792d85b21
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2024 21:34:17 +0000
Received: by hermes--production-gq1-799bb7c8cf-jfh5x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e290f093598dd7cebf6712409b4ec393;
          Wed, 10 Jul 2024 21:34:14 +0000 (UTC)
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
Subject: [PATCH v2 5/6] LSM: Infrastructure management of the infiniband blob
Date: Wed, 10 Jul 2024 14:32:29 -0700
Message-ID: <20240710213230.11978-6-casey@schaufler-ca.com>
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

Move management of the infiniband security blob out of the individual
security modules and into the LSM infrastructure.  The security modules
tell the infrastructure how much space they require at initialization.
There are no longer any modules that require the ib_free() hook.
The hook definition has been removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  3 +--
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 17 +++++++++++++++--
 security/selinux/hooks.c          | 16 +++-------------
 security/selinux/include/objsec.h |  6 ++++++
 5 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f1e0d6138845..7c979137c0f2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -372,8 +372,7 @@ LSM_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
 LSM_HOOK(int, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
 LSM_HOOK(int, 0, ib_endport_manage_subnet, void *sec, const char *dev_name,
 	 u8 port_num)
-LSM_HOOK(int, 0, ib_alloc_security, void **sec)
-LSM_HOOK(void, LSM_RET_VOID, ib_free_security, void *sec)
+LSM_HOOK(int, 0, ib_alloc_security, void *sec)
 #endif /* CONFIG_SECURITY_INFINIBAND */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
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
index f1eb93b65ae9..e8f34cbb1990 100644
--- a/security/security.c
+++ b/security/security.c
@@ -219,6 +219,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 
 	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
 	/*
 	 * The inode blob gets an rcu_head in addition to
 	 * what the modules might need.
@@ -402,6 +403,7 @@ static void __init ordered_lsm_init(void)
 
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
+	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
 #ifdef CONFIG_KEYS
@@ -5070,7 +5072,18 @@ EXPORT_SYMBOL(security_ib_endport_manage_subnet);
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
+	rc = call_int_hook(ib_alloc_security, *sec);
+	if (rc) {
+		kfree(*sec);
+		*sec = NULL;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_ib_alloc_security);
 
@@ -5082,7 +5095,7 @@ EXPORT_SYMBOL(security_ib_alloc_security);
  */
 void security_ib_free_security(void *sec)
 {
-	call_void_hook(ib_free_security, sec);
+	kfree(sec);
 }
 EXPORT_SYMBOL(security_ib_free_security);
 #endif	/* CONFIG_SECURITY_INFINIBAND */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 34ed787a4bfa..11f4bdabda97 100644
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
@@ -6964,6 +6954,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
+	.lbs_ib = sizeof(struct ib_security_struct),
 };
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7282,7 +7273,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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
2.45.2

