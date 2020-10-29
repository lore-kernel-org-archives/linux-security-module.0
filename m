Return-Path: <SRS0=Tuew=EE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E80C4363A
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 18:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB61E20759
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 18:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/8nB9ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgJ2Sfw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Oct 2020 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgJ2Sfv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Oct 2020 14:35:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E7C0613CF;
        Thu, 29 Oct 2020 11:35:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k10so2540001wrw.13;
        Thu, 29 Oct 2020 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8mwNG6QMyXuJ+ivtb4CUHNuJO9DxREq+55PstukYGQ=;
        b=W/8nB9kiRr68G8VfevQBmXOIky2SdJql0ywaRfKd4Pxmi83ARpm+KwVJ1H4rjnbHPd
         n9l9MsGe0cNWXaVGE3TnoWf9pzAYSxnwRNq5I33WVFE2vSweZC+IU8bzwtNDmBouOtBh
         WTDHWhfntaJePyuwcCPT9yxajvQVAMFvqSyi6lsZXkbjgTAURQZETrXKrgrEhinoUTHE
         fTrTSwnA96ulc3cc0zZaMjuWyhY/h0HqdzaAgFtebcqCVHU6wP15d5pgH7REGMOdlk2l
         GLi8FdrP3V7wdbVcxGhLFVCMslNdGORVrNIc1CQ9zj06iPGfu275flx5LG83wFc6cBKU
         9BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8mwNG6QMyXuJ+ivtb4CUHNuJO9DxREq+55PstukYGQ=;
        b=gALhhO0l8mu9JzIOfaBBpQN42E0zyJWHHgTouZp+EIqaG3djWEVmKRmOVgkLK5ohXd
         ls0kVAq3cZ6A/RdBHkMndOSPjPz0ZTLehiMb/uvlFpQuGqATcsxi4wzALQknl0/BpwwN
         IQXVt2LQGuQdOweanASSQgWNbnJSkiWuV+rOw47Tikv9mxFs88ATpeUeu6QydpPYphHD
         AKS77XxqkvOdvrUAlwWYmfHqMcJ/doD7hkkyCaDlJHqqKommOr0zaDqGgiFg/AFCQiRh
         11SmvLIiKAXrpic/0EGdyAjDmLJENeKngc9evkPHct3VlaNQAIf9PVDXB5VtbN9IjvH4
         UVdg==
X-Gm-Message-State: AOAM530di/LlGMv8Tz5HEjnGTKtHeAd9nrST+XZPhgi6uSLr+mQTdX8/
        qZJQbG2jE94fa1sBuHzwDSU=
X-Google-Smtp-Source: ABdhPJw7lWmw6p4UI7FPj77X+jfKrlxboA78WVMDCq3yCSLRwn04ggoE60dYqqHAB48QQiDMRTU2QQ==
X-Received: by 2002:adf:f482:: with SMTP id l2mr7297025wro.26.1603996550404;
        Thu, 29 Oct 2020 11:35:50 -0700 (PDT)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id f4sm5800982wrq.54.2020.10.29.11.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 11:35:49 -0700 (PDT)
From:   Aleksandr Nogikh <aleksandrnogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [PATCH v3 1/2] security: add fault injection capability
Date:   Thu, 29 Oct 2020 18:35:25 +0000
Message-Id: <20201029183526.2131776-2-aleksandrnogikh@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
References: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
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
---
v2:
* Renamed should_fail_lsm_hook() to lsm_hooks_inject_fail().
---
 lib/Kconfig.debug   |  6 +++++
 security/security.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 537cf3c2937d..80d289591e29 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1803,6 +1803,12 @@ config FAIL_MAKE_REQUEST
 	help
 	  Provide fault-injection capability for disk IO.
 
+config FAIL_LSM_HOOKS
+	bool "Fault-injection capability for LSM hooks"
+	depends on FAULT_INJECTION
+	help
+	  Provide fault-injection capability for LSM hooks.
+
 config FAIL_IO_TIMEOUT
 	bool "Fault-injection capability for faking disk interrupts"
 	depends on FAULT_INJECTION && BLOCK
diff --git a/security/security.c b/security/security.c
index 69ff6e2e2cd4..1105ad0f6891 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/fault-inject.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -669,6 +670,51 @@ static void __init lsm_early_task(struct task_struct *task)
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
+static int __init fail_lsm_hooks_debugfs(void)
+{
+	umode_t mode = S_IFREG | 0600;
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_lsm_hooks", NULL,
+					&fail_lsm_hooks.attr);
+	debugfs_create_u32("retval", mode, dir, &fail_lsm_hooks.retval);
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
@@ -707,16 +753,17 @@ static void __init lsm_early_task(struct task_struct *task)
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
2.29.1.341.ge80a0c044ae-goog

