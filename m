Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C045C54FD5
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 15:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5F020409
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 15:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jOtKOWyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgCYP0o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:26:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50449 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgCYP0o (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 11:26:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id d198so2952004wmd.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2020 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gr2YowP7xZurwhXRmAY/lGUCfPPt09BjXH0RtGSlGeM=;
        b=jOtKOWyTFlnI/HR751jZDGLmFII6PtQqnMWGGc6Kuplu+oLGGOyoVx/n2KE9AEXfa7
         S7Q8DjwzxNI5Dfx0qEYkavRH2hNu9bmEzzUZFSVfmmJw1Ox0SZ3iel47ilMw1cLL+ETj
         R8OXrs1soxud01CII8flpnkTsDNk6QMVRbGkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gr2YowP7xZurwhXRmAY/lGUCfPPt09BjXH0RtGSlGeM=;
        b=t8e1bHDRY5wieHYJpvmsCikdF2poEDEOKHYxTKqmUGfS2QEQmifD3miup9aNhG9267
         FxWq2hH1nTnjozSI0Xi3QrmWqHETVPKPyHi7sTOTql0ydx2CyOE0990x8k9KCXvAaDG4
         eb2rlL21zzF5I/FuTvZEKGebcJEbM5f6GeWtkuNUeZwXKJOx5juG39U6WcG7oK/i1tQv
         VElQaS6xQTqcX59IzYhggVxl3VVuj01+kFwi1vl24IiYyxXS0i89Fh8aZ1aJbyOcq7s7
         yrY6tDd48RfOvDadtxvZDRpvWHtR0k29CifXuXjSkrK/pBFIfqJW4y6TatssToFLrvX1
         0xuw==
X-Gm-Message-State: ANhLgQ38/eK/CW15J3EYabmj6r62ESxtQUQ6SyTMoDYuT4l2jPCG7/bu
        2rD1/4rL29tOB78sam4cbaq4+g==
X-Google-Smtp-Source: ADFU+vvy259BxeGiK8c7t1ayuKqsAgNDwtV6vzhjuhUBg/FiqUoeBqmrE08UcneZC4pHHld1lJDKpw==
X-Received: by 2002:a1c:df07:: with SMTP id w7mr3820469wmg.7.1585150000943;
        Wed, 25 Mar 2020 08:26:40 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a2sm4033701wrp.13.2020.03.25.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:26:40 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Kees Cook <keescook@chromium.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v6 3/8] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Wed, 25 Mar 2020 16:26:24 +0100
Message-Id: <20200325152629.6904-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325152629.6904-1-kpsingh@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
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
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Yonghong Song <yhs@fb.com>
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
index 82875039ca90..1210a819ca52 100644
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
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) 	\
+noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)	\
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

