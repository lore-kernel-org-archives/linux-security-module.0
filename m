Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267A1DFFB
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724613170; cv=none; b=IUcnP9ei10q/o24u7D+HGDkhkYaLvVaEWrXIiRmdA62pEWLWwlQc+LqLkYl9NDj9OqOc+82dwUHg6ElrNm8Sk6+KOwiSukqYxPebLbhvzvZe10KSbHUvd6HwuCKjBmi+8lx8cerwvYtQCT2KHxHP964E/JanCFl4iWQEQ+6O0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724613170; c=relaxed/simple;
	bh=67ymlQDOa1Der05uWcWmKFyIg/qwS1ENd9dk4rFsI2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hb9LxRK8ae9bKZNou5PHrCXJGHW/VX2GUvg1T48g6nigV0dl5CFwKbh99Min3h5c5rCeTqqE/kTp5fkJJa0oJsJ14BXZatSI5FFv5wm3XjtTXNz1VSlmjHrV0BDaLH1Yhxh5+mpoDwHttyK4BtBUtUD4U7vHjRgAmpp2e56OvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=C+WjFqNZ; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C+WjFqNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724613167; bh=dqraIuMpwR6bHt3tfUB7hIAQsUylj3oQRwTA/i7LrWI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=C+WjFqNZS5euSGhR1O6yH1jVp159gjJQqIndjNBkHXyd80KVb5jxPqXo0q5LwRPigBmKtn2BfdGZWRzzA/W/cOmmGH0KU6PgxJ4qpgdkMeDl8f8522bCn0Obc7sQ/1zZ4OEif65oWWYosIsB94P3AS75EBwKbN6z4vecOYWOkTBhxPwI/UHLlgEkWn+gOcbZL7aKwVuT6noLv/iV8A9j7OhcHgzSW2PMgezSRfcbxQpLH5uBi3sYhaR3yZHvy1HtDsWeoZ8ML0H0eOfz6dWTfw5xRydaUj+rkfvYrbGx+CPDmYFMx6pKqajMWmgBK0TKoUA5agj7YlCWM8ismRqb3A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724613167; bh=eO1PYtKjZ6ioD1d3/AkG8BKGwfiw77zAsgAMVORv6KT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MHZ7E9jCbYvw60nL2f6t+KTQlIzb1yciDHIN3YNkbktGXYsJ6srY0uO/dqXoY4WqUyYU0G4WQV/y1v3Wqc1Kc2g1fChnps9t1z9fx3lfXrOm9byjiHF7gI/BB2mh3MH207jXaifws+vdqHa+3Qsksvlqr7jpozk/QqFGT3kOvtZj90yLWqibVn/YeixF9JwkPIA/WAPW2liSNuMuqRnAipXn1PWUN+jyN3vfr6pNTpUpnTuC1VqIwS1oStLWttNlDO2HW3TIocTAoXl3rH8fXQ1F5ABTY1WFE6ssDZbInlCgfAJWWmsy1a1JnH8+DozCMUSovOpuh+SzGdoOIcN86Q==
X-YMail-OSG: g1nSUcsVM1nuk8omOIYAZrp6oAtG34T6J7m_VcyzLD6qPqL4_zCN2Xq5Z8Gh_2G
 Y5DlxRp.uwA5zMDe93vrRpLImIS2P9j_EFxP0b0M1Q36bxuO1V7RDjx.tuUaJ4Z7_yxKX6z5jbjO
 1dY92_U_JGPYpshkJWUPTeaR16TFrwCf28dEZv3TLvUcmub_PHYQ58mCGf6w0Ctu0BMl1WiEyBzX
 qBcK_7cDqsPV2033yDB_CNCv166TUA94S.Y5A.HeExyqB74H2SwHkYHO9XUSEzLCTxBz9GbYxCa1
 EZO497rFG_l96RL7IOr5Z5XV2MmmaQFhJ9B1w0fWNkssfutmd9bZkjK.jK.RWhLgUo.5Z30QsZru
 rs31n.lx1enLKwzjD99r1F6wWEvCm91a42dGeChzTQn601YY1xjbyrNtdWD9bvSSlE.6xTHekuTB
 9ijwz1TpdLvIHyPCnM7ZpDO0D9A2vDpp3sUWVQcv_eFluQGoaxzXc3FDlWuveo6dzWK5a_S8KYLg
 TehiuTnbS1GVOgxLOSFPElnj4bjku62OKNUPJk8.zNzkgSfAX8iULPo7wf.8vw2VgWogjP324rME
 0NwVIMKID1jp1QPd7CRhLqGuNXLpXlbs0KGmPNbZ7xbjrg2VPwUeD3ozuvliXeTqshO3ghRDnD41
 .uHVThf67KPI6ZV0KyUcQpm57MxXCujh6s2P5ReFm8g7sOQIAPeqxjBYVlwoiSPYW6Z5oyRuDI67
 v6xS6dL.UKL6vefWozd2xpDXkBOo8kEjEFhGkhYSy5Dw0D2HcSZI1H8tnUuy5Anwq565.2VO9C.u
 5RSkKnsqmbrsPUmw2SJhRmlbvMIpB9.cRC7Sul5PJVViAqv8GJeb4tQ4TiQwgF2bnKGtcUOkUCm2
 loSDbc7afbNflo12CJs58sDR3aA97XCwRGRUFFrlfdQDvYFMMLg3GzN85091qpNNch8jhoEqTMkZ
 Udv6X6.yDO9MRGf_bFgXnLBFQK7sTc1BgFnc8J.2kACTZT9iVkDbWZI35inwBM.89gfVQoRdpAvx
 kglqYUV3bSHpVQvacN3H8k88PGWBoXzLRZXx0F7UmSb62M6PcPAIp8zXAnf0U3il71e3.kYbHbZE
 sf8Ro9apSUGZ0EZ.xtGE4CDBJZNxV0z1tjFKCJPUBZQvc.K0AHkJahgu01J8UdKC2jNXF82Qre4Y
 lu._RanL1TWU88fIEsDhniXw3mDdkGveO4d9FOEN0Z6w6Uy7bzfXYsSjzYR37Ql4uvICqowVAbYl
 3Mv2gZE3gPh0qClU.Johb.JS9Lm8zsCRSHIgWo0AYKnlQwb_7R1g9uLbgALiD0Gw55YIMTBMZ4oJ
 ECWLGmnL8bGSrx8QKk3J_jAPLmQv0GT6F81DKZggTForY.53r5wX9aosyx_i2WJCClV3bfx60.uS
 57ptovSGajQI7PyWfdZfvSNVHB9x9dxJwYwdQ_eUg_SkxyC0X7AH76j8crDqbVszNz_u_RPP2j1W
 DaANd_CfuqVgZ8_7tbCeNFA1g6G.iSJEigq.PELM4ac0wPVSvuRkz0wQXwLdouJcKKfa636SVMcn
 5SMUMfs_pC6wNnZUgGnCAEJ.Gq11W8Itas74_sebiWcFO5v4ZubYpf9c1txc2t4GHkXOHoOV9brn
 3Cshj1sSbm6MygXgafGUcBfsSKmn7XXLJPEfWOoUXJDVD0s.E4h41m4eiwxZvQn1Nk_xiFXghoOq
 AlLIc7OMmrGtPIlmv1cB4vF8tzUGDakgs1cOlIvn6n8vbAcm174ObC.ISL.Sygp7cyQSFIopk_nI
 2IcXp513MRJl8NhWL78.u4_ru0ssQ0rCUgmAgpxf9dQwHdAe2lqsBRIX1Zf2EG9dKdzX6_xzRn_v
 IJ6qiJuYQQgGkYxmP91vR6jKhR_Dh02bdUC3..lya8eB0AnLJTaauQGqQvkmc7XeDtuaL2.z_bxf
 x1IbjzAFyLEfW4XDQ1nByKKW4uGO.VVaQn2slqIhnDgLncv3BBxdDLn83wulIdoO43CqcLEnSbl.
 4IOsIdsJ2bWiEFZpOq4a7RfxShZoz05uXLUvGMQJuTDvgvehipsTYUjrI23aZuuYn8AY4b04ugPE
 UPKr9ItgVqg3u4YyjCrRVv2l.mBNDVvg7uxCAUbait5u1nD7eWQARUORjipF2QcqLYQbyG3UDFTr
 2p6vWEFHB.YP_CP.zzPSjj4gI.TwAJR4gRzM1i4Ze8TsCp0iZwOeskj6FCfqBNkw5prBo_c5JDX0
 WjSgBm5j._ibL7sdZyMIhu_ZFnPtmbQiZBeJH5DCGBwHiQeRfGkV43s36Tg3bQ.l9.bRgRiLuwAP
 uhzFvsvz1MCsxgUTME5Umr6pL97RzcR0FoEdz
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 54319396-7e8c-4c84-a22d-16d7a6eb5d5a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:12:47 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9a60282a87ef6e0dec5cdda503c29ed7;
          Sun, 25 Aug 2024 19:02:35 +0000 (UTC)
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
	mic@digikod.net,
	linux-audit@redhat.com,
	audit@vger.kernel.org
Subject: [PATCH 05/13] LSM: Use lsmblob in security_ipc_getsecid
Date: Sun, 25 Aug 2024 12:00:40 -0700
Message-ID: <20240825190048.13289-6-casey@schaufler-ca.com>
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

There may be more than one LSM that provides IPC data for auditing.
Change security_ipc_getsecid() to fill in a lsmblob structure instead
of the u32 secid.  Change the name to security_ipc_getlsmblob() to
reflect the change.  The audit data structure containing the secid
will be updated later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
Cc: audit@vger.kernel.org
---
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      | 18 +++++++++++++++---
 kernel/auditsc.c              |  3 +--
 security/security.c           | 14 +++++++-------
 security/selinux/hooks.c      |  9 ++++++---
 security/smack/smack_lsm.c    | 17 ++++++++++-------
 6 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 3e5f6baa7b9f..c3ffc3f98343 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -253,8 +253,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
 LSM_HOOK(int, 0, userns_create, const struct cred *cred)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
-LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
-	 u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmblob, struct kern_ipc_perm *ipcp,
+	 struct lsmblob *blob)
 LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
 LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
 LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
diff --git a/include/linux/security.h b/include/linux/security.h
index a0b23b6e8734..ebe8edaae953 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -290,6 +290,17 @@ static inline bool lsmblob_is_set(struct lsmblob *blob)
 	return !!memcmp(blob, &empty, sizeof(*blob));
 }
 
+/**
+ * lsmblob_init - initialize a lsmblob structure
+ * @blob: Pointer to the data to initialize
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *blob)
+{
+	memset(blob, 0, sizeof(*blob));
+}
+
 #ifdef CONFIG_SECURITY
 
 int call_blocking_lsm_notifier(enum lsm_event event, void *data);
@@ -500,7 +511,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_create_user_ns(const struct cred *cred);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1340,9 +1351,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 84f6e9356b8f..94b7ef89da2e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2638,8 +2638,7 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	/* scaffolding */
-	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
+	security_ipc_getlsmblob(ipcp, &context->ipc.oblob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index bb541a3be410..6e72e678b5b4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3611,17 +3611,17 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 }
 
 /**
- * security_ipc_getsecid() - Get the sysv ipc object's secid
+ * security_ipc_getlsmblob() - Get the sysv ipc object LSM data
  * @ipcp: ipc permission structure
- * @secid: secid pointer
+ * @blob: pointer to lsm information
  *
- * Get the secid associated with the ipc object.  In case of failure, @secid
- * will be set to zero.
+ * Get the lsm information associated with the ipc object.
  */
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+
+void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	lsmblob_init(blob);
+	call_void_hook(ipc_getlsmblob, ipcp, blob);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 102489e6d579..1b34b86426e8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6328,10 +6328,13 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return ipc_has_perm(ipcp, av);
 }
 
-static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static void selinux_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
+				   struct lsmblob *blob)
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
-	*secid = isec->sid;
+	blob->selinux.secid = isec->sid;
+	/* scaffolding */
+	blob->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -7252,7 +7255,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(userns_create, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmblob, selinux_ipc_getlsmblob),
 
 	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5d74d8590862..370ca7fb1843 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3442,16 +3442,19 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 }
 
 /**
- * smack_ipc_getsecid - Extract smack security id
+ * smack_ipc_getlsmblob - Extract smack security data
  * @ipp: the object permissions
- * @secid: where result will be saved
+ * @blob: where result will be saved
  */
-static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
+static void smack_ipc_getlsmblob(struct kern_ipc_perm *ipp,
+				 struct lsmblob *blob)
 {
-	struct smack_known **blob = smack_ipc(ipp);
-	struct smack_known *iskp = *blob;
+	struct smack_known **iskpp = smack_ipc(ipp);
+	struct smack_known *iskp = *iskpp;
 
-	*secid = iskp->smk_secid;
+	blob->smack.skp = iskp;
+	/* scaffolding */
+	blob->scaffold.secid = iskp->smk_secid;
 }
 
 /**
@@ -5157,7 +5160,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
 
 	LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmblob, smack_ipc_getlsmblob),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_security),
 
-- 
2.41.0

