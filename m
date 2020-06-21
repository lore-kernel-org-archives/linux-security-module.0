Return-Path: <SRS0=caJR=AC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4941C433E0
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Jun 2020 22:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D5A24825
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Jun 2020 22:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a89qNGlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFUWVm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgFUWVm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Jun 2020 18:21:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFAC061794
        for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2020 15:21:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so1410143wml.3
        for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2020 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcxfYlAyKzbITdSbFArzA2umqb7j1yl/HuXhhiSDWMM=;
        b=a89qNGlRNmNNNIPKu7EIHagX5mdQzBSxnYrV/zChfLnMlFSPXSzMPmDWl39DcPMLrU
         tGKk1mBkfW+78JxrtnG24tyNRhwQTUebFotv9ur4f+f04Nkcw4nhb3Qn/fl30t0MbJ8r
         U5V1+mBMZBSElcmF5STvUO47mAX3euxFVJKTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcxfYlAyKzbITdSbFArzA2umqb7j1yl/HuXhhiSDWMM=;
        b=D4MwTP/9hrRSeawZ1BVpi3x7iETdgBOyWw1pXQl1G+Vq3SRNX3dMxc1luaZmnxtzvZ
         ISHgMq1QW8Cgf5hl98mV/5DPA3h8lML1R55OdvWnj9l1lBu2GVV0OtihPGhtAL8DSFRw
         XK9xMR3XZ6MEEFto+r4PvYux5fJvTseXEixIfvRorW2Fl1HF2KExPhawM/bXJLqNMRvG
         63Cn1v6E3DGRV6+ta3YiVDF1vjhOjhnwGBf2Ze0yyPaXWDAOGlAQj6fjtXAT+lnTDNg3
         CDeHlk+P6oxn/rCmFkau7UQpb6DPq0fgxgEavhUOtCaJpVtrsre/ZAjKSyBh/Zxliix0
         2/yw==
X-Gm-Message-State: AOAM532WoXkVdd4PzZClkAmnskiMj2oayg1zp4yZRN2Fic3qRWhCGu1l
        nfWEktoaAbm5rjDM4EJo8iO2OQ==
X-Google-Smtp-Source: ABdhPJyawXdwUDr2apHIXHwsbzgybV9TIbkv/UlOjUZZRmH3JVPJoMesK5eIu0YntqTgef+D0vJGFQ==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr4047196wmj.115.1592778100686;
        Sun, 21 Jun 2020 15:21:40 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id f2sm13936251wmj.39.2020.06.21.15.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 15:21:40 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>
Subject: [PATCH] security: Fix hook iteration and default value for inode_copy_up_xattr
Date:   Mon, 22 Jun 2020 00:21:35 +0200
Message-Id: <20200621222135.9136-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

inode_copy_up_xattr returns 0 to indicate the acceptance of the xattr
and 1 to reject it. If the LSM does not know about the xattr, it's
expected to return -EOPNOTSUPP, which is the correct default value for
this hook. BPF LSM, currently, uses 0 as the default value and thereby
falsely allows all overlay fs xattributes to be copied up.

The iteration logic is also updated from the "bail-on-fail"
call_int_hook to continue on the non-decisive -EOPNOTSUPP and bail out
on other values.

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/lsm_hook_defs.h |  2 +-
 security/security.c           | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6791813cd439..f4b2e54162ae 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -150,7 +150,7 @@ LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
 	 size_t buffer_size)
 LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
-LSM_HOOK(int, 0, inode_copy_up_xattr, const char *name)
+LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
 LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
 	 struct kernfs_node *kn)
 LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
diff --git a/security/security.c b/security/security.c
index 0ce3e73edd42..70a7ad357bc6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1414,7 +1414,22 @@ EXPORT_SYMBOL(security_inode_copy_up);
 
 int security_inode_copy_up_xattr(const char *name)
 {
-	return call_int_hook(inode_copy_up_xattr, -EOPNOTSUPP, name);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * The implementation can return 0 (accept the xattr), 1 (discard the
+	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
+	 * any other error code incase of an error.
+	 */
+	hlist_for_each_entry(hp,
+		&security_hook_heads.inode_copy_up_xattr, list) {
+		rc = hp->hook.inode_copy_up_xattr(name);
+		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(inode_copy_up_xattr);
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
-- 
2.27.0.111.gc72c7da667-goog

