Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918772F005B
	for <linux-security-module@vger.kernel.org>; Tue, 17 Jun 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194690; cv=none; b=ellrJInlzqS2x64V8CkeqJHt2OuUGnWGZicnKwMAs6SPjntT0WL8uumhflQUx/U815jEUupHGq7bwGUUBDNLFJNlVNKGYKvmbJ4vcri4zEOKxLIu1czc69KwxFBky6F1mhU+vjjIo4z6/z/kJdMFtpgXktR873b0uWS5QuEKkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194690; c=relaxed/simple;
	bh=3EF3D8lxhYBlqw7KGLuw5Y8urL6gCeC0wkh6ms1vr/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scKM4BdQ3f0IBOWeZ4mWuuiCJScT03KYn3qM2vGfPbscc1tz7eFk9dA2BX9EJqWPigkO8NYf/fJftxg98/kMXe8q+iZgpLl15rSlH4QPeB09UfMFhszBrWcdP8VxNgTSH6H0zJXVDxeC87hvoko/Q8t8sTl0cvsuKwda6RANoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uiPKWbwU; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uiPKWbwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750194682; bh=sI0i54Q4pL0t0o09OtuuQYl63AX6B0X/7Bb5sWduo1M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uiPKWbwUtdx8f2QfqK4xXW86h6N96YSeiWZafRIINUS3pGfjk/3ASz3MKHXK66WzyqZXBg6e7/c2l1B/UNIRt9mS5xPXBTweqMUzvmM5wOJluD63xImsvdAqjwnHt5wbx2mxMj9Py7b5Q3IVhILsyex/lccgooSRjXC+Q6d3rI7MDczcN3QKtOxNsjXzTxGbO6j1egFGcTvADY6SYmFsfAOh/G40qw6+5E4Jq3tSGDuldRaXlGdUHvTXj6lmwzB/zmmeNIqZdF/AUuw7VbXq8E5nxqZyzS+y6vMFsAMIVoCz+E4iQ4RtJjdIMhgQNiyQ3ZuZXf2xkvsxPuikKjkx4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750194682; bh=tdxPE/j8lmyB2NzzwXloufsAPkQ5f13ndc+yUd2kzQQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XyDpweqcrtzgL9A9CgPR3R/ekuBNbEL2ic0DOxxyfyPpBLqTrqHSHlKAe9Ehl/3BwEK7tIarb74ji9lqxVDYQ6hM5qAawJAo1Ad2Byp0PZXUwUtOI9+FGZ2BIxO/wbwgytj5iyyjOWSBOQ1SnBLjcPoWKPQZjzvNI63ButS79cL4mkYO3MrMLaKTUtvTzC0zoVb2LPSAaN02uO14rqim/gqNXry0Z2H1XgfvpURnljKgFXZElN4zpIA7/3J8hVMoHjwkuIl3IWQRzLr8pgV4eqmnsCOm8zMApoAStG5rc5lgjIdsjwxwjUiSEz6ElRr7C/UpBrsooNLjWzjdjVR/8w==
X-YMail-OSG: WVXAjfAVM1mkEldlz9wEfK0d10JfUleHyKeLmjZd6QENEv7lmiRyz3YOfgFj9Xu
 HAl2l7kyWjjAtoO8om1hY.GJ85uBqfbjROQcDRDUjjRmNZA4laSbFEVLP016xLB75WSPitfPb2VF
 uHst.xuFQZ2lJRIwmh67Ay91QtClcD1q3fuPwzRJtLDqPSFda1mPPm.cK8F2RmiohWezj1cxy_R7
 5Ki.iPOgzBOGENeP_1lyZaERQ0OqWsEKNU5CMd5DNtV7r0Tsz8E478mx4Ddv0ZuUn1eE5AEta_qK
 FjNeRJwc5tsumlvjmuM7G4yG77z5aVZ2q.YOoSESk77D9ecJHPXvfFMQIIjWsJOJFGftldWFONPG
 L7R0ve3Bwpb5OFcVPuZQ2iqNw0jPkDfbPGXen3BSBBSL_.VVrnOGjh37Qjggt2CbybclDnSj3pkn
 cQmDBezLbcZBGTtJ7KlKnPhBfYRW9.YrECyUWxA5KtZGjK0ef.si_lS1.Z08jsPJR8QOyHyS3gLp
 P6xl3FFYWjOK0Hexzl2pF8CKRts.u6kix3N._9.gT3AhSnUbchppMJjMQjsiDf38JI5Xp4DweoZI
 R397EBWQdalgs5EJ5P04yn98UDJ5erG51rI7Vq.RUAdz7kInhuACR7lVopmRiO_i3MdprO5k0A0d
 0tEq2R52KKYNXrIGd..0dQRPFAZUZhO3d7hItLUKU_LKztTAPQUlKkdYKCZLyUt5B5.Il_2W7iqq
 TaBF44oQM7kzgovSlCyth7PjmuIsmCVOO.m.YlPfcbLG7SL8qDF930TvJpSKnyhtEn2JFsb3gq59
 7rUvK0MVeX28EJNp.U3ugDR5m4027aw4xZl3XAK.vpAWl_0ZyN7xho8VnCsrQIG9.csOBOeQr7An
 Nj0bB__ExFsFHiFi0_D75.hI_WqqdG6EB0IZsrojcZZ_isj_HaSCqV7J4EQqtlA.bW8lPnpZCjYZ
 MuW2_U8pt9EA5E3RVdjIubkvW.eoBvQan3.zfL9ZY7fPr0xAqAH4lThdALOnUD9.4GCLBn5.X1Qn
 J0obV0U2hRkyNKJr0_ncSD87hlqDS.9mkA2OcF.sspcUjOnnDhWUuqNtxWrWZP6I0BXrW.NGS0_p
 C9MV5o3CHnIYZp4A261WnrxY8IX888MpRB3uo7ezj9USacR64er2QRZ9FEhqtyZdXKnJoU2Frklx
 NIVEdKhSX51akAcgArXhQ0c3Qn_KJ3Rh04zbglpGa5rannEftg.biICxX4LGlrbV7PRGXGlPPhOW
 vnP.NshYvSFOAt7wTFiD7lhPnexLLM17e8zbeDNFbp3.ZlVeB3LfFy6cH9KVZFG5ngEJipZRyLf1
 9qOd5s6wwKzkPHfzaJNmBQPDg_Z.oaFNqfsl6MC7_f3SgJHEHtb_ZdOp9s55PaqbE_4gYauK098G
 nImpzXhjiIq7ShHuviAEjxb7TrrN06cnluB0nNum31drhsOhX4gRWN7uXmJBd.l70YnpTQsUkhW5
 vS.zWKAvrEjCUNTVQzkFhAG3jPBarhW1nRxlUkI8uqy85FocGNVoMNWLumkVge5H4faPvWQqyidn
 qXp3x6yDXluGaZ7HMJgAOtd1YVcl3gCzncH4Af3p3cuD2lwk4TAMHjBnqvsuaRrQtxKCsZmzMbU6
 qT2cRpQgSjGmRZm6w43js9D.OqF1vQCxLPuW6ONyPdOSWD9C5NlKksTlbeWBQ9g0zURCnQhlG257
 A8F6n3uULS0T5sKSLXgFuh8YxJSspbUwpRqRSHCs13jnT7Wn6hmxlK5mV9Mxrklat0BkpCAzr1Bi
 6F9C73AaNKToQQhF8LJYQD0NOWPAl9sMe5Tdwqu6YbbGWbnBr.JxyTMeHApPf.5RhBXRDr2R1gBU
 ddGMgn5wxkflL128xzhGM7LMZn61e8SqwPdLUTJ6QGMtnWj1YldJ0cbSlWIkiLBbBf0D5SxasAFl
 Cz7EL828ucSjUL9YnHluf3fWURIcOFJ0Tx_C0mGeTgNWXodyRsSCNazw_me8Epo9AeFlIRg5Ygaq
 MTZQRGcXtgxYuCV4bq7ID9s2LGD91dSA4bmLkB0QNOj8tmcmWowSmqqKZ_nSAC6hSdiSR0v.T6Z.
 X8RRxmwVMtvp472J8gY3O88Uy_6e.U._kG8rGueGxaqYxeWXw8dQDvNHma66cHMN.9UdkyNHMqy6
 AKzZk5ErDIj8Lw37gdV.0SZ3KdIa_orHFCIzCvgJGvcK74fkpHcmNxiilYIiAfk.okBPI9y5xvCb
 WzRbwTkcYE3mpNe.eEOvTjgEr1.NCbHMyZHpF09bbU9qOr1jSg6M7spmQs7LqXz5Ztxzz_oOJzkj
 b.VVaHuVFiCB.eFl6tUqqo8ZBzLk-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bca69091-4de3-476a-9a95-1eb54be5ef1f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Jun 2025 21:11:22 +0000
Received: by hermes--production-gq1-74d64bb7d7-f4j4n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c2f63bee58180d330568dcd5f1b3323;
          Tue, 17 Jun 2025 21:01:12 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 2/3] LSM: allocate mnt_opts blobs instead of module specific data
Date: Tue, 17 Jun 2025 14:01:04 -0700
Message-ID: <20250617210105.17479-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250617210105.17479-1-casey@schaufler-ca.com>
References: <20250617210105.17479-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace allocations of LSM specific mount data with the
shared mnt_opts blob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/security.c        | 12 ++++++++++++
 security/selinux/hooks.c   | 10 +++++++---
 security/smack/smack_lsm.c |  4 ++--
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9741c76e4654..1871ebc5833b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -219,4 +219,5 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
 	return &xattrs[(*xattr_count)++];
 }
 
+extern void *lsm_mnt_opts_alloc(gfp_t priority);
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 8a4e0f70e49d..ec61fb7e6492 100644
--- a/security/security.c
+++ b/security/security.c
@@ -904,6 +904,18 @@ void security_sb_free(struct super_block *sb)
 	sb->s_security = NULL;
 }
 
+/**
+ * lsm_mnt_opts_alloc - allocate a mnt_opts blob
+ * @priority: memory allocation priority
+ *
+ * Returns a newly allocated mnt_opts blob or NULL if
+ * memory isn't available.
+ */
+void *lsm_mnt_opts_alloc(gfp_t priority)
+{
+	return kzalloc(blob_sizes.lbs_mnt_opts, priority);
+}
+
 /**
  * security_free_mnt_opts() - Free memory associated with mount options
  * @mnt_opts: LSM processed mount options
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 88cd1d56081a..f7eda0cce68f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2808,7 +2808,7 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
 		return 0;
 
-	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	opts = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!opts)
 		return -ENOMEM;
 
@@ -2830,8 +2830,12 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 	if (!src)
 		return 0;
 
-	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
-	return fc->security ? 0 : -ENOMEM;
+	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+	if (!fc->security)
+		return -ENOMEM;
+
+	memcpy(fc->security, src, sizeof(*src));
+	return 0;
 }
 
 static const struct fs_parameter_spec selinux_fs_parameters[] = {
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 44bd92410425..1d456df40096 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -622,7 +622,7 @@ static int smack_fs_context_submount(struct fs_context *fc,
 	struct smack_mnt_opts *ctx;
 	struct inode_smack *isp;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	fc->security = ctx;
@@ -673,7 +673,7 @@ static int smack_fs_context_dup(struct fs_context *fc,
 	if (!src)
 		return 0;
 
-	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
+	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!fc->security)
 		return -ENOMEM;
 
-- 
2.47.0

