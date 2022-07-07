Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB5DC43334
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 22:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiGGWdJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiGGWcv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 18:32:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FC6759C
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 15:32:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j193so3193463oih.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 Jul 2022 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5md+eRaroN3b4x5GXk8vDK0Yn23IzIrTWAe3e+Lx7Q=;
        b=aNBBpDIdjJ8tvtO8GaBiWmkh9oQhGcb6KAdgM/0e35zl+mr2r/xgzUWjFkfNmJOaEm
         Jvhr+t6gmYTNnCQMTKv+oMfi4pLA4Ogl9NJlch8V8tQGl16wtwfJpFXSaYcVKfYfcrMM
         jMLEPkI/8F3wR7TAumcOZqojwn71aRJyKEYgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5md+eRaroN3b4x5GXk8vDK0Yn23IzIrTWAe3e+Lx7Q=;
        b=iwJqN/3AZM6vPTGm7YESM9yjREifc/kFjN6ORMnq9/JWAiav0v1t5EHBWLpuzMtpdx
         XOXocwpehqtjNJe16Spo8R6iJRsPni8NQx2nc1ArLS4s0yqn1faTjV6KTqMfh7uZRjNc
         QsurbjXwO2y3+oaPenexQgUFgv5UDyZg875sYZpCKtjqlKZQUpa4KA8HI/POcU0QeI81
         ZehsGj8TI88jDOvDKyiB3a0dLnq6rZdW/pt+54VPZZ39XzHJIoW4TpEllIYaiw1w8UM3
         p2fNUBIkB2H3HP5ww2OT5m3pFHsRYKqxkf0oVXF1P/+3DduraEWrXpJpsbt/QSJRC1Ws
         3EqQ==
X-Gm-Message-State: AJIora8BMBd7ZSl9GwFJ6L6NO9ASEKLjeZo8jdIO4PC6HE5qUztHMaAA
        4k4B68J4rofewKbaGdnDcGlufw==
X-Google-Smtp-Source: AGRyM1srNOFm7S5tg87SqlO14myBHyfKEwvfh+AVIicT3RMtZrigLBMXO3g8hWk7379whlu6136QGw==
X-Received: by 2002:a05:6808:20a7:b0:337:a9f9:24fb with SMTP id s39-20020a05680820a700b00337a9f924fbmr157852oiw.220.1657233162560;
        Thu, 07 Jul 2022 15:32:42 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id i16-20020a05683033f000b00616b835f5e7sm16246222otu.43.2022.07.07.15.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:32:41 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v2 3/4] selftests/bpf: Add tests verifying bpf lsm create_user_ns hook
Date:   Thu,  7 Jul 2022 17:32:27 -0500
Message-Id: <20220707223228.1940249-4-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707223228.1940249-1-fred@cloudflare.com>
References: <20220707223228.1940249-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The LSM hook create_user_ns was introduced to provide LSM's an
opportunity to block or allow unprivileged user namespace creation. This
test serves two purposes: it provides a test eBPF implementation, and
tests the hook successfully blocks or allows user namespace creation.

This tests 4 cases:

        1. Unattached bpf program does not block unpriv user namespace
           creation.
        2. Attached bpf program allows user namespace creation given
           CAP_SYS_ADMIN privileges.
        3. Attached bpf program denies user namespace creation for a
           user without CAP_SYS_ADMIN.
        4. The sleepable implementation loads

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
The generic deny_namespace file name is used for future namespace
expansion. I didn't want to limit these files to just the create_user_ns
hook.

Changes since v1:
- Introduce this patch
---
 .../selftests/bpf/prog_tests/deny_namespace.c | 88 +++++++++++++++++++
 .../selftests/bpf/progs/test_deny_namespace.c | 39 ++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/deny_namespace.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_deny_namespace.c

diff --git a/tools/testing/selftests/bpf/prog_tests/deny_namespace.c b/tools/testing/selftests/bpf/prog_tests/deny_namespace.c
new file mode 100644
index 000000000000..a1fb07038dd5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/deny_namespace.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include "test_deny_namespace.skel.h"
+#include <sched.h>
+#include "cap_helpers.h"
+
+#define STACK_SIZE (1024 * 1024)
+static char child_stack[STACK_SIZE];
+
+int clone_callback(void *arg)
+{
+	return 0;
+}
+
+static int create_new_user_ns(void)
+{
+	int status;
+	pid_t cpid;
+
+	cpid = clone(clone_callback, child_stack + STACK_SIZE,
+		     CLONE_NEWUSER | SIGCHLD, NULL);
+
+	if (cpid == -1)
+		return errno;
+
+	if (cpid == 0)
+		return 0;
+
+	waitpid(cpid, &status, 0);
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return -1;
+}
+
+static void test_create_user_ns_bpf(void)
+{
+	__u32 cap_mask = 1ULL << CAP_SYS_ADMIN;
+	__u64 old_caps = 0;
+
+	ASSERT_OK(create_new_user_ns(), "priv new user ns");
+
+	cap_disable_effective(cap_mask, &old_caps);
+
+	ASSERT_EQ(create_new_user_ns(), EPERM, "unpriv new user ns");
+
+	if (cap_mask & old_caps)
+		cap_enable_effective(cap_mask, NULL);
+}
+
+static void test_unpriv_create_user_ns_no_bpf(void)
+{
+	__u32 cap_mask = 1ULL << CAP_SYS_ADMIN;
+	__u64 old_caps = 0;
+
+	cap_disable_effective(cap_mask, &old_caps);
+
+	ASSERT_OK(create_new_user_ns(), "no-bpf unpriv new user ns");
+
+	if (cap_mask & old_caps)
+		cap_enable_effective(cap_mask, NULL);
+}
+
+void test_deny_namespace(void)
+{
+	struct test_deny_namespace *skel = NULL;
+	int err;
+
+	if (test__start_subtest("unpriv_create_user_ns_no_bpf"))
+		test_unpriv_create_user_ns_no_bpf();
+
+	skel = test_deny_namespace__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel load"))
+		goto close_prog;
+
+	err = test_deny_namespace__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto close_prog;
+
+	if (test__start_subtest("create_user_ns_bpf"))
+		test_create_user_ns_bpf();
+
+	test_deny_namespace__detach(skel);
+
+close_prog:
+	test_deny_namespace__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_deny_namespace.c b/tools/testing/selftests/bpf/progs/test_deny_namespace.c
new file mode 100644
index 000000000000..eedede891431
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_deny_namespace.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+#include <linux/capability.h>
+
+struct kernel_cap_struct {
+	__u32 cap[_LINUX_CAPABILITY_U32S_3];
+} __attribute__((preserve_access_index));
+
+struct cred {
+	struct kernel_cap_struct cap_effective;
+} __attribute__((preserve_access_index));
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm/create_user_ns")
+int BPF_PROG(test_create_user_ns, const struct cred *cred, int ret)
+{
+	struct kernel_cap_struct caps = cred->cap_effective;
+	int cap_index = CAP_TO_INDEX(CAP_SYS_ADMIN);
+	__u32 cap_mask = CAP_TO_MASK(CAP_SYS_ADMIN);
+
+	if (ret)
+		return 0;
+
+	ret = -EPERM;
+	if (caps.cap[cap_index] & cap_mask)
+		return 0;
+
+	return -EPERM;
+}
+
+SEC("lsm.s/create_user_ns")
+int BPF_PROG(test_sleepable_create_user_ns, const struct cred *cred, int ret)
+{
+	return 0;
+}
-- 
2.30.2

