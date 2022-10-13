Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56603C43217
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Oct 2022 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJMWhP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Oct 2022 18:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJMWhI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Oct 2022 18:37:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7826153826
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 15:37:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l4so3092677plb.8
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsVURujdxv2TmCZAOzBG5PyJ5Db0orOcMu9GXfW9Fck=;
        b=Q6uQT6cZ6HlnR383h6WH/uQ3S8aFq0qFNpnMDAPTNxVKhhUPExQlulnkpOZFEcG4DO
         rkvGu+fypFN8ukziyyJYzxxpoBTmyy1iUMJDn54cWfAj/wTnNaO3mMX3ID9iCOFpoe8X
         RsBJfdcTkFBtAvNEDyiSrCSfUxIE9g7TpRhNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsVURujdxv2TmCZAOzBG5PyJ5Db0orOcMu9GXfW9Fck=;
        b=jvYPE+R19UB8ydc5Hehqh8JRapcOA5HcNlTdIX47ZX5bB8as+f9ZFDc/adfJxka+83
         jTt2rxv6B7QQGeAyf5UK3iyVHdPCQhAEoUvJyjT4AS1WAbxHiujv/BZ45p5SlJVTnufC
         rIN0kzf8DNgBQHc5N56FWgA7L7FfzGE9Tm7olX8A9YwCYv3L7gHREMpR90256pJkHAxx
         2Ib614ow3puUUfk5qO7ez5fws3lW4L3uLHRzzWk+AkSscLpLGNoWd2azwiM0RzqV0ozM
         lquu27tVdYov/a8ARl+gk9ZoLc8INQbqve4c6zV0LpEu86yYTZjW6ocyQyzTRqQQrJm8
         ejOA==
X-Gm-Message-State: ACrzQf1HwmZS7nqAM2wEek7y0noWbqCWv/JodYRJaWwYM8PusKiIMk1C
        hJIxMm84dIyHygNubZU7NV8Rvw==
X-Google-Smtp-Source: AMsMyM7imnz6ZZQ3TevCrG0iuI2bK+HUr3oLsWudqm7wRbi/ZzdALNZlnC9CYelAiPLCRmpxIoMRsw==
X-Received: by 2002:a17:902:da90:b0:17e:c64c:99c2 with SMTP id j16-20020a170902da9000b0017ec64c99c2mr1943103plx.85.1665700621712;
        Thu, 13 Oct 2022 15:37:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090ab38200b0020aaa678098sm234714pjr.49.2022.10.13.15.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:37:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Takashi Iwai <tiwai@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 5/9] LSM: Introduce inode_post_setattr hook
Date:   Thu, 13 Oct 2022 15:36:50 -0700
Message-Id: <20221013223654.659758-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7546; h=from:subject; bh=Xca597ImY3Tk10E6V1MSqwTfNHEUXjfa0mP2kJeVjWU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMESltMyWfjIAxwaRChBzXRUlWazuBJOtIDnt/w 1MfQKfKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBAAKCRCJcvTf3G3AJvKrEA Cv4dUFIPRnCesIjZqkLeNcMzFfxbwiPE1sa41CkqiusWgCWPpw9xThOQPNFPRXFGxfmAC4WWW1s8Pg Egp8ySPdL2Z2ZoFWspeAtEgLvpvnmuRcX6fwwpY2ScnK5la6MfxFZkePaPw3Id+v98xX/AHDV1pWNb vs8AhqXnNpd3RRPq/KFMBRDfTo+AzEHouQwqd5mlYQASMCBHJoRkJEAzhRhKOAbNE8Un0qFFOJM127 f+ack2Ke7ExNavXK4FkwW2up2biDDSZlkFUKz7WtrVP+2dS2WsYjcjfUfjUvXLm2fuSJyTDpyYSnZg W1Vs4h3zeVaiPxoX+hqHJml8C9VfVSJ9TyAL9EnML3kB6wPrlAYaqYr/P4FBqsahnbuK/7vQT0Qs/F 2KI+L2CxqiFt0ts5Kh7SShJDqx8Dm/dCYydir3f9GaGEb6RkbgNa8H7dBgr9Tlen2YDZSz3/wB/V3p r9zop5w9BfLKWggfjpWH9k4e6NNtTN7hk1PuK/D+wMADD2V6v6bJl59WNYw1ImFIlznT+6PlF00Wah zmdHVen0w0epT+QxM9hC6wN3T/hhqp0jbalmg2KFioZBCZzR3xgqQpLeWgKM3lmcI7hv1IJ2iN7MQq ScwM1fPFxBDOAqCV+moVHEi1Vs8HGXUZc8I8Xrbi4Dx7pg5pfU3LkeZ3D/eg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

IMA and EVM need to hook after setattr finishes. Introduce this hook and
move IMA and EVM's open-coded stacking to use it.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/attr.c                             |  3 +--
 include/linux/evm.h                   |  6 ------
 include/linux/ima.h                   |  9 ---------
 include/linux/lsm_hook_defs.h         |  3 +++
 security/integrity/evm/evm_main.c     | 10 +++++++++-
 security/integrity/ima/ima.h          |  2 ++
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     |  1 +
 security/security.c                   |  8 ++++++++
 9 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 1552a5f23d6b..e5731057426b 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -423,8 +423,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
-		ima_inode_post_setattr(mnt_userns, dentry);
-		evm_inode_post_setattr(dentry, ia_valid);
+		security_inode_post_setattr(mnt_userns, dentry, ia_valid);
 	}
 
 	return error;
diff --git a/include/linux/evm.h b/include/linux/evm.h
index aa63e0b3c0a2..53f402bfb9f1 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -23,7 +23,6 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     struct integrity_iint_cache *iint);
 extern int evm_inode_setattr(struct user_namespace *mnt_userns,
 			     struct dentry *dentry, struct iattr *attr);
-extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
 extern int evm_inode_setxattr(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, const char *name,
 			      const void *value, size_t size);
@@ -75,11 +74,6 @@ static inline int evm_inode_setattr(struct user_namespace *mnt_userns,
 	return 0;
 }
 
-static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
-{
-	return;
-}
-
 static inline int evm_inode_setxattr(struct user_namespace *mnt_userns,
 				     struct dentry *dentry, const char *name,
 				     const void *value, size_t size)
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 9f18df366064..70180b9bd974 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -127,20 +127,11 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
-extern void ima_inode_post_setattr(struct user_namespace *mnt_userns,
-				   struct dentry *dentry);
 #else
 static inline bool is_ima_appraise_enabled(void)
 {
 	return 0;
 }
-
-static inline void ima_inode_post_setattr(struct user_namespace *mnt_userns,
-					  struct dentry *dentry)
-{
-	return;
-}
-
 #endif /* CONFIG_IMA_APPRAISE */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 806448173033..0b01473eee8a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -135,6 +135,9 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 	 bool rcu)
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
 LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr,
+	 struct user_namespace *mnt_userns, struct dentry *dentry,
+	 unsigned int ia_valid)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
 LSM_HOOK(int, 0, inode_setxattr, struct user_namespace *mnt_userns,
 	 struct dentry *dentry, const char *name, const void *value,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 1ef965089417..aca689dc0576 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -817,7 +817,9 @@ int evm_inode_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+static void evm_inode_post_setattr(struct user_namespace *mnt_userns,
+				   struct dentry *dentry,
+				   unsigned int ia_valid)
 {
 	if (!evm_revalidate_status(NULL))
 		return;
@@ -905,6 +907,12 @@ static int __init init_evm(void)
 
 late_initcall(init_evm);
 
+static struct security_hook_list evm_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(inode_post_setattr, evm_inode_post_setattr),
+};
+
 void __init integrity_lsm_evm_init(void)
 {
+	pr_info("Integrity LSM enabling EVM\n");
+	integrity_add_lsm_hooks(evm_hooks, ARRAY_SIZE(evm_hooks));
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 15a369df4c00..5c95ea6e6c94 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -176,6 +176,8 @@ int ima_inode_setxattr(struct user_namespace *mnt_userns,
 		       int flags);
 int ima_inode_removexattr(struct user_namespace *mnt_userns,
 			  struct dentry *dentry, const char *xattr_name);
+void ima_inode_post_setattr(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, unsigned int ia_valid);
 #endif
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ddd9df6b7dac..ccd54b50fe48 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -631,7 +631,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * to lock the inode's i_mutex.
  */
 void ima_inode_post_setattr(struct user_namespace *mnt_userns,
-			    struct dentry *dentry)
+			    struct dentry *dentry, unsigned int ia_valid)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct integrity_iint_cache *iint;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 94379ba40b58..ffebd3236f24 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1093,6 +1093,7 @@ static struct security_hook_list ima_hooks[] __lsm_ro_after_init = {
 #ifdef CONFIG_IMA_APPRAISE
 	LSM_HOOK_INIT(inode_setxattr, ima_inode_setxattr),
 	LSM_HOOK_INIT(inode_removexattr, ima_inode_removexattr),
+	LSM_HOOK_INIT(inode_post_setattr, ima_inode_post_setattr),
 #endif
 };
 
diff --git a/security/security.c b/security/security.c
index ca731132a0e9..af42264ad3e2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1333,6 +1333,14 @@ int security_inode_setattr(struct user_namespace *mnt_userns,
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
+void security_inode_post_setattr(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, unsigned int ia_valid)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_setattr, mnt_userns, dentry, ia_valid);
+}
+
 int security_inode_getattr(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
-- 
2.34.1

