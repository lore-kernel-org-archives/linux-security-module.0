Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF012E75
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475012; cv=none; b=bn1dxMjWcQzWLHb5vSaD9TXPpiWXkpn8U1Dmw+Po+4Oqqk3lTLccyZ8wJjnlouNF7m/yf73sBYo3kjr+mOypD4NEiP8wFloWkFuGx8m/qL3nD9ELnSpAK0W5TYEvJBL17BitYNoseK/uHJxyzVrgupK0BXu/RkP9dhPIvZGnP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475012; c=relaxed/simple;
	bh=xUCdm1uftuDsJTlt1Yo7PKcKmRqIbTvTWWR4t4XTxaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtBLZWtTnnKXmChHeDryy3mTU2V6Yw2N93px7+WvZyMiAVQ1l8DYni73xr9NGRmoEjltfygJg4igQm179Ey0gYPftDm3EOfjgoMmdTv+VWSDqr+pMqaRaenaLwBZEDDrgfqrNvrpZiBbQu9MwANqj54HBhtD3B+jneFuczgtL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nTTn1FHN; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nTTn1FHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720475003; bh=yPahCZ39LI9I680IlKonBPhAyo3a0ekLmeVRGNR7N2g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nTTn1FHNkqCOL7iw9j+4YB1OnoGRxA2tn5C0RR7xiOn/H//lPs2fkwS28cyVv44b5rocrcb8CAK4fKAtTbJN2peH2+qawetiIcxdYOV1q+iExFgVJmZPVXC55xEPnRRf/9i/0aiHXEDLStPsNcnpzWc6S4HqYjanDaRdQI5Tsh+mFjJvMlXVwG1PEHmGLIsYc7PjiKTE03Jw/bedL5Fmw/bNVdoH7kHLiyQcpfDIxdLZcchR17rMUC81EcUEd7CgubPtIR+m+sZJzBYe/9DCskFSrnTaV3pxluY1OC/HcVvX+D3wQiRukitow4DT2lgBEq+/a4tiDH6eNqA+zlasMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720475003; bh=3RM8hrObz9Ihk8t8FD4QQdHLtEgRtkaGRfjvA+caHoI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QTEfGH+xFC59xYCVvlLleNp49BUyrUPJYElw9zRCzgZBm62jpGKWHv8axP2899++8DHS4ZX+qXqELyQ0t30N/c1A+56MfcHEPbYywEHwpEmF9d4cKKcaMNx04CljtbyZY6vcKitawQhUjGoxrUHppPcqZGXGelTQBMjwL6aPRulINBBJZV6r2GWxjrzGkwzK+SckDnxvYC3/X30EwelUn/+mPfQZJox092CvOSErKpg5mdWDswZA3utUwTjwBbzq4NhGXmRn3QwLJZiUeVGncYhv6nhA2RP3e3IMTfBgD9bNk0BQ7B50/2lJQoz1MQX48+/tpDj0pgcfC2ph0lJZtA==
X-YMail-OSG: pW_EAFkVM1ntemsOPqN5XcMASOKavgayFpN_4Po2wZU1uGm3S4Iw54Dt9XIVqqg
 MXNQmjpnPK2Gf0nj0RLynXO_VKDDlEeSJkLqL_KE5zRCu3i4eN2l6PuaTJN5HJccUAVW5QneZOFC
 FnecBG8dI.JSw_tJBHmxM6vUOBnLY8v7ICgR1nRoUrwm2RAhd.lbZtJAVrh8uZMThTDfvJGOO7UL
 GZdTnRgS2Hj8c1JKhZfcNcNkH4Z7LVMl5IC7DJJVSqd4oCadJmQuhcGiO0QlJ5ZXO1MBtzWlvYGA
 gfODC4J4aob9S7uuo78rXQPi9V7e6iYByQqr_zgcI5gheHJIOAck_YsZe_lcTo0fDHIw6qWwaL8S
 IyCTjsHHZ0UbgEIGB7.cqg.Itd39aDhfPVMoRyJ6JOmxEwTGrom.16FFWY44qBvW4U_Bt6g3a9yB
 AFpq18O6kDXIVoMY.AJTi1VMXVtyorPeMJlryk9EM5CpJuKJryj46PjM44gCa5iLk2R1V2_OMD2z
 YhbYEcgr76Gp8ku_Z3_GHMS2SZX_Zo09i8rLdFXFPVpLMUENovlptGy81J6uS3xO6YBqnsphQB8P
 PJ6q.DoNJoQis4CqzUjZadk4Ea8C1A7888tjdkEESv_t3YnDBhLWRwaGKURq.7q9M5XMfyyKV8Wi
 YBMTp.6WTY2OfCHBM.WOolY5IEeV4W5rq4OcmL65ZzJ9DA2.Z_xy1tcFPCuTAG1QXeCClnoOrirA
 pgeCRRmrfGZFCv6cPvT5KlpU1J8MVIn9QaVXNCDU5iiAYreGuDrNZ936qlr0tMaGxVmezU7wcjt1
 .eelUTDykBPxxqohdzTR6tfKsxwMy9jj3zumEDr91NkmO6KUzLd88gStpHL.hFr0ZaZr0XHU6jRu
 7uIqNVyqFzwvwJSfAHX.pOYZPXVaT4dYRHEtNoX_OG1LSBOp8BmMzmWNLdtlDSG1QZjJjfOCvjbS
 VYuhqRCAmFxHx49dXK..erOuGuKbArSvliLfTOWUhVtGqOU7spr3AOeIIfC1w2d8ErSjJ4pg13o3
 kk1I7cXecA.l1l0EmAMyDUK_7fug55EfTcBXsbxiMVA8mkkMRrGaoxIs3GpkVMvlQzxbuIFym95C
 63TGuSzrlTlzOEtXAMTjH1BNmHplQwEwELkRbRYsJYV3n_bycT2OBcjo4aMvb_n192xplY4qeTyW
 b8uuDDlg6ORjP2Ov1oPNG.2oJ56zMH_E8_N186GHCdh0nQ256ViMzlpLVDyjF4eca0OucGxQXsfG
 KeCk_alKeZuGXlM5cX6w0kHixeDQZ4MQkPXcRPC8QOEzc0zGzH33h4sTiIGxDXvos5o7JvcUVN0x
 Z.wFzEYIJk_N0mT7ktczpdtRdD6UQHIeMf448aPNvKrsu4Qu4e35JUYM.e9CwBS0joclacGu3YyL
 oA2K_sYpT1zugiHLeMJQXL_fo9ieZCWryHZj0D0gWBaXWCHTXPVJFX7gWsJX3d4fTGpPPrSLbWwm
 .aaH.v4CSRXWm0s7yxZaEPnKJEBblCIQxjLu0RqrjsUB2aAMy5DTQh68Pw9fQaMiZf2sqYtOIiiX
 rOW8KJrnke3m9HFyaMsdiXzppOby4XbOTFCI1hxI8sSTTNb7twZRxfj0l_L1f0kAMxObTg3tKybC
 zzxRnibWR6pMqWrZwj3anNp7VTu000j0zwfYC_p15Lnpd_SXkAgda5fq7KAHW4Xqgth.rcxJDaKz
 isigoQug6ZASpCOKHaqSMCRFDsRSOKk9toWg8kQn5RiFVpIGdyMvu3OLCdSvRrR8iKF15VX2tbTR
 8TrVoZiUkXdcQXCzIg2pI8H6bGkZn_29mQUC.himNPNydDazycP9CiFaTCvR.u.DndfajUgPuMfD
 Zezpdv.Rt_q9o_bPEg3Zv6NKvj2ETH1Bo5nnuNi2C_8lIa3z0B_WZYnmaYmbkI1PFjcFsOtomM9c
 kNTgRdyZr3BjD55Tpzd1XFVeEohYmYW3r.VVoPlofSG4ILYBGdO2dMxmeqUtWJmF5gM8qh6KRuQW
 YR0nzxadiwEXBA0NNOfTwDLXt_oOGqPOmMb8xXA.UlW7wTJNsCvK.ziUYDn3U9Tvgkry12jjhumf
 Ctx72h.CYDaR4XIqjg198.gvxZoBBh6Aq52cIr4IQ_2qppj6k0b6s5lXN3MC.MDjvikksruC1fG7
 .0Dl1fqUM9497vQ61eHF6frm.Bcyeawh5Bt5TAuw18ugpSi4mLu.RikFP6h4Sixx2EKf9wjt1iD1
 2Sb539Owqo52lHit1NxVjIKpdNQ7vHB9mUx8fiQ.vHB_oxdRO9AekaRpWogFUNK5N6Y4shFMbuLQ
 RhjE2AcCKoA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 296ccba8-57c6-482a-b5e0-0fbef744e017
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Jul 2024 21:43:23 +0000
Received: by hermes--production-gq1-5b4c49485c-4t9zs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c7c573d8884470e4d5a91dff95913d1b;
          Mon, 08 Jul 2024 21:43:19 +0000 (UTC)
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
Subject: [PATCH 6/6] LSM: Infrastructure management of the perf_event security blob
Date: Mon,  8 Jul 2024 14:39:57 -0700
Message-ID: <20240708213957.20519-7-casey@schaufler-ca.com>
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

Move management of the perf_event->security blob out of the individual
security modules and into the security infrastructure. Instead of
allocating the blobs from within the modules the modules tell the
infrastructure how much space is required, and the space is allocated
there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 12 ++++++++++++
 security/selinux/hooks.c          | 18 ++++--------------
 security/selinux/include/objsec.h |  6 ++++++
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b6fc6ac88723..f1ca8082075a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -79,6 +79,7 @@ struct lsm_blob_sizes {
 	int	lbs_ipc;
 	int	lbs_key;
 	int	lbs_msg_msg;
+	int	lbs_perf_event;
 	int	lbs_task;
 	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
 	int	lbs_tun_dev;
diff --git a/security/security.c b/security/security.c
index 731a54fabc79..da2111f8d9df 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/xattr.h>
 #include <linux/msg.h>
 #include <linux/overflow.h>
+#include <linux/perf_event.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
@@ -232,6 +233,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
 #endif
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
@@ -414,6 +416,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
+	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
@@ -5653,6 +5656,13 @@ int security_perf_event_open(struct perf_event_attr *attr, int type)
  */
 int security_perf_event_alloc(struct perf_event *event)
 {
+	int rc;
+
+	rc = lsm_blob_alloc(&event->security, blob_sizes.lbs_perf_event,
+			    GFP_KERNEL);
+	if (rc)
+		return rc;
+
 	return call_int_hook(perf_event_alloc, event);
 }
 
@@ -5665,6 +5675,8 @@ int security_perf_event_alloc(struct perf_event *event)
 void security_perf_event_free(struct perf_event *event)
 {
 	call_void_hook(perf_event_free, event);
+	kfree(event->security);
+	event->security = NULL;
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79fe75603881..d1d6adfdfbc7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6952,6 +6952,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_key = sizeof(struct key_security_struct),
 #endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+#ifdef CONFIG_PERF_EVENTS
+	.lbs_perf_event = sizeof(struct perf_event_security_struct),
+#endif
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
@@ -6983,24 +6986,12 @@ static int selinux_perf_event_alloc(struct perf_event *event)
 {
 	struct perf_event_security_struct *perfsec;
 
-	perfsec = kzalloc(sizeof(*perfsec), GFP_KERNEL);
-	if (!perfsec)
-		return -ENOMEM;
-
+	perfsec = selinux_perf_event(event->security);
 	perfsec->sid = current_sid();
-	event->security = perfsec;
 
 	return 0;
 }
 
-static void selinux_perf_event_free(struct perf_event *event)
-{
-	struct perf_event_security_struct *perfsec = event->security;
-
-	event->security = NULL;
-	kfree(perfsec);
-}
-
 static int selinux_perf_event_read(struct perf_event *event)
 {
 	struct perf_event_security_struct *perfsec = event->security;
@@ -7312,7 +7303,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
-	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
 	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
 	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
 #endif
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index b1878f9395b5..d632a9180b41 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -219,4 +219,10 @@ selinux_ib(void *ib_sec)
 	return ib_sec + selinux_blob_sizes.lbs_ib;
 }
 
+static inline struct perf_event_security_struct *
+selinux_perf_event(void *perf_event)
+{
+	return perf_event + selinux_blob_sizes.lbs_perf_event;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.41.0

