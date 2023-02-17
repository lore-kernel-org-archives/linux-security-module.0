Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A88C636D4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBQD0f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBQD0d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABE4BEA8
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:32 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s22so58084qtw.11
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENbnQ+kzWqQkhQbwpFGeWjy1AoNkiavZM84Pz0J1QCc=;
        b=SSd6GeRncHUdasPtk950vg/P8/w7WnhUWjSKj2a2X9v9fAm0itn3Sxd7KxLfH+L9mx
         bZbC7kdG3r8QklNxErd05Swp144x5yaUhgUymV6fuptYKFW4X9aSp5ENznFxq+NEevyl
         17uHKUjyv5JXYrXbsMWhZEafUKw+pJp9LZA7VSLxd8w9q9Mb2j28KuYsbYjbetDTg5Gz
         BXD8LB/L8tm5KXSZcwj4cMCxA0YgnBdzrf+OhwE6o1e8UV3zVgV7QZ6YnIYcfSQL9GBw
         NoKicpF5+NzsW1cKcvfGx/NRz8tVLhwGp7z6xHCaHTz2eOPAbjCW8Pawtf4SCb24qvCJ
         dRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENbnQ+kzWqQkhQbwpFGeWjy1AoNkiavZM84Pz0J1QCc=;
        b=Id91UZT3/1b3pO+iTqQycKepBI/ORqJ/S+IZu0gJdDFUykRiNw0V4BYqZ9WbfWGqrt
         MY+CF6M5t6ksxYrmRw6ZxazIKF9p7Y+c7c1/T1IsmfIlhJSDu4SGS9XHj3LojlIUMjfY
         MC0rH1+kJQAw563IXEC/Ai0IUYzJXiK1gLsOZrf95gfmFnEj5JLjgcPcJw90R8zL5q0V
         fXcnzQ6kLPFGasIoFMZp9TScfTGdceGC9dwgXLXPOpQdr8ZfaomS6o+5mMwCZg0paoXB
         UviUVaE++j4gX+Fij6oYI7aL/SsH+GAxrLiCjq+t0qcMkiQ1HeDr9HS3V8cYUigAsw/Z
         Cifg==
X-Gm-Message-State: AO0yUKXmYD+xFDqeJ8m5KXC8iRZpBMlbhctpa2Tns4beujvY6ke1XDxc
        rk+2nraHOeZOb79fIDrwp5ui4nXGszQ79c4=
X-Google-Smtp-Source: AK7set/zEe7/df86WS63uK67jvjQVF9ZrQxptq43rgg3p3VFx3L40rG4Ccwqlg0czsC/IK+83AdDqw==
X-Received: by 2002:a05:622a:194:b0:3ab:d932:6c4e with SMTP id s20-20020a05622a019400b003abd9326c4emr13791851qtw.18.1676604391359;
        Thu, 16 Feb 2023 19:26:31 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id 13-20020ac8564d000000b003afbf704c7csm1334663qtt.24.2023.02.16.19.26.30
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:30 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 02/22] lsm: move the fs_context hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:05 -0500
Message-Id: <20230217032625.678457-3-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h | 17 -----------------
 security/security.c       | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 24c242713a44..84afd93b878f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,23 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for mount using fs_context.
- *	[See also Documentation/filesystems/mount_api.rst]
- *
- * @fs_context_dup:
- *	Allocate and attach a security structure to sc->security.  This pointer
- *	is initialised to NULL by the caller.
- *	@fc indicates the new filesystem context.
- *	@src_fc indicates the original filesystem context.
- *	Return 0 on success or a negative error code on failure.
- * @fs_context_parse_param:
- *	Userspace provided a parameter to configure a superblock.  The LSM may
- *	reject it with an error and may use it for itself, in which case it
- *	should return 0; otherwise it should return -ENOPARAM to pass it on to
- *	the filesystem.
- *	@fc indicates the filesystem context.
- *	@param The parameter.
- *
  * Security hooks for filesystem operations.
  *
  * @sb_alloc_security:
diff --git a/security/security.c b/security/security.c
index 9e98f6703e18..3170df73a7cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -979,11 +979,34 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+/**
+ * security_fs_context_dup() - Duplicate a fs_context LSM blob
+ * @fc: destination filesystem context
+ * @src_fc: source filesystem context
+ *
+ * Allocate and attach a security structure to sc->security.  This pointer is
+ * initialised to NULL by the caller.  @fc indicates the new filesystem context.
+ * @src_fc indicates the original filesystem context.
+ *
+ * Return: Returns 0 on success or a negative error code on failure.
+ */
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 {
 	return call_int_hook(fs_context_dup, 0, fc, src_fc);
 }
 
+/**
+ * security_fs_context_parse_param() - Configure a filesystem context
+ * @fc: filesystem context
+ * @param: filesystem parameter
+ *
+ * Userspace provided a parameter to configure a superblock.  The LSM can
+ * consume the parameter or return it to the caller for use elsewhere.
+ *
+ * Return: If the parameter is used by the LSM it should return 0, if it is
+ *         returned to the caller -ENOPARAM is returned, otherwise a negative
+ *         error code is returned.
+ */
 int security_fs_context_parse_param(struct fs_context *fc,
 				    struct fs_parameter *param)
 {
-- 
2.39.2

