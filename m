Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A182E94116
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Oct 2023 20:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjJFUr3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Oct 2023 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjJFUr1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Oct 2023 16:47:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30CFD
        for <linux-security-module@vger.kernel.org>; Fri,  6 Oct 2023 13:47:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEDAC433C8;
        Fri,  6 Oct 2023 20:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696625237;
        bh=6sVmxKblEF00JE0Lc5YD1cGhezWuYx0Ygc3bygqY480=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uh4amCrxQobt6j/MzMBO6815z5NsfeaRzfhMg1wuFLJQun4SbMP54ORKDC1HAHFLU
         rb4SK1BsFDn4yYIrD8k/fQT4uhT8oal2RMs2oSqO5zQcqkJtHVKY//ewbK5TCQIX+9
         xm/K1BacJWGtevgD5pGYslDwK+g8CRsSw3xOKmmxDoaJ1/FiN0kRkiW51tgvCrdkgD
         zto6k0KRAo1mtEVQxzmkFJhycWIMoMFCXC/vgj2op7sIVbp0R5kn90oCGFKg6hOaq6
         Vbxz0jBc6Rh4Acqz1AtivqyR62ONZDNj9uY4XgaEcJzLRJRd6prl5Sy4ekVYIwKTDo
         Gmrl3cfIRVsTg==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org, renauld@google.com, pabeni@redhat.com,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v6 2/5] security: Count the LSMs enabled at compile time
Date:   Fri,  6 Oct 2023 22:46:58 +0200
Message-ID: <20231006204701.549230-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231006204701.549230-1-kpsingh@kernel.org>
References: <20231006204701.549230-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These macros are a clever trick to determine a count of the number of
LSMs that are enabled in the config to ascertain the maximum number of
static calls that need to be configured per LSM hook.

Without this one would need to generate static calls for the total
number of LSMs in the kernel (even if they are not compiled) times the
number of LSM hooks which ends up being quite wasteful.

Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_count.h | 114 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 include/linux/lsm_count.h

diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
new file mode 100644
index 000000000000..dbb3c8573959
--- /dev/null
+++ b/include/linux/lsm_count.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2023 Google LLC.
+ */
+
+#ifndef __LINUX_LSM_COUNT_H
+#define __LINUX_LSM_COUNT_H
+
+#include <linux/args.h>
+
+#ifdef CONFIG_SECURITY
+
+/*
+ * Macros to count the number of LSMs enabled in the kernel at compile time.
+ */
+
+/*
+ * Capabilities is enabled when CONFIG_SECURITY is enabled.
+ */
+#if IS_ENABLED(CONFIG_SECURITY)
+#define CAPABILITIES_ENABLED 1,
+#else
+#define CAPABILITIES_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
+#define SELINUX_ENABLED 1,
+#else
+#define SELINUX_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_SMACK)
+#define SMACK_ENABLED 1,
+#else
+#define SMACK_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_APPARMOR)
+#define APPARMOR_ENABLED 1,
+#else
+#define APPARMOR_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_TOMOYO)
+#define TOMOYO_ENABLED 1,
+#else
+#define TOMOYO_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_YAMA)
+#define YAMA_ENABLED 1,
+#else
+#define YAMA_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN)
+#define LOADPIN_ENABLED 1,
+#else
+#define LOADPIN_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM)
+#define LOCKDOWN_ENABLED 1,
+#else
+#define LOCKDOWN_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_SAFESETID)
+#define SAFESETID_ENABLED 1,
+#else
+#define SAFESETID_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_BPF_LSM)
+#define BPF_LSM_ENABLED 1,
+#else
+#define BPF_LSM_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
+#define LANDLOCK_ENABLED 1,
+#else
+#define LANDLOCK_ENABLED
+#endif
+
+/*
+ *  There is a trailing comma that we need to be accounted for. This is done by
+ *  using a skipped argument in __COUNT_LSMS
+ */
+#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)
+#define COUNT_LSMS(args...) __COUNT_LSMS(args)
+
+#define MAX_LSM_COUNT			\
+	COUNT_LSMS(			\
+		CAPABILITIES_ENABLED	\
+		SELINUX_ENABLED		\
+		SMACK_ENABLED		\
+		APPARMOR_ENABLED	\
+		TOMOYO_ENABLED		\
+		YAMA_ENABLED		\
+		LOADPIN_ENABLED		\
+		LOCKDOWN_ENABLED	\
+		SAFESETID_ENABLED	\
+		BPF_LSM_ENABLED		\
+		LANDLOCK_ENABLED)
+
+#else
+
+#define MAX_LSM_COUNT 0
+
+#endif /* CONFIG_SECURITY */
+
+#endif  /* __LINUX_LSM_COUNT_H */
-- 
2.42.0.609.gbb76f46606-goog

