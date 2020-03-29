Return-Path: <SRS0=qkJb=5O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09905C2D0E8
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Mar 2020 00:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D470120578
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Mar 2020 00:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PMY8KHel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgC2Aoe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 28 Mar 2020 20:44:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53932 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgC2AoF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 28 Mar 2020 20:44:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so15836860wmj.3
        for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2020 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R06x0mive4StEspSChp8nXo8gNb0lFU1htQmKzctqw8=;
        b=PMY8KHelbwaNa5xYBYDcWyEk94/0a2gh2tMn0Q3NqQjOr84u0kOMBhjAZJvXfucvnD
         7kq5k5vcsQrc/xL4Ugpec9xTSjW+xkYonCBlU3FutlOy50av8YXw+YRL6J3j+SjfPaGL
         +CZeRoYm+WJGtT7lztYXA5+rfTbl+Tb7evYVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R06x0mive4StEspSChp8nXo8gNb0lFU1htQmKzctqw8=;
        b=Z7pArcgkMRb39lk0oaIvEdJFjjjSGLSZpTvXzdTOukKt4mze3rVHwQZNaxkqjzp9zi
         GcQ5OFTXawvYkOaxKACkP37kilmNDU+q9zkBsD5yZLDY6SUftCubx8j4db9FIYdBhLyO
         X0UOy/PKQqmPHrizJOfsOHnfQmSM1LOb87oBeDDFAdjTy5uJU99IwrPwYh2Rx/dZaPVX
         XnQWYCTnyLqLfzOeOHOvqlRVpjmVL1vWcM60kF7Q4CB9HXO18fxbocTRy3N0ptKkH6LV
         6JraeUP3t9qaezJ8nLPYZ4SOnvgHH9HVgiQFMxV0y4QyYHUz0ZTx4stBi6TVQ7U+6jeR
         l3CQ==
X-Gm-Message-State: ANhLgQ3rnz/Z91lGKFyVL/+1q+9HZ19g7Ul8q5ZM9OaSvg/hHmqJQohV
        WfJqvuwAgtilYCLKZfsM3ywTzQ==
X-Google-Smtp-Source: ADFU+vsyGkhX3SOTyLgCNzb2toTt7FNMiXNaSN34rKBoCi4LpY6Cqns9hhN73YF/13ZQuL/6iRJ14g==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr5831470wmj.15.1585442643969;
        Sat, 28 Mar 2020 17:44:03 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id e5sm14577647wru.92.2020.03.28.17.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 17:44:03 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v9 3/8] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Sun, 29 Mar 2020 01:43:51 +0100
Message-Id: <20200329004356.27286-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200329004356.27286-1-kpsingh@chromium.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

When CONFIG_BPF_LSM is enabled, nop functions, bpf_lsm_<hook_name>, are
generated for each LSM hook. These functions are initialized as LSM
hooks in a subsequent patch.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bpf_lsm.h | 22 ++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 14 ++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/linux/bpf_lsm.h

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..83b96895829f
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#ifndef _LINUX_BPF_LSM_H
+#define _LINUX_BPF_LSM_H
+
+#include <linux/bpf.h>
+#include <linux/lsm_hooks.h>
+
+#ifdef CONFIG_BPF_LSM
+
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	RET bpf_lsm_##NAME(__VA_ARGS__);
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+
+#endif /* CONFIG_BPF_LSM */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82875039ca90..3b3bbb28603e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -7,6 +7,20 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
+
+/* For every LSM hook that allows attachment of BPF programs, declare a nop
+ * function where a BPF program can be attached.
+ */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
+noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
+{						\
+	return DEFAULT;				\
+}
+
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
 
 const struct bpf_prog_ops lsm_prog_ops = {
 };
-- 
2.20.1

