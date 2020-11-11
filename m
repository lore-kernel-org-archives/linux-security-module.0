Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCECC388F9
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F8320795
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 10:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjeglUGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgKKKpM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKKpL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 05:45:11 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7B6C0613D1;
        Wed, 11 Nov 2020 02:45:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so1874361wme.3;
        Wed, 11 Nov 2020 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sT+gZe0r8U7E1fOWd1D4bWdDDMPbW0dyZ/UKoJjOFwo=;
        b=IjeglUGhhwfyqF1t7cRE2AWo+xXAdfcUxs6HWQeAOup8QzPegm1owlp+4JqPar0TC3
         JTVj3XDEebdOVpOOp6cOqU9GdI1gEuiIGF9Nr+GqFbVnXz6XZh55FLDEQZavgxL4fvxX
         6SKql2uoULuDYTnaYAA4/5G0lW3axvufGDZLPmiuO7sokzBCvh5kH9EUfiiJU8Ml7VHe
         pTwoDRf6JrwcCSpHxLZAjW6Y4CxyMt1BQcVDHWwiHHxAervGsGqknQB4iEfMOFLiR3Lh
         dtNakCkiC2SuWTwru7vQe6qAlraXN6YsdZkV9xmGnl3SGWIr9qCnw0bnX/GwtBfztpxF
         7ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sT+gZe0r8U7E1fOWd1D4bWdDDMPbW0dyZ/UKoJjOFwo=;
        b=LvKL+DZpyx4/NZKaxDxnpJbgRgKgbOy2Aqi908msJ/udNWklkKy+/H28vdffUCsAqi
         9EdjKKlPuhC6O598MMxiGqDIa8kiLcTcI7a+zH1u02YTHDsvPsFKk8uvYMBzXEgaplS6
         KE4yUFOt31wJ7aXTqrhGHBICQalg4sfHPA7gLsgToo1/IXUjlZUfah+oNWrGhTqFack8
         0F69gKEZJRzuOdLOGMkHJFVfciy4v07pxK+wooYIuT3iGq8V6LypoUzVRsqbc5c1T8ez
         v53TIEZQ1uEejgdJfuBotLiPNfHz1iXLmfCvdkylTxTN0pvZJPy6U6CVavnEcxeH+Kju
         bXxQ==
X-Gm-Message-State: AOAM531B4IXyamUmLENv9PiTF72Zj8cSnwdE1JvcQRaridBk6RlqkQKR
        uuVSSQXOpH2qbs50oPbEi4w=
X-Google-Smtp-Source: ABdhPJzOfqB+nORtxB9KG/o7pYhAyjUAyFHG8HiCIMlUMhyRlB6b0MMzp49GIpohgJakl8omEOYDtA==
X-Received: by 2002:a1c:c203:: with SMTP id s3mr3353522wmf.77.1605091510130;
        Wed, 11 Nov 2020 02:45:10 -0800 (PST)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id u195sm2111549wmu.18.2020.11.11.02.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 02:45:09 -0800 (PST)
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com, casey@schaufler-ca.com,
        penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mortonm@chromium.org,
        Aleksandr Nogikh <nogikh@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v4 1/2] security: add fault injection capability
Date:   Wed, 11 Nov 2020 10:44:08 +0000
Message-Id: <20201111104409.1530957-2-a.nogikh@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201111104409.1530957-1-a.nogikh@gmail.com>
References: <20201111104409.1530957-1-a.nogikh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Aleksandr Nogikh <nogikh@google.com>

Add a fault injection capability to call_int_hook macro. This will
facilitate testing of fault tolerance of the code that invokes
security hooks as well as the fault tolerance of the LSM
implementations themselves.

Add a KConfig option (CONFIG_FAIL_LSM_HOOKS) that controls whether the
capability is enabled. In order to enable configuration from the user
space, add the standard debugfs entries for fault injection (if
CONFIG_FAULT_INJECTION_DEBUG_FS is enabled).

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
---
v4:
- Changed retval debugfs file type - now it keeps a signed integer.
- Made CONFIG_FAIL_LSM_HOOKS depend on CONFIG_SECURITY.
v2:
- Renamed should_fail_lsm_hook() to lsm_hooks_inject_fail().
---
 lib/Kconfig.debug   |  6 ++++
 security/security.c | 69 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6140413174be..5f4399816019 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1813,6 +1813,12 @@ config FAIL_MAKE_REQUEST
 	help
 	  Provide fault-injection capability for disk IO.
 
+config FAIL_LSM_HOOKS
+	bool "Fault-injection capability for LSM hooks"
+	depends on FAULT_INJECTION && SECURITY
+	help
+	  Provide fault-injection capability for LSM hooks.
+
 config FAIL_IO_TIMEOUT
 	bool "Fault-injection capability for faking disk interrupts"
 	depends on FAULT_INJECTION && BLOCK
diff --git a/security/security.c b/security/security.c
index 69ff6e2e2cd4..be3a3c7c6d6a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/fault-inject.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -669,6 +670,67 @@ static void __init lsm_early_task(struct task_struct *task)
 		panic("%s: Early task alloc failed.\n", __func__);
 }
 
+
+#ifdef CONFIG_FAIL_LSM_HOOKS
+
+static struct {
+	struct fault_attr attr;
+	int retval;
+} fail_lsm_hooks = {
+	.attr = FAULT_ATTR_INITIALIZER,
+	.retval = -EACCES
+};
+
+static int __init setup_fail_lsm_hooks(char *str)
+{
+	return setup_fault_attr(&fail_lsm_hooks.attr, str);
+}
+__setup("fail_lsm_hooks=", setup_fail_lsm_hooks);
+
+static int lsm_hooks_inject_fail(void)
+{
+	return should_fail(&fail_lsm_hooks.attr, 1) ? fail_lsm_hooks.retval : 0;
+}
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+static int fail_lsm_retval_set(void *data, u64 val)
+{
+	fail_lsm_hooks.retval = (int)val;
+	return 0;
+}
+
+static int fail_lsm_retval_get(void *data, u64 *val)
+{
+	*val = (u64)fail_lsm_hooks.retval;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fail_lsm_retval_ops, fail_lsm_retval_get,
+						 fail_lsm_retval_set, "%lld\n");
+
+static int __init fail_lsm_hooks_debugfs(void)
+{
+	umode_t mode = S_IFREG | 0600;
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_lsm_hooks", NULL,
+					&fail_lsm_hooks.attr);
+	debugfs_create_file("retval", mode, dir, NULL,
+						&fail_lsm_retval_ops);
+	return 0;
+}
+
+late_initcall(fail_lsm_hooks_debugfs);
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+#else
+
+static inline int lsm_hooks_inject_fail(void) { return 0; }
+
+#endif /* CONFIG_FAIL_LSM_HOOKS */
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
@@ -707,16 +769,17 @@ static void __init lsm_early_task(struct task_struct *task)
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
-	do {							\
+	int RC = lsm_hooks_inject_fail();			\
+	if (RC == 0) {								\
 		struct security_hook_list *P;			\
+		RC = IRC;								\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				break;				\
 		}						\
-	} while (0);						\
+	}							\
 	RC;							\
 })
 
-- 
2.29.2.222.g5d2a92d10f8-goog

