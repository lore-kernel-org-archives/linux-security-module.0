Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008668;
	b=TPW/v+7Np6iQqwbmyT6vc0/StvEopIDvx32Yy2Mk8so8oRWpyLrPCvzS3DzqfjIzyg1K
	 P3+FuaGhXS5R3WOqhP0T8ONEp8jHLO8qx/7eHRn5HFcrbFyIYm6sb/3fD74xp6uTkwM23
	 Lu/DPN1sJv+NnMaZLVw6e3mporBu+lbPcIoTE1ktN42G6HFfkqK+/v4VsaN/PmaN5F+WJ
	 q/e7+11mDhlZuG/LHsQ3PQwzQzZMJ11wqYNHnSKPHF5zqmqRbSVDAk57s8IPA2NZGBhY/
	 2s8peJmOv7Bz1IVWuikfwgVmzaAb53Yqwh1fRSxrgTMG5D9XdY1dwToi6y4v1ewoPbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008668;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nujbxywysw1THYDbs5pJnpdFcGsTn9DNVHlZbLoNeO0=;
	b=NdXR6JupmirnFqjdVRqb/ujzpMYWfK2nqxULW1EJYyqgDgvs1qU4ICQg1H102TiodCF4
	 RjGLAu32kuo6+FP31LbPhPtvGh79mISG3nS8Uqwe3h3kKbqCygnuad4dH+jbeSuWnHygs
	 8T97Ax3jlfwLkuMZOhCnRmkm4Ukv6tEvyCJ9QfydSvNEVa6BO2kcIdFPDSUUxlf59uOwd
	 5UJsFyHaQ/pY3KAbm/WOsn71E21W4s/EZA0J7CFGwvMouzE3TIrpsCUJ9kyYWLrUSE2uu
	 CDtT6qtib/GcLluR5V5BYsaVDsaPU9ZhvrlrWWJpoLxXmQQ4epz6MGMl1mvz80a7AUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVszNAVi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D78606A9DF;
	Mon, 26 Oct 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVszNAVi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DEF1F01189;
	Mon, 26 Oct 2026 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008667;
	bh=nujbxywysw1THYDbs5pJnpdFcGsTn9DNVHlZbLoNeO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aVszNAVisauaQUvQDEhMMsU4Hq+b4XrxWm+JJK4b4zTPzkR9OfJc+Kgao/yPRvB8C
	 VZWVdZXDMh56LuhNco81/eSOD8HbuWbthsiZKLUaMWWdDjSdAz2uVfGDaMlQo7qDLb
	 S+LCjCo6/8qs2X19zhYjt1+ITKCGo5JqbpZwN05/S+WCSwtozU+uOXM+OdL49KlOwO
	 1EjjIo5goNGwaFTz+G5HVhb+2Qaa2hSWn/IgZHHxmM9lC4yy01JQ4JCBOU5t4o/lX9
	 OUdDzM4QmrJuEOLmnhtLcMrcitNQJdDyuUhp6MD16p5vTxMVvr1UApekd9nFi3/ORN
	 vGbijlj1waOcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 10:57:16 +0100
Subject: [PATCH 8/8] selftests/bpf: add a lifecycle test for the namespace
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
Message-Id: <20261026-work-security-namespace_free-v1-8-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7056; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x/mOnOiE+IxXo39rBsPXme0Vz67VAdaym4XN6zZLZEg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdV2GaGL5u+3zZzkiDp9uPC3OqCVre/J15z1ZTtX/Kv
 uD24vmMHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5torhn0nNK9Y07ZT0Rfmn
 UqvXaK4KCynz11550vRA+7zvvY+nLWRkeNnms6zkEI/th8Nn/pdcjG+/N22l3VfD6apbtM6ELXp
 +kQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Track new uts, ipc and net namespaces from a bpf LSM by their namespace
id and check that:

- namespace_init already sees the id that NS_GET_ID reports

- namespace_init, namespace_install and namespace_free fire exactly once
  for each of them

The test fails if the namespace_free hook isn't called or if the
namespace id is allocated after namespace_init.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/bpf/prog_tests/ns_lifecycle.c        | 145 +++++++++++++++++++++
 .../selftests/bpf/progs/test_ns_lifecycle.c        |  88 +++++++++++++
 2 files changed, 233 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_lifecycle.c b/tools/testing/selftests/bpf/prog_tests/ns_lifecycle.c
new file mode 100644
index 000000000000..8ea4939efb23
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ns_lifecycle.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Exercise all namespace LSM hooks from a BPF LSM: unshare() new
+ * namespaces (namespace_init), setns() into them (namespace_install) and
+ * drop the last reference (namespace_free).
+ */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <sched.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <linux/nsfs.h>
+#include "task_local_storage_helpers.h"
+#include "test_ns_lifecycle.skel.h"
+
+struct ns_stat {
+	__u32 ns_type;
+	__u32 init_count;
+	__u32 install_count;
+	__u32 free_count;
+};
+
+static const struct {
+	const char *path;
+	int type;
+} namespaces[] = {
+	{ "/proc/self/ns/uts", CLONE_NEWUTS },
+	{ "/proc/self/ns/ipc", CLONE_NEWIPC },
+	{ "/proc/self/ns/net", CLONE_NEWNET },
+};
+
+#define NR_NS ARRAY_SIZE(namespaces)
+
+static bool all_freed(int map_fd, const __u64 *ns_id)
+{
+	struct ns_stat stat;
+	int i;
+
+	for (i = 0; i < NR_NS; i++) {
+		if (bpf_map_lookup_elem(map_fd, &ns_id[i], &stat) || !stat.free_count)
+			return false;
+	}
+	return true;
+}
+
+void test_ns_lifecycle(void)
+{
+	int orig_fd[NR_NS] = { -1, -1, -1 }, new_fd[NR_NS] = { -1, -1, -1 };
+	struct test_ns_lifecycle *skel = NULL;
+	int pidfd, map_fd, err, i, tries;
+	struct ns_stat stat;
+	__u64 ns_id[NR_NS];
+	struct stat st;
+
+	for (i = 0; i < NR_NS; i++) {
+		orig_fd[i] = open(namespaces[i].path, O_RDONLY | O_CLOEXEC);
+		if (!ASSERT_OK_FD(orig_fd[i], "open orig ns"))
+			goto close_fds;
+	}
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_OK_FD(pidfd, "pidfd_open"))
+		goto close_fds;
+	err = fstat(pidfd, &st);
+	close(pidfd);
+	if (!ASSERT_OK(err, "fstat pidfd"))
+		goto close_fds;
+
+	skel = test_ns_lifecycle__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		goto close_fds;
+
+	err = test_ns_lifecycle__attach(skel);
+	if (!ASSERT_OK(err, "skel attach"))
+		goto destroy;
+
+	map_fd = bpf_map__fd(skel->maps.ns_lifecycle);
+	skel->bss->monitored_pidfd_ino = st.st_ino;
+
+	err = unshare(CLONE_NEWUTS | CLONE_NEWIPC | CLONE_NEWNET);
+	if (!ASSERT_OK(err, "unshare"))
+		goto disarm;
+
+	for (i = 0; i < NR_NS; i++) {
+		new_fd[i] = open(namespaces[i].path, O_RDONLY | O_CLOEXEC);
+		if (!ASSERT_OK_FD(new_fd[i], "open new ns"))
+			goto restore;
+		if (!ASSERT_OK(ioctl(new_fd[i], NS_GET_ID, &ns_id[i]), "NS_GET_ID"))
+			goto restore;
+	}
+
+	/* Leave the new namespaces and install them again. */
+	for (i = 0; i < NR_NS; i++) {
+		if (!ASSERT_OK(setns(orig_fd[i], namespaces[i].type), "setns orig"))
+			goto restore;
+		if (!ASSERT_OK(setns(new_fd[i], namespaces[i].type), "setns new"))
+			goto restore;
+		if (!ASSERT_OK(setns(orig_fd[i], namespaces[i].type), "setns orig again"))
+			goto restore;
+	}
+
+	skel->bss->monitored_pidfd_ino = 0;
+
+	/* Drop the last references. Network namespaces are freed asynchronously. */
+	for (i = 0; i < NR_NS; i++) {
+		close(new_fd[i]);
+		new_fd[i] = -1;
+	}
+
+	for (tries = 0; tries < 1000 && !all_freed(map_fd, ns_id); tries++) {
+		kern_sync_rcu();
+		usleep(10000);
+	}
+
+	for (i = 0; i < NR_NS; i++) {
+		/* namespace_init must already have seen the id. */
+		if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &ns_id[i], &stat), "lookup ns_stat"))
+			continue;
+
+		ASSERT_EQ(stat.ns_type, namespaces[i].type, "ns_type");
+		ASSERT_EQ(stat.init_count, 1, "init_count");
+		ASSERT_EQ(stat.install_count, 1, "install_count");
+		ASSERT_EQ(stat.free_count, 1, "free_count");
+	}
+	goto destroy;
+
+restore:
+	for (i = 0; i < NR_NS; i++)
+		setns(orig_fd[i], namespaces[i].type);
+disarm:
+	skel->bss->monitored_pidfd_ino = 0;
+destroy:
+	test_ns_lifecycle__destroy(skel);
+close_fds:
+	for (i = 0; i < NR_NS; i++) {
+		if (new_fd[i] >= 0)
+			close(new_fd[i]);
+		if (orig_fd[i] >= 0)
+			close(orig_fd[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ns_lifecycle.c b/tools/testing/selftests/bpf/progs/test_ns_lifecycle.c
new file mode 100644
index 000000000000..88c5d40ba27a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ns_lifecycle.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct ns_stat {
+	__u32 ns_type;
+	__u32 init_count;
+	__u32 install_count;
+	__u32 free_count;
+};
+
+/* Unlike inode numbers namespace ids are never recycled. */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16);
+	__type(key, __u64);
+	__type(value, struct ns_stat);
+} ns_lifecycle SEC(".maps");
+
+__u64 monitored_pidfd_ino = 0;
+
+char _license[] SEC("license") = "GPL";
+
+static bool is_monitored(void)
+{
+	struct task_struct *task;
+
+	if (!monitored_pidfd_ino)
+		return false;
+
+	task = bpf_get_current_task_btf();
+	return task->thread_pid->ino == monitored_pidfd_ino;
+}
+
+SEC("lsm/namespace_init")
+int BPF_PROG(ns_init, struct ns_common *ns, int ret)
+{
+	struct ns_stat new = {}, *stat;
+	__u64 ns_id;
+
+	if (ret)
+		return ret;
+
+	if (!is_monitored())
+		return 0;
+
+	ns_id = ns->ns_id;
+	new.ns_type = ns->ns_type;
+	bpf_map_update_elem(&ns_lifecycle, &ns_id, &new, BPF_NOEXIST);
+	stat = bpf_map_lookup_elem(&ns_lifecycle, &ns_id);
+	if (stat)
+		__sync_fetch_and_add(&stat->init_count, 1);
+	return 0;
+}
+
+SEC("lsm/namespace_install")
+int BPF_PROG(ns_install, const struct nsset *nsset, struct ns_common *ns, int ret)
+{
+	struct ns_stat *stat;
+	__u64 ns_id;
+
+	if (ret)
+		return ret;
+
+	if (!is_monitored())
+		return 0;
+
+	ns_id = ns->ns_id;
+	stat = bpf_map_lookup_elem(&ns_lifecycle, &ns_id);
+	if (stat)
+		__sync_fetch_and_add(&stat->install_count, 1);
+	return 0;
+}
+
+SEC("lsm/namespace_free")
+int BPF_PROG(ns_free, struct ns_common *ns)
+{
+	struct ns_stat *stat;
+	__u64 ns_id;
+
+	ns_id = ns->ns_id;
+	stat = bpf_map_lookup_elem(&ns_lifecycle, &ns_id);
+	if (stat)
+		__sync_fetch_and_add(&stat->free_count, 1);
+	return 0;
+}

-- 
2.53.0

