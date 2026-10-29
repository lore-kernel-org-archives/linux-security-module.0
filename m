Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292079;
	b=z35TORQvs+BOqrCT4gv+fSsmDPoQAdFepSH8Ytbk7PkgSoKG6Vl5FyKMWI6B/TeVZtbQ
	 bPklpIdx/yQYgkaCnbJ8SVWvEFPpTH9NuGx4l2WVB541QJEsrLPMUyfDtQOq52r5tudHT
	 oWnsF3BBeSl8UPaxtLwrs1zdeXQZpP1Xx5tupmx4noUfC+BQTwUo28eUkfo9c0g315wLO
	 1etQSHQBlSGVxERo5mhpQnnNYmk7k9n7uMPnWQtzuK3Xfna8mdCHsUkOy3maaZjZfmk6w
	 grkB1AWfjzLwEvUOpHwUxQ5G9lZ5vRI3ah4qXfl0VCMSfaS+mSG0RNX+POgnu03sLZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292079;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kIACSg1GN4/Z1pmDBSV+ZT7hHzXLk1muYGH0ic4mbA0=;
	b=AChYUGhM2ZHlMH9DhtymoJ3T7c/5qlaE3jB5PIfdY6WhOjFEbhswG+DdYpZSAeIcCI+b
	 rixF7FfgfIiCMmf3oj0IW4WFgfrHSSLKgRK9C9Z091kFEdg24FGnHdLw7Bcd/maJ8PQTk
	 DKzcPVmQhxVus31g/sQpkwdMmnBq51RrMRJyN7UAeTWXY+A7d5dZTO+0G/aNF7OiZdk+E
	 SdWg7Q+CuI/i/8YcHlySJz4xsu9sejU+QxoNnlZDFqImQPo49cNFbyHbtUzSD5taLi4Fg
	 TvnVzC9YEGT7WxhAMmRmSr0An28FRkWaZk9CdCkXMbNsYdTrAos+2PjVnp/wbNQzhvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIv5CIvy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC663606A32A;
	Thu, 29 Oct 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIv5CIvy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DB01F01824;
	Thu, 29 Oct 2026 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292078;
	bh=kIACSg1GN4/Z1pmDBSV+ZT7hHzXLk1muYGH0ic4mbA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AIv5CIvyvNfsrxKRklpWYRMnTPnlYr6KJLKVGVWmlBg8XQrT3I+s1xn7dSZq6TkIb
	 y2jGaOZHkddAxee1QExDx3zc356q27iDokQThCAP2TflaV3wf+yClRNLM+eepLkRUS
	 BjMpq4a2Hq78GbRS+LgcWGYR0blzE1rNmklJC04fI0f3sTVpt5/adMAoh9w/omXfbB
	 3+qSIMSkRY+o3uToowP4jDDrNlydAU9zQ9f0djSOlnvV4JC7rVo+dM7Hch+Go2Ml6N
	 3sJagZGrl464IOHBaejtfUMoJhOSp0dQc7pZfN+anQmMnsyrLJ8hXljubl3a923SQQ
	 klC36KoQDzfig==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Oct 2026 17:40:58 +0100
Subject: [PATCH v2 3/7] selftests/bpf: add verifier tests for the namespace
 LSM hooks
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-work-security-namespace_free-v2-3-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5058; i=brauner@kernel.org;
 h=from:subject:message-id; bh=D7Bu3xuEXKU6T6CnrKC+mtAnsa77aiI5K6zZtrV1+0E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9LpfPdJ1RUB0uupeFVyBG1TZp6/ddd3fvqHuhLVdy3
 8JD5s/6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMW8Hwz4w3qG/G2bk2zy64
 Vc+Ov/vMvrurmsHc6PiVGYpFPvxqdgz/7Mv/rAtTenpqU0zuzbDmtGDxE2f321zy6phpsDf3WPU
 XRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test kfunc that takes a trusted struct ns_common and check that:

- namespace_init and namespace_free arguments can't be passed to it

- namespace_install arguments can

The test fails if namespace_init and namespace_free are treated as
trusted.

Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 ++
 .../selftests/bpf/progs/verifier_lsm_namespace.c   | 38 ++++++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  5 +++
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |  1 +
 4 files changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 04740ba37e91..3963a4f71d98 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -147,6 +147,7 @@
 #include "verifier_set_retval.skel.h"
 #include "verifier_lsm.skel.h"
 #include "verifier_lsm_init_xattr.skel.h"
+#include "verifier_lsm_namespace.skel.h"
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 #include "verifier_ctx_ptr_param.skel.h"
@@ -337,6 +338,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_set_retval(void)            { RUN(verifier_set_retval); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_verifier_lsm_init_xattr(void)       { RUN(verifier_lsm_init_xattr); }
+void test_verifier_lsm_namespace(void)        { RUN_TESTS(verifier_lsm_namespace); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm_namespace.c b/tools/testing/selftests/bpf/progs/verifier_lsm_namespace.c
new file mode 100644
index 000000000000..d14fa2363dcc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm_namespace.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/* The namespace hasn't been set up yet. */
+SEC("lsm/namespace_init")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(namespace_init_untrusted, struct ns_common *ns)
+{
+	bpf_kfunc_trusted_ns_test(ns);
+	return 0;
+}
+
+/* The namespace is being torn down. */
+SEC("lsm/namespace_free")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(namespace_free_untrusted, struct ns_common *ns)
+{
+	bpf_kfunc_trusted_ns_test(ns);
+	return 0;
+}
+
+/* setns() holds a reference to a fully set up namespace. */
+SEC("lsm/namespace_install")
+__success
+int BPF_PROG(namespace_install_trusted, const struct nsset *nsset,
+	     struct ns_common *ns)
+{
+	bpf_kfunc_trusted_ns_test(ns);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 6380f52f4dd2..8d6bd2237f34 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -350,6 +350,10 @@ __bpf_kfunc void bpf_kfunc_trusted_task_test(struct task_struct *ptr)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_trusted_ns_test(struct ns_common *ptr)
+{
+}
+
 __bpf_kfunc struct task_struct *bpf_kfunc_trusted_null_test(void)
 {
 	return NULL;
@@ -1030,6 +1034,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_release_test, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_ns_test)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_null_test, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_nullable_test)
 BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 3b810f1e438f..bc32c4078d27 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -355,6 +355,7 @@ int bpf_kfunc_st_ops_inc10(struct st_ops_args *args) __ksym;
 
 void bpf_kfunc_trusted_vma_test(struct vm_area_struct *ptr) __ksym;
 void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
+void bpf_kfunc_trusted_ns_test(struct ns_common *ptr) __ksym;
 struct task_struct *bpf_kfunc_trusted_null_test(void) __ksym;
 void bpf_kfunc_trusted_nullable_test(struct task_struct *ptr__nullable) __ksym;
 void bpf_kfunc_trusted_num_test(int *ptr) __ksym;

-- 
2.53.0

