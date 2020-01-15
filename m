Return-Path: <SRS0=2BO2=3E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C0C32771
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCAA214AF
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yga+W/iC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAOROH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:14:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33905 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgAORN0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so16547067wrr.1
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2020 09:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQxyMYtQgG6tF+BejS82EQt5eHXmPPeHraWUkmIc0QY=;
        b=Yga+W/iCrwZEPrgbOH4uvmZSQ4eJbT4jPmG7QfaLvI8q/IhW+b3j6ruG6TShNLD0bP
         AKf8N8df7zWHLD4+mWV28aqub0K6suL8XejKMq5vK88tmApvSDircxWWy86eNl+C96uz
         ZrW0VwqLFo/ZEBPgHZGBi1vzL9BFTsATdWVCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQxyMYtQgG6tF+BejS82EQt5eHXmPPeHraWUkmIc0QY=;
        b=mJ4Sig+FEK+MGvcBlJB2BseTDkGP6zw7aEYEjs2QI35cQC+8Azg5/DJh+jFH4kKcrb
         vknn8cec2XbRiw/cHI8DpJQJOaX1qt49qcNFA90rWQ8OqPnfBh5g46WMSnnoFHhkWzuv
         e0BLUcu9K4CWll96zCvC/Pmo0m64OHkfQsMtqm3D+i0TJwLXJW665fpia8+0TlTic86E
         04djZB6lBOItUq8xqaPec31VSCR9EMbY2hhfexwNu6CBsL5pYzEg2jNsVUPH7s8DJxsI
         KUNrJqtbhFY8r04ry9UOhgnHSdoCPndQgeY2Lm4UX1k1AysWVUA+A0H41R5yRaVqbKvR
         ropg==
X-Gm-Message-State: APjAAAXy0mLEIH2I5f30Rt4E+VOjSIx2rPqWQZanBqelRkqstffVuYWE
        FzVbt/jnOwyWhNcDtkgVesjVXg==
X-Google-Smtp-Source: APXvYqyStWbKFkVOZQVLej5NW5P7eiu3AV1pQZ7BoLB818RceL/4QpAvR2W5UVweCfin0rbmzynJVw==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr33132617wrn.146.1579108405163;
        Wed, 15 Jan 2020 09:13:25 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:24 -0800 (PST)
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
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v2 04/10] bpf: lsm: Add mutable hooks list for the BPF LSM
Date:   Wed, 15 Jan 2020 18:13:27 +0100
Message-Id: <20200115171333.28811-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

- The list of hooks registered by an LSM is currently immutable as they
  are declared with __lsm_ro_after_init and they are attached to a
  security_hook_heads struct.
- For the BPF LSM we need to de/register the hooks at runtime. Making
  the existing security_hook_heads mutable broadens an
  attack vector, so a separate security_hook_heads is added for only
  those that ~must~ be mutable.
- These mutable hooks are run only after all the static hooks have
  successfully executed.

This is based on the ideas discussed in:

  https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal

Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS             |  1 +
 include/linux/bpf_lsm.h | 71 +++++++++++++++++++++++++++++++++++++++++
 security/bpf/Kconfig    |  1 +
 security/bpf/Makefile   |  2 +-
 security/bpf/hooks.c    | 20 ++++++++++++
 security/bpf/lsm.c      |  9 +++++-
 security/security.c     | 24 +++++++-------
 7 files changed, 115 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/bpf_lsm.h
 create mode 100644 security/bpf/hooks.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0941f478cfa5..02d7e05e9b75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3209,6 +3209,7 @@ L:	linux-security-module@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	security/bpf/
+F:	include/linux/bpf_lsm.h
 
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..9883cf25241c
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,71 @@
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
+#include <linux/lsm_hooks.h>
+
+#ifdef CONFIG_SECURITY_BPF
+
+/* Mutable hooks defined at runtime and executed after all the statically
+ * define LSM hooks.
+ */
+extern struct security_hook_heads bpf_lsm_hook_heads;
+
+int bpf_lsm_srcu_read_lock(void);
+void bpf_lsm_srcu_read_unlock(int idx);
+
+#define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
+	do {							\
+		struct security_hook_list *P;			\
+		int _idx;					\
+								\
+		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
+			break;					\
+								\
+		_idx = bpf_lsm_srcu_read_lock();		\
+		hlist_for_each_entry(P, &bpf_lsm_hook_heads.FUNC, list) \
+			P->hook.FUNC(__VA_ARGS__);		\
+		bpf_lsm_srcu_read_unlock(_idx);			\
+	} while (0)
+
+#define CALL_BPF_LSM_INT_HOOKS(RC, FUNC, ...) ({		\
+	do {							\
+		struct security_hook_list *P;			\
+		int _idx;					\
+								\
+		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
+			break;					\
+								\
+		_idx = bpf_lsm_srcu_read_lock();		\
+								\
+		hlist_for_each_entry(P,				\
+			&bpf_lsm_hook_heads.FUNC, list) {	\
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (RC && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
+				break;				\
+		}						\
+		bpf_lsm_srcu_read_unlock(_idx);			\
+	} while (0);						\
+	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? RC : 0;	\
+})
+
+#else /* !CONFIG_SECURITY_BPF */
+
+#define CALL_BPF_LSM_INT_HOOKS(RC, FUNC, ...) (RC)
+#define CALL_BPF_LSM_VOID_HOOKS(...)
+
+static inline int bpf_lsm_srcu_read_lock(void)
+{
+	return 0;
+}
+static inline void bpf_lsm_srcu_read_unlock(int idx) {}
+
+#endif /* CONFIG_SECURITY_BPF */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
index a5f6c67ae526..595e4ad597ae 100644
--- a/security/bpf/Kconfig
+++ b/security/bpf/Kconfig
@@ -6,6 +6,7 @@ config SECURITY_BPF
 	bool "BPF-based MAC and audit policy"
 	depends on SECURITY
 	depends on BPF_SYSCALL
+	depends on SRCU
 	help
 	  This enables instrumentation of the security hooks with
 	  eBPF programs.
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
index c78a8a056e7e..c526927c337d 100644
--- a/security/bpf/Makefile
+++ b/security/bpf/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright 2019 Google LLC.
 
-obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o
+obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o hooks.o
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
new file mode 100644
index 000000000000..b123d9cb4cd4
--- /dev/null
+++ b/security/bpf/hooks.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/bpf_lsm.h>
+#include <linux/srcu.h>
+
+DEFINE_STATIC_SRCU(security_hook_srcu);
+
+int bpf_lsm_srcu_read_lock(void)
+{
+	return srcu_read_lock(&security_hook_srcu);
+}
+
+void bpf_lsm_srcu_read_unlock(int idx)
+{
+	return srcu_read_unlock(&security_hook_srcu, idx);
+}
diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
index 5c5c14f990ce..d4ea6aa9ddb8 100644
--- a/security/bpf/lsm.c
+++ b/security/bpf/lsm.c
@@ -4,14 +4,21 @@
  * Copyright 2019 Google LLC.
  */
 
+#include <linux/bpf_lsm.h>
 #include <linux/lsm_hooks.h>
 
 /* This is only for internal hooks, always statically shipped as part of the
- * BPF LSM. Statically defined hooks are appeneded to the security_hook_heads
+ * BPF LSM. Statically defined hooks are appended to the security_hook_heads
  * which is common for LSMs and R/O after init.
  */
 static struct security_hook_list lsm_hooks[] __lsm_ro_after_init = {};
 
+/* Security hooks registered dynamically by the BPF LSM and must be accessed
+ * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock. The mutable
+ * hooks dynamically allocated by the BPF LSM are appeneded here.
+ */
+struct security_hook_heads bpf_lsm_hook_heads;
+
 static int __init lsm_init(void)
 {
 	security_add_hooks(lsm_hooks, ARRAY_SIZE(lsm_hooks), "bpf");
diff --git a/security/security.c b/security/security.c
index cd2d18d2d279..4a2eb4c089b2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -27,6 +27,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/bpf_lsm.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -652,20 +653,21 @@ static void __init lsm_early_task(struct task_struct *task)
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
 			P->hook.FUNC(__VA_ARGS__);		\
+		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
 	} while (0)
 
-#define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
-	do {							\
-		struct security_hook_list *P;			\
-								\
+#define call_int_hook(FUNC, IRC, ...) ({				\
+	int RC = IRC;							\
+	do {								\
+		struct security_hook_list *P;				\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
-				break;				\
-		}						\
-	} while (0);						\
-	RC;							\
+			RC = P->hook.FUNC(__VA_ARGS__);			\
+			if (RC != 0)					\
+				break;					\
+		}							\
+		RC = CALL_BPF_LSM_INT_HOOKS(RC, FUNC, __VA_ARGS__);	\
+	} while (0);							\
+	RC;								\
 })
 
 /* Security operations */
-- 
2.20.1

