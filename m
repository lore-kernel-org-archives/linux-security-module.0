Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0A1D5AB7
	for <linux-security-module@vger.kernel.org>; Wed, 19 Mar 2025 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424496; cv=none; b=hEXs52/w3oHqQ7BcEJysmbm9waDo42bg2F0U4y+xeArm36fKwpx84LTe/QBGmy5QiDEVGa3TDZQ5xhqwHOlQ9/UXo9QN75QqWvLfjdlhoZoe7+Xe0OFqCJo7g3uX9CLOPjzXf6A8U1PUMnEzUE7J03976HUF31TbR+Abe+7SmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424496; c=relaxed/simple;
	bh=1r0zs/LbeLsRa0vbFxcK1+nFQ3eqfobRwfUent68QiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhBhYdY6Tx7Rid2f+trm3R9LHEU77RFP9qNgG84cKAv4ehbjiXNeMuwpZVLJvruigZaBg7M5jfVLobTgamqw6+PdxNDWlpDPYY9Ip9a3q4Ms0YU74PS2BOqdPShFEdB1h9X2ZejQuWiWDJyclQLpAnMnTLOF9ka1iYinZ7JqBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qzHUMryZ; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qzHUMryZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742424493; bh=MddBqorTKiN57Cxwu2di9pDK4ApoHeFyxSqCJ/tKmuo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qzHUMryZ4G7+ACvtGWGWN77XIj4U4AZW1EqT456WyZnqQNihFjTNWSk5N8fv3x7f7ct02fJTyead3yQvb+74XM2J86S/TDgFtwngJRUD3ufkIX6W8t28fJkoVtug/rjyYxgEJpfF9cwgdXzBO2S+m3qc877pyznJjWCmvTqTd+BtRdXYM8UOQFxyjy0lTgXRPQLK/KN3CAWWUJIpHWf88heP+TWF7mJ2vRyuj8vKVeEROotRUo7OL2o6eM0TB7ij3IvXyDs11LubzWJpyAmUzBXeR8VU6lGdpkc+5WfEHXPv75mUBqrzBL6hajvIF+5d4gtYMfX5k/04GWVrlmL4Dg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742424493; bh=jG02EucpMgFZURRdsfOz8kNEhZ8wICfz5XRWxv73nGq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ee5B6Ttq9EK2O+ViS2IGlgAmLpJ0nu2xAfqu8/DT2Kh2TIrF/F1ZUYVVO1nDKR6rCuobTgAnH/7LiYKHmqVLo96BZrLhil10p9my3j4Lr6+oVRIlPFYAHrHrjbQHl2qK53GKDCyTIC+tBHntRoBo2AarhoHOQJa/6UBfaROnpWbLea9MjE3XHGP6Wn4a9gh4hlc3AGQbM4jbSSYp5pa7cs5F8LBQCFE7EcltU0thct4R5YSZa1YGdrb4SpvME78wtzUT0+Wxi/kMC2o6DNzc1A55iH2OTz+6Mfmqod/mIpuBPG/Ea9SeabHB+1iXuiY9LX+FZStf0+r+Eol0yxJ6wQ==
X-YMail-OSG: E3dUUKkVM1lQohKrCaU7knCm8SZrDrBjn.wvNGzHVW9B2i4yNkSkypqmhi8CMrc
 x85vDilBw0crC7LZqwF25lW5f58k28PETbiImWX519FF4CP7aaz2Au1QeWBzWglh6TQTjiIU5PAr
 bppjXbP0ELiJWfAWuuR3t3.TFB2rbxy14M4uIK26hRWDEzUdnnv2v2g0BxOKd3A_K9cUAecRb088
 i6mNCz3lNzOC3XEoxzCvMdp.kByzM4GDylXAx654kI5DQrOqi0YWVeSu8F79LJctivmdjlR64ZT1
 Dbp9UPa0ZqBu023QaS0faaoYSmhptxuWS6.PRNC9JMFS9uZVUZSvhqGlIzOQh4csgvQjPB3rivf7
 urt3PnUpg.G9fEyYYI.OrAnxcbXwU66DVXyh3kNyFd6UeBTrWuEOweJZPS52nrMyU6Qx_A97dFus
 sYv8b6fKe3h9LErpWc9G70Qrt3oa0qpYD9lKMidbh8su6wEmuHgDnBgu0RqaXVmWGcNiaIUfzXNF
 oxi2qjSnxrBHCyDtpWB9NmCv9I.HKed3FXl1NyLLOI3m3qLqJOJaMo637n1Yf4b5Ryiw7jThvW65
 W14sG_tuW.DmUo7vnQdL8QOkeO8dq.q0YhcHZuBvi8DEwfapYIgOKDN4uE8sFib._7ZPJFyqqdRU
 f6L0UKB14vvT8gfzEKkYrsXJDznrncC2C8SJ5blHnifOmubTS62uQxkr8GhSoSMhNBYhv9YbG6Xl
 3cpAj7or7UUwN3FuS8xDY_m0337ytgtEjNzoxKiPkDCM5.7lHpocDBl6F3.ap3Zt4nfDG_92WR17
 9BNRpNXB9MN4pb01J_3JYOWRUuFrvVMePEhsopk4hPg5rPhWivmo2nZ6JEsByGIiOA9uj3C9Qf1f
 JLgdtw08d6wFl2xUZ0soDhpvydrFDS4Q1qQanftpb65tUQwH095U9Csw.DMakuZ.987mqm2LngR0
 qLBc0zBn9MqZmRloTemwmpccHwxfyCWIm8Yf5_d1l8IJQgi44U8YI1fsOrEgKabq7z9kS0CbCYVi
 cfJHmef6ZfKpHylvFZnnEpgeNO_V0c3YycBdtDlawPaOG_KLCvGxlz35z5l0IWbRBn6JE4LhQo4k
 Negy5PrCg6s.PJciVGCiVNPRGsoJIhwSB7HVBSbjNoy7HZWutjt5mGcro0E69_exBCbOVNXnikXg
 pACidX3Z5LfKqqq51JfOKBOSvMg4oBx9Ym56QQmRan8eUY29i4IkVy7e_0FZqznHn9lrVJR6X.ur
 GA3gJTwi4NNFS5KwayKL2_TFJ8jpmKXrKOU.RQ1yVUkM1YeXvDU2Sno0hgapk80_OSC6FZ4APKjc
 ZuF3Jbce_1BfG1yYT.ttaXB..kwuUX6SaPii2dmepeYhNtDws9xvIoTtkq0f5acvwfIsMqCaqCmr
 oopUfoRhEOU8322U0HZ9j1mZhxxN_oEsKoDLCUNwTkow9ZHP3gq9Xad2_u6AGJFXYz6Ol1ho.Pbc
 8S_1UOCJBgn6t_AEEINPMUKgB9VJR1fGLTSY1chVPgMcLWwU2PTmCcjvhlkxepf6FhUsy3XRk4QH
 Vljv__yXVvXkrVIZtgRTt_rm27N.5vxcb5EUmdIfC65uEJsoTGS.46AL_4Jicmo9uF0QKI7JZSob
 4fF7sMj9GRwCWZkw3a0Pf5FgMiFVq1JdmYLIT.V7ivrtf4O.i4NnRYr0bRN0e6TtzJHOXD1BxbZN
 5lAJIbQOzw_CtyXnL14vAOC9wE0Qz4ec8k0QLZ2V3o2JgELFF9lbWoZSP.cCW8lL515jIU4Jn6zs
 ldRTMcOzN2yVe7qPpc_DBbuz5Ekb7PI9oZOWdcHoQqmu6kIUoy4vHb21u6vo8vZoMU.n4kvqTYFi
 ejQRNvqKnZzPdItsNEyX1_nmlXyE0JcmMrUfc7YhdzOFp8weT.i.koOmR7rzn3Dj8QGAg2IGbmle
 rO_3DYSvvKhTmvCVKUbBY77jnWkqSsSKyvGql18Klmd0X5WMbrW5haAbBN95EXJgsy_kKtRVm2.U
 TZ_BO.FtNOlQfrj6X3hFGFIT78muZRKMGph6510vZcHWVi0RaQhlfyS3a9bgQhdD0gkk_o1mrGfe
 QY_u_W1fjGZO3nPLnTNPVAA6UJndtwSut1Lykjm5zhxdByFTCkyU3dRjHNmlhW1PfC08NasHV1Ao
 sl_2KtHAuwgRzhtu19hJ5ClBuWJ9pCYvh1YFynP3XkqYXOuIONWBqL_57pupacKhzOHhAoBi6vQj
 dao0MrHYKbm7Uwmd17kMggrk6OFUnc3zQIUYYaDKhq.a6QQG4vroaalNc83wwAoZGflZlaYItwCJ
 3p2zrmxZXlK6TTcXRaA1k4.ROR_Y-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 704e53e2-b1dd-4fa8-863c-b720d8565769
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Mar 2025 22:48:13 +0000
Received: by hermes--production-gq1-7d5f4447dd-jcqz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e9bd32085bcf3fce38fe3767fad9b05;
          Wed, 19 Mar 2025 22:27:55 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v3 5/5] Audit: Add record for multiple object contexts
Date: Wed, 19 Mar 2025 15:27:44 -0700
Message-ID: <20250319222744.17576-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250319222744.17576-1-casey@schaufler-ca.com>
References: <20250319222744.17576-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
An example of the MAC_OBJ_CONTEXTS (1424) record is:

    type=MAC_OBJ_CONTEXTS[1424]
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
the "obj=" field in other records in the event will be "obj=?".
An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on an object security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h      |  6 +++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 51 +++++++++++++++++++++++++++++++++++++-
 kernel/auditsc.c           | 45 ++++++++-------------------------
 4 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 3402e3ca43c6..8fdfa2721273 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -188,6 +188,7 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop);
+extern int audit_log_obj_ctx(struct audit_buffer *ab, struct lsm_prop *prop);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -255,6 +256,11 @@ static inline int audit_log_subj_ctx(struct audit_buffer *ab,
 {
 	return 0;
 }
+static inline int audit_log_obj_ctx(struct audit_buffer *ab,
+				    struct lsm_prop *prop)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 5ebb5d80363d..8ca58144bcc6 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -147,6 +147,7 @@
 #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
 #define AUDIT_MAC_TASK_CONTEXTS	1423	/* Multiple LSM task contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1424	/* Multiple LSM objext contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 8ce453f6dc7d..69db0ee09a3f 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1133,7 +1133,6 @@ static int is_audit_feature_set(int i)
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
 }
 
-
 static int audit_get_feature(struct sk_buff *skb)
 {
 	u32 seq;
@@ -2324,6 +2323,56 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+int audit_log_obj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
+{
+	int i;
+	int rc;
+	int error = 0;
+	char *space = "";
+	struct lsm_context context;
+
+	if (audit_secctx_cnt < 2) {
+		error = security_lsmprop_to_secctx(prop, &context,
+						   LSM_ID_UNDEF);
+		if (error < 0) {
+			if (error != -EINVAL)
+				goto error_path;
+			return error;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+		return 0;
+	}
+	audit_log_format(ab, " obj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < audit_secctx_cnt; i++) {
+		rc = security_lsmprop_to_secctx(prop, &context,
+						audit_lsms[i]->id);
+		if (rc < 0) {
+			audit_log_format(ab, "%sobj_%s=?", space,
+					 audit_lsms[i]->name);
+			if (rc != -EINVAL)
+				audit_panic("error in audit_log_obj_ctx");
+			error = rc;
+		} else {
+			audit_log_format(ab, "%sobj_%s=%s", space,
+					 audit_lsms[i]->name, context.context);
+			security_release_secctx(&context);
+		}
+		space = " ";
+	}
+
+	audit_buffer_aux_end(ab);
+	return error;
+
+error_path:
+	audit_panic("error in audit_log_obj_ctx");
+	return error;
+}
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index dc3f7e9666f2..e39d7be20c29 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1098,7 +1098,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsm_context ctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1108,15 +1107,9 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (lsmprop_is_set(prop)) {
-		if (security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF) < 0) {
-			audit_log_format(ab, " obj=(none)");
-			rc = 1;
-		} else {
-			audit_log_format(ab, " obj=%s", ctx.context);
-			security_release_secctx(&ctx);
-		}
-	}
+	if (lsmprop_is_set(prop) && audit_log_obj_ctx(ab, prop))
+		rc = 1;
+
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
@@ -1392,16 +1385,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (lsmprop_is_set(&context->ipc.oprop)) {
-			struct lsm_context lsmctx;
-
-			if (security_lsmprop_to_secctx(&context->ipc.oprop,
-						       &lsmctx,
-						       LSM_ID_UNDEF) < 0) {
+			if (audit_log_obj_ctx(ab, &context->ipc.oprop))
 				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmctx.context);
-				security_release_secctx(&lsmctx);
-			}
 		}
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
@@ -1558,18 +1543,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (lsmprop_is_set(&n->oprop)) {
-		struct lsm_context ctx;
-
-		if (security_lsmprop_to_secctx(&n->oprop, &ctx,
-					       LSM_ID_UNDEF) < 0) {
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", ctx.context);
-			security_release_secctx(&ctx);
-		}
-	}
+	if (lsmprop_is_set(&n->oprop) &&
+	    audit_log_obj_ctx(ab, &n->oprop))
+		*call_panic = 2;
 
 	/* log the audit_names record type */
 	switch (n->type) {
@@ -1780,15 +1756,16 @@ static void audit_log_exit(void)
 						  axs->target_sessionid[i],
 						  &axs->target_ref[i],
 						  axs->target_comm[i]))
-				call_panic = 1;
+			call_panic = 1;
 	}
 
 	if (context->target_pid &&
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  &context->target_ref, context->target_comm))
-			call_panic = 1;
+				  &context->target_ref,
+				  context->target_comm))
+		call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
-- 
2.47.0

