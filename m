Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C1C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AC064E83
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 15:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBVPFr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:05:47 -0500
Received: from smtp-42ab.mail.infomaniak.ch ([84.16.66.171]:44131 "EHLO
        smtp-42ab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230215AbhBVPFp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 10:05:45 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Dklpb3pLxzMppP0;
        Mon, 22 Feb 2021 16:04:55 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Dklpb0tVvzlh8TH;
        Mon, 22 Feb 2021 16:04:55 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default LSM stack ordering
Date:   Mon, 22 Feb 2021 16:06:08 +0100
Message-Id: <20210222150608.808146-2-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222150608.808146-1-mic@digikod.net>
References: <20210222150608.808146-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Add a new option CONFIG_LSM_AUTO to enable users to delegate default LSM
stacking order to kernel developers.  This enable to keep a consistent
order of enabled LSM when changing the LSM selection, especially when a
new LSM is added to the kernel.

CONFIG_LSM depends on !CONFIG_LSM_AUTO, which is backward compatible and
gives the opportunity to users to select CONFIG_LSM_AUTO with a make
oldconfig.

CONFIG_LSM and CONFIG_LSM_AUTO depend on CONFIG_SECURITY, which makes
sense because an LSM depends on the security framework.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210222150608.808146-2-mic@digikod.net
---

Changes since v2:
* Revamp without virtual dependencies but a new option to automatically
  enable all selected LSMs.

Changes since v1:
* Add CONFIG_SECURITY as a dependency of CONFIG_LSM.  This prevent an
  error when building without any LSMs.
---
 security/Kconfig    | 19 +++++++++++++++++++
 security/security.c | 26 +++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f99f1d..fae083e9867d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -243,6 +243,7 @@ source "security/integrity/Kconfig"
 
 choice
 	prompt "First legacy 'major LSM' to be initialized"
+	depends on SECURITY
 	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
 	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
 	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
@@ -275,8 +276,26 @@ choice
 
 endchoice
 
+config LSM_AUTO
+	bool "Automatically enable all selected LSMs at boot"
+	depends on SECURITY
+	default y
+	help
+	  This automatically configure the build-time selected LSMs to be
+	  enabled at boot unless the "lsm=" parameter is provided.
+
+	  If this option is not selected, it will be required to configure and
+	  maintained a static list of enabled LSMs that may become inconsistent
+	  with future user configuration.  Indeed, this list will not be
+	  automatically upgraded when selecting a new (future) LSM, e.g. with
+	  make oldconfig.
+
+	  If you are unsure how to answer this question, answer Y.
+
+# This lists should be synchronized with LSM_ORDER defined in security/security.c .
 config LSM
 	string "Ordered list of enabled LSMs"
+	depends on SECURITY && !LSM_AUTO
 	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
 	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
 	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
diff --git a/security/security.c b/security/security.c
index 401663b5b70e..defa1d2c40a3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -82,7 +82,31 @@ static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
 static __initdata const char *chosen_lsm_order;
 static __initdata const char *chosen_major_lsm;
 
-static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
+#ifdef CONFIG_LSM
+#define LSM_ORDER	CONFIG_LSM
+#else
+
+/*
+ * This lists should be synchronized with the default values of CONFIG_LSM
+ * defined in security/Kconfig .
+ */
+#define LSM_ORDER_PRE	"lockdown,yama,loadpin,safesetid,integrity,"
+
+#if defined(CONFIG_DEFAULT_SECURITY_SMACK)
+#define LSM_ORDER	LSM_ORDER_PRE "smack,selinux,tomoyo,apparmor,bpf"
+#elif defined(CONFIG_DEFAULT_SECURITY_APPARMOR)
+#define LSM_ORDER	LSM_ORDER_PRE "apparmor,selinux,smack,tomoyo,bpf"
+#elif defined(CONFIG_DEFAULT_SECURITY_TOMOYO)
+#define LSM_ORDER	LSM_ORDER_PRE "tomoyo,bpf"
+#elif defined(CONFIG_DEFAULT_SECURITY_DAC)
+#define LSM_ORDER	LSM_ORDER_PRE "bpf"
+#else
+#define LSM_ORDER	LSM_ORDER_PRE "selinux,smack,tomoyo,apparmor,bpf"
+#endif
+
+#endif /* CONFIG_LSM */
+
+static __initconst const char * const builtin_lsm_order = LSM_ORDER;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
-- 
2.30.0

