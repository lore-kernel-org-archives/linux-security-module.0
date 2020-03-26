Return-Path: <SRS0=UFfU=5L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E8C2D0EE
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 14:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C0F20787
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 14:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nGEs+UUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgCZO3O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:29:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgCZO2l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 10:28:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id a9so7207028wmj.4
        for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2020 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3kFl5COAYKa66U/jHq8uPw/HaoWHyV8EfIjqjqU5r4=;
        b=nGEs+UUmb27XB7ctAgMBSWIEPmuFPP/4QTlXyuJYnjRZvfg/RcuruvPbWwWiiNQK6S
         J32oaYJ9+N0XM6BbRz8PKq5ZO6XRYyTK9wwqb8V9Ep8zbwwZS0Sj8ozIxEP7NFU5Ilq8
         VZm+d3InK21nVx9gCzPkEJ48djXG7m49ZNL9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3kFl5COAYKa66U/jHq8uPw/HaoWHyV8EfIjqjqU5r4=;
        b=rtbVG8jqFQtX1aRcuySsXn2xu45UExdM3pYEtUf1HEhTtV/RfovuxA8ccHgTMrkcGm
         EqukX2k1efRUo55VliZbBlMBsMc6GZt3AneZ9oQMihjeW0wNoacCvvyYJS722OU4eSBd
         fvudY7jjVl9cFzAVrP4WM69EszlOVCk7HHonE161D+tFwTcNwYagQiIl1rfGJhuBwQge
         ZQhoD8u+Jer8hM9zuTjgHyvNdQZ7HlLZoLzRZYXZoN7BZhE0d7HlEMRYjO1iT74wY6jC
         dpME5bFkOMcx0APMQYVXUNJw6HT91C9yxB1ZORfP6v32hKjN3kN/hj9h2NjCb0P8XAEM
         pfrw==
X-Gm-Message-State: ANhLgQ2rKwe+RBNTWRVsnhhGRvJHL8m/RQd66HuxPCasJuNR05kAbatT
        vIT+8apR0CItoB19ZHCN1N5Odg==
X-Google-Smtp-Source: ADFU+vuZUCLPD7UKKLWVw6qw4EgktHQWbMliuYjs6Gn4WRyyJSSgQrB8M3Ljr+BggxOn9YzwkDWCow==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr228422wmg.96.1585232919526;
        Thu, 26 Mar 2020 07:28:39 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q3sm3643971wru.87.2020.03.26.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:28:39 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v7 5/8] bpf: lsm: Initialize the BPF LSM hooks
Date:   Thu, 26 Mar 2020 15:28:20 +0100
Message-Id: <20200326142823.26277-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326142823.26277-1-kpsingh@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

* The hooks are initialized using the definitions in
  include/linux/lsm_hook_defs.h.
* The LSM can be enabled / disabled with CONFIG_BPF_LSM.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
---
 security/Kconfig      | 10 +++++-----
 security/Makefile     |  2 ++
 security/bpf/Makefile |  5 +++++
 security/bpf/hooks.c  | 26 ++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)
 create mode 100644 security/bpf/Makefile
 create mode 100644 security/bpf/hooks.c

diff --git a/security/Kconfig b/security/Kconfig
index 2a1a2d396228..cd3cc7da3a55 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -277,11 +277,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
-	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
-	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
-	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
+	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
+	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/Makefile b/security/Makefile
index 746438499029..22e73a3482bd 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
 subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
+subdir-$(CONFIG_BPF_LSM)		+= bpf
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -30,6 +31,7 @@ obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
+obj-$(CONFIG_BPF_LSM)			+= bpf/
 
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
new file mode 100644
index 000000000000..c7a89a962084
--- /dev/null
+++ b/security/bpf/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020 Google LLC.
+
+obj-$(CONFIG_BPF_LSM) := hooks.o
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
new file mode 100644
index 000000000000..32d32d485451
--- /dev/null
+++ b/security/bpf/hooks.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+#include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
+
+static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
+	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
+	#include <linux/lsm_hook_defs.h>
+	#undef LSM_HOOK
+};
+
+static int __init bpf_lsm_init(void)
+{
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	pr_info("LSM support for eBPF active\n");
+	return 0;
+}
+
+DEFINE_LSM(bpf) = {
+	.name = "bpf",
+	.init = bpf_lsm_init,
+};
-- 
2.20.1

