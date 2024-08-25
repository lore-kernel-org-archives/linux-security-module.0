Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22963987D
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612566; cv=none; b=aNE78jinudYmayF8rLJoQpKOACY1p5CoEYQmFYQ5vCQbn5NrDt6+uwo/PDvlIs/57GqAh5F0bF+GMvkcx9JHM3+6eI3/BVGFsC7KI7miBHH4rv/g5ejxuJyUUbfMZgiXnDq6JEm7x3JVOB+0r8r2HBgfJdW8Czlp+9geaVeTRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612566; c=relaxed/simple;
	bh=LcHqPrkPEEFFHdhzxgu4iRQ0Tt4BNZV2Va6r0mI1N2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3UZSSrGAk1iQN4u0xcBtmZEdTcV0h0mYvNq1QTAkYmQ4papKnq+iVeFnFWgyta0+70sdeKn4Y34lpJr6YgaZAwYy0oloBgPfXA63uEsdNIsqpAaY/54hqhZOEML3rZHaGdpYAvKXMjtUSaDEMcKLGbk44xg6mJJITW1NrmWLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rqWMBLnd; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rqWMBLnd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612557; bh=7DLvTlvt8Ehn7CzLgfq7BkFdeiaLATaqWWfDllacuwQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rqWMBLnd02hSwuIxXSVrGFthCdnzDw+kxP/Uu01hqas2+7HXmO3ipamYKOwAeBuNP3DEg1g14HY0yDrWaMUc++bwIHbLJk5/lPRAzUgJTA7bkZ0p71AaiRTMsLwHapP8oFbwi1Tpi88uax94cbuBq3OX7gyircsbotdviN+CU0Y6ahNUzg0NQW4Ium68m1nAQfVjdKmhme5XDNDAMMw/NcPwgd14R4kb2l1yeNZpl3dTaWyZzop+Oms9hht82tVG84rwUCW8PcrG2YAY3D/P6X5oSSsTimsolumETlodf49A0xWr3iWria3/2pmSuCmy7bbt3G75s016NrSbC/0ApQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612557; bh=REVtL9pX9y9jpDWEX01VnjzrKMFArO3KO5D9V06iUxM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RnruNdoFSrhHOaB6LJ4JsM07B3r8w7jdfr2MdHnuDRsHJRVtqZmaEyCKC+vR4EG6SyFHwXokdS5VWfjblCkVDyPUEVdcuIQE3K0bdbqFVw9ZHRFK8nuRrQK55E/89mNdIYV1a5FEsyLCS7YkcMoyS8e77kuwjMl0tL28doNY6BCAYNNAUmp6wZC6rjneMh+sB3yH0RLz3xlKZPb3qqQc1UJrGQVxA/qzSWulSLJIvCbpge8XLJZT6ufXouy21OJIq8MFeNW0UDd5DVmE4gfgYUF8uEXzcZ1YS+xEbD42+IvcSiZ4pQhKF8xaKQG863ieuqayOxzy+fn2D0+vkL4org==
X-YMail-OSG: iemYCF0VM1kqpHMSC7jfbrRob7ujbDpZPrfj9wi9ESmXiHi.WwbJkqVN1pMTAu4
 WGCj7JPsiRYm03IQX4ywMvWUBEYk6PwbWLcRy9VW2FJDWMoh7utoQ6b3roHrLmZBIjvg99ihJ2G2
 UtpOq4Si6KNRJoY90M6cAa1R_ToyYZVN.xDS89jML457Qs7BVfyNWyyLDJPRvz3zn6POejTI52aK
 glIk1c6G6tMLkYn6COwRvZWdbhFd8kLTTcIsQ73DlI.tXDydeyu8tyASizWHaODdz8Gl_uvjGym7
 tMw0FVt7OphKVagpee37_bcfgdxJoxCISAPIymK8_vKHeLr1yknhhYr03g73IiKgO2VAHJo.iJ0z
 L374yUXoDHMVUPO0ja7WGS4p1lqn.LUzvR332.QPkAhBaGsioS3wRPApplHxIcIo0p1.uc1aG.uk
 kLgL9ZOklVXB1A7LCLQ7BjCz.dyOcGSIN.jaAgZaMVyQ.ejWTpDXVJb0y9RpA5mbGx7mlpbNx4Lo
 rY.IYF_qL47I2.QUY.xXTbZdqlCJG4N3j7twuP5acRG9EkcPhX9f6pbVl_Hoku.guV1QmTlxxQ2o
 stTcN7ksPie5.qKthCjSA7lRgQ2fTRRnqN4wZkyeppsiCtVZkST.bDLmxCuoIEdSCC_a32yNAsNl
 55XnN13BllRwj3kjAzUfrmugc2OURQW0orGAEJZLHWCk3drrQD4r1BY_3nhNa9QOaf1I2nZPVQxE
 Upc7lMOCtEb4awp8mHas7XER0a0USx.A9d.RgSrca_qZkQOfZmEICbih.KDlhAWLGbWYqU_MRoHY
 5znPW_e37GqkXKJieayu6Hj2qtkzhydYsunulvHwSI5UxuhZoB89qD39cgarz0B29BP.jmtQW85h
 b8LSs9UKS0jSf0M16_MsEHJywL_6G2otPl__YKMXBCCnt4mHbYcTVQjzaUGw7wQRXnJBJb6du6V9
 Ol46TPsfM5_xPhegP1OEXC5XmiUvodtrgdaplvxBHS6y36FmlW6C.ucfvsvUOxMj9sqwfoyXfSMj
 4cATdAIX9nWt0vnHO4TbMm6QHY7.wv6b0NXa.soqPHt18QQw0vMpHHvf2W_m4TYHZOerrlq.kytK
 BrqjZFH30oNSk7buGsKS3Ug02UhN0pvvC_1EXl06OdC6iRdpudIk8qTnJ2Fsfd.Bt6BPeDSCkEjX
 ZqG2GaZJDoUZKLBxCxiuyjiQzOg7YaYHdGy0Q4hffj32z9gUOs6Itg.0UMHnHDYMfuFz.8OnSPY8
 jRVjz3TbLYt93Iwz3y7PZ2AsWp3X6QFGZtwxt4ICHR0apJFktFJGThgzSBwGJ018uANnEuw1IQw3
 VJDKHY69Tu9PYGR.rHvl0pxm5vMX9o0DVvHh0uMwL0.VXuLbofxMUE421EVq44ZSclRqLd1GT8Rg
 ZLj2qcGXw7eLBX67aSAg6PI3XRWnqv3W0BsHaBiMpZCwoeYiI87nHPBl1iqbfzx0M_o1oijlGBSa
 u.5kekGxnvKYN9ojPlSmgQ7vtLz0bG9FYie6j7C3T5hYHjS6dr67e2XWS_96SOux15QWxS4WJ11t
 tJ1n4upoeNOpN0KGH2121NXrd7WnIlVhizyC8Z7MrwesMibmAqLKEzOlBUZoQvUsPe9Ewt.koNbm
 Ffq87WWOseCfSRjG5HqHm5.7W.MevfaTv_tZVmhA2KahqRbjUmsnVzFbDHXdGlxIW99R_fVNczPE
 gm55U11Vsk_70jqx4kaUKxDLcLfzk8CcS.aDMAOydVjr.H6T_CG5flZO08I.NCQ9dUCm1Zi9pl.t
 KQiARAIJm9K7QtkTaXkSkT6FywWr3tLEeUwruKet7RGNiNAwEDvIUjfJa3SjMgkdXsz4NZjiw3yW
 tpNlO.Cqj9ZDj1ER1M4rPY.WBpB4bjpG.BHl7zJGVbOkeN674GAfbw_BxdGICpf3NMVH7LGlIRIi
 i3RAe30LCbUmmUM3vB5YKYB5skTAuJvOvglhxwlCuAs1B.Nv8Oab65I4Hv8k8ayh8hW8Kw0t8LYs
 gEkwPAn0DbvqVTi7U4vgEdxQtg5_8B2FKJH9wI2Z37zKJvu.ZaPN2f_1LSKZacaCnvKzo7OOfs92
 5XgH91EqSpeUWASY3eUkaphnBGlZYx_9vk352hgwBHHx4rwJDM8UjyrlEBG3weDCOZscdInc1aZs
 P56x0BTlnqa8AfQw.pBOx.5a643dobOzB7FOudyVuHKirjygPYwmmbKhd9rjBpuANweA2wuQqERL
 w8BYBrdZOaLyBVmQVX2eNeCEKqjtEwHcxDhxfjJx52MxSVO1335eMnnzc07Fm37O6Z2OHvRiqaS6
 Oh6mHWWj5B_yrG5K7EGf3eWnAnAa.XyS9GQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bb48e948-3421-4e81-9bd8-5a2d9ab9ab89
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:02:37 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9a60282a87ef6e0dec5cdda503c29ed7;
          Sun, 25 Aug 2024 19:02:33 +0000 (UTC)
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
Subject: [PATCH 04/13] Audit: maintain an lsmblob in audit_context
Date: Sun, 25 Aug 2024 12:00:39 -0700
Message-ID: <20240825190048.13289-5-casey@schaufler-ca.com>
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

Replace the secid value stored in struct audit_context with a struct
lsmblob. Change the code that uses this value to accommodate the
change. security_audit_rule_match() expects a lsmblob, so existing
scaffolding can be removed. A call to security_secid_to_secctx()
is changed to security_lsmblob_to_secctx().  The call to
security_ipc_getsecid() is scaffolded.

A new function lsmblob_is_set() is introduced to identify whether
an lsmblob contains a non-zero value.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 13 +++++++++++++
 kernel/audit.h           |  3 ++-
 kernel/auditsc.c         | 19 ++++++++-----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 457fafc32fb0..a0b23b6e8734 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -277,6 +277,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
 	return kernel_load_data_str[id];
 }
 
+/**
+ * lsmblob_is_set - report if there is a value in the lsmblob
+ * @blob: Pointer to the exported LSM data
+ *
+ * Returns true if there is a value set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *blob)
+{
+	const struct lsmblob empty = {};
+
+	return !!memcmp(blob, &empty, sizeof(*blob));
+}
+
 #ifdef CONFIG_SECURITY
 
 int call_blocking_lsm_notifier(enum lsm_event event, void *data);
diff --git a/kernel/audit.h b/kernel/audit.h
index a60d2840559e..b1f2de4d4f1e 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/fs.h>
 #include <linux/audit.h>
+#include <linux/security.h>
 #include <linux/skbuff.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
@@ -160,7 +161,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 23adb15cae43..84f6e9356b8f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				/* scaffolding */
-				blob.scaffold.secid = ctx->ipc.osid;
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 			audit_log_format(ab, " a%d=%lx", i,
 				context->socketcall.args[i]);
 		break; }
-	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
-
+	case AUDIT_IPC:
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (lsmblob_is_set(&context->ipc.oblob)) {
 			char *ctx = NULL;
 			u32 len;
 
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_lsmblob_to_secctx(&context->ipc.oblob,
+						       &ctx, &len)) {
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
@@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->ipc.perm_gid,
 				context->ipc.perm_mode);
 		}
-		break; }
+		break;
 	case AUDIT_MQ_OPEN:
 		audit_log_format(ab,
 			"oflag=0x%x mode=%#ho mq_flags=0x%lx mq_maxmsg=%ld "
@@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	/* scaffolding */
+	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.41.0

