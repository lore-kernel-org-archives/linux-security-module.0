Return-Path: <SRS0=3ULx=DW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D7C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 10:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540C122249
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 10:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8x+hh8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgJOKrN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgJOKrN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Oct 2020 06:47:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6FCC061755;
        Thu, 15 Oct 2020 03:47:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so2683100wmf.0;
        Thu, 15 Oct 2020 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfBI0kEhgBEp/yzB0r7jlPYrLmZoq5EWgUXwW8ULDvE=;
        b=W8x+hh8LIzS73BuduCL6HnAkYdDC8vj1/IwjjKwxG2WaTJ+r0Yk97BzUsliHy8rh/H
         reR5I2nIdWLtBa45BD3Yrz6mw0fVblXWUCAzcuRFu08MkxzFz1VvswPHfVpITf0gdDcZ
         1ndJ9eWJPsxc32Eojy48SOQPyA3AXafsemuk5jaTeMN5V7i4DjJt2l673iKnbn0BMmEG
         Lf8q1XEiEQ/IXezyygzo63NfISoRLzMoWCcsDwxxdOdfwqiSS70w9471MQVzTLei57Va
         6xVOB7bCC1IyoX445knNosXvgFCY3WkHZ9ESfw+aJMqJwZoGrq3P+QB+6kmZg8dqxLYX
         nArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfBI0kEhgBEp/yzB0r7jlPYrLmZoq5EWgUXwW8ULDvE=;
        b=kdkKOkPYE/wUXfTEJyPXSqnNOSCxHIsj/TLSI0ZGCPgf72WHyIjw5hgMrDKVPXZ0HR
         cWOR/dfrI876xk7xRuikRqEX18PLRK3wg1GCcldjR7y5H0k1ltjFTyrBK25EJuIJloAp
         tTEcIZWhPDs/4Hh5zNk0v392IIhj5pcnIKJmmVOq0yuMCtaY/1IKtv0epTO3LGxAAhXj
         8Fz8IDjCQjDYwiKMNC/q6HKA9xK8VTmpT554jdHltyQvkgLu+uDZ4qb9b6QxyzFM7rCz
         V9uQUOc9hwqmiwBEK2qkp8pFiN7InctzIBDUIjTEeeYSsfXYPujMs+8zW23w3ioR+ner
         jkVA==
X-Gm-Message-State: AOAM533NMmwDZfVGwGhQfr672VMa3u9sTQkq4PUIfW4mR/BPJaRfqiw/
        aIyLE8RzUEoUvBETGQL6A1U=
X-Google-Smtp-Source: ABdhPJxf1qYaWWa8NUeduoBjncuXuBFB7jHWlxhjxxHGBSdhdlci+KmRoPC26oscMpZ3SqiprtPWSQ==
X-Received: by 2002:a1c:6054:: with SMTP id u81mr3362929wmb.10.1602758831761;
        Thu, 15 Oct 2020 03:47:11 -0700 (PDT)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id c132sm3671249wmf.25.2020.10.15.03.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 03:47:11 -0700 (PDT)
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [RFC PATCH 1/1] security: add fault injection capability
Date:   Thu, 15 Oct 2020 10:46:49 +0000
Message-Id: <20201015104649.2104432-2-a.nogikh@gmail.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201015104649.2104432-1-a.nogikh@gmail.com>
References: <20201015104649.2104432-1-a.nogikh@gmail.com>
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
 lib/Kconfig.debug   |  6 +++++
 security/security.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 08c82666cf3e..0c9913ebe1c1 100644
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
index 69ff6e2e2cd4..bd4dbe720098 100644
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
+static int should_fail_lsm_hook(void)
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
+static inline int should_fail_lsm_hook(void) { return 0; }
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
+	int RC = should_fail_lsm_hook();			\
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
2.28.0.1011.ga647a8990f-goog

