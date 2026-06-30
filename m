Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF1466B57
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844806; cv=none; b=CVCjtju7d3xYKfTlw73qAe7lgGf+Vj8QhI1O9J/q5O6LgsgYaG98/Ee1Wm8XaBQCmut97fTXOet09lR1R7PdQxDPV2AE2GQsKPAnkcH/Zjq90uo7qScv/fzCrquDCck2A76byDcLuZE0KOZdbBj90354eBO/hZZDaUobXXl82GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844806; c=relaxed/simple;
	bh=TeJg/uFNllSXWMK0neZRwdfp/P5yHMtYIrnhTQRfrMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNOhsOZyqTEOqlU9jaSu88bItcmnfDtzhrxWWzkT3vNrlgwvxIvQZ0oYo2sOh7MRtwQgyFZRmIXVY3PVG6RbgWmbtgAGhepHjeFdDSrmiHcX5IyKHj+xXP8Q3PMtATQFyCq/erMt4/NESAhqbOoWwMBAfzwDSwfpbHA/qUnWijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQVk0S4/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQVk0S4/"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6a434cabso65582085a.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844802; x=1783449602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js2eNt9rzG9O8LLuOeJpP1N/qL4mplqn3u9ItyCCT94=;
        b=eQVk0S4/c/CDxAzEgR+EH2cHFERb3zd7w7eYDIMlDWBp893YzCw7NwxVVClwltO2Y5
         dFCrGk1ATtpIy5bn1iavoNBwAoQHUXm3QqsyB04dhbxA33pwRJrU4ecvqm4PJAhBG6wu
         fqLxWfgenTuLYiFm4x6qpFxoFisefkkOQW7hVfWyjwUQMaEqnM6QE+deylNF1jL3O45x
         AKEYSnbF27odhY6Wxo+OZIJKyy8z28ICnIBVxohio+K/bSl/1DZn0IPH6ogGwLUvyKxO
         4nppBjvB+ihGkjszOLaJYRZVAS87txJMVMnWBgEHs16iQJERncAvpxUaiDEg2E0oQ9f0
         Nz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844802; x=1783449602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Js2eNt9rzG9O8LLuOeJpP1N/qL4mplqn3u9ItyCCT94=;
        b=gsDq0O26t5cNx/dWB2QV+ylb7wpDYRmAq458by5R3HKdAcD9HYeql1EvxYmShjnKCB
         cP8Sd8+07oGi4bIKw++XpvPbXs5wbU7cfGz3Mwfvjev3Q43NmueXzy/Khu7bhbsADrlQ
         eorImhX8KjZl8ChiE2yr71xgxkTE2fuebEJY70nVemVyq9Dbh7F82CET87TPR/79dEEq
         TINFlAVq5oOqp9egz5xaCW7VS8UJWDvKHJnPmfMtEIN1zYl+v0gKvP4u6mpFphEEz1up
         DWYTiz44E5WZqiigWvxHFpQcToKQh2X8kz6tVHfWEjX2D77MeVEzPEKNm7ul1a5YcuBN
         qDEw==
X-Forwarded-Encrypted: i=1; AFNElJ8Hh2gwiWtupb6nB6K7vr8L+lrBFo949U1kcP/OLGDn4QIHWkJH3ROxlkwd9G5gyLLfV3COg/02yMzOIkPxco0IMEUCv6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuIrGbl8Y4XvAMYARQ/FIbamLLNXN6VBe8aMOq+UfbxMo3St1
	V4QJRtFjc0Co67drbR4OA5+mf/7hmTkI+di33d/PzO6Rg24aNZOVF6pj
X-Gm-Gg: AfdE7cm2D8CnBfqcPyua/ljLwuB5gnJ2Bi3oKTE2wfBn5FyjqiFaXPoNQXGdwp6XYfL
	iYfgKScr7ddj3yP+UoJ+dVRwzZQox29N5CDfGnHEIJjJAkhbT5hdPFMOE6MmXQLajd8IgSgmzJ0
	5Bs+NkW6G0hDY09xiFVZ803ITlLJGmjstLacaalfAgciBTxUeL7yOL2sS773kw0MUU5D71OMW62
	G8Lw8EEpaYWuYarjvhChqYRr/eWM6bRleIREOafAVi62OEdpzCd3u0KKfWdFNWmfrf+tVSZBCxS
	PD2HsLm2EgZ7Vy9Ppr7t83BDkKPjPMeB2L5GB7325LajGJPTCJUvOSvsolJPKC+U74PEndT4B5e
	dWOWPki0j8DQiFW81tZ1ViwlXA+RRsCmUn1K9wyMFGqss/65sFxtcyhSvqwRqClHAOL/TxH/slA
	pNMV00RyZks9YkV9UJBKv1bw/srm5Xc2AK57MIronyDSeZkEkb+jE2vZISPCcSWlUNMC7LV/Zm3
	7vI+Ch2dyaLSiI=
X-Received: by 2002:a05:620a:4412:b0:915:8988:4e55 with SMTP id af79cd13be357-92e62791d9emr790756385a.40.1782844802320;
        Tue, 30 Jun 2026 11:40:02 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62191b18sm326961285a.18.2026.06.30.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:40:01 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v4 bpf-next 3/3] selftests/bpf: add tests for bpf_init_inode_xattr kfunc
Date: Tue, 30 Jun 2026 14:39:55 -0400
Message-ID: <20260630183956.281293-4-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630183956.281293-1-dwindsor@gmail.com>
References: <20260630183956.281293-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test bpf atomic inode xattr labeling in inode_init_security.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 117 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 3 files changed, 153 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index ae71e9b69051..2639f9f94195 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -92,4 +92,9 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+struct lsm_xattrs;
+extern int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
+				const char *name__str,
+				const struct bpf_dynptr *value_p) __ksym __weak;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..8b2e0d433aea 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
 #include "test_fsverity.skel.h"
+#include "test_init_inode_xattr.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
@@ -268,6 +269,116 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_init_inode_xattr(void)
+{
+	struct test_init_inode_xattr *skel = NULL;
+	int fd = -1, err;
+	char value_out[64];
+	const char *testfile_new = "/tmp/test_progs_fs_kfuncs_new";
+
+	skel = test_init_inode_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_init_inode_xattr__open_and_load"))
+		return;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_init_inode_xattr__attach(skel);
+	if (!ASSERT_OK(err, "test_init_inode_xattr__attach"))
+		goto out;
+
+	/* Trigger inode_init_security */
+	fd = open(testfile_new, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	ASSERT_EQ(skel->data->init_result, 0, "init_result");
+
+	/* initxattrs prepends "security." to the name. */
+	err = getxattr(testfile_new, "security.bpf.test_label", value_out,
+		       sizeof(value_out));
+	if (err < 0 && errno == ENODATA) {
+		printf("%s:SKIP:filesystem did not apply LSM xattrs\n",
+		       __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_GE(err, 0, "getxattr"))
+		goto out;
+
+	ASSERT_EQ(err, (int)sizeof(skel->data->xattr_value), "xattr_size");
+	ASSERT_EQ(strncmp(value_out, "unconfined_u:object_r:user_home_t:s0",
+			  sizeof("unconfined_u:object_r:user_home_t:s0")), 0,
+		  "xattr_value");
+
+out:
+	close(fd);
+	test_init_inode_xattr__destroy(skel);
+	remove(testfile_new);
+}
+
+/* Keep in sync with BPF_LSM_INODE_INIT_XATTRS in include/linux/bpf_lsm.h. */
+#define INIT_INODE_XATTR_MAX 4
+
+/*
+ * Programs may attach to inode_init_security without an attach-time limit, but
+ * the kfunc only lets BPF claim INIT_INODE_XATTR_MAX xattr slots per inode.
+ * Calls beyond that budget are rejected at runtime with -ENOSPC.
+ */
+static void test_init_inode_xattr_slot_limit(void)
+{
+	struct test_init_inode_xattr *skel[INIT_INODE_XATTR_MAX + 1] = {};
+	struct bpf_link *link[INIT_INODE_XATTR_MAX + 1] = {};
+	const char *testfile_slot = "/tmp/test_progs_fs_kfuncs_slot";
+	int ok = 0, nospc = 0, other = 0;
+	int i, fd = -1;
+
+	/* All programs attach successfully; there is no attach-time cap. */
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		skel[i] = test_init_inode_xattr__open_and_load();
+		if (!ASSERT_OK_PTR(skel[i], "open_and_load"))
+			goto out;
+
+		skel[i]->bss->monitored_pid = getpid();
+
+		link[i] = bpf_program__attach_lsm(skel[i]->progs.test_init_inode_xattr);
+		if (!ASSERT_OK_PTR(link[i], "attach"))
+			goto out;
+	}
+
+	/* Trigger inode_init_security once with all programs attached. */
+	fd = open(testfile_slot, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	/*
+	 * Exactly INIT_INODE_XATTR_MAX programs claim a slot; the program past
+	 * the budget gets -ENOSPC. The order in which programs run is not
+	 * guaranteed, so count results instead of indexing.
+	 */
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		int res = skel[i]->data->init_result;
+
+		if (res == 0)
+			ok++;
+		else if (res == -ENOSPC)
+			nospc++;
+		else
+			other++;
+	}
+
+	ASSERT_EQ(ok, INIT_INODE_XATTR_MAX, "slots_within_budget");
+	ASSERT_EQ(nospc, 1, "slot_over_budget");
+	ASSERT_EQ(other, 0, "unexpected_result");
+
+out:
+	if (fd >= 0)
+		close(fd);
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		bpf_link__destroy(link[i]);
+		test_init_inode_xattr__destroy(skel[i]);
+	}
+	remove(testfile_slot);
+}
+
 void test_fs_kfuncs(void)
 {
 	/* Matches xattr_names in progs/test_get_xattr.c */
@@ -288,4 +399,10 @@ void test_fs_kfuncs(void)
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
+
+	if (test__start_subtest("init_inode_xattr"))
+		test_init_inode_xattr();
+
+	if (test__start_subtest("init_inode_xattr_slot_limit"))
+		test_init_inode_xattr_slot_limit();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
new file mode 100644
index 000000000000..cb378db957aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cisco Systems, Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+int init_result = -1;
+
+static const char xattr_name[] = "bpf.test_label";
+char xattr_value[] = "unconfined_u:object_r:user_home_t:s0";
+
+SEC("lsm.s/inode_init_security")
+int BPF_PROG(test_init_inode_xattr, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct lsm_xattrs *xattrs)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value_ptr);
+	init_result = bpf_init_inode_xattr(xattrs, xattr_name, &value_ptr);
+
+	return 0;
+}
-- 
2.53.0

