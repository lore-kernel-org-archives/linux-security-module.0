Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57139C636D4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBQD0o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjBQD0i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:38 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4A59726
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:37 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e26so59674qtq.6
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6ARFBhGfk/ZcxahWJXYEpBZngygyvEk1kMSYDeZduw=;
        b=eEiTaju20pS7D4iOs3QAjVZYQIEhixUZIuH8C1Oa6KSkJ+HcR3OpDvC+IUib/zWTQ8
         ALBqE7H39d4fAb4tLC+uSLoWoJXTr5FnCVPGK3RiAfBWz8JTpAxITOK2vX3stHHfrStt
         tBg/Zlj7ZcUsQgZ8gUCHo+MRmkgSlNU5E+hJv/lJFmg2UElwNLAhKUI/Bc4ZcbN5FjEW
         YDuZQmrBdeWGS9mcJUIsXpBHDeh3Kveq2qfhYKTpo/x2J75VtTw5H+JeAs9Mliqv4ce8
         aZWOzYh6H6r8Fr1/yVFvHL43PnIQ8rjszgNLQ/Pl521vKcc9vCdi02QmRzCV7rL0cEb0
         Pk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6ARFBhGfk/ZcxahWJXYEpBZngygyvEk1kMSYDeZduw=;
        b=HbP8GGml6mw/tr29NRJ3QnQKQF838oKewWke7yloVSAK5D5eYc7j6+MznrsIdMIW53
         DGwzH08iqWQB2R/c4a65BxAfK1d1Bl5ZDI3WmWD/vgf5zVA7qm0owKxJgbaiVV/yl9Yf
         BmaIBZL0v4mJWBIzWhMFZO80nV6r5sydLXx6a6cKXcq1KJ6sUdzAqjhEI+mOo7d73a2K
         7wqsOQpZe2eyid3smb1L/khzm8mdc8qtyUf+JUIjB/sGXXeiMsOVhLdKfBANtr/r+WKw
         EwVAiJlrEnCvM1ZD8uBitb3uOMEV8maXVsqF77zKis2TZB0Lv7aa+EYJDVdBc9sPOepl
         PfQA==
X-Gm-Message-State: AO0yUKWkvGH62K1FqPsXFC5W9XjeLc0yeK3Hqy+QBmdf5/CSN/uxhWs4
        alHl9LSaRKp8cbfj79WshSQE/BkfLTjqvQo=
X-Google-Smtp-Source: AK7set8JPEGg99sdM94LvpztpKzCuABne/ylZGWxvOXL1GpsjHJft6x5ItFXlIhQMpXhkrpaTX5xfg==
X-Received: by 2002:ac8:578e:0:b0:3af:4d45:b73 with SMTP id v14-20020ac8578e000000b003af4d450b73mr15150401qta.33.1676604395335;
        Thu, 16 Feb 2023 19:26:35 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id z20-20020ac84314000000b003b630456b8fsm2427668qtm.89.2023.02.16.19.26.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:34 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 05/22] lsm: move the kernfs hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:08 -0500
Message-Id: <20230217032625.678457-6-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h |  9 ---------
 security/security.c       | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3cdd58424796..c953f6c356f2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,15 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for kernfs node operations
- *
- * @kernfs_init_security:
- *	Initialize the security context of a newly created kernfs node based
- *	on its own and its parent's attributes.
- *	@kn_dir the parent kernfs node.
- *	@kn the new child kernfs node.
- *	Return 0 if permission is granted.
- *
  * Security hooks for file operations
  *
  * @file_permission:
diff --git a/security/security.c b/security/security.c
index 8195f4e7293e..aae94d3d531d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2344,6 +2344,16 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+/**
+ * security_kernfs_init_security() - Init LSM context for a kernfs node
+ * @kn_dir: parent kernfs node
+ * @kn: the kernfs node to initialize
+ *
+ * Initialize the security context of a newly created kernfs node based on its
+ * own and its parent's attributes.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn)
 {
-- 
2.39.2

