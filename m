Return-Path: <SRS0=0oss=4I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C200C11D18
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6FF20722
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HebykKvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgBTRxA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:53:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54348 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgBTRxA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id n3so2975744wmk.4
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQw2DgUHyFsv/uFvbbGRrtN6ETqPZ9VjN5jx2X9sBgU=;
        b=HebykKvIKM5PZBkfLT5pCg4RIu6HnbBOEdy3+q3FsjO2oWApigJ78PqksZx6/3EZYc
         9DjpGuAVVRgNXvKMXKti6vuT6WZrU0JBiCGOA+Oo5lL072xka032SsballAS566SRGgj
         BdUUee2PA2YgC7U96fabPMYN5WlrgRTHl5k0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQw2DgUHyFsv/uFvbbGRrtN6ETqPZ9VjN5jx2X9sBgU=;
        b=eHO2BqxcLvC/KrEU2TjwkKfztDa4i2UG6V/x+Xyum4SJNZvqDB+bKyDl3lwWM6mKYE
         63GpvxRj1DM1Rm9Th0jzU+0YsfSqN+arM8XNfP6fEVaez5PFOxgZwObbtD58NuwPY8cU
         uN9x7p8C8peTcq6rOtkO/OOGw9R310kd2e+IxFg+LqgH1m/564RLuGHaAzB9hus/p91k
         4FTpQF17+C8+MO23tkCEirdDH79atUoNMzeVqDxKJQRGkU0/4PeIYyVguofg47AtOEJo
         Ie7yhLCQkDCzASSAeCQYwr3boUlBqWa0WX9h1o4extD6Ct4M1xRHz3te4hCB8trlQ1y2
         r0ew==
X-Gm-Message-State: APjAAAWQLmgAPdlNllRfbJEfTnMsDSTVZWldliNkrSyU/NQGGw7FPw5v
        NFWlSWGhRch2xCA+X0Aj/cwUFlpOpdE=
X-Google-Smtp-Source: APXvYqyrfCxoZ+bs+y1C/Ol8/1xIHHXPZjDT3tv6J1XnPzCayZgQWx/JyE/a4db+w5DAnaRL5jF07g==
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr5840606wmd.77.1582221177369;
        Thu, 20 Feb 2020 09:52:57 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id r5sm363059wrt.43.2020.02.20.09.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:52:56 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for BPF LSM programs
Date:   Thu, 20 Feb 2020 18:52:45 +0100
Message-Id: <20200220175250.10795-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

The BPF LSM programs are implemented as fexit trampolines to avoid the
overhead of retpolines. These programs cannot be attached to security_*
wrappers as there are quite a few security_* functions that do more than
just calling the LSM callbacks.

This was discussed on the lists in:

  https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.org/T/#m068becce588a0cdf01913f368a97aea4c62d8266

Adding a NOP callback after all the static LSM callbacks are called has
the following benefits:

- The BPF programs run at the right stage of the security_* wrappers.
- They run after all the static LSM hooks allowed the operation,
  therefore cannot allow an action that was already denied.

There are some hooks which do not call call_int_hooks or
call_void_hooks. It's not possible to call the bpf_lsm_* functions
without checking if there is BPF LSM program attached to these hooks.
This is added further in a subsequent patch. For now, these hooks are
marked as NO_BPF (i.e. attachment of BPF programs is not possible).

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_lsm.h | 34 ++++++++++++++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 16 ++++++++++++++++
 security/security.c     |  3 +++
 3 files changed, 53 insertions(+)
 create mode 100644 include/linux/bpf_lsm.h

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..f867f72f6aa9
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#ifndef _LINUX_BPF_LSM_H
+#define _LINUX_BPF_LSM_H
+
+#include <linux/bpf.h>
+
+#ifdef CONFIG_BPF_LSM
+
+#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK
+
+#define RUN_BPF_LSM_VOID_PROGS(FUNC, ...) bpf_lsm_##FUNC(__VA_ARGS__)
+#define RUN_BPF_LSM_INT_PROGS(RC, FUNC, ...) ({				\
+	do {								\
+		if (RC == 0)						\
+			RC = bpf_lsm_##FUNC(__VA_ARGS__);		\
+	} while (0);							\
+	RC;								\
+})
+
+#else /* !CONFIG_BPF_LSM */
+
+#define RUN_BPF_LSM_INT_PROGS(RC, FUNC, ...) (RC)
+#define RUN_BPF_LSM_VOID_PROGS(FUNC, ...)
+
+#endif /* CONFIG_BPF_LSM */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index affb6941622e..abc847c9b9a1 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -7,6 +7,22 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/bpf_lsm.h>
+
+/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
+ * function where a BPF program can be attached as an fexit trampoline.
+ */
+#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
+#define LSM_HOOK_int(NAME, ...) noinline int bpf_lsm_##NAME(__VA_ARGS__)  \
+{									  \
+	return 0;							  \
+}
+
+#define LSM_HOOK_void(NAME, ...) \
+	noinline void bpf_lsm_##NAME(__VA_ARGS__) {}
+
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK
 
 const struct bpf_prog_ops lsm_prog_ops = {
 };
diff --git a/security/security.c b/security/security.c
index 565bc9b67276..aa111392a700 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <linux/bpf_lsm.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -684,6 +685,7 @@ static void __init lsm_early_task(struct task_struct *task)
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
 			P->hook.FUNC(__VA_ARGS__);		\
+		RUN_BPF_LSM_VOID_PROGS(FUNC, __VA_ARGS__);	\
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
@@ -696,6 +698,7 @@ static void __init lsm_early_task(struct task_struct *task)
 			if (RC != 0)				\
 				break;				\
 		}						\
+		RC = RUN_BPF_LSM_INT_PROGS(RC, FUNC, __VA_ARGS__); \
 	} while (0);						\
 	RC;							\
 })
-- 
2.20.1

