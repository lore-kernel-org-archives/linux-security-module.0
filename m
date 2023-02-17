Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B792C636D7
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBQD1B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBQD0y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:54 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2759731
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:48 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id b21so4247752qtr.13
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l941xZLUa3StD56ZJmY0zkFqLlRGjjOVeTEPQ20n3vs=;
        b=eRHx8jDqnIcPXybD5LpUKsCI0ZKpGyK9cZQPc3tM/eNJQcvHE/25DHymDS1KpeqGOT
         dYpDqnJL+O70LBXQBbSfNPfBmiLno9Qty8fLLWSmeHqVhClAR3QluHNOumMHKe6WXXLH
         7vlISXugywqhwDbAiZu41KttVsLZfWXV7dnCc9G9LaHprzRfJLZJAIyVi8/xwJJvA2MT
         d6DnR/v96+k5dlz+OlBVtqGWWScQ6e0SO+bV85Z8IM/nheZloxJkepxITxD3gmhWt4SQ
         o6wbTdNCSkwVhdyR8RBHD7iY5San//Yy5kmsgYZ0z29Yxsvv61TZx0Df8JkTtuZW61H7
         L+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l941xZLUa3StD56ZJmY0zkFqLlRGjjOVeTEPQ20n3vs=;
        b=WZwiZ+NWCLIHHF0b6eT7p0qW/JmutS99vZB2Mlx0q4MUquriYEc3HVSI6Ka54RsUZm
         hV6wFcWR5Q9InIhF2I4+CjPOcSsmf3OhXQ8HmgBr6R9Zan4aDoKF2R/navXA+FoUt1G0
         RVVGwkKnlIIJUPGqqSewxyB1vHtizbP93k34rLEL1q8j+Vbhw5N1jWTajbAZLM9sOPAo
         Ui2XB+2+OVXwsAU+/iHJivAHegJs0o7602udTjo2FmGQbfodlB5uThtBklUMg7PShPuQ
         Dm3L+hZOISI/YsR11epVQkLNt42vTZlqvhikszrFtTZiKwq4MjoFnvNU5zwMj8D1baIe
         eyEg==
X-Gm-Message-State: AO0yUKXYk2nnEH6RpIDr5zNM3AAn6GQUd+LcNsHrXXLFfWYSeOxZ22FS
        d1ABwi17GUnXSBwV6uD19JYynnRdD1vSUdY=
X-Google-Smtp-Source: AK7set+ePfaO5feU7SsoOUV51735wGCSgsHQ56ghRmvUEsjE3kQfJKlhEN2u7ajvvnEb1cM7RP1PAQ==
X-Received: by 2002:ac8:5c0e:0:b0:3bd:d8f:2d79 with SMTP id i14-20020ac85c0e000000b003bd0d8f2d79mr6291940qti.64.1676604407706;
        Thu, 16 Feb 2023 19:26:47 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id 196-20020a3707cd000000b0073ba97eb13csm489832qkh.50.2023.02.16.19.26.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:46 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 14/22] lsm: move the key hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:17 -0500
Message-Id: <20230217032625.678457-15-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 32 -------------------------------
 security/security.c       | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9c5254e4e9d1..2cfa56e3abc3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,38 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks affecting all Key Management operations
- *
- * @key_alloc:
- *	Permit allocation of a key and assign security data. Note that key does
- *	not have a serial number assigned at this point.
- *	@key points to the key.
- *	@flags is the allocation flags.
- *	Return 0 if permission is granted, -ve error otherwise.
- * @key_free:
- *	Notification of destruction; free security data.
- *	@key points to the key.
- *	No return value.
- * @key_permission:
- *	See whether a specific operational right is granted to a process on a
- *	key.
- *	@key_ref refers to the key (key pointer + possession attribute bit).
- *	@cred points to the credentials to provide the context against which to
- *	evaluate the security data on the key.
- *	@perm describes the combination of permissions required of this key.
- *	Return 0 if permission is granted, -ve error otherwise.
- * @key_getsecurity:
- *	Get a textual representation of the security context attached to a key
- *	for the purposes of honouring KEYCTL_GETSECURITY.  This function
- *	allocates the storage for the NUL-terminated string and the caller
- *	should free it.
- *	@key points to the key to be queried.
- *	@_buffer points to a pointer that should be set to point to the
- *	resulting string (if no label or an error occurs).
- *	Return the length of the string (including terminating NUL) or -ve if
- *	an error.
- *	May also return 0 (and a NULL buffer pointer) if there is no label.
- *
  * Security hooks affecting all System V IPC operations.
  *
  * @ipc_permission:
diff --git a/security/security.c b/security/security.c
index f06b95a9705c..cc2294e094ec 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4467,23 +4467,63 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 
 #ifdef CONFIG_KEYS
 
+/**
+ * security_key_alloc() - Allocate and initialize a kernel key LSM blob
+ * @key: key
+ * @cred: credentials
+ * @flags: allocation flags
+ *
+ * Permit allocation of a key and assign security data. Note that key does not
+ * have a serial number assigned at this point.
+ *
+ * Return: Return 0 if permission is granted, -ve error otherwise.
+ */
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
 	return call_int_hook(key_alloc, 0, key, cred, flags);
 }
 
+/**
+ * security_key_free() - Free a kernel key LSM blob
+ * @key: key
+ *
+ * Notification of destruction; free security data.
+ */
 void security_key_free(struct key *key)
 {
 	call_void_hook(key_free, key);
 }
 
+/**
+ * security_key_permission() - Check if a kernel key operation is allowed
+ * @key_ref: key reference
+ * @cred: credentials of actor requesting access
+ * @need_perm: requested permissions
+ *
+ * See whether a specific operational right is granted to a process on a key.
+ *
+ * Return: Return 0 if permission is granted, -ve error otherwise.
+ */
 int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 			    enum key_need_perm need_perm)
 {
 	return call_int_hook(key_permission, 0, key_ref, cred, need_perm);
 }
 
+/**
+ * security_key_getsecurity() - Get the key's security label
+ * @key: key
+ * @buffer: security label buffer
+ *
+ * Get a textual representation of the security context attached to a key for
+ * the purposes of honouring KEYCTL_GETSECURITY.  This function allocates the
+ * storage for the NUL-terminated string and the caller should free it.
+ *
+ * Return: Returns the length of @buffer (including terminating NUL) or -ve if
+ *         an error occurs.  May also return 0 (and a NULL buffer pointer) if
+ *         there is no security label assigned to the key.
+ */
 int security_key_getsecurity(struct key *key, char **_buffer)
 {
 	*_buffer = NULL;
-- 
2.39.2

