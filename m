Return-Path: <SRS0=YXOF=5I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99222C54FD1
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 16:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7149120714
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 16:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Is/fLBhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCWQoh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:44:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33462 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbgCWQod (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Mar 2020 12:44:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so17987770wrd.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2020 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlA7urqMw8mKHvI9rDt37xMzrwfcfL0wKrtQ00PyQpc=;
        b=Is/fLBhXkfsoYTWL+rb7nbgKjQZDSHeREiaENX/ryr1Klw/wT/paImg2ZmlmRU0LM+
         ye/muNgE3Jxcw0uJbW0K2yyK5O8Xv+MkovtpqtVyRzdBCIVq49/Rd6tRgP1cSIBIpK3h
         G0DKJOPlqTSzhRvHt99l0hw3zeL0nmEbFCjMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlA7urqMw8mKHvI9rDt37xMzrwfcfL0wKrtQ00PyQpc=;
        b=r5Tacur5QxDhiWoXR/Xe8VWBFQnmHgkeuroGRtCMbv6BV4qsaOlHnE+Dm50EeR7VIC
         BqEmfAejtI5MGD7uxAyRFRsXCIbiDQkRcQ/6IiFebiIsfzw28hVjJ9wN6x95QRnVuJnN
         ZVFiMYNNBO7nmDKZ2DasFs0by6agCfG0Xn2b7SV9jFb8JBPN2yg7Pg0iZqj+yubHgl8o
         7jaH4HesEYrOCbGpBx3EJgHR+T+L+MbZ5hYyNWN2OnUU3r1XiUHJE1GameSGeuf9kha7
         tSlDtu+IuMKuxc0NkIpQGZGy0S00sfzzvJIqftQxHFKqd3qLaXVVsqhoC/ImQoHz8kTh
         FINg==
X-Gm-Message-State: ANhLgQ14IV8Av1+ZXKppPxxZo4ku6mSvhJ+xNEzy9ZApuZ9TiZaxL171
        +oZ+vjCHpmN93txKmBHmiXJ7/Q==
X-Google-Smtp-Source: ADFU+vvenfV9RiF6dhaMgXP3eNwDfXU99Q73rNQBjL6pcYXi5tPMuc0G+60g/ixBpbmYqRRFBqeADA==
X-Received: by 2002:a5d:54cb:: with SMTP id x11mr20563706wrv.179.1584981871985;
        Mon, 23 Mar 2020 09:44:31 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id l8sm199874wmj.2.2020.03.23.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:44:31 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Mon, 23 Mar 2020 17:44:11 +0100
Message-Id: <20200323164415.12943-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323164415.12943-1-kpsingh@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
generated for each LSM hook. These nops are initialized as LSM hooks in
a subsequent patch.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
---
 include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/linux/bpf_lsm.h

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..c6423a140220
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,21 @@
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
+#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK
+
+#endif /* CONFIG_BPF_LSM */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82875039ca90..530d137f7a84 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -7,6 +7,25 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
+
+/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
+ * function where a BPF program can be attached as an fexit trampoline.
+ */
+#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
+
+#define LSM_HOOK_int(NAME, ...)			\
+noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)	\
+{						\
+	return 0;				\
+}
+
+#define LSM_HOOK_void(NAME, ...) \
+noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
+
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK
 
 const struct bpf_prog_ops lsm_prog_ops = {
 };
-- 
2.20.1

