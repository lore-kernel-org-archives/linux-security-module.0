Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71ACDF59
	for <linux-security-module@vger.kernel.org>; Sun,  9 Nov 2025 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716600; cv=none; b=nQMacunYUkPhjUyxNTDeJ98TjnFNgJATX7HjYsw8U6m26HQzcRSw695/5t8/S4fdVIs/HI/IXq9wR1w0QQuaxKqvkhZvoLkWN7VVVNrPn8QxnoB4cMe7QklWoh8YXw0eNNhgR6lXHoEOf+hMs7fDgICIpfoBh3O93WaKguQb4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716600; c=relaxed/simple;
	bh=2Xst/vWZRQfIbFdvs6RQj0nxTxusEJwKIpWE4GcmOGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/ofxngnwaNNstrnCi7O3k3MTn8d/8xQ+1b9+g0VOtxAJyPWteILM0PWC2SmcVV0SsgRioBt5hE9JyG7zl3kpt1rWD0eNJLHZwF1mAeZTdj52fQ18+izYNbVtiP1i2//yonroRNlrf/NF+xfasHQ77imJoFY5yyYV8eElOiuu6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAhCqmCT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAhCqmCT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7277324054so328172466b.0
        for <linux-security-module@vger.kernel.org>; Sun, 09 Nov 2025 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716597; x=1763321397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9X0WSsklw9i3/zTUnlpZxBFFs2Scnh3bG/4KsrRLjU=;
        b=KAhCqmCTYGO/XrxJpcJLJf2qXtmrbPP/ePbuHImOxqyqTzIq4zjUZYcEr00k39f8aD
         6kfWj5XSRBt7RiEpY0j9+ZL2Sjxeve6SwazpfZ/jugXbMIGXtFl01smiDpTZhJrgmMYm
         sIMQUt3Ba0otyvsHgyJ8Q4qynvUe2eTmxwwSNSQmNxpdaYM5UVwMhmAsuAySQqfiM5ro
         1b+zzM2Ej8wnbq5JF4cV7+IVDTs5BBIooQ/7AO041vFOtG5h6GMo/IsIAvWBp3Hhq9a0
         mxt0YPBcKzaPLME1eS/YE6yZ9Qqa89cXUAICLDxVVlRFpBfJEF+jYkUbN9HU245hLaf4
         fSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716597; x=1763321397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9X0WSsklw9i3/zTUnlpZxBFFs2Scnh3bG/4KsrRLjU=;
        b=jnVhwjfif43ILgsmYn6U2KhVjvhtEhUzbJmWZ0RNwlVSBEaCAuLLssA63CphHeHvad
         j1jewZ6wfntmDYHcujA6mjEFpZml+F/K98gUeEECtPXg1I8ogl2jwS0QcXlNfBK83Gzh
         J2uGwjXSU7+94BaUqnrJ57oki0mJ5+fuAr7bkSkUxTowtY/oLOpVF60Nh65u/NiyE2hc
         sMQphc+P2SiUpY+FE+800Skd/A2Esc+laG3N6Hu2Fgz4Ny3+nt1k2aZ/pxolZSnfLNuP
         vAbwdoAWJG4UNvrEuAYQaQPILKyJ64I1SDwQ5E0iSaRdFaxiH8R2cAM4+dTtkPKOdWSV
         eN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnPkv4SpaC/6l9/W5OTLkZdjK3eW9qAZmDa+D29xGCDb1iXKQivbvWUaHF4xzOwJare22P/BLjlF42KrLW4DiBYh1Q8+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuoIPnVZXlIGiYK7YcQXxdcnfY3Ouo40z9XccqTDmb4sTV3Z6N
	8ubAwOPJxSXg/+rx5iPJ7+Hm+NluK5EWs9smjkIw5y8j4vO20f/0OqGx
X-Gm-Gg: ASbGncv3hVuMfP743uO0cAvPDNm8RuhxWdLux9y6bBz+WIncOGpUK2G+VwRI5vsiGMn
	rTiH5OA4+Tuup7fJnkLWr3EKkvof32ITJLt6h0u4+FnigljZeI3UfkoJmdz90SjQsxBNHEcQ2Cd
	0sp/7t781ot+A9LuUovaVkf00DIL5NG6K5wLzsHqLyiejwQt8h1YqQpG8ng4VjqFZ8V1Cm4iVg2
	jT46pYOS9FH4obq30VqZV1mgpMbXBxl/Xlv3nHHlv6ztRN7KzWu1BttSbr5bv5rlgL9VJU3cjqv
	iQLeot8ECzaj1Jn2bStOy2vQW0dy56pyylAwi+bVzZ7jcH8e/bOlOz97ioL1VWzpV/vTwZpG5WT
	9J5Rkf9YMiGhSujGzmMZlrT4BeG+DG+hf/wHRLU4qt2XNwCOMls96q75vW+j87SHMfoILfXEQrC
	agbsw2/RK0glbGaW0fwn411M1iIhtj891wNCAX+ltY5wxMshMA
X-Google-Smtp-Source: AGHT+IHrgd/WaAUKtJjIV/YzPSmxInsoQ/OLnSUWlueNzR2NdCIJDhR+EncK1yoDmkljcZI8G1o0Fg==
X-Received: by 2002:a17:907:54e:b0:b72:ff9b:c68d with SMTP id a640c23a62f3a-b72ff9bca10mr145772966b.57.1762716597051;
        Sun, 09 Nov 2025 11:29:57 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9be2eesm875278766b.63.2025.11.09.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:29:56 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: paul@paul-moore.com
Cc: casey@schaufler-ca.com,
	keescook@chromium.org,
	song@kernel.org,
	andrii@kernel.org,
	kpsingh@kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] security: provide an inlined static branch for security_inode_permission()
Date: Sun,  9 Nov 2025 20:29:40 +0100
Message-ID: <20251109192940.1334775-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine is executing for every path component during name resolution in
vfs and shows up on the profile to the tune of 2% of CPU time in my
tests.

The only LSMs which install hoooks there are selinux and smack, meaning
most installs don't have it and this ends up being a call to do nothing.

While perhaps a more generic mechanism covering all hoooks would be
preferred, I implemented a bare minimum version which gets out of the
way for my needs.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/security.h | 11 ++++++++++-
 security/security.c      | 12 ++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 92ac3f27b973..0ce1d73167ed 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,6 +68,8 @@ struct watch;
 struct watch_notification;
 struct lsm_ctx;
 
+DECLARE_STATIC_KEY_FALSE(security_inode_permission_has_hooks);
+
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
 /* If capable should audit the security request */
@@ -421,7 +423,14 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 int security_inode_readlink(struct dentry *dentry);
 int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 			       bool rcu);
-int security_inode_permission(struct inode *inode, int mask);
+int __security_inode_permission(struct inode *inode, int mask);
+static inline int security_inode_permission(struct inode *inode, int mask)
+{
+	if (static_branch_unlikely(&security_inode_permission_has_hooks))
+		return __security_inode_permission(inode, mask);
+	return 0;
+}
+
 int security_inode_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr);
 void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
diff --git a/security/security.c b/security/security.c
index 4d3c03a4524c..e879f034a77c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -51,6 +51,8 @@ do {						\
 
 #define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
 
+DEFINE_STATIC_KEY_FALSE(security_inode_permission_has_hooks);
+
 /*
  * These are descriptions of the reasons that can be passed to the
  * security_locked_down() LSM hook. Placing this array here allows
@@ -639,6 +641,12 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		lsm_static_call_init(&hooks[i]);
 	}
 
+	if (static_key_enabled(&static_calls_table.inode_permission->active->key)) {
+		if (!static_key_enabled(&security_inode_permission_has_hooks.key)) {
+			static_branch_enable(&security_inode_permission_has_hooks);
+		}
+	}
+
 	/*
 	 * Don't try to append during early_security_init(), we'll come back
 	 * and fix this up afterwards.
@@ -2343,7 +2351,7 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 }
 
 /**
- * security_inode_permission() - Check if accessing an inode is allowed
+ * __security_inode_permission() - Check if accessing an inode is allowed
  * @inode: inode
  * @mask: access mask
  *
@@ -2356,7 +2364,7 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_inode_permission(struct inode *inode, int mask)
+int __security_inode_permission(struct inode *inode, int mask)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-- 
2.48.1

