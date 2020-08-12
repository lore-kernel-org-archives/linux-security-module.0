Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5217C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 00:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C72080C
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 00:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="knit+tWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHLAnF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:43:05 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:40980
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgHLAnE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 20:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597192982; bh=zpMsrOgidFwYOozpHwovuFVe9Qow3bMCfzTTWkZ5+Bc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=knit+tWMOiE9Ww6vwKFkXISdKoWYkErbnysDFWi32ajkVMasT+S4/D5azlmH3Cp82mIn/wdv57kq/pJiTUuMSHNCCLgTMOWz6tGQ98nG5FzI38PleKHdBrzo1Im3oPs7MONkoM8unWsa2HeV0haTArdf5V3mlFCLbapMBF4b5Wg9TN4s1Jd/fvtrefYWwxCKQFCFPZzPv+xMdCBudokQU4yRBuQ8J+VKHPwIEnfnODzDkkWxjxx99JmBhLlpmtDYGe4VeMCa4taTKSNDrE72EJtrlqzYuNosNunDhEqqfOIXfWeDr2MiAxdzct+pBGC4fvmjJ8FEe9CckrikCCR86A==
X-YMail-OSG: gxub22UVM1nACwsfn57mDB8jFFN5EM17hGHHVCh7iRCYViniXagNgu2mTFEIk6H
 oSU2m1vBCxLXyGxFrP2ZvIR1VVOgBbr6HvmGf1f1OS9q7LBBoV9n7mI.HfAfA7jGRwrAeCHGJjEf
 3n4Cf.KC50fyGP.aj1vnolY8oWj2j1e5P0cxa1O.jlkL_H6thR8IV8YEFH6WgkMWZFPjPU5xvnQ1
 O_shwouPWaYU.7.3lhtcUGHB0EKQM0tvVT.thtXSCEjTJlryVvSf5W0ksv.mm9Y2CfRJWqVhDX0W
 OKuxRzn956mc9hC6syqLJ8cnugzZmfhAnn7pkevTcgGOnFiQbnTWUbcu_HdIPox3E4dz0Hc4gbc8
 3H3x3oPQ9cjTnc8sfZ16uUCyOjRe_2Oao.29EgiCe.zqkgYQKH6QHTFK2rrNzcvYabhTlyIDqLbk
 NXM8i4M6LK_ykWwVAevXjhrQsHSUCiZx3P.P8EEXRBjB3Rid2Ubx5QcUA8LH56CRzRec0PlY1nqG
 kS9LmGNjak8mqxCjlMDqicgmdKPptLkXzraoY2WnTWcsBjqvigItEurGxazi1cWzSCOO3v2zAj_J
 __PuroY4nB1ORtfFtlX1MHWxqvdQ1fEYvmRW19u.B25AUEYUw1njLqaUbzjaU7HUFZofqYtVsNUj
 3dHGE5Rm3VRxX0tBjtIuZTuJFWtcBl4h2ZI7FMaKw8.92O2WHrqZeERG0LDcY84WupSDwwMKcbFa
 uD8YTouJVFcBy7rCl4Xtoi.puh9rmTHnp5AXjkuULTsmF0iPVzZ3K4uUC2wDEq_owuGbM4OzBUmb
 ovnOsnMUurDb.p3EnCqvV2vy4m4WrIdqO8nT5Ktw_Dfh2f8HsbQrc0pLVzyJkTCGnXElUPUESap4
 NdNXhfx15wYAKQnuJhhzC9p5lhp3IfO50q3sld637Xh82Ywey9fwshbnL0FRcM2c9LzpWGoYg.fs
 mVw6YFgu9OdMWjHFqLSLP5znDddXWY1lFQBsno1VbFqwS71CaHt2AP9XTGyCi1rF4WN.v5R7wnD2
 qQIZXl8OKViv23Me9i_4M0JOuhoQTDdaySJA4aXT_eDXUWUHwuSGnQQ0ZZzDwiFkYXx45kdWNKIx
 WRY2Nw6WN2duBPKE6ScBfSgcZjzoVdEq2HDxld8lPJ85wUFfL9CdULrhsJ7pMNgxOTXCIcHw9vKQ
 NjYJh7bGm5jFd7OA2uT4Zs__DCGNSeDj2l6L0pkP7YpSzYcHUN54XkLMY0_IpJBLL4TeI3Ten2_R
 NIbv6ft4AKSumbSaUvb6pqSkfwoi4ZzBs0sihbE__swskh4nqFmKuuuU00xYhmJTS3XlkUkkLIld
 4RdN4k3rMqZP5Oo7emfp_uE7NAWgWyi3xvL1PPG6IG7NLGOH_b2XY.X4H5uRlZCbYorney252DWi
 qyIWvPuzNTASNsdrknWcIp9aNcS1nm4o9zdO2Yl_xzh6cEaRH4j8qtutregIk86NjXQh7K18xLbo
 z8f9RMqIK96k_io17uUz0VvXNO3SBp.tXQg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Aug 2020 00:43:02 +0000
Received: by smtp404.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3f5fd5fceb8add411cf7549426162c8f;
          Wed, 12 Aug 2020 00:43:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     SMACK-discuss@lists.01.org, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com, casey@schaufler-ca.com
Subject: [PATCH 3/3] Smack: Use the netlabel cache
Date:   Tue, 11 Aug 2020 17:39:43 -0700
Message-Id: <20200812003943.3036-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200812003943.3036-1-casey@schaufler-ca.com>
References: <20200812003943.3036-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Utilize the Netlabel cache mechanism for incoming packet matching.
Refactor the initialization of secattr structures, as it was being
done in two places.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h        |  1 +
 security/smack/smack_access.c | 55 +++++++++++++++++++++++------------
 security/smack/smack_lsm.c    | 27 +++++++++++++----
 security/smack/smackfs.c      | 23 ++++++---------
 4 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index c5d745a3ada8..a9768b12716b 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -297,6 +297,7 @@ struct smack_known *smk_find_entry(const char *);
 bool smack_privileged(int cap);
 bool smack_privileged_cred(int cap, const struct cred *cred);
 void smk_destroy_label_list(struct list_head *list);
+int smack_populate_secattr(struct smack_known *skp);
 
 /*
  * Shared data.
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 38ac3da4e791..efe2406a3960 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -510,6 +510,42 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
 	return 0;
 }
 
+/**
+ * smack_populate_secattr - fill in the smack_known netlabel information
+ * @skp: pointer to the structure to fill
+ *
+ * Populate the netlabel secattr structure for a Smack label.
+ *
+ * Returns 0 unless creating the category mapping fails
+ */
+int smack_populate_secattr(struct smack_known *skp)
+{
+	int slen;
+
+	skp->smk_netlabel.attr.secid = skp->smk_secid;
+	skp->smk_netlabel.domain = skp->smk_known;
+	skp->smk_netlabel.cache = netlbl_secattr_cache_alloc(GFP_ATOMIC);
+	if (skp->smk_netlabel.cache != NULL) {
+		skp->smk_netlabel.flags |= NETLBL_SECATTR_CACHE;
+		skp->smk_netlabel.cache->free = NULL;
+		skp->smk_netlabel.cache->data = skp;
+	}
+	skp->smk_netlabel.flags |= NETLBL_SECATTR_SECID |
+				   NETLBL_SECATTR_MLS_LVL |
+				   NETLBL_SECATTR_DOMAIN;
+	/*
+	 * If direct labeling works use it.
+	 * Otherwise use mapped labeling.
+	 */
+	slen = strlen(skp->smk_known);
+	if (slen < SMK_CIPSOLEN)
+		return smk_netlbl_mls(smack_cipso_direct, skp->smk_known,
+				      &skp->smk_netlabel, slen);
+
+	return smk_netlbl_mls(smack_cipso_mapped, (char *)&skp->smk_secid,
+			      &skp->smk_netlabel, sizeof(skp->smk_secid));
+}
+
 /**
  * smk_import_entry - import a label, return the list entry
  * @string: a text string that might be a Smack label
@@ -523,7 +559,6 @@ struct smack_known *smk_import_entry(const char *string, int len)
 {
 	struct smack_known *skp;
 	char *smack;
-	int slen;
 	int rc;
 
 	smack = smk_parse_smack(string, len);
@@ -544,21 +579,8 @@ struct smack_known *smk_import_entry(const char *string, int len)
 
 	skp->smk_known = smack;
 	skp->smk_secid = smack_next_secid++;
-	skp->smk_netlabel.domain = skp->smk_known;
-	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
-	/*
-	 * If direct labeling works use it.
-	 * Otherwise use mapped labeling.
-	 */
-	slen = strlen(smack);
-	if (slen < SMK_CIPSOLEN)
-		rc = smk_netlbl_mls(smack_cipso_direct, skp->smk_known,
-			       &skp->smk_netlabel, slen);
-	else
-		rc = smk_netlbl_mls(smack_cipso_mapped, (char *)&skp->smk_secid,
-			       &skp->smk_netlabel, sizeof(skp->smk_secid));
 
+	rc = smack_populate_secattr(skp);
 	if (rc >= 0) {
 		INIT_LIST_HEAD(&skp->smk_rules);
 		mutex_init(&skp->smk_rules_lock);
@@ -569,9 +591,6 @@ struct smack_known *smk_import_entry(const char *string, int len)
 		smk_insert_entry(skp);
 		goto unlockout;
 	}
-	/*
-	 * smk_netlbl_mls failed.
-	 */
 	kfree(skp);
 	skp = ERR_PTR(rc);
 freeout:
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7a79ddb39e94..86db667ce319 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3715,6 +3715,18 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 	int acat;
 	int kcat;
 
+	/*
+	 * Netlabel found it in the cache.
+	 */
+	if ((sap->flags & NETLBL_SECATTR_CACHE) != 0)
+		return (struct smack_known *)sap->cache->data;
+
+	if ((sap->flags & NETLBL_SECATTR_SECID) != 0)
+		/*
+		 * Looks like a fallback, which gives us a secid.
+		 */
+		return smack_from_secid(sap->attr.secid);
+
 	if ((sap->flags & NETLBL_SECATTR_MLS_LVL) != 0) {
 		/*
 		 * Looks like a CIPSO packet.
@@ -3762,11 +3774,6 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 			return &smack_known_web;
 		return &smack_known_star;
 	}
-	if ((sap->flags & NETLBL_SECATTR_SECID) != 0)
-		/*
-		 * Looks like a fallback, which gives us a secid.
-		 */
-		return smack_from_secid(sap->attr.secid);
 	/*
 	 * Without guidance regarding the smack value
 	 * for the packet fall back on the network
@@ -3845,6 +3852,9 @@ static struct smack_known *smack_from_skb(struct sk_buff *skb)
  * @family: address family
  * @skb: packet
  *
+ * Find the Smack label in the IP options. If it hasn't been
+ * added to the netlabel cache, add it here.
+ *
  * Returns smack_known of the IP options or NULL if that won't work.
  */
 static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
@@ -3853,13 +3863,18 @@ static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
 	struct netlbl_lsm_secattr secattr;
 	struct socket_smack *ssp = NULL;
 	struct smack_known *skp = NULL;
+	int rc = 0;
 
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
 		ssp = sk->sk_security;
-	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0)
+
+	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 		skp = smack_from_secattr(&secattr, ssp);
+		if (secattr.flags & NETLBL_SECATTR_CACHEABLE)
+			rc = netlbl_cache_add(skb, family, &skp->smk_netlabel);
+	}
 
 	netlbl_secattr_destroy(&secattr);
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 9c4308077574..e567b4baf3a0 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -922,6 +922,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		rc = count;
+		/*
+		 * This mapping may have been cached, so clear the cache.
+		 */
+		netlbl_cache_invalidate();
 	}
 
 out:
@@ -2950,15 +2954,6 @@ static struct file_system_type smk_fs_type = {
 
 static struct vfsmount *smackfs_mount;
 
-static int __init smk_preset_netlabel(struct smack_known *skp)
-{
-	skp->smk_netlabel.domain = skp->smk_known;
-	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
-	return smk_netlbl_mls(smack_cipso_direct, skp->smk_known,
-				&skp->smk_netlabel, strlen(skp->smk_known));
-}
-
 /**
  * init_smk_fs - get the smackfs superblock
  *
@@ -2997,19 +2992,19 @@ static int __init init_smk_fs(void)
 	smk_cipso_doi();
 	smk_unlbl_ambient(NULL);
 
-	rc = smk_preset_netlabel(&smack_known_floor);
+	rc = smack_populate_secattr(&smack_known_floor);
 	if (err == 0 && rc < 0)
 		err = rc;
-	rc = smk_preset_netlabel(&smack_known_hat);
+	rc = smack_populate_secattr(&smack_known_hat);
 	if (err == 0 && rc < 0)
 		err = rc;
-	rc = smk_preset_netlabel(&smack_known_huh);
+	rc = smack_populate_secattr(&smack_known_huh);
 	if (err == 0 && rc < 0)
 		err = rc;
-	rc = smk_preset_netlabel(&smack_known_star);
+	rc = smack_populate_secattr(&smack_known_star);
 	if (err == 0 && rc < 0)
 		err = rc;
-	rc = smk_preset_netlabel(&smack_known_web);
+	rc = smack_populate_secattr(&smack_known_web);
 	if (err == 0 && rc < 0)
 		err = rc;
 
-- 
2.19.1

