Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CE4FECCD
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188429; cv=none; b=a13zrS6nSdW05F9QUk3h2GVOPC3cSr6hthh+etfM7FyoVA76nNi2zJUSjB4gWxPIjDztf5aiWHdZ96KlTcG7s0i4AlxhTGX9JmWKRYI56NCgeR12vgjVpjmGqOlOJBsxEYtATVwLE0V3hkEF9C8FDJYLQ+JpDkYUSf8dNxSR328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188429; c=relaxed/simple;
	bh=KJmAMn9kyZlisXvbTbDVwQ8wzaahdzZjp32Cx71hT9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpdQ1WecWDVCNbLIKTK/NDHWFWybicTsRnTnUESfnbxyjxIJmZm/CojHV7+3+LplWy+epadnpFVrJAoOQRr5wAnd6l3fEx+DSqJlRxNWYzmNmoJHxog9+KUanZ+/ny92jFgNN9+VnQ8MMwvQXZMoDdORfkNph0eErjeb2HmBjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iasmlXfc; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iasmlXfc"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-85a50f6a7f7so40534477b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188426; x=1788793226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0HdDzHGCpm+jxHHcKn7aF3osQpvVTCYyJTtW+VBgeM8=;
        b=iasmlXfcIQvkWIy4Q3+gCBHK5OhpLF6ESTfTNWXYZlSqRyNBXqDTdEFmwUyrjg0VWP
         +99EeCAHNtDbXSIfKv3uCElmQ7uyIT3zkTbtVzKGK0WzZa2XFURUTIh1jBK3NHeqGT+q
         Z0gdAxvE4aEvalZfPvlZwevFpubCM6BpDWw2XOkjQx0dWRAOkTrfT9TlKIG5Q4yhlZJe
         KqeGAgAH1p/B7WG5QGoTAwN1mw3L15SbJeTFbLAAgGSVuv8mWdrkkMmygBthn0JsHlqD
         Izp2iz96n6kd/JTCMpbIooS8jdeblIQ47jbV7FhHGiXuXfE+jUvgXTRC8mJ9HZnM5/LL
         3YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188426; x=1788793226;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0HdDzHGCpm+jxHHcKn7aF3osQpvVTCYyJTtW+VBgeM8=;
        b=aAXUJo+xfaLRx5l9nCfRwHz77Zf2AqUdp5rxsftyG3R4qvU4iqwx3/YNY+NJ/I95bQ
         2/i83THCn4HKchb1jWYg+nOeXY9bn9lz6UBr8PeOcIOhwAKq4kulTWSNTZ3WgJmbjk2I
         O0q+FH4VDiUZjRx4muxkwooYR7QUpUzo24cliH+azBrCenj7ef8IFCMukbGwdf5Nzm6l
         Uq0uMQShGVoJLJPBFA2Pu4/XTIbUW9TBLJqJlZW0+OPhZvNuLatMCbtHRPVoupD+NHJ6
         j8+H7UW7KxuJY4hD40VY9Mp6ms1Oo8Fwi6EJeVWlr7zyrwgqSei5PNfrgiTGKbWYvfep
         pCdA==
X-Forwarded-Encrypted: i=1; AKwUvBx+x2MHVqzB3a3mf9Qy/RZvZFOqWfCjPExp+EbKzblG13/Ua1d7zvd8FiJniLLywsTG8gMPAFKy5wT4oLrq6MJNodoDrV0=@vger.kernel.org
X-Gm-Message-State: AFuF++lvPg+0Gb7YrZgE4cMcRAmhU7nuc2pAq6L4PwDFIyvuLfOFpvoR
	udaLkBDvMD32Cme/PSTScjXJMPrtbZQ80qgn4eXfQHFEHR4aK+1xpFs6TQGabRLY
X-Gm-Gg: AYBFou3EAp/m8kilGQZl1qMiLXCVLEGoR/Y+LO7tYfdsJnCrRyiscFu1dvKkaebW8pd
	guv7CvMXDNIJG0/at4JQSm0TM90WzinNJaoClGNE8wP9uua8AD3RgbtKU8dcdwg8Nl/JJ528La7
	xhE+8G2KwmecHrkstNH+fcNhhC220W8iKlVUcaKvP73VQ9heYYrDsNP/Y0JlVmoHNC/BVjBEjtI
	lskGtGTEVfllyyO20uouDtd7uNRbKziicBclKaywjdArqLU3Fdkjw/gGi0gzoB6CjgjwoNJc/4I
	5MRta2npUwz09uKM22w7zGtyeHa11t5RfSt5ptUSKllM6Gs//tJ+ncap7QPPIf6/ht073pnFcIJ
	WQgbR4pDStAnfE8M+pGtz/vWodXnA/vx0rAr5t+1pjWmifzOscqjGeRjn9ClUagga6GNGy97kOQ
	+rymPLyraKq/Kqabx7QbjB7ItKgRoG1TCMlCIeErJj6QjlZuVVrlfCuxrXJrRdYGzX2bKaGOe68
	yKvhEwdeOmT3wcuLqAsvB5AR7FZMxWLKw==
X-Received: by 2002:a05:690c:f15:b0:833:a89f:6cab with SMTP id 00721157ae682-85d660d94aamr105891687b3.2.1788188425564;
        Mon, 31 Aug 2026 08:00:25 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:24 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 09/15] selftests/bpf: Add tests for the LSM policy object kfuncs
Date: Mon, 31 Aug 2026 10:58:51 -0400
Message-ID: <20260831145858.3869191-10-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test the properties of the policy object interface that hold
independently of any LSM implementing the hooks.

The failure programs pin down the verifier-side contract: the kfuncs
are rejected in tracing programs, the fd kfunc in LSM programs, the
apply kfunc in syscall programs, on non-bprm LSM hooks and in
non-sleepable programs, leaked references fail verification, and a
kptr loaded outside an RCU read-side section cannot be acquired.

The syscall program checks the runtime contract of
bpf_lsm_policy_from_fd(): a bad fd, a fd that is no LSM's policy
object, and a nonzero value of the reserved flags all resolve to
NULL.

Exercising the kfuncs against an LSM actually providing policy
objects is left to that LSM's own tests.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../bpf/prog_tests/lsm_policy_kfuncs.c        |  54 ++++++
 .../selftests/bpf/progs/lsm_policy_kfuncs.c   |  52 ++++++
 .../bpf/progs/lsm_policy_kfuncs_failure.c     | 154 ++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
new file mode 100644
index 000000000000..9f4ffb5f47be
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <test_progs.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "lsm_policy_kfuncs.skel.h"
+#include "lsm_policy_kfuncs_failure.skel.h"
+
+/*
+ * Runtime contract of bpf_lsm_policy_from_fd(), independent of any
+ * LSM implementing the policy object hooks: a bad fd, a fd that is no
+ * LSM's policy object, and a nonzero value of the reserved flags all
+ * resolve to NULL.
+ */
+static void test_from_fd_null(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct lsm_policy_kfuncs *skel;
+	char tmp_path[] = "/tmp/lsm_policy_kfuncs_XXXXXX";
+	int tmp_fd, err;
+
+	tmp_fd = mkstemp(tmp_path);
+	if (!ASSERT_GE(tmp_fd, 0, "mkstemp"))
+		return;
+
+	skel = lsm_policy_kfuncs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out_close;
+	skel->bss->plain_fd = tmp_fd;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.check_from_fd),
+				     &opts);
+	if (!ASSERT_OK(err, "check_from_fd_run") ||
+	    !ASSERT_OK(opts.retval, "check_from_fd_retval"))
+		goto out_destroy;
+
+	ASSERT_TRUE(skel->bss->got_null_for_bad_fd, "bad_fd_null");
+	ASSERT_TRUE(skel->bss->got_null_for_plain_fd, "plain_fd_null");
+	ASSERT_TRUE(skel->bss->got_null_for_bad_flags, "bad_flags_null");
+out_destroy:
+	lsm_policy_kfuncs__destroy(skel);
+out_close:
+	close(tmp_fd);
+	unlink(tmp_path);
+}
+
+void test_lsm_policy_kfuncs(void)
+{
+	if (test__start_subtest("from_fd_null"))
+		test_from_fd_null();
+	RUN_TESTS(lsm_policy_kfuncs_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c
new file mode 100644
index 000000000000..f084ccfcde91
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern struct lsm_policy_object *
+bpf_lsm_policy_from_fd(int fd, u32 flags) __ksym;
+extern void bpf_lsm_policy_release(struct lsm_policy_object *object) __ksym;
+
+int plain_fd;
+bool got_null_for_bad_fd;
+bool got_null_for_plain_fd;
+bool got_null_for_bad_flags;
+
+/*
+ * Runs in the test runner's context through BPF_PROG_RUN, where
+ * @plain_fd is meaningful.
+ */
+SEC("syscall")
+int check_from_fd(void *ctx)
+{
+	struct lsm_policy_object *object;
+
+	/* A fd not open in this task's fd table must resolve to NULL. */
+	object = bpf_lsm_policy_from_fd(-1, 0);
+	if (!object)
+		got_null_for_bad_fd = true;
+	else
+		bpf_lsm_policy_release(object);
+
+	/*
+	 * A valid fd that is not any LSM's policy object must be
+	 * declined by every LSM and resolve to NULL.
+	 */
+	object = bpf_lsm_policy_from_fd(plain_fd, 0);
+	if (!object)
+		got_null_for_plain_fd = true;
+	else
+		bpf_lsm_policy_release(object);
+
+	/* The flags are reserved: any nonzero value must resolve to NULL. */
+	object = bpf_lsm_policy_from_fd(plain_fd, 1);
+	if (!object)
+		got_null_for_bad_flags = true;
+	else
+		bpf_lsm_policy_release(object);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
new file mode 100644
index 000000000000..04080838aefd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern struct lsm_policy_object *
+bpf_lsm_policy_acquire(struct lsm_policy_object *object) __ksym;
+extern int bpf_lsm_policy_apply_bprm(struct lsm_policy_object *object,
+				     struct linux_binprm *bprm,
+				     u32 flags) __ksym;
+extern struct lsm_policy_object *
+bpf_lsm_policy_from_fd(int fd, u32 flags) __ksym;
+extern void bpf_lsm_policy_release(struct lsm_policy_object *object) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+struct policy_slot {
+	struct lsm_policy_object __kptr *object;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct policy_slot);
+} policy_map SEC(".maps");
+
+/*
+ * The LSM policy kfuncs are limited to LSM and syscall programs by
+ * the BPF-side kfunc filter: a tracing program calling one must fail
+ * verification.
+ */
+SEC("tp_btf/task_newtask")
+__failure __msg("calling kernel function bpf_lsm_policy_from_fd is not allowed")
+int BPF_PROG(tracing_prog, struct task_struct *task, u64 clone_flags)
+{
+	struct lsm_policy_object *object;
+
+	object = bpf_lsm_policy_from_fd(-1, 0);
+	if (object)
+		bpf_lsm_policy_release(object);
+	return 0;
+}
+
+/*
+ * The fd kfunc is exclusive to syscall programs: it must be rejected
+ * in an LSM program, even on an allowed hook.
+ */
+SEC("lsm.s/bprm_creds_for_exec")
+__failure __msg("calling kernel function bpf_lsm_policy_from_fd is not allowed")
+int BPF_PROG(lsm_get, struct linux_binprm *bprm)
+{
+	struct lsm_policy_object *object;
+
+	object = bpf_lsm_policy_from_fd(-1, 0);
+	if (object)
+		bpf_lsm_policy_release(object);
+	return 0;
+}
+
+/*
+ * The enforcement kfunc is exclusive to the sleepable bprm LSM
+ * hooks: it must be rejected in a syscall program.
+ */
+SEC("syscall")
+__failure __msg("calling kernel function bpf_lsm_policy_apply_bprm is not allowed")
+int syscall_restrict(void *ctx)
+{
+	return bpf_lsm_policy_apply_bprm(NULL, NULL, 0);
+}
+
+/*
+ * Any LSM attach point other than the sleepable bprm hooks must be
+ * rejected for the enforcement kfunc.
+ */
+SEC("lsm.s/file_open")
+__failure __msg("calling kernel function bpf_lsm_policy_apply_bprm is not allowed")
+int BPF_PROG(wrong_hook, struct file *file)
+{
+	return bpf_lsm_policy_apply_bprm(NULL, NULL, 0);
+}
+
+/*
+ * The enforcement kfunc may sleep: a non-sleepable program on an
+ * allowed hook must be rejected.
+ */
+SEC("lsm/bprm_creds_for_exec")
+__failure
+__msg("program must be sleepable to call sleepable kfunc bpf_lsm_policy_apply_bprm")
+int BPF_PROG(nonsleepable_prog, struct linux_binprm *bprm)
+{
+	return bpf_lsm_policy_apply_bprm(NULL, bprm, 0);
+}
+
+/* An acquired policy object reference must be released before returning. */
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int leak_policy(void *ctx)
+{
+	bpf_lsm_policy_from_fd(-1, 0);
+	return 0;
+}
+
+/*
+ * A kptr loaded outside an RCU read-side critical section is
+ * untrusted: the acquire kfunc must reject it.
+ */
+SEC("lsm.s/file_open")
+__failure __msg("must be a rcu pointer")
+int BPF_PROG(acquire_untrusted, struct file *file)
+{
+	struct lsm_policy_object *object;
+	struct policy_slot *slot;
+	int key = 0;
+
+	slot = bpf_map_lookup_elem(&policy_map, &key);
+	if (!slot)
+		return 0;
+
+	object = slot->object;
+	if (!object)
+		return 0;
+
+	object = bpf_lsm_policy_acquire(object);
+	if (object)
+		bpf_lsm_policy_release(object);
+	return 0;
+}
+
+/* A reference acquired from a shared policy object must be released too. */
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(leak_shared_policy, struct file *file)
+{
+	struct lsm_policy_object *object;
+	struct policy_slot *slot;
+	int key = 0;
+
+	slot = bpf_map_lookup_elem(&policy_map, &key);
+	if (!slot)
+		return 0;
+
+	bpf_rcu_read_lock();
+	object = slot->object;
+	if (object)
+		object = bpf_lsm_policy_acquire(object);
+	bpf_rcu_read_unlock();
+	return 0;
+}
-- 
2.55.0

