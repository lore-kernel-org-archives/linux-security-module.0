Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3849F383BF
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724613070; cv=none; b=Bo5hHNXW0hukhL3glQoTEKklrS9gglmQqTgEAtFLrqH1gaulBfnG180uNb0auxXTaQNYcw+9RlPbRgK53olOzVmYnNbY6CWTUEG116FwjXufN3mEaPrn/8k3uNAhqpBio74dDdTUEawrH6v/kaop58gVPMMgPLHo1K6CCg3+AQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724613070; c=relaxed/simple;
	bh=LeB8X7+ZJITov5x6L6aFo3j/PNTvgzI7vPg4NLbRQWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTxA9ZYJCmYy0S0HOInQYpu7Cv/QYv/U9mcBetJ75LnRR3y3bera8e8YbqmwdAMLcqucV9iVg4zet4mVCdATP4ILCURC5oL9NJGrENkEWAkVq4oQ5U5DdD+A/qNWjBliXb9oHBzEDrvhWg2nVK26tP7lCKkJcEv+XWlE4G8ffzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=e9o8tz8x; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e9o8tz8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724613067; bh=UimBTnRsvOOlheUTsD/8wlPBEHMvbpszab7VOu1lPs8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=e9o8tz8xZ8dpUz3BCII9UBBhPcXU0vZpUQWDtv/SvTxsSv/dleocyEMKPXA/gPPOL7ZozoezsKbN15PzDC+Twf/2+NTGD5Bgkj5qsQDzx7JqrWUdreWJdF7zb6wo21/bB9D5B3UHuqXKpYDmC6QcJqI0f+9MRUFmnFdXA8BjSGtuVReqSjDPk+dJDvR8YqWs+fsfoIPyPuAZG/VnF1dqd5LuCkhGYJO5Qk/e0JsyLrZ1K2ibddsAHKkMPRhUqPWpf3/K0wS9qhbyvYZnQNAPd4mAB+C5/an3JD1u4McBGtrHYsbqfmn28g+aYxydUImCxeQU9ynCivh+RfrssjTxYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724613067; bh=o93hdrto2CHERWGz3rP4R6vtHi8AjRTkAEO1tMDq6vE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=b3lf0III45V2HPfwUSneV21QIsPL/Ytse7KqDpOAG39jv50KXcQpv8SPw9dWX1GK07SXAqQefZssFOwyamDLmjxVAHvMzyLVtmNp/CzTJXivSMco6hvPonobCA3OhwKSUFlDZnLcRwsLNwPIqLkkKen5StdxVdre21/ayxDVQi5lM2S4gtmYTEooRVP5Sgxza7JKD12fy8zvDHGlnDdg1GinMB/mS48aM2DwbJqTRMQ09KuZna4QHHiXYo4TRqJbwW4bD8K4BnhW0Qpsx3I9yRxzPagh33TVSmiogvhTSdbP+0cfSJa7wSfAXBWMqVlbZplaLxdldGxSwv2ZmS1Eiw==
X-YMail-OSG: WR.JJOYVM1noQokXfDLr1Qh73B74.m6Vz9GDe1UpUirQdDLpu0BPnKKfSfAtjcS
 GlxdLjXosxgPsYUKM2SB5gsqN98m2Pi3LWxoFQvNvhsdAsFpdFF3r7TGjOOREfjYM5ZV950yg4uK
 k6G49r8wf6Mx8cezrjPLZ4r2ZFoG2asHxie9UP.4bNtxAG4IM.mqwVnlTKekZqQiZTLz_Bj17cwm
 xKm63qMjOIk7DOa.6LtqvpRUtBURXUvaeM_Ht3zxOiFzNti2uIWHe_TgLB1Oxwuq9AjVjbbS765t
 bmrABiV9Fo7vSjQsz05BUF.hDGGJ0J8P6FglBUsZQ8_RjvQQf3bqBCtaDxY.FxRJccLqYtld1LTN
 8sxCBg5p7ROZkfm.4eKQWZxKCU95dGOMQ2UZ4_W4iouCxnvHopWaEH_LbbF9D2X7ppTGEfhZemHG
 YRk63E5.nbUzhbMMb7tJ2uD5wGRNWB.xP82Pvu0T43GjWF1RqQTcOUQ05fFKH8oM7yWn2r08qrde
 YlGzM6h._K2AZhQVtmtOz1V4Tw7A6L_PJoW3k9yXZPKOExpa4w9fQwC_07nbL2zINBUcK.M3hZXU
 HqBAwNtymZrEDBBbBx0KalXzHjanLecpqJM_17hkjgGAUZLztlqVfVXhe9n_wE9ENkxu4yE1Nx3.
 XPp7mampixioco7rJHMcn2zniC3hMo5.jR5sKDv9zmE2vNhg0S.OktibbTIykMbBrwqReeZc2g0q
 9qmXJG28iujmdsPmPwQw9T37Vd_fEVhq11S9ekqxXWc3PxY9Dm0Ah7HFb3_LK1TBreivRlsd.nnU
 A8zgc3ZFHfiMAZTwUBVZHdXfQepIBDY.vkg5LKsRKGVyOsTC5UnydFs2D0HeLjrWn6WmI7gyMTZH
 TfvDXS69cZnJmf_1VbHANsbRlSF6lxu0zx1VPg_tHnRBx_w.Cg8G58G6aIIgRAWc.h7T6jUuurCX
 eNk7crVu1iNuKwUSVQC5EPq52YD_pmpcAoyD7sViTckmRgMtaASfTHXrXLfRQC1EBLfA4T4AJHYY
 BUBAJextuet6hlSb7xEUaWTDw3aiztRj0zYg9zQA38vvR729LKxRFpMlGFdV7mk1ylxyUUU5T_bC
 DTrn7pMS0C5pSTNUrV6236XgJBfGsaBvmuSuE9Jzzg3LtHF6jvaZSKt2vGIHz2b72URYgnNop8np
 O0.1b_f4ONADTWqSKxq2sH6f8r7HrbUAQMACtFgQcnMBVDHmrPcQTlfoq7hPXLRYgpADq51In5Fh
 yR6HF_Q_3HM.mr2YGNjRz99HEzq6Vw7Muqp4rvXXOgx4ummfcxfYK6Crh8zLUU8g6sdK_sUdfLP_
 aCD1LlGg39BoQJBX8kWIoO9XbhAQG.P2cBmd2kqlF8qJu7Lcu.g5D0en9GRKCyd9Vdygx8HgGjs5
 7yNj2A0qkVcEEek6BLKZ4L2nYuVtBL0zov7pabYkTS8.JhW1djxw6L0qowZrfqiAcYoG87Ht.Vsb
 Nr3MAigt3RrfN1IVPrLmMD3uhpBEAOIc4DKJ8gnN_e1y10YOWmh68FloWXYNE.i_2HbRMxhg0Qz7
 m3v9vVBlTRQLNlWBta0q9EkkGGQO5tmldCxCOf8RM.zzM3bMcOa45ZAhUHu9DSLrSWZg39lgm3Nh
 W5PAl.pZQRlhAF7XqOazadvHZ1Tv.mMgnW.fdqAvXQ4FWpNoNPfyKV1Jl31HlRF6I42MU0AWoJua
 XynMGfDBwr581SQw5mrxmKLAlK01iMseKpPxbWG8kazswaSh_uA0DbHbn6elNw24It3Jizvu72gk
 HuztlFpbExSkw_hDr8z5MCQ7xuy5kiu.s3ZlWVxrZAVpqsFagMe8TBrB76kMRlsMvhf9Glr3vb0i
 lYqmiYQr2QIX99ueYT3TcIvsbmTnBGXywWL14jQ7GgZctdUPz.pJcBrj_n13aqQRyU2F0oNoE7fQ
 .hESdWSJNTIL8uGz5TaX6_HLvrLXGh58PS1wZ2c8kikNqPN_SMxHJYChugaVLVmnPfCwQyR6svNu
 VYm1y3GYxPz4zoHTOkXl2lljj2c7eLVz2ow1L6z7Kg.NFi2opK3N1RbmtTELPcoMb.8w7vE.O8A2
 D8s8QNzXpdQh_9lsgDt8FwSEALh56nenFk_Ms15tNNWCbbvQsR3x65Y13rFVv6vyI8QgqY2DwlO8
 wOTiOe2CoObkAjzsV_A_3.fbdDEb6Swhdly6l1Df_wb_nrSyPbfWGvP_5fgOjcO_OXjytfz2mm.J
 wlEMbRy7WyQr8JuIn7lqR._UONYP4sOyWltxk9d5ZgD9ddTnLgo_4IzYSwnjUJ_pPM9auCogb7_9
 y1DIyr3X8QfExue40.bFS.G8l45v5t8F4MN.E
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 180a0a24-8275-41a3-a658-e31d44370de4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:11:07 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6fc1ee0505485e3267054d717b5fc74f;
          Sun, 25 Aug 2024 19:00:57 +0000 (UTC)
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
Subject: [PATCH 02/13] LSM: Use lsmblob in security_audit_rule_match
Date: Sun, 25 Aug 2024 12:00:37 -0700
Message-ID: <20240825190048.13289-3-casey@schaufler-ca.com>
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

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hook_defs.h       |  3 ++-
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                | 11 +++++++----
 kernel/auditsc.c                    | 18 ++++++++++++++----
 security/apparmor/audit.c           |  8 ++++++--
 security/apparmor/include/audit.h   |  2 +-
 security/integrity/ima/ima_policy.c | 11 +++++++----
 security/security.c                 |  7 ++++---
 security/selinux/include/audit.h    |  5 +++--
 security/selinux/ss/services.c      | 11 ++++++++---
 security/smack/smack_lsm.c          | 11 ++++++++---
 11 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 855db460e08b..1d3bdf71109e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -416,7 +416,8 @@ LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
 LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
 	 void **lsmrule, gfp_t gfp)
 LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
-LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
+LSM_HOOK(int, 0, audit_rule_match, struct lsmblob *blob, u32 field, u32 op,
+	 void *lsmrule)
 LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 0057a22137e8..c0ed2119a622 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2071,7 +2071,8 @@ static inline void security_key_post_create_or_update(struct key *keyring,
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			     gfp_t gfp);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -2087,8 +2088,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index d6ef4f4f9cba..c4c7cda3b846 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1339,8 +1339,8 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsmblob blob = { };
 			pid_t pid;
-			u32 sid;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1370,9 +1370,12 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_current_getsecid_subj(&sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+					/* scaffolding */
+					security_current_getsecid_subj(
+							&blob.scaffold.secid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
+						   f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..23adb15cae43 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -471,6 +471,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob = { };
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -681,7 +682,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_current_getsecid_subj(&sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				/* scaffolding */
+				blob.scaffold.secid = sid;
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rule);
 			}
@@ -696,15 +700,19 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					/* scaffolding */
+					blob.scaffold.secid = name->osid;
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						/* scaffolding */
+						blob.scaffold.secid = n->osid;
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -716,7 +724,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				/* scaffolding */
+				blob.scaffold.secid = ctx->ipc.osid;
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 6b5181c668b5..758b75a9c1c5 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -264,13 +264,17 @@ int aa_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule)
 {
 	struct aa_audit_rule *rule = vrule;
 	struct aa_label *label;
 	int found = 0;
 
-	label = aa_secid_to_label(sid);
+	/* scaffolding */
+	if (!blob->apparmor.label && blob->scaffold.secid)
+		label = aa_secid_to_label(blob->scaffold.secid);
+	else
+		label = blob->apparmor.label;
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index 0c8cc86b417b..c5a516e61318 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -202,6 +202,6 @@ static inline int complain_error(int error)
 void aa_audit_rule_free(void *vrule);
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp);
 int aa_audit_rule_known(struct audit_krule *rule);
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
+int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule);
 
 #endif /* __AA_AUDIT_H */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 09da8e639239..40119816b848 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -635,7 +635,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob blob = { };
 
 		if (!lsm_rule->lsm[i].rule) {
 			if (!lsm_rule->lsm[i].args_p)
@@ -649,15 +649,18 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, lsm_rule->lsm[i].type,
+			/* scaffolding */
+			security_inode_getsecid(inode, &blob.scaffold.secid);
+			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, lsm_rule->lsm[i].type,
+			/* scaffolding */
+			blob.scaffold.secid = secid;
+			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
 			break;
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..64a6d6bbd1f4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5399,7 +5399,7 @@ void security_audit_rule_free(void *lsmrule)
 
 /**
  * security_audit_rule_match() - Check if a label matches an audit rule
- * @secid: security label
+ * @lsmblob: security label
  * @field: LSM audit field
  * @op: matching operator
  * @lsmrule: audit rule
@@ -5410,9 +5410,10 @@ void security_audit_rule_free(void *lsmrule)
  * Return: Returns 1 if secid matches the rule, 0 if it does not, -ERRNO on
  *         failure.
  */
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, secid, field, op, lsmrule);
+	return call_int_hook(audit_rule_match, blob, field, op, lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 29c7d4c86f6d..104165e4c931 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -41,7 +41,7 @@ void selinux_audit_rule_free(void *rule);
 
 /**
  *	selinux_audit_rule_match - determine if a context ID matches a rule.
- *	@sid: the context ID to check
+ *	@blob: includes the context ID to check
  *	@field: the field this rule refers to
  *	@op: the operator the rule uses
  *	@rule: pointer to the audit rule to check against
@@ -49,7 +49,8 @@ void selinux_audit_rule_free(void *rule);
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
+int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			     void *rule);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e33e55384b75..43eb1d46942c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3633,7 +3633,8 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			     void *vrule)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *policy;
@@ -3659,10 +3660,14 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		goto out;
 	}
 
-	ctxt = sidtab_search(policy->sidtab, sid);
+	/* scaffolding */
+	if (!blob->selinux.secid && blob->scaffold.secid)
+		blob->selinux.secid = blob->scaffold.secid;
+
+	ctxt = sidtab_search(policy->sidtab, blob->selinux.secid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
-			  sid);
+			  blob->selinux.secid);
 		match = -ENOENT;
 		goto out;
 	}
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4164699cd4f6..52d5ef986db8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4776,7 +4776,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 
 /**
  * smack_audit_rule_match - Audit given object ?
- * @secid: security id for identifying the object to test
+ * @blob: security id for identifying the object to test
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
@@ -4784,7 +4784,8 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
+static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+				  void *vrule)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
@@ -4797,7 +4798,11 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	skp = smack_from_secid(secid);
+	/* scaffolding */
+	if (!blob->smack.skp && blob->scaffold.secid)
+		skp = smack_from_secid(blob->scaffold.secid);
+	else
+		skp = blob->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
-- 
2.41.0

