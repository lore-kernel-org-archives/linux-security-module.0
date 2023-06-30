Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE10FC001B3
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jun 2023 03:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjF3DRi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 23:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjF3DRc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 23:17:32 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F0C359C
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:17:30 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-56344354e2cso968160eaf.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095049; x=1690687049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53ZMdGhNmZ+BOpMUbgSFLyEDTkK0ZHteXsorexZvGcc=;
        b=Hhds97GUYBeppbOwT50AZutzB1nVVfNLRInAfnNP58IkESH6yufdJYjjXoko1dy9G+
         7Ur8NWUwfJrbcpQSpTt286069+coFcb6LHT+Hpu/39T4cIbHcx3ohwZzEN7MljiB4mGX
         nGNyBGTlMBhsV2p04QbZotAIplV3r6a4qLE4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095049; x=1690687049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53ZMdGhNmZ+BOpMUbgSFLyEDTkK0ZHteXsorexZvGcc=;
        b=kbEc2TOievVXd3ARXQDqYAiNjEy4WZSJ7TkC74gUwqmT5ahOrEgwEzKMVl1jFuodBH
         DtK3IrigcRzuuhyrb14YmNzztyGanpb+SdIwLqnP/Km9lVV2Ywf4NzFoI3HWseEVKTx5
         Iybs+kCycvBtX5KZRoIV4oRI77Jix/gZjbCfG8ycs8TWhKkRbSjtt+zTEssh9yUPiFim
         0UrDaNXc3wc0dD0+8JbCpeR1PUtRWPHx2GwvqpU/etqE05i5jODYWlRXGGlXX3niUU/o
         k6aslggi8Hl4F7knxaSBOpofJwFlajNejM+jjcbPlPjrZtO9Lw1AbikZl2xUxmyxFXuf
         OvEg==
X-Gm-Message-State: AC+VfDxlK/36mFR5bU18DV84mw6cgAy67jSB8veZoxc24ZxDNqyfW5CJ
        N99k4SUqnfxuvx5HmS6gycQmjQ==
X-Google-Smtp-Source: ACHHUZ7w0MIcW5kZcKcCzQ5+ZTjH6ysBlmgQ4PxTyUtw8h8Kk3p3zrfxkxjd+Odq2hqr4KUnUW6Icw==
X-Received: by 2002:a05:6808:1921:b0:3a3:7e8f:2f2a with SMTP id bf33-20020a056808192100b003a37e8f2f2amr1773186oib.11.1688095049673;
        Thu, 29 Jun 2023 20:17:29 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id x24-20020aa784d8000000b0065438394fa4sm1622577pfn.90.2023.06.29.20.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:17:29 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/2] mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Fri, 30 Jun 2023 03:17:19 +0000
Message-ID: <20230630031721.623955-2-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630031721.623955-1-jeffxu@google.com>
References: <20230630031721.623955-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

When vm.memfd_noexec is 2 (MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED),
memfd_create(.., MFD_EXEC) should fail.

This complies with how MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED is
defined - "memfd_create() without MFD_NOEXEC_SEAL will be rejected"

Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 mm/memfd.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index e763e76f1106..812750298e8a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -268,6 +268,19 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 
 #define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
 
+static int sysctl_memfd_noexec(void)
+{
+	int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
+#ifdef CONFIG_SYSCTL
+	struct pid_namespace *ns;
+
+	ns = task_active_pid_ns(current);
+	if (ns)
+		sysctl = ns->memfd_noexec_scope;
+#endif
+	return sysctl;
+}
+
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
@@ -278,6 +291,7 @@ SYSCALL_DEFINE2(memfd_create,
 	int fd, error;
 	char *name;
 	long len;
+	int sysctl = sysctl_memfd_noexec();
 
 	if (!(flags & MFD_HUGETLB)) {
 		if (flags & ~(unsigned int)MFD_ALL_FLAGS)
@@ -294,35 +308,23 @@ SYSCALL_DEFINE2(memfd_create,
 		return -EINVAL;
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-#ifdef CONFIG_SYSCTL
-		int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
-		struct pid_namespace *ns;
-
-		ns = task_active_pid_ns(current);
-		if (ns)
-			sysctl = ns->memfd_noexec_scope;
-
-		switch (sysctl) {
-		case MEMFD_NOEXEC_SCOPE_EXEC:
-			flags |= MFD_EXEC;
-			break;
-		case MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL:
+		if (sysctl == MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
 			flags |= MFD_NOEXEC_SEAL;
-			break;
-		default:
-			pr_warn_once(
-				"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
-				task_pid_nr(current), get_task_comm(comm, current));
-			return -EINVAL;
-		}
-#else
-		flags |= MFD_EXEC;
-#endif
+		else
+			flags |= MFD_EXEC;
+
 		pr_warn_once(
 			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
 			task_pid_nr(current), get_task_comm(comm, current));
 	}
 
+	if (flags & MFD_EXEC && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
+		pr_warn_once(
+			"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
+			task_pid_nr(current), get_task_comm(comm, current));
+		return -EACCES;
+	}
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
-- 
2.41.0.255.g8b1d071c50-goog

