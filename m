Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D283839C
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612849; cv=none; b=Ln1z15p5qkAn2fvW24XUXhzebhep8M0aqSm5D7GlP59LeAmT6KMRhBL3xxefYDubWYUYlHlIZ9gqL45GXahDfNu89Xt06xkM9w910JA08nj5miSZgFtvYvP+BvwwEH7B2AeNLfL6Z8ptgFdJ2mxOF+YAeOCuSm4pFeLwX6lOwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612849; c=relaxed/simple;
	bh=PTAwC388/98I60LM3CkPrj2d2gHZ63MsPbQQfXw15sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDUrBbQj/Qmy03dIZd2HS3NFXuKkfXXFpv0P8MMIcOeSgsFs7wtljH6ZdsPgGOXA9ciYqB/aFti1OJMXH96OZOyz7a2UerJCk8XWJp2u1lmrrJFsnttCE8vzSYQJo3tbneMndwo0rh+RLvysyqB/SIJRptTBhOZHyYs382Z7tf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pdxs/bJU; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pdxs/bJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612846; bh=gj05YMwICVh/HhYrYO3+ZRVKA5r4wTDMC8F67pxZ08o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=pdxs/bJUTaHEjJP0GLhacOcJDo5g5RWI/d6mvLRA/S3RHdezVRcAKOcqT2bkHYIplBcPdXxlyYhvjLOsATboJNZvVDTAwzRhGXN+8Unh+X4xmDFTRIpjic1Bx0ruxaa86QwNEJqlmNi8/JSx5/EbL1vCWC9up1GBtUPca6OITZobhU3CUtrVYrHLVZfnd66IwI/uk3Sw676Rivcn7rMyKRnR0vHVAwQbyxsEFOyR4uSDUyxecx/TBnO4JO0JicqMSo44Buuo20la+Tl3CPrWt24YRO6I1tQdp+cnUQPgaHmhLwoULmU06CcSul4t2M/ugkBMMVSl1pstzwQtbjgiUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612846; bh=mGIMI08dP3FXdy9jC0qRHzUQ7T8vFMPDnAwh7R40746=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HlzynemZwjMKJQiTg9SW5V69bmqrsxDk8HVH6Dwhlz5X+8GRNiI7pFjJyPKgJruRBcjqLL2f7u8TD5E60ZpbsvLS7nQCA72e3kd26d77ttwVJK0tRUQgilYZP8xSoMmXwQdtxZCzuQxq8Jp4gB2MFY5oZpoQ4YMXp8LAmmrw2Zzz5w2kwMU9nyUf6Dya7hlZvUT2kKRXf2PqSn52E5d2NQwbnW12wFWWAFsTAN6YjBX7B5QCReDJdXLsuNIQ0dcLjjTzaPWSAHn7ncagA6ADH8T/MUN8JujrHAcAt1YPEkTuENWD4G0ITNngxOY3KnjKjrYkD0Hd0JzWaMQmLZKX0w==
X-YMail-OSG: MWLBSNAVM1m4jxm9OZcfum5B3S6NJfO.1QA4tKCbqu8ItxJ_xLDAXYvMVqNyIHz
 kR7oIVQvjSb38u7k1TDvsz5kD_XdVDJlaZqrs3Ob7I19g8XlV3LoU_FhXwxM1HmCtMO3b3BsTQAc
 cpbu8JgAFoGUgqEjArsDGGMpgJ75EeZyk0EkseEbhAOorhP5pv3euCTdvfC0nK3TZowKxa8ANDS1
 Eq6p_aep6R_rnzHCBzmo5bPTkRGmvPQiWZVrKuuxQ4uT.Y90yIip16tzqS8zfNZ1hSwp.nEgxp45
 KzPF_C32nFDAnNogCxVkLfih2GUk7Mxl1sdsN3yfS3FjhYVdSBBCt87dcPYO2msrWbWMwgTlLXFW
 vFhybA3egmB7oq.t2Y8VsROuA_RgxLsaT5UZMXfkjBv7clqkVHXzhtWGBIpsn3lGmcQCxibteBMm
 7E2STBSuct8bI0ujA7hcQmgF76wH__qtHyo_XCelUUBEpOXyxJjTIjlqVOphCn4GWLc24_rOTHPB
 0xvcoQJ.LpNDDYMQdjHP9VvJSlW36bmbfXKcPYr5YkgoqXBmk51xb0qSYJbqXW2eZmbSMVqcdsp2
 8wXvc0.J86G.L9n21pmvtaLyU8aU.DSeDxSpL0845_ex5pQJsFve3SeXxMX5kz2KSBnKvy.0zhKu
 vxCM9eS1BIMQGrXZ0vJkAdZ7CLEgf8lHtVXw3nIeNIN6zdl0XvQSE3WkFzCJfkm01lxPWgPFkYjc
 E1y.o4QEMesbemlUVzqNqWKCNDcYg_tLc8Se3AQUj.a6ALG6O7yF7VBIbzW76fTaIsVCAIEdmqqh
 tlGngpttzs_tiCY1ExcRTnbcrUwqy7heVdTio7onEXSulbFRFXgfHODYCCe8kxbYTSHnC.tRofeG
 GWU8IgH.rjs9P1Uf_8tQ1RF8i3egT2MLfGj1Jo2q7ydzBVYFc8CG99a6Te28OohTT9Wq2EaBdHDR
 q75D4ctVE6Lhmzwmoe65yjQlmVCz1bBI.h4EK5LfXL7oN5459q7p1oS2GN5qi8zwzXrZzAfpkBKw
 PDZ9ipuQPqGaxLRAy4_IA8ASybBoO4lQCsYy0y79Yt0zO4xcIw5DLxB1uyQjbMPwKK_HYKXCsgdY
 TGXkPM3pS0N2D2X_N_idgKiyHnlo2zEV5Swub14PH6H35tdj27vU1mDfHATzc7q4m3ipkU.SXjKr
 1GrD0yf7X08ePKC9qcfoTlcyYNpvQk889n5LFBv_5DfG9i9MdyLx8VGxDbqoh0NnBn4w03jiMrsN
 hO_OOFAoYCqHIRWvo63byZylFVsWBxsb24UKgX43q_9ECFMzjcyuI7Rv2U9OE8mmve6KsvBiIweC
 nWcjPB9WZnteTWXSLXxfNw567nAYQrVWGCKQ1kTzRcG90A6RiHgwSvgNikzEJ3Y8M4wfMbFPHzU2
 rhKLmI650QJzjEkDhT_.jJiqFfIMwsGU.p.RAm2TijS4VKRMtszJLF.BSshbWy6Mdqo1amYghQok
 o8HXGMI2lWcF640yfG3r_54MJam9auP99KwJGt2yUq_usckch1zO4wa_vWNLMGE_FuBFZIc6agPv
 4W_3PIVhTJF7wgRgfVnIaYzdSQtMnNlGdQlw8JkL7sEZ3A0Z7D6rtgFoY84lPIKfkYHeFQ1JkB_R
 Lmaf.R78isA1fMbzXj1FN0Ht3Ey7tEfheWbFws2CLTMi2a6BmfqLkg2XKdhAb.lCUT6g4sf7yhJB
 c.LYwtXRV3gVDGwuagA78cmuyYDJxoiL_hQNzbuVz.4c.wWZHYSS6B32E0qdYUWQpS6pM6O.LE8g
 t7x8OWeHZsOw51U5A6Vg7jDlVIIa74oqabEKXqgyDI7F0JwTp6uHmceWHW_Ny.oxiiMq8wKJ7bTj
 gS0zV3XHxvJAm5hAtknQr1biewtWjIaLhndqqOo7CzLSaU39I_B8hy5F05N_Ms_OWxV50MvmQ5Ww
 4dpNwSHcHIU53VQU8LsD_mwxQybLSdRvxGPXPRgHytaFh9vRJWKk2kSdkvKRmgkxwi2fNfgk5ck4
 mfWq3m6GYi8aBNHHfWYYwg4odmCWXxFbgvcqYEq6NTIGq80k2XvZWBNIJTCx30ufyfXPS6hA7fsg
 OvBBHEK3Z5S02nGoXp6mooKzXO06WY_6S6cPEVEmhYTQPAYhaS0bWh1uvV8RkcSx3q6_dW79aT6V
 c3i2KUTP1WdO4CKsiIk3vWpPdoRxOykbl9M.y0dFlBnuG1Ja7gJ8m0D2mJ9LPTMsEDSlTQa_g3tc
 AnNPSFKOiDa6aBdZxwEW9NRvUCbsIbT9rZkCuw64fVrGaBFWs2Kq9WfYClQS2xtzKFuokL.O8NXj
 84DxfniUM3v3dTDQAq1TGV5wSyuMQDPSMrkbeHkJwINWCDA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: adb486b2-0631-42c5-9811-c615e01066cd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:07:26 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed4e1fab5441326e8fd35b3239a0dd08;
          Sun, 25 Aug 2024 19:07:22 +0000 (UTC)
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
Subject: [PATCH 12/13] Netlabel: Use lsmblob for audit data
Date: Sun, 25 Aug 2024 12:00:47 -0700
Message-ID: <20240825190048.13289-13-casey@schaufler-ca.com>
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

Replace the secid in the netlbl_audit structure with an lsmblob.
Remove scaffolding that was required when the value was a secid.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/net/netlabel.h            | 2 +-
 net/netlabel/netlabel_unlabeled.c | 5 +----
 net/netlabel/netlabel_user.c      | 7 +++----
 net/netlabel/netlabel_user.h      | 6 +-----
 security/smack/smackfs.c          | 4 +---
 5 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 654bc777d2a7..eb6b479c5c06 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -97,7 +97,7 @@ struct calipso_doi;
 
 /* NetLabel audit information */
 struct netlbl_audit {
-	u32 secid;
+	struct lsmblob blob;
 	kuid_t loginuid;
 	unsigned int sessionid;
 };
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 7f38dc9b6b57..7bac13ae07a3 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1534,14 +1534,11 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
-	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getlsmblob_subj(&blob);
-	/* scaffolding */
-	audit_info.secid = blob.scaffold.secid;
+	security_current_getlsmblob_subj(&audit_info.blob);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 3ed4fea2a2de..6cd1fcb3902b 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,10 +98,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
-				     &secctx,
-				     &secctx_len) == 0) {
+	if (lsmblob_is_set(&audit_info->blob) &&
+	    security_lsmblob_to_secctx(&audit_info->blob, &secctx,
+				       &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 40841d7af1d8..1a9639005d09 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,11 +32,7 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	struct lsmblob blob;
-
-	security_current_getlsmblob_subj(&blob);
-	/* scaffolding */
-	audit_info->secid = blob.scaffold.secid;
+	security_current_getlsmblob_subj(&audit_info->blob);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8..878fe44b662d 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -182,11 +182,9 @@ static inline void smack_catset_bit(unsigned int cat, char *catsetp)
  */
 static void smk_netlabel_audit_set(struct netlbl_audit *nap)
 {
-	struct smack_known *skp = smk_of_current();
-
 	nap->loginuid = audit_get_loginuid(current);
 	nap->sessionid = audit_get_sessionid(current);
-	nap->secid = skp->smk_secid;
+	nap->blob.smack.skp = smk_of_current();
 }
 
 /*
-- 
2.41.0

