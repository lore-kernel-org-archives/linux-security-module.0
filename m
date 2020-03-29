Return-Path: <SRS0=qkJb=5O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B6CC2D0F0
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Mar 2020 00:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DC620780
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Mar 2020 00:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n+MR70Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgC2AoK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 28 Mar 2020 20:44:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38474 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgC2AoK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 28 Mar 2020 20:44:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so16589132wrv.5
        for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2020 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nud9iCgymhMny/b6LyKOYPyZH+9aFPP2eYRxU5pasn0=;
        b=n+MR70OtgEACRUkau4HKI3tDv8aY/4F+KWuArkY5BgtpgBkbSS0bnyC6VlAFG11kvn
         JAo+643ejsE2VneQ6BkGT7xTY0Y0s7VGIG62fYmZpeoSmp6yfbu0nJaIC1AeByP1e4lk
         VgAtNgf8xc2seps1l+zFsuTzYXQRRDDGbXUms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nud9iCgymhMny/b6LyKOYPyZH+9aFPP2eYRxU5pasn0=;
        b=LqVrXbFbJgA0z3Amja25WN270nbktrVAlGogJYPMdI5P8+mPqbOtasQeI0Qxh/9zIP
         8NMeGOktV5X2fHSMR1n4RBulSc+GtP9HiyRISZqVACU1qrikNeEAFN7tboHWn5oAg+Du
         j38mMBFM48fr+RXyIcwWFV+ApvlPXfgUSlVSNVfEa9qHZB2C3g8Xq/ccOgGLCthQH5Ei
         bwGR8KQesexFXxT/RwyvEDvJiRO0Ww69cp2kQIieOGftmeCLWt9MMsdkjCrDTqBdpVsN
         ZtedqNt94uPETBl1XjZQpGTr7+RS8YXJoyLT+faDMiSJIjL6rMwP4So4iJyXBNtrW3cb
         AIJw==
X-Gm-Message-State: ANhLgQ1NsmGEwk7o+djVlIC6s5+e3LGPOqeRxaMagCZFeU61jM8fBsrc
        K0RRMu4R8X1cF0Bfb/gsOSFikA==
X-Google-Smtp-Source: ADFU+vu2NjYr2YC9FbLy3DLCJLQU+o7CWH6MxhvNywhIsEPhZBxvVGNXSnpRtDpUirBMZupQNhZ9YQ==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr7646845wru.371.1585442648597;
        Sat, 28 Mar 2020 17:44:08 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id e5sm14577647wru.92.2020.03.28.17.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 17:44:08 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
Date:   Sun, 29 Mar 2020 01:43:55 +0100
Message-Id: <20200329004356.27286-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200329004356.27286-1-kpsingh@chromium.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

* Load/attach a BPF program that hooks to file_mprotect (int)
  and bprm_committed_creds (void).
* Perform an action that triggers the hook.
* Verify if the audit event was received using the shared global
  variables for the process executed.
* Verify if the mprotect returns a -EPERM.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
---
 tools/testing/selftests/bpf/config            |  2 +
 .../selftests/bpf/prog_tests/test_lsm.c       | 86 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       | 48 +++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 5dc109f4c097..60e3ae5d4e48 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -35,3 +35,5 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_IPV6_SIT=m
 CONFIG_BPF_JIT=y
+CONFIG_BPF_LSM=y
+CONFIG_SECURITY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
new file mode 100644
index 000000000000..1e4c258de09d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <malloc.h>
+#include <stdlib.h>
+
+#include "lsm.skel.h"
+
+char *CMD_ARGS[] = {"true", NULL};
+
+int heap_mprotect(void)
+{
+	void *buf;
+	long sz;
+	int ret;
+
+	sz = sysconf(_SC_PAGESIZE);
+	if (sz < 0)
+		return sz;
+
+	buf = memalign(sz, 2 * sz);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	ret = mprotect(buf, sz, PROT_READ | PROT_WRITE | PROT_EXEC);
+	free(buf);
+	return ret;
+}
+
+int exec_cmd(int *monitored_pid)
+{
+	int child_pid, child_status;
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		*monitored_pid = getpid();
+		execvp(CMD_ARGS[0], CMD_ARGS);
+		return -EINVAL;
+	} else if (child_pid > 0) {
+		waitpid(child_pid, &child_status, 0);
+		return child_status;
+	}
+
+	return -EINVAL;
+}
+
+void test_test_lsm(void)
+{
+	struct lsm *skel = NULL;
+	int err, duration = 0;
+
+	skel = lsm__open_and_load();
+	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
+		goto close_prog;
+
+	err = lsm__attach(skel);
+	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
+		goto close_prog;
+
+	err = exec_cmd(&skel->bss->monitored_pid);
+	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	CHECK(skel->bss->bprm_count != 1, "bprm_count", "bprm_count = %d\n",
+	      skel->bss->bprm_count);
+
+	skel->bss->monitored_pid = getpid();
+
+	err = heap_mprotect();
+	if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
+		  errno))
+		goto close_prog;
+
+	CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
+	      "mprotect_count = %d\n", skel->bss->mprotect_count);
+
+close_prog:
+	lsm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
new file mode 100644
index 000000000000..a4e3c223028d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include  <errno.h>
+
+char _license[] SEC("license") = "GPL";
+
+int monitored_pid = 0;
+int mprotect_count = 0;
+int bprm_count = 0;
+
+SEC("lsm/file_mprotect")
+int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
+	     unsigned long reqprot, unsigned long prot, int ret)
+{
+	if (ret != 0)
+		return ret;
+
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	int is_heap = 0;
+
+	is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+		   vma->vm_end <= vma->vm_mm->brk);
+
+	if (is_heap && monitored_pid == pid) {
+		mprotect_count++;
+		ret = -EPERM;
+	}
+
+	return ret;
+}
+
+SEC("lsm/bprm_committed_creds")
+int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
+{
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (monitored_pid == pid)
+		bprm_count++;
+
+	return 0;
+}
-- 
2.20.1

