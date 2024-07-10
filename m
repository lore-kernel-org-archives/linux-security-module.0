Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74BD535
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647357; cv=none; b=AvKPc3Dgchc3W1lOXx/XpVfPzeTiwrOkcztR7VDL8/XBYMDbSTDHNYYPOXKErbBpjzPI8YPZR2XyFJdi+7fdyYUH4filEiRQ2ZkYoDnfRz1TqzoCctNbMZ/F/I+5OFknGdoXAscKWIP7ZZo5ipMUveY4YwuY+Lu/ClkglJNndPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647357; c=relaxed/simple;
	bh=2EhCYsIzr0si97J1QYfmDT1bDqO4u/uKt2I08nDMfdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3b4+utdPaTdKGqep43ANUmbYKAWyeWVUTalNB+hU0j6HhQp5KuqTVAQHS2yytIaNauvRAB7pxxVym6DL0hTLMBxNQzH3LJqMWVX5T0uscgU6fC8GziE727BDkYlmcO0DKnfl47Ky+nMo1NZ6rHYlN5daZRFY2f9QlvkwEWUCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Kmokk+8Q; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Kmokk+8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647354; bh=L25Pfj89kcj6bP8haqQKOdpjtzclR6D+8BGBHyqsn9o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Kmokk+8QvMaLl7LDD3N2vmVvZfn8WTJ3Hl2NhmE1GE3JBdBkuw8aZg4sbPmrWjNkczA+6AvPIuu48D/UqpokDoS2dIN7XXDBPaVqctMKmgERztuHrYc9ogsc59wfDkXWIN3QCJUx411DIuQ07Sb3MKrI4/iXKFmSka6VxomJDUKYvRJyzXV16rnQQK9u2dTMuoMDeqImWV70ZNKBvrDpmrlESFELOfLiVNHURZZxb7mW6IBU/YyQQTeaerJBcpBAD3VZtsBZNo4pR/oh6mzTHPbFRzf2qEPgp3Z09STHk7+n6SScV39B03unCMaTiosy/S1qSWoZfBj16a83GxguTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720647354; bh=9lRrdMoDN2Gqn3i58bSvQEhD+hiHKilVf3qQRUp2SMU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VSifdL4dMmBmt2V9ekwJBOkYGooQsmtUTdwkHpcKuzP8HFBzB1QHzExtv1ET+XhfGsOOk8D/qyDWTiULwa7prGJghaIkOPO2coh8as72ysdpkPmc4ZNUpYV3S3g+s32KHZBRtuu/50HStbN+QHRdyZyVjOf2NvQIXzadtNO0w55rj8DFBaJmgY98WWiD5kJJxk3Miny5jCExM2guJ0cLfKGNfiZY7Mdv4u+P3vcqLrhAxVyA/7/spSpovlqEHBX6Dk68ISs8dV8dTM1msO/FAaGQBEH1IKUBj2rAJKpul9eSr/s3k+G/ueLG2yTqJJRXz20sHz2owK6fjFQKvVM8Dw==
X-YMail-OSG: PlqKp3UVM1kOKmuxcOqkoskYd8_FqX7oDYgx4jO7m2eV5wmMuyNz0U8izOrLhYm
 cfXGe3uM2DS7_vWga7Zn.xP_BSGgAZhTwYRXirfh8.mWVWFwArh3P_NSVjdQoHnvEbVvHJJqn.gt
 Ur3KylIUfLH0RjD5dQMvBqL1nQwGryi1mLWlesfazAI4DPV_KK_OB7JLgCcOWUTaJQ9_PcdmRjNP
 TWaio72R87tcx4yLQuyzeh..MIl.fLkbfjVnulflw4hl.tbrf6.fWzi5h5LfnT6O1AUFpUgoyx8f
 tyIjV854wKs0xBbnVD_Y31EKnmTrq8mUEbq0ybK3A7QayIxDt3zOZGCd35RCwgKrKv0PcfwnUX3_
 bYzDnb.WwbHlqRpq7lAk0fdlTHmBq35eT6TGJI_0lyE4gFs0CCZVmWZqIXPMNl2KUi58XHR8Eejo
 1SWwFKWhBhhxHSD7Zmj8QTT7FDzImDevh0BKkrgpTZXyxUv83mHn78GNcLmHeh0KgbbATVkS6Wg0
 ._GsBe9rzQ4NwQ7DnWxtGxXa5K75H2kltqgP2cX99eU2QLK0Bw8e1pipA6CnTETET_E6V7uqpEiE
 IcPPOUdqIYHscEtzfib8qzSuR5ovgo0MHuJdDVYSDYw6j.__V5DNbpSYSV4qyNeb3Q2JqlevBMXQ
 vbQOzsw0tFawXdA13nx9jgHxcPsfJ_LqbXcwoh8lfz_GgFwIBEVIp7IDmQE04j5tKbDRUMWF_6sg
 WZvSa48ky6htl4fS9FPQEuVmRa1ZoD4MpTzR5u387WXgLNmmYWmYHwuLjtaWHbl3NBUrIRnoxXPq
 QJhMXTUCm7U49_oCummhfgKK1VoGxkDovRbxPh8dDA2zJrsc96Xn0r2ACB3uaBEaOo2KMNOsSr7e
 71gkHnROK_VZAH1GUzJQC4rak3Ra9gNwhqGyD5kGT3rCK2ozme.UHaiUDHEtCRiHvaz8YNO0fCKh
 gcV80PtQesKoSIfUJ6khLN7g8opCecZWNlz.FuBEBEMITXPz6X0u4roE8jR.udGjCTLfqWtXky78
 ev45mDiGY8htufss5xvcATBc.yeC_Hrz86poWJSCXc1FEkynw4gEKzvbENk3VEzQSgGGj.vRReGf
 tLAKofX9KEPILvyDy6XyeZgGrJ8f_2_GGQH_3XE4VfDuAYWOCjMRXSCndO8bRq9vHbODz68nwDE5
 hIEXhKqr8tnxr_K9BxUPYIdVOKlah2UD.Qfxxv6MxHI2QY.YvcAX_gbalu8XmrymToV2o7pQBTny
 LzOpERV.FF.nnUh946T43pqcQUzVc_T66EyXt1xsPBskXTt8MmHp1K0wpW4.NIEnhbLPONzFKgKR
 M2XFci6HoEHV.Qwa9LtSg8sfxrCrZVgMJ9LPhewKWXAn6z_ICYZVoWA_Pa1al8iuaVfAg0Dyoybp
 vURMrva5iSHEU6TmFkeEsCgf0UZrMplA2AUKp2o7jANAOZGtSFZpnhovYmNu4ShXU5h9e5gfyMhT
 0XG7uTSRgJ.vyOlww7eTq0aitZOiCN8BHIMof.mBPiUPnW0om9tPbBCaVVBch256zBiE8VY69OoI
 5YrTBPCQ4ZDAsG5CJ_ZrDk7z5ujiG5Wlsp7XHk6G02YV4Jksy_w6GUCiyjOT9ECt5.L8Xg0I2upM
 MN_Q7H4r2mj8nbVA7vneNef2khQM7IZo82u83mHIaacgUz50RjWj8nrOm5s7EqgNBlSnAi_g55tF
 QoVnJf0FKo0yk3XR4LoCGmLF2R44qX0Mmdq_Fu56yunVRWf0NoalGXgK1d3jneV7TGcdY95vitaj
 KG66jQh82XUJ1fu9JT5ydwEgCs9OQT_tE7sIDuu9EWiDOXjJBB0s53YJnBmMRi9U18IBX2D6vr.O
 jdlQV8498aMkCRYuRKhZHp6vwi0xvcj2Fve7ryRdzo3kV8KHO803DIeCdH5lHGFjEyN72M_7C.18
 ia5nfu_oUxEuuB9c_UsC57duVr6vVec6uQw9nh497Z_0s25RC4BGhmz49bv1Z9uQAcbUH2hGwJNV
 l3tTihXgmbtCbOnlAn4ElOoDImleqF9sCDkQkRBvn8zKU7YL.Lo2FnltFivxmmycr9yBfR.9CebD
 SJg7vBUKTXTabE1GiRKD0sJqxHIBdnmConBUqpCmzJlIRWhsDbJt7aoMsSiAlElM1T2kFpnzwySB
 stp71RnnRO_f.9soBTcGq1VGpyqzwAc7HyCPh1P60qHaEggC7PVi0MqaKYFse.3hvzqLg2w_OlJq
 izh3TDt5m_ntZbsrBXDNV7Y.thAVFm35.Wo.AIbjVyK.hRVG3fiUrsWvA_bE0yvl.QMCMMqv7m7q
 zwUY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5f687b58-dda2-480a-a420-265863d844e9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2024 21:35:54 +0000
Received: by hermes--production-gq1-799bb7c8cf-zh7nt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b02b0457b05e8bf93c289b59d86d57f9;
          Wed, 10 Jul 2024 21:35:48 +0000 (UTC)
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
Subject: [PATCH v2 6/6] LSM: Infrastructure management of the perf_event security blob
Date: Wed, 10 Jul 2024 14:32:30 -0700
Message-ID: <20240710213230.11978-7-casey@schaufler-ca.com>
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

Move management of the perf_event->security blob out of the individual
security modules and into the security infrastructure. Instead of
allocating the blobs from within the modules the modules tell the
infrastructure how much space is required, and the space is allocated
there.  There are no longer any modules that require the perf_event_free()
hook.  The hook definition has been removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  1 -
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 20 ++++++++++++++++++--
 security/selinux/hooks.c          | 18 ++++--------------
 security/selinux/include/objsec.h |  6 ++++++
 5 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7c979137c0f2..658e4ba282e6 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -438,7 +438,6 @@ LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
 #ifdef CONFIG_PERF_EVENTS
 LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
 LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
-LSM_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event)
 LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
 LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
 #endif /* CONFIG_PERF_EVENTS */
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
index e8f34cbb1990..444b0ea28c04 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/xattr.h>
 #include <linux/msg.h>
 #include <linux/overflow.h>
+#include <linux/perf_event.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
@@ -230,6 +231,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
@@ -412,6 +414,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
+	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
@@ -5659,7 +5662,19 @@ int security_perf_event_open(struct perf_event_attr *attr, int type)
  */
 int security_perf_event_alloc(struct perf_event *event)
 {
-	return call_int_hook(perf_event_alloc, event);
+	int rc;
+
+	rc = lsm_blob_alloc(&event->security, blob_sizes.lbs_perf_event,
+			    GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	rc = call_int_hook(perf_event_alloc, event);
+	if (rc) {
+		kfree(event->security);
+		event->security = NULL;
+	}
+	return rc;
 }
 
 /**
@@ -5670,7 +5685,8 @@ int security_perf_event_alloc(struct perf_event *event)
  */
 void security_perf_event_free(struct perf_event *event)
 {
-	call_void_hook(perf_event_free, event);
+	kfree(event->security);
+	event->security = NULL;
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 11f4bdabda97..f42f6af55a73 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6950,6 +6950,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_key = sizeof(struct key_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+#ifdef CONFIG_PERF_EVENTS
+	.lbs_perf_event = sizeof(struct perf_event_security_struct),
+#endif
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
@@ -6981,24 +6984,12 @@ static int selinux_perf_event_alloc(struct perf_event *event)
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
@@ -7310,7 +7301,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
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
2.45.2

