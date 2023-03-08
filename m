Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A9C64EC4
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Mar 2023 18:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCHSbo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCHSbn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Mar 2023 13:31:43 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261BFBD7B8
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 10:31:42 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c3so19092473qtc.8
        for <linux-security-module@vger.kernel.org>; Wed, 08 Mar 2023 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678300301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcDeU7vO7AEyrmp7TSA7boktjZz0kH16sEiBmyW+prk=;
        b=I3pR8zAuqotmc6OFZFk0CT89UMvxMZWP9hd9cgLVHYcmL3E017GJ4wDwiCfn6KgWtS
         uweLrM0RVUrK5r29fU+nyb/fcqqIsU+g81UMlnjmUKJCsw7il8MHILDNQyhpumLxFstB
         FImE3M8Lt0hAHH87EZD4A71e1l37FpODqPYoj+kdzoSH1d9REs/+ofljlebSOmT+buVN
         zAeryeXymuo0Gv5NXYAOEVtegQOPKiGIKUOkI9atAPSPaqsTvbZRu9pzGEA7z+NAxs+L
         OmOkmo7DEm+ceR7MkCDh91mggcU25E8vJNcvg7wh8CpjpZC2+MCALgk3bl5o+IVwMQI1
         gUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678300301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcDeU7vO7AEyrmp7TSA7boktjZz0kH16sEiBmyW+prk=;
        b=jHWB19r04r89tOBWN8cNoIUki7DWOTNF6wsJaXd90KGJx4iPIpv0e16FmoapJPyaEj
         ByWyWqfRZU5FPUNYxBkkiYR6+ph/wfowN0wQulIqwJufjI4HUer0raIJDDRDpBvFn2Lf
         Y7JEwkB3ZSWCt3VKeV3xOzxre7QxmVitcjfZ/vOdv/bLXyDFwGvV9d4NS7Ka9XGo+WZ4
         VVcvoLYHE5VJydleVfagx2rALqKI5mYZFIYz2Qg329dkMUz2zfXBkoE+vR1TJHPKe/NV
         3g1qftZi6PauBVWkOHUXPCnEsqxT0JFQy8dM/BmghxHyivdB7nXCbvL+jIL97yCG0tE5
         bw1Q==
X-Gm-Message-State: AO0yUKW9/keH1eEejlipRvG1/WdAUUkaOsU4uBM/Yn5fewhRHGz0msiZ
        ncLp0h9loskxISZdSXKo+hs12xlto+NoIWfX1Q==
X-Google-Smtp-Source: AK7set8VXDry4mMKKPgGNnWRHYgk5wsMJMhRA17NFUdO0Cdj+g5hEjmQvEaWyV6E8jo6nFGtkh0ohA==
X-Received: by 2002:ac8:7d86:0:b0:3bf:d993:f3aa with SMTP id c6-20020ac87d86000000b003bfd993f3aamr33070284qtd.35.1678300300764;
        Wed, 08 Mar 2023 10:31:40 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id w19-20020ac843d3000000b003bfbf3afe51sm11944856qtn.93.2023.03.08.10.31.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:31:40 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: fix a badly named parameter in security_get_getsecurity()
Date:   Wed,  8 Mar 2023 13:31:39 -0500
Message-Id: <20230308183139.201496-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

There is no good reason for why the "_buffer" parameter needs an
underscore, get rid of it.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hook_defs.h |  2 +-
 security/security.c           | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 094b76dc7164..6bb55e61e8e8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -381,7 +381,7 @@ LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
 LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
 LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
 	 enum key_need_perm need_perm)
-LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **_buffer)
+LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
diff --git a/security/security.c b/security/security.c
index 4c39cfe313bf..e6c275fff001 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4981,20 +4981,20 @@ int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 /**
  * security_key_getsecurity() - Get the key's security label
  * @key: key
- * @_buffer: security label buffer
+ * @buffer: security label buffer
  *
  * Get a textual representation of the security context attached to a key for
  * the purposes of honouring KEYCTL_GETSECURITY.  This function allocates the
  * storage for the NUL-terminated string and the caller should free it.
  *
- * Return: Returns the length of @_buffer (including terminating NUL) or -ve if
+ * Return: Returns the length of @buffer (including terminating NUL) or -ve if
  *         an error occurs.  May also return 0 (and a NULL buffer pointer) if
  *         there is no security label assigned to the key.
  */
-int security_key_getsecurity(struct key *key, char **_buffer)
+int security_key_getsecurity(struct key *key, char **buffer)
 {
-	*_buffer = NULL;
-	return call_int_hook(key_getsecurity, 0, key, _buffer);
+	*buffer = NULL;
+	return call_int_hook(key_getsecurity, 0, key, buffer);
 }
 #endif	/* CONFIG_KEYS */
 
-- 
2.39.2

