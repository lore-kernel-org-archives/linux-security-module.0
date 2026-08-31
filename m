Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C03DF008
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173950; cv=none; b=tXRXYLreHzsFvmKa+/XLXVR5Mwq+yALGcwttcfLx1waPyDrkhaHyk2T7j304c8zHEjSB2D3pcdk5FB8k+456h0sTKjz/yFYgClD8L9EuW73o/+4gQB4qzQqJlbZXjr0M99RYmwUIdSYZlPiYvzAY1D/r//KNX4ooo+HAfnXIS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173950; c=relaxed/simple;
	bh=y5iYChw8nF11runuMjE8Uw+uP5rRpjA/7boYD0o41Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrNKB6ooVffrD1pZLcz0qevovErZolO7yUaXImTY/nHnt9g+ABwq2Ieb8k3JhdLNrRwVXF53aFqqCc8XW8sUTlRcyFoY/ti233jvs5AE1dDK3OU1IPl6BXzWCL+l1SFC1hzykK+l1oOGKFZ3ul6ZxMk1pSI217h3qAj/xblSKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItjL/Iwc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItjL/Iwc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso33012285e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173946; x=1788778746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AL55HAG4k1n7C88GY36XQ8E/eQDnUPzpxsPx8YoQWJ0=;
        b=ItjL/IwcXq1O2ohX673dzR6q+vNDYHwR7Rro8esSZhcyJK4FAyIekgTMImvm9FXcS3
         WKDUw1B4oCU9bWFbP53UuIrRWXdmpwRWCahnf+meWowgluD972oNmcgT9SZsE/qwJrGr
         6jKE4H8lpO1Mw+olxlDwWloKIjP385wgm2c7phJ/S8vbDebaUHLuEwXbHu41+9lGsWMN
         AwORRSeJyw/jj6K1/cJUHeccwMJlfpXaozPLA965MzMxihjy14BearjzYKaI5L1almS9
         e355oGUE9+Pf66I1HuIWx3AeF9kDj1S5o2dIXVo+vgXXXcgHaWIfcoYc2ByL3m/MaD5d
         KwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173946; x=1788778746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AL55HAG4k1n7C88GY36XQ8E/eQDnUPzpxsPx8YoQWJ0=;
        b=BxPcYuC7gzxYitGKxTexfrPP+dtsHNONuKgUswvpO8kD+1BKsy+WwzPgv7Y3syklvi
         3IdDu+t/jrsenAgttt1mVbIBhl5xbaamyRfkME0avXuwRHXaRtuXbAU92mav0LZon+np
         dqo87lzmeNnWthrWdDJORWKgdM4uVUoQyGCcQPkqG0Bmwy2YL3R6ZurheMwX5uEQX5Yo
         Vy2tsZZB0tVl7zOFAjmAEnAFnQ0nr29cHTAH/rl54c9E9VWQGnOliyj1S8I8GgMefnRe
         tiio0DLc3FzzCq1thrJMlijZmEeMe5mdNyvbm7D3ELDaTyMSJE/Gl8ZGSUsVDtDNEjsi
         bRnw==
X-Forwarded-Encrypted: i=1; AHgh+RqKar5eVRhNZ91EvbGcetgiI4+gY6NMddi1B4CHkvcpPGWfx0QvH7w3VKFgofkQ90F+Wl34ZXSLxAuswkIiuyYWPeRg9Zk=@vger.kernel.org
X-Gm-Message-State: AFuF++l3CDdKExtwFmXGTQhDFyaBs+idoofoiremoCt7OmqllCjHTnYY
	/4XxjLZ2Jo23MRkN7C9pRLoB/zExh1/g2eW7oIwBs4AEcPT+T/FGpKoe
X-Gm-Gg: AR+sD11b8EPBlJa/19jKbBW0u4A2oH4oU3aY2XIv7vdwKPqt0FEoI/XBfClB7Hl/OI5
	mHWgcq/YtcQGSAaEk/dzXbK9bhuTg3G8RqyUf75g44L5ppH1TMosciTdotUBbZ75PqGWxXaUXVo
	zvyx4rkpUHWj8O83QnVqxOZGMKuQfj0ubL4lZyedLWn3/SbiQPfqacaFDLf8VGU4nau3TGWxxa0
	TGZrpaZQVT0Oj5XX7rrRVdFEuHEdKDLImGDFHk8p3iqOYV4UEx1vO93Exi9CxHh0wNvmiLt/0AO
	WYPTJLiww+GjOT8ewBLbygoIix9wpIJPjph5GYeZGddxnrTetQkr+N1/FG4J6AEq7RBh/rBRNp3
	ReJCqexaF5nG+uBTWkAO0RhnFLFfWCfX+IMSZElyFw6nfQJrRc9wJ9E3Gvl7LtMEL8HUllffU5D
	aD6gVJaqWavGcskjiiiEwGF3NlTSXgHhLsGQYTEH5eXw7Z6LIZIM3XCCtciyqXV/Z3B3cAnDg8/
	2GKsg==
X-Received: by 2002:a05:600c:4445:b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-49b91c44fbfmr333816875e9.9.1788173946104;
        Mon, 31 Aug 2026 03:59:06 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:59:05 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 6/7] selftests/bpf: Add tests for the generic netlink BPF hook
Date: Mon, 31 Aug 2026 11:09:31 +0000
Message-ID: <20260831110934.241898-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831110934.241898-1-a.s.protopopov@gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few tests for the new generic netlink BPF hook.
Policies only apply themselves to the "nlctrl" family.

The following tests are being added:

  * doit: allow or deny CTRL_CMD_GETFAMILY

  * dump: allow or deny CTRL_CMD_GETPOLICY, nlmsg_flags |= NLM_F_DUMP

  * nlmsg_flags: allow or deny a command based on nlmsg_flags

  * other_family: check that other families still pass

Test also uses "ethtool" generic netlink family, so enable it in config.
This family is also required for the subsequent ethtool-specific selftests.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/genl_lsm.c       | 242 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/genl_lsm.c  |  58 +++++
 3 files changed, 301 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/genl_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/genl_lsm.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2f79688dcf7c..d4f9d9e6cb9f 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -28,6 +28,7 @@ CONFIG_DMABUF_HEAPS=y
 CONFIG_DMABUF_HEAPS_SYSTEM=y
 CONFIG_DUMMY=y
 CONFIG_DYNAMIC_FTRACE=y
+CONFIG_ETHTOOL_NETLINK=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
diff --git a/tools/testing/selftests/bpf/prog_tests/genl_lsm.c b/tools/testing/selftests/bpf/prog_tests/genl_lsm.c
new file mode 100644
index 000000000000..2d880fe7461f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/genl_lsm.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <linux/ethtool_netlink.h>
+#include <linux/genetlink.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "netlink_helpers.h"
+#include "network_helpers.h"
+#include "test_progs.h"
+
+#include "genl_lsm.skel.h"
+
+#define NLCTRL_FAMILY_NAME "nlctrl"
+#define OTHER_FAMILY_NAME  "ethtool"
+
+/* not probable to encounter this errno in real life */
+#define TEST_ERRNO EDOTDOT
+
+static int nlctrl_request(int fd, __u8 cmd, bool dump)
+{
+	static __u32 sequence = 1;
+	struct genl_req req = {};
+	__u32 seq = sequence++;
+	int err;
+
+	req.nlh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	req.nlh.nlmsg_type = GENL_ID_CTRL;
+	req.nlh.nlmsg_flags = NLM_F_REQUEST | (dump ? NLM_F_DUMP : 0);
+	req.nlh.nlmsg_seq = seq;
+	req.genl.cmd = cmd;
+	req.genl.version = 2;
+	if (addattrstrz(&req.nlh, sizeof(req), CTRL_ATTR_FAMILY_NAME, NLCTRL_FAMILY_NAME))
+		return -EMSGSIZE;
+
+	err = genl_send(fd, &req.nlh);
+	if (err)
+		return err;
+
+	return genl_recv(fd, seq, GENL_ID_CTRL, dump);
+}
+
+static void test_doit(struct genl_lsm *skel, int fd)
+{
+	int err;
+
+	skel->bss->target_cmd = CTRL_CMD_GETFAMILY;
+	skel->bss->target_flags = 0;
+	skel->bss->target_netns_inum = 0;
+	skel->bss->allow = true;
+
+	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
+	if (!ASSERT_OK(err, "CTRL_CMD_GETFAMILY (allow)"))
+		return;
+
+	skel->bss->allow = false;
+	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
+	ASSERT_EQ(err, -TEST_ERRNO, "CTRL_CMD_GETFAMILY (deny)");
+}
+
+static void test_dump(struct genl_lsm *skel, int fd)
+{
+	int err;
+
+	skel->bss->target_cmd = CTRL_CMD_GETPOLICY;
+	skel->bss->target_flags = 0;
+	skel->bss->target_netns_inum = 0;
+	skel->bss->allow = true;
+
+	err = nlctrl_request(fd, CTRL_CMD_GETPOLICY, true);
+	if (!ASSERT_OK(err, "allow_getpolicy_dump"))
+		return;
+
+	skel->bss->allow = false;
+	err = nlctrl_request(fd, CTRL_CMD_GETPOLICY, true);
+	ASSERT_EQ(err, -TEST_ERRNO, "deny_getpolicy_dump");
+}
+
+static void test_nlmsg_flags(struct genl_lsm *skel, int fd)
+{
+	int err;
+
+	skel->bss->target_cmd = CTRL_CMD_GETFAMILY;
+	skel->bss->target_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	skel->bss->target_netns_inum = 0;
+	skel->bss->allow = false;
+
+	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, true);
+	ASSERT_EQ(err, -TEST_ERRNO, "deny_dump_flags");
+
+	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
+	ASSERT_OK(err, "doit_flags_not_matched");
+
+	/* now, the other way around */
+	skel->bss->target_flags = NLM_F_REQUEST;
+
+	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, true);
+	ASSERT_OK(err, "doit_flags_not_matched");
+
+	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
+	ASSERT_EQ(err, -TEST_ERRNO, "deny_dump_flags");
+}
+
+static int other_family_request(int fd, __u16 family_id)
+{
+	static __u32 sequence = 1000;
+	struct genl_req req = {};
+	__u32 seq = sequence++;
+	int err;
+
+	req.nlh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	req.nlh.nlmsg_type = family_id;
+	req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	req.nlh.nlmsg_seq = seq;
+	req.genl.cmd = ETHTOOL_MSG_LINKSTATE_GET;
+	req.genl.version = ETHTOOL_GENL_VERSION;
+
+	err = genl_send(fd, &req.nlh);
+	if (err)
+		return err;
+
+	return genl_recv(fd, seq, family_id, true);
+}
+
+static void test_other_family(struct genl_lsm *skel, int fd, __u16 other_id)
+{
+	int err;
+
+	skel->bss->target_cmd = 0;
+	skel->bss->target_flags = 0;
+	skel->bss->target_netns_inum = 0;
+	skel->bss->allow = false;
+
+	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
+	if (!ASSERT_EQ(err, -TEST_ERRNO, "nlctrl_denied"))
+		return;
+
+	err = other_family_request(fd, other_id);
+	ASSERT_OK(err, "other_family_request ok");
+}
+
+static __u32 netns_inum(void)
+{
+	struct stat st;
+
+	if (stat("/proc/self/ns/net", &st))
+		return 0;
+
+	return st.st_ino;
+}
+
+static void test_netns(struct genl_lsm *skel, int fd)
+{
+	struct netns_obj *netns = NULL;
+	struct nstoken *nstoken = NULL;
+	int ns_fd = -1;
+	int err;
+
+	SYS_NOFAIL("ip netns del genl_lsm_ns");
+	netns = netns_new("genl_lsm_ns", false);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		return;
+
+	nstoken = open_netns("genl_lsm_ns");
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto out;
+
+	ns_fd = genl_open(0);
+	if (!ASSERT_OK_FD(ns_fd, "genl_open"))
+		goto out;
+
+	skel->bss->target_cmd = CTRL_CMD_GETFAMILY;
+	skel->bss->target_flags = 0;
+	skel->bss->target_netns_inum = netns_inum();
+	skel->bss->allow = false;
+
+	if (!ASSERT_NEQ(skel->bss->target_netns_inum, 0, "netns_inum"))
+		goto out;
+
+	err = nlctrl_request(ns_fd, CTRL_CMD_GETFAMILY, false);
+	ASSERT_EQ(err, -TEST_ERRNO, "denied_in_target_netns");
+
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	/* same request, same policy, but now from the original namespace */
+	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
+	ASSERT_OK(err, "allowed_outside_target_netns");
+
+out:
+	if (ns_fd >= 0)
+		close(ns_fd);
+	close_netns(nstoken);
+	netns_free(netns);
+}
+
+void test_genl_lsm(void)
+{
+	struct genl_lsm *skel;
+	int other_id, fd = -1;
+	int err;
+
+	skel = genl_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "genl_lsm__open_and_load"))
+		return;
+
+	fd = genl_open(0);
+	if (!ASSERT_OK_FD(fd, "genl_open"))
+		goto cleanup;
+
+	/* do this before attaching our hook, just in case */
+	other_id = genl_resolve_family(fd, OTHER_FAMILY_NAME);
+	if (other_id == -ENOENT) {
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_GT(other_id, 0, "genl_resolve_family"))
+		goto cleanup;
+
+	skel->bss->monitored_pid = getpid();
+	err = genl_lsm__attach(skel);
+	if (!ASSERT_OK(err, "genl_lsm__attach"))
+		goto cleanup;
+
+	if (test__start_subtest("doit"))
+		test_doit(skel, fd);
+	if (test__start_subtest("dump"))
+		test_dump(skel, fd);
+	if (test__start_subtest("nlmsg_flags"))
+		test_nlmsg_flags(skel, fd);
+	if (test__start_subtest("other_family"))
+		test_other_family(skel, fd, other_id);
+	if (test__start_subtest("netns"))
+		test_netns(skel, fd);
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	genl_lsm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/genl_lsm.c b/tools/testing/selftests/bpf/progs/genl_lsm.c
new file mode 100644
index 000000000000..b8364a3ce776
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/genl_lsm.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <errno.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define GENL_NAMSIZ 16
+
+__u32 monitored_pid;
+__u32 target_cmd;
+__u32 target_flags;
+__u32 target_netns_inum;
+bool allow;
+
+static bool is_nlctrl(const struct genl_family *family)
+{
+	static const char nlctrl_name[] = "nlctrl";
+	char name[GENL_NAMSIZ];
+	long len;
+
+	len = BPF_CORE_READ_STR_INTO(&name, family, name);
+	return len == sizeof(nlctrl_name) &&
+	       bpf_strncmp(name, sizeof(nlctrl_name), nlctrl_name) == 0;
+}
+
+/* Swiss-knife-like policy used in all tests */
+SEC("lsm/genl_family_rcv_msg")
+int BPF_PROG(test_genl_family_rcv_msg, const struct genl_family *family,
+	     const struct net *net, __u32 cmd, __u16 nlmsg_flags, int ret)
+{
+	__u32 pid;
+
+	if (ret)
+		return ret;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	if (!family || !net || !is_nlctrl(family))
+		return 0;
+
+	if (target_cmd && cmd != target_cmd)
+		return 0;
+
+	if (target_flags && nlmsg_flags != target_flags)
+		return 0;
+
+	if (target_netns_inum && net->ns.inum != target_netns_inum)
+		return 0;
+
+	return allow ? 0 : -EDOTDOT; /* unlikely to see this errno outside this test */
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

