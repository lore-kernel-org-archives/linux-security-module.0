Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008655;
	b=4SG9VYWNHQb1uKe98HWZFXj9hE8Y4whpyCX/eCayg0fv3zi+g7zrIqXF6yZ8bLSHotSU
	 rRTRgzGBCS39xPV6LPsnuJKrvQ/yyche4OXUV7b0JSgD54AgwLP6n71xxKbdlBp6udsgY
	 4oM3SZNBiRAsoJTUmskMK653IS6LliiFe+U7UYL66aLO0ulUYwJUYvK3gYyWIiaYmcSqS
	 1e3yRG0Xlk1oNdd90/81u0Mc1k1G3NMu8vt/2X2uN97T9+oOPxPdHp6bgmh7kHtY5RYod
	 6JzEqOj7/d6hyVwgCTkuuBlpBIoBXNrn3ndC+CBnSCKU8tty4ATNnzz2KqwvmsjKSTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008655;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cba8L0QLLvSJZxTSqvvmJNJnn6HTjA0KWyA9Y7/KAAI=;
	b=cMcTsoXtFvJN33q/4yEhEk2cEMIIeixzMwz4PJPMohbGYzoj3Sv5m6cniXH68w8+Wsir
	 jfIJmAny3syOEcXMXJgqxUZ/d4PkQm8gwvSSyXLVJ39OV/9w6ZYyNDtQgDV6afa3liRFZ
	 bw/s//s/l6pD0+fvdLM+qkB7Be+dbW06YSstiXUrjXr1qj92kOBJEMYpMG6Wr27ic5TDB
	 OPUFby+CsDIw44APRexsu8HuRdHA8AjVnkmbD2/2okcfsxu8xWaYuzw1jZPK0kbu9fzrV
	 kw4EYTspw8FaPU5oA9v3yJODl6HeDFmtNLJMjUFFoLuNdrNGFwst5gFe1euynriHrFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PonPjhKR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB7606A320;
	Mon, 26 Oct 2026 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PonPjhKR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1618C1F01828;
	Mon, 26 Oct 2026 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008654;
	bh=cba8L0QLLvSJZxTSqvvmJNJnn6HTjA0KWyA9Y7/KAAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PonPjhKRFYD251MxXmBWfG9RCypBKPvfT310FCB7O3Lf/2GXRx+a0qFTBFaWVp3nk
	 ivuBuM1B2bgw1RXDZqUCtiNSbv9r4AEt5LEJavsWMeluNVNHvp/Oa0SbIusOSzUNoe
	 WTK3HNl3m7L+j6bnbipIsjY7waLoKpayyhcX5xMPNN0Cb6gZ5AtFSQkGZCFTpSsBPV
	 vQWXwlSoRo6so4M5U3tN1FOWH2CFSminlF5GePk9J9Z2QnbDTacKHpb+w7iPL0KtAC
	 P0kMRlZnxtrQLY4uKStJeC3WTjbCd6ICogMsdupT++0DA2+okPkHPrPKDSdKeyTsQt
	 JhCL+EbW78NPA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 10:57:11 +0100
Subject: [PATCH 3/8] selftests/bpf: add verifier tests for the namespace
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
Message-Id: <20261026-work-security-namespace_free-v1-3-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4910; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JcpQUXTxQi3HIgm+dDZzkc2pBQ8yJUKjMEzHaGb0A4Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdV2Fy320gGCx6ozoh+UU5U/WZLc9/XOzSdAv6amITc
 uVTXCBzRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER4GRj+u4WVn9Y60bOqIqFK
 1P9p3an42+Hbdge1Cx1ibXizRe/+VIa/so9ubLDfeCBjebjQkq4918xMDpZo7d21LeW55stuBRc
 rFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test kfunc that takes a trusted struct ns_common and check that:

- namespace_init and namespace_free arguments can't be passed to it

- namespace_install arguments can

The test fails if namespace_init and namespace_free are treated as
trusted.

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

