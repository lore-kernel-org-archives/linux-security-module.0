Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1A1DFFB
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612847; cv=none; b=nl4gNuPd5yQx8lcO7SgMfY05VdGSlkHWNXK5eU5uIz53XGZqGvs6m1ES6rSKNQktPfYK+tgcxb6oIkDWvBr3VTyaAZpizzTG5KL/gFn2/X5TCnfITkEA8mZF9y1ddw95TOQkrtftWArnLRJPPqdWWRXPOqmYkhKA6poOIh4xGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612847; c=relaxed/simple;
	bh=XQyA+Zq17YKLl40zkmb3Ne7PSBvnWvxF9XksHqSs8Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqWAf/fI73HsDj/RANkJdLKVAcg8Yw77Pb20kh6+VwRrqZviiqYhbtDo0S9HTfgCh3zwajh4EttSRbQKDQzzpPNfHu+406pWaHW1pX7CnQRxD06gMkZzpY7BfNGW+Vu5u5wny3X5qjWJUEduZf39FxG3TMesa9VZ4f1TKPJsoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MRO1jPr7; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MRO1jPr7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612845; bh=A+ujkyFJqfrbVOxajgw7izgd7QW3xgj6enPTx+tW0LQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MRO1jPr7OvwRY/Sm2Za/+BFexZKUXw4e4pj2mwx3BNwnmfruxFPpAisyl8E4QCXSuNWn/PEHEEL4GlhvY5M2ZkjlHmarMHrAHP4i3UjUyWlSSFLhwFm5uDsCgG4mAv6apOpiZ4xUK0De6Hc1FM8HoZMXUnHH+7IFxz2woLGjjCjeDz8+kwvH47/eHwl6hVQEVa8ca6QNo/s6EfLMgtlkQ5NDjoQKI552JQpqwoRY0qkKGT53yH6h8nq8Ikml1aY8cTu2hwZAPA2oK68ihfXtudrWZnPyyr/W5ORx5tKuwgaRAU8L8+KTje1/FPDbd/PMvw/FtbVWTZOyzYeLyRvy7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612845; bh=4r9IwMMt3Jg8xJzSdREPUfQYd+oA1GO6/vc2SMZqk0F=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=k7KdkP9hY4QJvqZueLV9ROQSbAKLvbEyWIyqbMpEzS5/DPOkLRkSiw2Yht6OnCElYO7bTZ0cvEXTRTRJ/pB4gLirsIaqLaF5fmlI/A5viIBh1tFHvi/nF8r7QheiC1lFCiw1YdezzaC0cWEHFYzkeIcdyQ7YtpxPJYki67NtPyVIwKi7Sh1DeVy7tF0j0h2aA1jVMIPkbssByau5xs0BMpAzS7e5QYBnfUkf9oWckiMzr0T0++QCo00iN66MJmSdry0fs9XkpRTAJSjhYX7GqE36dEX1O7eJKjJChk70Aw+wehTw57qduabccDWw7xhkIGUYt8PTYr3od3SyQbjRMg==
X-YMail-OSG: 7fiqVGwVM1klGv2sRwJ6sEPajqrer9N1c3cNFyxLbVQvlVwxpjcohPgWEhUSaWq
 WFsxtZL8hoMxGRM4qEYw1Gioq2WD4SUGYvgcjb_6oSfm.sTJdBGWNRq5915e.aZg41tpuhAA4LtO
 UA6w7DYoNboOFce3AzKCkm6qBciNRsq_JZR3Yzodtf4PheIyHlZizvPe_4Cn6n9VRrLACeG0Jcwz
 x9Om85k27ENsggegKtweNfwcQA66HGmCuuF21vlL2mhGr4GOkXzCjO6hu07aw9sL2Omr854uYlhg
 o2UmQ_DS9e3G.40aLNZJDbxmrW.yF5Q7jVnYiEDgnrcLpIvb9XIdJEmiSXD8PsLJ6e1yNflcBp74
 nY_6OCVX.wQYeksRFzp2Z6iZbOaZunrf6efOj2b8mO2FyAkuWaBJ4dtoCcPn17UwAyk73YV8rqXe
 8Xos1wnLBGkDmd_8hsGNETT0tIs6uFtM6AwoZC1_kNPWxgWNaXQgQByNjatN_pwJ8Ffk3NBeaBzP
 XBvgOMb.omaX9_bgUtIqReTQxSwVfcaQpJHLIe2QPpgaMR_u9TVQkaW9eOr3OuSlwdNGxoctSCqJ
 g0_6IbdhKO_SqfA7v5uwWHJwUs07Bu2bzl0ZltZBkQAeEFXzKGGsZslwf.lFT2CFIMtPFVUWhbFz
 DxGSKAYIwizlac6MC_EUEvIC2w0BlGP3NbZCM67zu6ov0oKKvXJgPMqv42YI1.PPL5KOZgYPwGcT
 KboWRc2MCINm_BSWr4CTxQqWID8wcX_DQwzSH351Wf94fvNXo_37YFi841apHNEoUNiiP_NHApnJ
 FsX1ObNQ0i9Nl7DBbBUAvNLJPXLyZ0ugB.fmjFXZMSIa_tieN4UDs_q8vKVzkNCwbNBKgcuUFAzB
 ZdsRGexI36ezdijYmS_.2xQqn2bItfgqMGAxx3OVxdD2ziAdhZ4Z6miUExMijZexUNw0m1mjAiAS
 0WtbzR8Zj20Lx3HpFqlg9YKwC_VQJlyULJbBWRRTwi.P6QAX0TbiCR_gCAIZsVj9ytR9GebE8GC6
 ONJe6Ddhi2FReCqGdRR22Ux_Mlopt7tXyg61jW69w2AUn5ktN4Os4Krh_Y.f3CcF.Mszs7bgOESa
 B79dwmzWEOULpkXmPra1hP8yp.58Ht09xdQ_17HbwHYNaIgsNjj7QzF9Wzv9qUze_nbOE4G_l8at
 MD0HGeIJJ_03.2g1CtI2EOeukPFO25NSURgucMS4gUJtIFsH3tsVhIlZ43ySgtDrX23nN7.SuQnZ
 SKciTgu.jRkQPfuf6651_7De5n.7okSgZ6nnohEtrAupeJylx2ZWR8GoAP3B5jcPVDW9NfhIelRx
 JBE9Lx0O._CqGZqphkWfFpmvoHxzYtuxCnZ85N4f4gT6XH.gDggfmjiIO1Ux3Jz.6dPo3n4jOgRm
 lkgkDjGYdaykRKclmrXVk5Xqer.jTUkRcwdykiE6lNlzDLQ_jO9MNVnLFpHxBRYEDjMbh_DXXb48
 5SIPIb5se7s5SqgFvAOV8SehWFIoqE_rO5ahAgjZplan6EfLOU.LJIucazGCjRarSjXA9lvTvLrE
 jWX9KE8aRU33e1Pj6csA66RY7t7lkcvL6omDS269nHmUdtMIZXk2kdyqOGKJLVwYVV5ZXpBVQmkg
 PR3KMG8Ry_Dh226pseQHawhmHEDLydfRoD65RMxAXF6RZsA3mwWEKJe1nZNRyN6Cxba7GygzsohJ
 5U2BsrBpwxDoVbdDZLosDbYDQpfFigYatnKg.KJQ6Xm1EMDZyr9c.V0ZLSuN.uEi2y.v.Ch6EORV
 xxa22aFIBSdbDelvqQmo3P2r6FShh7uFGSyA3zG8TfsChhfWW_K9M.ugkG1j5gcnlAnCb7adP_sE
 jtb_gXeK.ODhKtFUd9mbZdT0Uj78KNZEyKM2UVuVT6renVn.OWSo_EjQFmwhsH.KIaEECIPLuC7o
 vHZQAqxUQ_nlMisw83emz4pmaTqMkz4sDbbtqVjq7gLWI8iF7NANAWmsX00owVDbZhIna89cbE1K
 SEPRbA96DlGFt7NdsXUt2g899xSlmjA.oA4b3EUl5Y7ypTBEepnIvtnap9w3_Zxdn_f_Zrcqj8MH
 Kti7xYxM4bqsLSwLa.oSBs3JigFTjgRdQCm6eMepuFo0H7uG8zGYPNHhMuj3Ipv.zu7bnq.Z2aZV
 8HwcxriKM63_6IdyO_g9CRJnFhmJ1xp.Ey1OQqbxWs64ASV7TgfM3UsNJOtpDiyoOpjwHI3vJQH5
 0JqHr.NKwYUk.UybOOITU1_wEhGcofH1i3szZMVaOSeBXjRAt0VRobe3aauWM3zC0X68_
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 759b7bf1-2f31-4bae-8437-8582a422ca5c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:07:25 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed4e1fab5441326e8fd35b3239a0dd08;
          Sun, 25 Aug 2024 19:07:24 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH 13/13] LSM: Remove lsmblob scaffolding
Date: Sun, 25 Aug 2024 12:00:48 -0700
Message-ID: <20240825190048.13289-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240825190048.13289-1-casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the scaffold member from the lsmblob. Remove the
remaining places it is being set.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h       |  6 ------
 security/apparmor/audit.c      |  6 +-----
 security/apparmor/lsm.c        |  4 ----
 security/apparmor/secid.c      |  6 +-----
 security/selinux/hooks.c       | 18 +-----------------
 security/selinux/ss/services.c |  4 ----
 security/smack/smack_lsm.c     | 33 ++++-----------------------------
 7 files changed, 7 insertions(+), 70 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 111c1fc18f25..ca4f3b41f344 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -144,11 +144,6 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
-/* scaffolding */
-struct lsmblob_scaffold {
-	u32 secid;
-};
-
 /*
  * Data exported by the security modules
  */
@@ -157,7 +152,6 @@ struct lsmblob {
 	struct lsmblob_smack smack;
 	struct lsmblob_apparmor apparmor;
 	struct lsmblob_bpf bpf;
-	struct lsmblob_scaffold scaffold;
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 758b75a9c1c5..120154a6d683 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -270,11 +270,7 @@ int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule)
 	struct aa_label *label;
 	int found = 0;
 
-	/* scaffolding */
-	if (!blob->apparmor.label && blob->scaffold.secid)
-		label = aa_secid_to_label(blob->scaffold.secid);
-	else
-		label = blob->apparmor.label;
+	label = blob->apparmor.label;
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 877c4e809ae8..08fde302c9fe 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -987,8 +987,6 @@ static void apparmor_current_getlsmblob_subj(struct lsmblob *blob)
 	struct aa_label *label = __begin_current_label_crit_section();
 
 	blob->apparmor.label = label;
-	/* scaffolding */
-	blob->scaffold.secid = label->secid;
 	__end_current_label_crit_section(label);
 }
 
@@ -998,8 +996,6 @@ static void apparmor_task_getlsmblob_obj(struct task_struct *p,
 	struct aa_label *label = aa_get_task_label(p);
 
 	blob->apparmor.label = label;
-	/* scaffolding */
-	blob->scaffold.secid = label->secid;
 	aa_put_label(label);
 }
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 3c389e5810cd..2b48050f97a6 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -100,11 +100,7 @@ int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 
 	AA_BUG(!seclen);
 
-	/* scaffolding */
-	if (!blob->apparmor.label && blob->scaffold.secid)
-		label = aa_secid_to_label(blob->scaffold.secid);
-	else
-		label = blob->apparmor.label;
+	label = blob->apparmor.label;
 
 	if (!label)
 		return -EINVAL;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 076511c446bd..a81529c21517 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3510,8 +3510,6 @@ static void selinux_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
 
 	blob->selinux.secid = isec->sid;
-	/* scaffolding */
-	blob->scaffold.secid = isec->sid;
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
@@ -4032,8 +4030,6 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
 static void selinux_cred_getlsmblob(const struct cred *c, struct lsmblob *blob)
 {
 	blob->selinux.secid = cred_sid(c);
-	/* scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 /*
@@ -4174,16 +4170,12 @@ static int selinux_task_getsid(struct task_struct *p)
 static void selinux_current_getlsmblob_subj(struct lsmblob *blob)
 {
 	blob->selinux.secid = current_sid();
-	/* scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 static void selinux_task_getlsmblob_obj(struct task_struct *p,
 					struct lsmblob *blob)
 {
 	blob->selinux.secid = task_sid_obj(p);
-	/* scaffolding */
-	blob->scaffold.secid = blob->selinux.secid;
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
@@ -6348,8 +6340,6 @@ static void selinux_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	blob->selinux.secid = isec->sid;
-	/* scaffolding */
-	blob->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -6634,13 +6624,7 @@ static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 				     u32 *seclen)
 {
-	u32 secid = blob->selinux.secid;
-
-	/* scaffolding */
-	if (!secid)
-		secid = blob->scaffold.secid;
-
-	return security_sid_to_context(secid, secdata, seclen);
+	return security_sid_to_context(blob->selinux.secid, secdata, seclen);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 43eb1d46942c..002072912800 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3660,10 +3660,6 @@ int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 		goto out;
 	}
 
-	/* scaffolding */
-	if (!blob->selinux.secid && blob->scaffold.secid)
-		blob->selinux.secid = blob->scaffold.secid;
-
 	ctxt = sidtab_search(policy->sidtab, blob->selinux.secid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index dbcf1c65da3c..670050f739da 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1655,11 +1655,7 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  */
 static void smack_inode_getlsmblob(struct inode *inode, struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_inode(inode);
-
-	blob->smack.skp = skp;
-	/* scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_inode(inode);
 }
 
 /*
@@ -2162,8 +2158,6 @@ static void smack_cred_getlsmblob(const struct cred *cred,
 {
 	rcu_read_lock();
 	blob->smack.skp = smk_of_task(smack_cred(cred));
-	/* scaffolding */
-	blob->scaffold.secid = blob->smack.skp->smk_secid;
 	rcu_read_unlock();
 }
 
@@ -2265,11 +2259,7 @@ static int smack_task_getsid(struct task_struct *p)
  */
 static void smack_current_getlsmblob_subj(struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_current();
-
-	blob->smack.skp = skp;
-	/* scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_current();
 }
 
 /**
@@ -2282,11 +2272,7 @@ static void smack_current_getlsmblob_subj(struct lsmblob *blob)
 static void smack_task_getlsmblob_obj(struct task_struct *p,
 				      struct lsmblob *blob)
 {
-	struct smack_known *skp = smk_of_task_struct_obj(p);
-
-	blob->smack.skp = skp;
-	/* scaffolding */
-	blob->scaffold.secid = skp->smk_secid;
+	blob->smack.skp = smk_of_task_struct_obj(p);
 }
 
 /**
@@ -3474,11 +3460,8 @@ static void smack_ipc_getlsmblob(struct kern_ipc_perm *ipp,
 				 struct lsmblob *blob)
 {
 	struct smack_known **iskpp = smack_ipc(ipp);
-	struct smack_known *iskp = *iskpp;
 
-	blob->smack.skp = iskp;
-	/* scaffolding */
-	blob->scaffold.secid = iskp->smk_secid;
+	blob->smack.skp = *iskpp;
 }
 
 /**
@@ -4825,10 +4808,6 @@ static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	/* scaffolding */
-	if (!skp && blob->scaffold.secid)
-		skp = smack_from_secid(blob->scaffold.secid);
-
 	/*
 	 * No need to do string comparisons. If a match occurs,
 	 * both pointers will point to the same smack_known
@@ -4889,10 +4868,6 @@ static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
 {
 	struct smack_known *skp = blob->smack.skp;
 
-	/* scaffolding */
-	if (!skp && blob->scaffold.secid)
-		skp = smack_from_secid(blob->scaffold.secid);
-
 	if (secdata)
 		*secdata = skp->smk_known;
 	*seclen = strlen(skp->smk_known);
-- 
2.41.0

