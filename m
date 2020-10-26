Return-Path: <SRS0=mR5W=EB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC95C55178
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Oct 2020 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB59124641
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Oct 2020 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh9KLOGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775737AbgJZMxD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:53:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51035 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775702AbgJZMwr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id 13so11520502wmf.0;
        Mon, 26 Oct 2020 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zIZSI5eymRh7YleTXMPveAGwP5JgMGOTN1Kj60Qisgw=;
        b=Wh9KLOGg6biS1w0GfT8TZ3i/0yZCu5gbkCT89jb7Vt6NZRdYTD1EM30crU5xXFD5dd
         OBnWh50eHsPR0xpWZ9ul3AaEqGVHC12nJ78rDbuKfWPNehjBUCEcqonD1RyBAXn/6kUj
         g9Vf1Sp9by4n4laduAxA6qWm2FQZrJ7sqKe16nvCQI/kFEcg72HAbjni+NY77VaaTIFh
         oeffbQpSyulFeghqvNl9krhJCC7FuN8fqQm4gW5KNbjB8uSEzN7o3JX2o9jJmINTZ3Ym
         FT8gCwCOt+5BycHLYXD3qleRdLNJSYYpReNCtJFr76LCT7fAT5MvR0FwBAiv0eFC+y/Q
         7OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIZSI5eymRh7YleTXMPveAGwP5JgMGOTN1Kj60Qisgw=;
        b=h6mUFhjVT0OYQRrIhSmrpA+mRlkZdaTQ4wzyjKkg2mw+7Z0a9dAP71GQWPNQuTebOI
         Kg2W6iq0DMTBobK5bkbFW8x4G5KfcqbzNaBmlkgS9+cwduJ29qQowWygdpP0Zz4SSgYz
         WYLcX0SCQLy8fEwCKigbGQ+Un8W+BmXAQngumIlVVAMjKoAWxBKKwr2zY6436JPe5tF8
         xJQVLNMifp8UMAXEOd03mMu7RZN/+nXDa4AzeedCnOBpSiLBD9MKGClMS8CpBxNPKYOF
         iYNRVQNnmcDjtqEb5je5GuOfxu5c4zutz4CWJxRgkikqLMjNFaw4coU2eJSnsCTk2Bb/
         fb2A==
X-Gm-Message-State: AOAM530XvlfRiZPZ2wq+vzkVcfDCp2GavSS1+5UwiC8dwB+IqlZcW7An
        XhiSXUHI/+bsHEKXqLT5kek=
X-Google-Smtp-Source: ABdhPJwKkDno9qbO9MaqAcgNA/pS8/cSxp5lHmNo4iy6PT5uYdmBjERtJd3yuL1/Ir647NtEfspeAw==
X-Received: by 2002:a1c:4085:: with SMTP id n127mr15399157wma.183.1603716765582;
        Mon, 26 Oct 2020 05:52:45 -0700 (PDT)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id a3sm23551139wrh.94.2020.10.26.05.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:52:45 -0700 (PDT)
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [RFC PATCH v2 1/2] security: add fault injection capability
Date:   Mon, 26 Oct 2020 12:52:26 +0000
Message-Id: <20201026125227.54520-2-a.nogikh@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026125227.54520-1-a.nogikh@gmail.com>
References: <20201026125227.54520-1-a.nogikh@gmail.com>
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
- Renamed should_fail_lsm_hook() to should_fail_lsm_hook().
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
2.29.0.rc1.297.gfa9743e501-goog

