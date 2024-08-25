Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD916F273
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612757; cv=none; b=WBNAmrgolQYw4qPXywsUdHYVrSmB3fdt9+t6YHQPKEUq/mUXQnU2pCB/L2yVPStvsLUuv1ahiTwDgnCnbx7W/C3mRLsm+4o+o/+d8KM8+kvn+zJzYyEZzX77J+c23d/VfV7LVDG1lqdp36A+ZwqNus2bVrZEpct8UP3RKXiIlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612757; c=relaxed/simple;
	bh=p4Mtb8ugz4OUlVr94IcBc1bx8DUl8mFi9fzQ6SSUejg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqoE31G80t0qWaPyTgq2rlhQ9B5PA5SYjVyauOXKDvVJtqRHMMwmOak7bFyFwAfPZjC3C4uCgUxGG6PRGhQfO5Uu3I2Pwp67nTmoVq+InTCZ4OY3V8OH9sqiXB3nEv9EVkspgigZhBh4sa201HZCTrTBpFnpOZvxodn8hQEvGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=H6oopqoh; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H6oopqoh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612755; bh=ZRWOmyaK2WNaXTe1s9bXbHgWg2DYHZpEUIKMfqsDMPM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=H6oopqoh8lMn/Vg28dZ9ccl8JKOx1k6bFt0Fx2A+RHbB0zlvZwpDEJAHmfkPe1T9Xkc6NPSvZ/9p8P1ldFiWAKIDXKk01LprI3tDSdrqPbu6AtEap/k3O11oHYaRsT/4Yp+tOeN0XWLvheCM3iM0doK24oOk80ydashKiiFDNdpd/Ylv5qA/jw/sb1KLF3nD4/37ZegyiLpmwyVK/yReWgyYl5r0awnWQcF1TUKDBArEX/swk2juYq1k2GoYWfbRMesf+9B0Hub9ifOzzZPZrY/lJiHjUxcbRVw91hHrxBnvbmVwhAHfRTAOKEVaKbLTFM9F4rGL6nON7uHI5XWlMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612755; bh=tD/kKv5QIfDwvlq0rBaawh/VYjIAy1z1vh8dZ/heqFU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rpTOo2tvPP0n1vu3Pl26cBUNX3G33L5SmaaZv0TCASSRpFqF0U3WLOnAcT0HV06w3oDa9HsEBndvwWF/q/c7uOWHW6nsSRt+HxVH61vrxP5FJXIgFicL2+6ACQTQ8brNux4OEoNHRiKyoAr5FDr35bNHNQxNf6LSi2wM2w1ddO7aolmk950Z2QFmLRjm9ItrVobCNC9pA7WIik/Q235IHzt45j5hgiQPYnjI+yC9NWNzXKn3a4WYmecPHTj95ysy0r+Bk5hThZxFP/41R8vKVCf5wRUoXBLuKxomUKqGinVeQHqXBCEtpwBGr3DHo5A2OKm/FGFqUv6WGnW7RV5WOQ==
X-YMail-OSG: vpJ9SlQVM1m646jwz68t0k3dk5JhavyPlW.cvN7mBye4cLBdoIkHu3a.fy2Tdzh
 47tPfxpDNm.xhTwx9YDuZWl3ANlcPEmSOkFd9DKqLwf3N79oRB3GWdM9uHO0jsUJTQtxu41S.JfK
 SrJjOkw3H7xH0tGkqypmlPtKRrUoHdHDHLLkDQL9e11CWdUWlzci6DRElXsPNvLonT7FVBnjpTn5
 vA6j7adzepLk7JTvCDgEikbPLwWLyecj0zqBLChdvcdIFV42ztslS03y96WPBcLj4d5GSMxwqXkG
 K_QOrVAhkagMQP9WPXhneCH2dQIl_.qWdEurstT9cpNEzYXq.TT6.MrVEr06mUq56TDx5GPk8a9i
 MvweAmasYwgnXwTcZbInf5ZjQUpQWyU6mMKX5On3hU0ZHHoYjG7hkqJLzAPIj1p6yfh8xud9QHRs
 PQHAhqddljHA1FV6D9XVRHnklv6XM.H.HR5FwSZvFveSfRmX417ccoZYUu4ypfsVJLPtKI2RjArW
 lvZBLa0C2VoG9xwxXldN1cMfJNdgLd4ooI7CuXKBAeBLgPP.iaTMiphJhYJgfhzmADT9YMRFTO_m
 6VmTYeweQgTgjavoheLPMkbIk8YDj23_r4ZxMDDSJZZaXLPIpS7VGXqhEXwIiimqaLr7OB0oimG9
 Rm0dlLCMSfbZQm.3qdBZrfHB2EuLcmuwpiTv_qPN5OB5Sjl9z3LutOOhEHlt0rssfARfJ72yILjJ
 hSbdd2OnKt_bmGcw5l8SjBk4bWLQo1p.ycGQypICLxGwhJ5eKIKZgCRfY2Yik2GrgLIPD0ZfZEuw
 bc879cuoI66.SfJu5bK3WmXlU1CDpF6nBshaWK42wN5_k4qKmuIgcr7UNDFR_crRk_5nuhCIeoVn
 RY9.flN.ACauOCFFMzgeXgQHrgcIkgvfpMXuPwS0._Ub041O91JsLLEf4r_dejOvwkoMJ4Phbfxl
 .udUL6AJnFGG.Fj6nBb5ZC2yadmG08rg_vW8LcNhhkYfynHaIhHooFjEUq9rU5MTuI0O0xjtAzbj
 vMDCbZbKtqP1AQZEfHYZzjw9_fC6o4zFssYbF0ZoUPfS9F1Ry1QcNkxpRzC0CK7xJdjAs6YVW7g3
 uzNWGDUg_7SLP87amIiK4znq66XXfwGbc09KMXWMkhXSh5QPYzKnU3sNLZjIAW5D_B0T5yb2ztkS
 w0Fn14A84CuOVk6B_0.dfNfSVnzm7uQCFUndOtcsPMzVpME.q9JnGrSn87hhzgw.V03pTtqNwC0v
 aD6nn.5baStG5_2Iwtlxff6UuXdUzEuQETkLRQD0KiKzhh2cut.790LqrvN5dgBgaY_2E3efcnDg
 pAmM7icUzMv2hy9APJ8kcpyTR4k9JWlSGPWYOxqacPiXkvUHPJ9Q8fnKoUiq5jD.A1D0kZ_0zUc2
 sRVOAAw9cedmTofIwc7VyYwnIt0bM5w2S7sTaNAlUYThDiUrTnJF5NAfK2wRBrJQyWyg7xsuh_2L
 S64rW1L0CiLQYKdgE_pOkcTBOamNMQtvlVw12Pqk6HgSxP1Im1VG85YGJiU4293HXdSKjkJhK0U0
 fQSiRLNB6xC7Rin6UPWF.x6JKqeVLwlZcnp_GmPH_b.4RG3XSwlz0TLfFpk5HL4Q5wBXdYwG5CMv
 b_NRaiMAwsC_8tkUKxd2c6yaVLUJKXn9ATX3hRJbS5jTMiQBF6UaTdEtMuQmg1JU3Bjvy1iSJ5zU
 e.pYltKEXzBYAw5Yd7k6UnX_VsSwKnVkw4hUvoPhlBPOSm57HIgrjwVbms4I6gsTcRR8bbGcRRZr
 FbMRlA0DkTEsG4SMsj85yvIn6xaWmAABwBZzfStws86zDpa9TFJHakfAf9NWaT1yEnyXLNdJqmOD
 qCE5htY3VH66.7NlfraAKSwlvhJFl0iMi.Z9Hb5FxtKED8Q8BJN9tDiEhaeoajNfyrr3rzehyIxJ
 eOt3EokhbeMR6Um3j4ELMs24XBSGN.YWQx1qX_qW85c8dB6Xms4IEFlDPmPTOAXtYo5chwpllFjG
 _KQxGpQ7VQPTC7yH5SHOQ1HnyeQMBW99xn_X.ASaF51._c4o7jBZz1ARUiex9pvKhjuKfWeVnQIw
 .oJLLVT_RazrL6sB27Sg8yVZ_xTUjJ2Ptda8Nk0YyiaKhRvq.Vk0e7BlQdcfMXmMFbmyfAsDbp6m
 uuXSTw9M9Sa9xBTamIYVWrhbaBs135BeZjXkGQ42vCG_kRUQCOfpHcEdxiaP8hBno1DafnjLJIyf
 _kjmAUctDFnAlSWirnDXKPl_jnonC1lIpWF797or3AD3pDPWEF6ntDZXHGvEgRM7pa5DP2F.Gkkb
 hjfIyI33VHI8m.k26ZyBSGXSTS2H17ZrGJQXie4sMd1_PZA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7a6ec7f4-5863-453a-a7f0-2e5c74617ca6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:05:55 +0000
Received: by hermes--production-gq1-5d95dc458-m8nfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa6d7487ce614a4db5b8d88c90575908;
          Sun, 25 Aug 2024 19:05:49 +0000 (UTC)
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
Subject: [PATCH 11/13] Audit: Change context data from secid to lsmblob
Date: Sun, 25 Aug 2024 12:00:46 -0700
Message-ID: <20240825190048.13289-12-casey@schaufler-ca.com>
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

Change the LSM data stored in the audit transactions from a secid
to an LSM blob. This is done in struct audit_context and struct
audit_aux_data_pids. Several cases of scaffolding can be removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h       |  2 +-
 kernel/auditfilter.c |  1 -
 kernel/auditsc.c     | 31 ++++++++++++-------------------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 6c664aed8f89..b413c0420c6f 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -144,7 +144,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsmblob	    target_blob;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 06309227a0eb..b3562e6ca081 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1370,7 +1370,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					/* scaffolding */
 					security_current_getlsmblob_subj(&blob);
 					result = security_audit_rule_match(
 						   &blob, f->type, f->op,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 886564532bbe..bfe2ee3ccbe6 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -100,7 +100,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob		target_blob[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -1019,7 +1019,7 @@ static void audit_reset_context(struct audit_context *ctx)
 	ctx->target_pid = 0;
 	ctx->target_auid = ctx->target_uid = KUIDT_INIT(0);
 	ctx->target_sessionid = 0;
-	ctx->target_sid = 0;
+	lsmblob_init(&ctx->target_blob);
 	ctx->target_comm[0] = '\0';
 	unroll_tree_refs(ctx, NULL, 0);
 	WARN_ON(!list_empty(&ctx->killed_trees));
@@ -1093,8 +1093,9 @@ static inline void audit_free_context(struct audit_context *context)
 }
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid, unsigned int sessionid,
-				 u32 sid, char *comm)
+				 kuid_t auid, kuid_t uid,
+				 unsigned int sessionid, struct lsmblob *blob,
+				 char *comm)
 {
 	struct audit_buffer *ab;
 	char *ctx = NULL;
@@ -1108,8 +1109,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+	if (lsmblob_is_set(blob)) {
+		if (security_lsmblob_to_secctx(blob, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1778,7 +1779,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_blob[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1787,7 +1788,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_blob, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -2722,15 +2723,12 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getlsmblob_obj(t, &blob);
-	/* scaffolding */
-	context->target_sid = blob.scaffold.secid;
+	security_task_getlsmblob_obj(t, &context->target_blob);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2746,7 +2744,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2758,9 +2755,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getlsmblob_obj(t, &blob);
-		/* scaffolding */
-		ctx->target_sid = blob.scaffold.secid;
+		security_task_getlsmblob_obj(t, &ctx->target_blob);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2781,9 +2776,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getlsmblob_obj(t, &blob);
-	/* scaffolding */
-	axp->target_sid[axp->pid_count] = blob.scaffold.secid;
+	security_task_getlsmblob_obj(t, &axp->target_blob[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
-- 
2.41.0

