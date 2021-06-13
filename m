Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA0DC48BCF
	for <linux-security-module@archiver.kernel.org>; Sun, 13 Jun 2021 06:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F28611ED
	for <linux-security-module@archiver.kernel.org>; Sun, 13 Jun 2021 06:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFMGsB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 13 Jun 2021 02:48:01 -0400
Received: from m12-14.163.com ([220.181.12.14]:37430 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhFMGsB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 13 Jun 2021 02:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+GKmK
        TI4RYtXz8Sc9ZBp4cs0XGgq7AZpUGAzKjq4WhI=; b=XLYqdcH2DF91JkKCjl8kj
        Lbq8J8/Xu/kCvLNLyrpJzBvUmRl6IZX2X/bva2X4EEZBC5JsDhCj/n7/9MzbLifx
        zcAEbziApATxxATicI3NTgUREJ5C5g45Yspv8Wwrex264TUNiXjm3KD/4Bj9AqWS
        QHDJUOVM1Vz1zJzwP7wWvQ=
Received: from ubuntu.localdomain (unknown [183.159.69.187])
        by smtp10 (Coremail) with SMTP id DsCowACHhD0xqcVgnClcOg--.2017S4;
        Sun, 13 Jun 2021 14:44:02 +0800 (CST)
From:   Li Qiang <liq3ea@163.com>
To:     akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, paul@paul-moore.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, liq3ea@gmail.com,
        Li Qiang <liq3ea@163.com>
Subject: [PATCH] security: add LSM hook at the memfd_create point
Date:   Sat, 12 Jun 2021 23:43:59 -0700
Message-Id: <20210613064359.389683-1-liq3ea@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACHhD0xqcVgnClcOg--.2017S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1xJFW3KryxKr4xGF4rKrg_yoW5uw43pF
        4kCF4rta18AFy7Z393C3W7G3W3J3yFgr47XrW2gw1UAF1Iqw4vqF4DuF1Ykrn5GrZrZFW0
        9ayxWrW3CrWjqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UI1v3UUUUU=
X-Originating-IP: [183.159.69.187]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTxCwbVsGZJBP6gABsP
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

memfd_create is often used in the fileless attack.
Let's create a LSM hook so that we can detect and prevent
anonymous file creation.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 include/linux/lsm_hook_defs.h |  4 ++++
 include/linux/lsm_hooks.h     |  5 +++++
 include/linux/security.h      | 15 +++++++++++++++
 mm/memfd.c                    |  6 ++++++
 security/security.c           |  7 +++++++
 5 files changed, 37 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 04c01794de83..955556d0d084 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -403,3 +403,7 @@ LSM_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event)
 LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
 LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
 #endif /* CONFIG_PERF_EVENTS */
+
+#ifdef CONFIG_MEMFD_CREATE
+LSM_HOOK(int, 0, memfd_create, const char *name, unsigned int flags)
+#endif /* CONFIG_MEMFD_CREATE */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5c4c5c0602cb..e9c31dbb2783 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1557,6 +1557,11 @@
  * 	Read perf_event security info if allowed.
  * @perf_event_write:
  * 	Write perf_event security info if allowed.
+ *
+ * Security hooks for anonymous file
+ *
+ * @memfd_create:
+ *	Check whether anonymous file creation is allowed
  */
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
diff --git a/include/linux/security.h b/include/linux/security.h
index 06f7c50ce77f..44b43a7569b5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2037,4 +2037,19 @@ static inline int security_perf_event_write(struct perf_event *event)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_PERF_EVENTS */
 
+#ifdef CONFIG_MEMFD_CREATE
+#ifdef CONFIG_SECURITY
+
+extern int security_memfd_create(const char *name, unsigned int flags);
+
+#else
+
+static inline int security_memfd_create(const char *name, unsigned int flags)
+{
+	return 0;
+}
+
+#endif /* CONFIG_SECURITY */
+#endif /* CONFIG_MEMFD_CREATE */
+
 #endif /* ! __LINUX_SECURITY_H */
diff --git a/mm/memfd.c b/mm/memfd.c
index 2647c898990c..dbd309e455d2 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -18,6 +18,7 @@
 #include <linux/hugetlb.h>
 #include <linux/shmem_fs.h>
 #include <linux/memfd.h>
+#include <linux/security.h>
 #include <uapi/linux/memfd.h>
 
 /*
@@ -290,6 +291,11 @@ SYSCALL_DEFINE2(memfd_create,
 		goto err_name;
 	}
 
+	if (security_memfd_create(name, flags)) {
+		error = -EPERM;
+		goto err_name;
+	}
+
 	fd = get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
 	if (fd < 0) {
 		error = fd;
diff --git a/security/security.c b/security/security.c
index b38155b2de83..5723408c5d0b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2624,3 +2624,10 @@ int security_perf_event_write(struct perf_event *event)
 	return call_int_hook(perf_event_write, 0, event);
 }
 #endif /* CONFIG_PERF_EVENTS */
+
+#ifdef CONFIG_MEMFD_CREATE
+int security_memfd_create(const char *name, unsigned int flags)
+{
+	return call_int_hook(memfd_create, 0, name, flags);
+}
+#endif /* CONFIG_MEMFD_CREATE */
-- 
2.25.1

