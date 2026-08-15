Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C93939A2
	for <linux-security-module@vger.kernel.org>; Sat, 15 Aug 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786792856; cv=none; b=cyWzrzYr0jzMEmfLV/O5gtPlaj8ImXVqqDfx/+KozrvhaSos/85CC8SYUAwQiF09HErrXUJzXetnb0fjN4E4lqumWsi4Fglfw0GzyDHgrjm1MrAR8kxNLBlC0SyptHdILVsGFEBK5/zFnJnZjkxpBbQ1nVJ6W1ddylXuOIDgUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786792856; c=relaxed/simple;
	bh=BRb/H6gQyImwNG31QtMHC6XRD9DnDYtem0s3kH7ioLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6C+vrBHtAwX/Q8NnNGgAEJbpruyPeWpHHZPNe0WWJZKuYdRzQalOkW//GjMrTmvcITx1/+2+zjgNDk8qandKR+2IxrtIpOLMy0WpRwlOksUPQt2qR5YMYernE3QRT1viqKiAN0AQvnRXpRBoMtlesddSZU+t8KmVT9HAmQg2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by+J+fAH; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by+J+fAH"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-836ce6cbe1eso23291537b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 15 Aug 2026 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786792852; x=1787397652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPYKJdV6UanlxlzF1JXSEmSoCuW7gRMwUCGNDo7gTeg=;
        b=by+J+fAHdcMUb7Xdj6yvosWZmBP1qQF2qsmyiaK3BUwvn4rMEarjAAnCrbqWGmtNio
         gEh/eokb0ShtUsseLO1JYk89IidCZnewqUK3uDHaPyp7cwdT9VnIdDy88pB3F9uXu6gG
         bxvo+NVtQippMaTkgIjUrDn3In6eRPc0+JPfCfncrcrOqgJyCU58eD/atgMbqN51XWUH
         fsVZyfsIxccOYyyQSe4Qhd1ms2QH9J+7HR8CVeBK17uDmrhNGvy0cEBskAtdLQFCkI6V
         JxcQEeuzVFYFOui+umrlroq1CRq3RE61ZJNzUK98nbk+L/SpInAIEnftdrLjjiuV/aDw
         KACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786792852; x=1787397652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JPYKJdV6UanlxlzF1JXSEmSoCuW7gRMwUCGNDo7gTeg=;
        b=Y6wpyN0U4iBKwWRSA+Tof0kYChuznUZkjRazHjDb02lLIemcbvIkcCbmiC4ICfPNSx
         09HXUEHRjRlcddss2JJAt+7VrJd5CFwFGFbJcNSwL0x2jHjdQcAD47hkjivkCzfUsGRv
         PK4thykR+pmcZi8iJne1/DBW3v9n9rmhAW7v9qFuoc/MUBaHeAI+z1gTJyWBMMcj/0Px
         tFqhW8R9mOSRoPeXN4jzFawmCYWfEItK3ALGQuzja79NQ27qpCexAqoXDl3rcnSZuAH+
         F0kgyarpG0oBl+Xdmm+E4tB3c7EivkiJdKm7URw/3+RYzNMTQBOK23ko7xmnDwVmZZ15
         ZCMw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5Qv+R1zboWIG25N1mQoToCGMoTh/8Z0oZPhDJzOtmJZ4T/p7bDP8MUyv+Kl725vtE/cKQwHUuQkfsfyl0tXAhyWgXcaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHKCTMjD8X7Cp2Ga40wa/X7p2NljALCDoygoZMvt8jTKbpVn1
	dBsA1KbbY1B9X60WV5C5UZoV/C/L6xRNhXUC0VvPQwHGonyRPzREuA0R6FjBn4nM
X-Gm-Gg: AR+sD10iFzLxJV3IFMOGEaSWArJz35slajWEvRb13n8y/BsQVKvGKLAHkYv++dl5aiS
	uGOlTk91CjArFNdbUrT+WFCydfiTPxKt5PTuGcKi2goJfyxg1XWZMgYsO2RGsc8xzbYH81nwnmt
	VjIqUYBrAIaxv6F1XzQuA4eFcn7SV8+IK4EIKjS8l20VG6V9VXQ4lM1j8A9jMyNtvApXX2ujn91
	OVyLXslZJ0FsHeDC0ZStRTFptaVONlZzpIxIft6fWfmhPzY8biLdtrw1Yg6A3FYvpKlC1n1zYWC
	zIx+MOJP12SsKgmUC3IVP8yFFncaoKuPBKEHga5W/MoZAeVYQRQHubJoDoF5ChJi0dbx75xj4qB
	dkma00Myhfeki2TnL9vQZOMi9sdBSYB6uFio0NGO7coYb+W8WJr3ClsosxnH9BznFk1PjFZuei3
	3BFci/KsFI+8zMzYHqjWrvtpyyWcWqSztlXYEy4JE3yC+elePtkFOgkUHwWqztATFtn2KClNBLm
	8TtdfhFpUBn0GNipsEjFSZVMcrhYdzqcbYOQDs=
X-Received: by 2002:a05:690c:e1c6:20b0:812:996f:176e with SMTP id 00721157ae682-83712da2b76mr35634757b3.26.1786792851947;
        Sat, 15 Aug 2026 04:20:51 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:31f0:efe0:f2d8:ae44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c36a84d9sm24388037b3.46.2026.08.15.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:20:51 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_security_locked_down kfunc
Date: Sat, 15 Aug 2026 07:20:41 -0400
Message-ID: <20260815112041.1248855-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260815112041.1248855-1-utilityemal77@gmail.com>
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the bpf_security_locked_down() kfunc. An LSM program attached to
the locked_down hook denies LOCKDOWN_HIBERNATION, so a syscall program
querying the kfunc observes both verdicts deterministically without
touching real lockdown state: 0 for LOCKDOWN_KEXEC and -EPERM for
LOCKDOWN_HIBERNATION. Out-of-range reasons must return -EINVAL.

Programs in denied calling contexts (a tracing program, and an LSM
program attached to the locked_down hook itself) must be rejected at
load time by the kfunc filter.

The selftest config guarantees the verdicts are stable: the bpf LSM is
in CONFIG_LSM and the lockdown LSM is not, so the kernel cannot already
be locked down.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/prog_tests/lsm_kfuncs.c     | 28 +++++++++++++++
 .../testing/selftests/bpf/progs/lsm_kfuncs.c  | 34 +++++++++++++++++++
 .../selftests/bpf/progs/lsm_kfuncs_fail.c     | 26 ++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
new file mode 100644
index 000000000000..c836851d8397
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "lsm_kfuncs.skel.h"
+#include "lsm_kfuncs_fail.skel.h"
+
+void test_lsm_kfuncs(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct lsm_kfuncs *skel;
+
+	RUN_TESTS(lsm_kfuncs_fail);
+
+	skel = lsm_kfuncs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (!ASSERT_OK(lsm_kfuncs__attach(skel), "attach"))
+		goto out;
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.query),
+					      &opts), "test_run"))
+		goto out;
+	ASSERT_EQ(skel->data->ret_clear, 0, "not locked down");
+	ASSERT_EQ(skel->data->ret_denied, -EPERM, "locked down");
+	ASSERT_EQ(skel->data->ret_invalid_low, -EINVAL, "LOCKDOWN_NONE invalid");
+	ASSERT_EQ(skel->data->ret_invalid_high, -EINVAL, "CONFIDENTIALITY_MAX invalid");
+out:
+	lsm_kfuncs__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_kfuncs.c b/tools/testing/selftests/bpf/progs/lsm_kfuncs.c
new file mode 100644
index 000000000000..2637b9bc9025
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_kfuncs.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern int bpf_security_locked_down(enum lockdown_reason what) __ksym;
+
+/* Reason nothing in the test environment genuinely queries or locks. */
+#define DENY_REASON LOCKDOWN_HIBERNATION
+#define ALLOW_REASON LOCKDOWN_KEXEC
+
+int ret_clear = 1;
+int ret_denied = 1;
+int ret_invalid_low = 1;
+int ret_invalid_high = 1;
+
+SEC("lsm/locked_down")
+int BPF_PROG(lockdown_hook, enum lockdown_reason what)
+{
+	return what == DENY_REASON ? -EPERM : 0;
+}
+
+SEC("syscall")
+int query(void *ctx)
+{
+	ret_clear = bpf_security_locked_down(ALLOW_REASON);
+	ret_denied = bpf_security_locked_down(DENY_REASON);
+	ret_invalid_low = bpf_security_locked_down(LOCKDOWN_NONE);
+	ret_invalid_high = bpf_security_locked_down(LOCKDOWN_CONFIDENTIALITY_MAX);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c b/tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c
new file mode 100644
index 000000000000..b9861d9c4f16
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern int bpf_security_locked_down(enum lockdown_reason what) __ksym;
+
+/* Tracing programs must be rejected by the kfunc filter. */
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("calling kernel function bpf_security_locked_down is not allowed")
+int BPF_PROG(tracing_caller, int a)
+{
+	bpf_security_locked_down(LOCKDOWN_KEXEC);
+	return 0;
+}
+
+/* As must locked_down programs, which would recurse into the dispatch. */
+SEC("lsm/locked_down")
+__failure __msg("calling kernel function bpf_security_locked_down is not allowed")
+int BPF_PROG(recursive_caller, enum lockdown_reason what)
+{
+	return bpf_security_locked_down(what);
+}
-- 
2.54.0

