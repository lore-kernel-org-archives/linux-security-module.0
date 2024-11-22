Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C001E0094
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286075; cv=none; b=M5xftaTh+S6CNgqHBQb+yf4R7XK3De07cNIbpp4Uw67ex0TFZhpRlTgUkfRwYnm2KsSTlBcUcXmjqrgMM2sRuhna0IDq7/kvGoMnxUxRUeB5S0RBa2mu6Qv7DKF9NKeu4Q3DPo/tOKPf6r4qmsWY8MIBFTnRGMEzJhXRONJS9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286075; c=relaxed/simple;
	bh=yqIV3JokOrPL6fJpSmvCdfso7UefVNGNi9cxShXHoSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4qMRvoTij4BtGUtR/78XVu/9osqA119Wf3V1PTGtpgjddYu8Hx1iS2tjSVg2bYbsQMpccwHqHlfYv292zha/sesRfctqna3e21AFMsSUMnZA54Gz3nOxcTyK0MVWAYxAdKtkG9Ts0jMo/1jdG0i4qYdt+I2OIGuA6tP2An4b1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gb1wR04x; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gb1wR04x"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKf5bWMzj3q;
	Fri, 22 Nov 2024 15:34:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286070;
	bh=N1kG0yjS/ipUTLbH7ZaWMfoEW1SfPQZh0ziwxs6aNoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gb1wR04xjyL9bDUB2QA84Ko8QuzoOQA8Yx3rwbwV+/kYOb5NbsqzymngFMRUFJT21
	 bOCqGJJhBMCHamV4eesFx0d1JwBApVDBesASo8/4vhaBFVMgRfsi2Mv6Gp88p56f92
	 WhITlOCvrY06wm6ZgFvysk7Aoi4IKH1GTZc7YqGM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKf0yFszlYn;
	Fri, 22 Nov 2024 15:34:30 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 22/23] selftests/landlock: Add tests for audit
Date: Fri, 22 Nov 2024 15:33:52 +0100
Message-ID: <20241122143353.59367-23-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit_test.c to check with and without
LANDLOCK_RESTRICT_SELF_LOGLESS against the three Landlock audit record
types: AUDIT_LANDLOCK_DENY, AUDIT_LANDLOCK_DOM_INFO, and
AUDIT_LANDLOCK_DOM_DROP.

Tests are run with audit filters to ensure the audit records come from
the running tests.  Moreover, because there can only be one audit
process, tests would failed if run in parallel.  Because of audit
limitations, tests can only be run in the initial namespace.

The audit test helpers were inspired by libaudit and
tools/testing/selftests/net/netfilter/audit_logread.c

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Phil Sutter <phil@nwl.cc>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-23-mic@digikod.net
---

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/audit.h      | 308 ++++++++++++++++++
 tools/testing/selftests/landlock/audit_test.c | 168 ++++++++++
 tools/testing/selftests/landlock/common.h     |   2 +
 tools/testing/selftests/landlock/config       |   1 +
 4 files changed, 479 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/audit.h
 create mode 100644 tools/testing/selftests/landlock/audit_test.c

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
new file mode 100644
index 000000000000..4977e8fac081
--- /dev/null
+++ b/tools/testing/selftests/landlock/audit.h
@@ -0,0 +1,308 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock audit helpers
+ *
+ * Copyright © 2024 Microsoft Corporation
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/audit.h>
+#include <linux/limits.h>
+#include <linux/netlink.h>
+#include <regex.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+
+#define REGEX_LANDLOCK_PREFIX "^audit([0-9.:]\\+): domain=[0-9a-f]\\+"
+
+struct audit_state {
+	int fd;
+	size_t exe_len;
+	char exe[PATH_MAX];
+};
+
+struct audit_message {
+	struct nlmsghdr header;
+	union {
+		struct audit_status status;
+		struct audit_features features;
+		struct audit_rule_data rule;
+		struct nlmsgerr err;
+		char data[PATH_MAX + 200];
+	};
+};
+
+static int audit_send(const int fd, const struct audit_message *const msg)
+{
+	struct sockaddr_nl addr = {
+		.nl_family = AF_NETLINK,
+	};
+	int ret;
+
+	do {
+		ret = sendto(fd, msg, msg->header.nlmsg_len, 0,
+			     (struct sockaddr *)&addr, sizeof(addr));
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 0)
+		return -errno;
+
+	if (ret != msg->header.nlmsg_len)
+		return -E2BIG;
+
+	return 0;
+}
+
+static int audit_recv(const int fd, struct audit_message *const msg)
+{
+	struct sockaddr_nl addr;
+	socklen_t addrlen = sizeof(addr);
+	int err;
+
+	do {
+		err = recvfrom(fd, msg, sizeof(*msg), 0,
+			       (struct sockaddr *)&addr, &addrlen);
+	} while (err < 0 && errno == EINTR);
+
+	if (err < 0)
+		return -errno;
+
+	if (addrlen != sizeof(addr) || addr.nl_pid != 0)
+		return -EINVAL;
+
+	if (msg->header.nlmsg_type == NLMSG_ERROR && msg->err.error)
+		return msg->err.error;
+
+	return 0;
+}
+
+static int audit_request(const int fd,
+			 const struct audit_message *const request,
+			 struct audit_message *reply)
+{
+	struct audit_message msg;
+	int ret;
+
+	ret = audit_send(fd, request);
+	if (ret)
+		return ret;
+
+	if (!reply)
+		reply = &msg;
+
+	return audit_recv(fd, reply);
+}
+
+static int audit_filter_exe(const struct audit_state *const state,
+			    const __u16 type)
+{
+	struct audit_message msg = {
+		.header = {
+			.nlmsg_len = NLMSG_SPACE(sizeof(msg.rule)) +
+				     NLMSG_ALIGN(state->exe_len),
+			.nlmsg_type = type,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.rule = {
+			.flags = AUDIT_FILTER_EXCLUDE,
+			.action = AUDIT_NEVER,
+			.field_count = 1,
+			.fields[0] = AUDIT_EXE,
+			.fieldflags[0] = AUDIT_NOT_EQUAL,
+			.values[0] = state->exe_len,
+			.buflen = state->exe_len,
+		}
+	};
+
+	memcpy(msg.rule.buf, state->exe, state->exe_len);
+	return audit_request(state->fd, &msg, NULL);
+}
+
+static int audit_filter_drop(const struct audit_state *const state,
+			     const __u16 type)
+{
+	struct audit_message msg = {
+		.header = {
+			.nlmsg_len = NLMSG_SPACE(sizeof(msg.rule)),
+			.nlmsg_type = type,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.rule = {
+			.flags = AUDIT_FILTER_EXCLUDE,
+			.action = AUDIT_NEVER,
+			.field_count = 1,
+			.fields[0] = AUDIT_MSGTYPE,
+			.fieldflags[0] = AUDIT_NOT_EQUAL,
+			.values[0] = AUDIT_LANDLOCK_DOM_DROP,
+		}
+	};
+
+	return audit_request(state->fd, &msg, NULL);
+}
+
+static int audit_set_status(int fd, __u32 key, __u32 val)
+{
+	const struct audit_message msg = {
+		.header = {
+			.nlmsg_len = NLMSG_SPACE(sizeof(msg.status)),
+			.nlmsg_type = AUDIT_SET,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.status = {
+			.mask = key,
+			.enabled = key == AUDIT_STATUS_ENABLED ? val : 0,
+			.pid = key == AUDIT_STATUS_PID ? val : 0,
+		}
+	};
+
+	return audit_request(fd, &msg, NULL);
+}
+
+static int audit_match_record(struct audit_state *const state, const __u16 type,
+			      const char *const pattern)
+{
+	struct audit_message msg;
+	int ret, err = 0;
+	bool matches_record = !type;
+	regex_t regex;
+
+	ret = regcomp(&regex, pattern, 0);
+	if (ret)
+		return -EINVAL;
+
+	do {
+		memset(&msg, 0, sizeof(msg));
+		err = audit_recv(state->fd, &msg);
+		if (err)
+			goto out;
+
+		if (msg.header.nlmsg_type == type)
+			matches_record = true;
+	} while (!matches_record);
+
+	ret = regexec(&regex, msg.data, 0, NULL, 0);
+	if (ret) {
+		printf("DATA: %s\n", msg.data);
+		printf("ERROR: no match for pattern: %s\n", pattern);
+		err = -ENOENT;
+	}
+
+out:
+	regfree(&regex);
+	return err;
+}
+
+struct audit_records {
+	size_t deny;
+	size_t info;
+	size_t drop;
+};
+
+static void audit_count_records(struct audit_state *const state,
+				struct audit_records *records)
+{
+	struct audit_message msg;
+
+	records->deny = 0;
+	records->info = 0;
+	records->drop = 0;
+
+	do {
+		memset(&msg, 0, sizeof(msg));
+		if (audit_recv(state->fd, &msg))
+			return;
+
+		switch (msg.header.nlmsg_type) {
+		case AUDIT_LANDLOCK_DENY:
+			records->deny++;
+			break;
+		case AUDIT_LANDLOCK_DOM_INFO:
+			records->info++;
+			break;
+		case AUDIT_LANDLOCK_DOM_DROP:
+			records->drop++;
+			break;
+		}
+	} while (true);
+}
+
+static int audit_init_state(struct audit_state *state)
+{
+	int err;
+
+	state->fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_AUDIT);
+	if (state->fd < 0)
+		return -errno;
+
+	err = audit_set_status(state->fd, AUDIT_STATUS_ENABLED, 1);
+	if (err)
+		return err;
+
+	err = audit_set_status(state->fd, AUDIT_STATUS_PID, getpid());
+	if (err)
+		return err;
+
+	state->exe_len =
+		readlink("/proc/self/exe", state->exe, sizeof(state->exe) - 1);
+	if (state->exe_len < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int audit_cleanup(struct audit_state *state)
+{
+	struct audit_state state_clean;
+
+	if (!state) {
+		int err;
+
+		/* Requires when called from FIXTURE_TEARDOWN_PARENT(). */
+		state = &state_clean;
+		err = audit_init_state(state);
+		if (err)
+			return err;
+	}
+
+	/* Filters might not be in place. */
+	audit_filter_exe(state, AUDIT_DEL_RULE);
+	audit_filter_drop(state, AUDIT_DEL_RULE);
+
+	/*
+	 * Because audit_cleanup() might not be called by the test auditd
+	 * process, it might not be possible to explicitly set it.  Anyway,
+	 * AUDIT_STATUS_ENABLED will implicitly be set to 0 when the auditd
+	 * process will exit.
+	 */
+	return close(state->fd);
+}
+
+static int audit_init(struct audit_state *state)
+{
+	const struct timeval tv = {
+		.tv_usec = 1,
+	};
+	int err;
+
+	err = audit_init_state(state);
+	if (err)
+		return err;
+
+	// TODO: Make sure there is no rule already filtering.
+
+	err = audit_filter_exe(state, AUDIT_ADD_RULE);
+	if (err)
+		return err;
+
+	/* Sets a timeout for negative tests. */
+	err = setsockopt(state->fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (err)
+		return -errno;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
new file mode 100644
index 000000000000..f09273dc164a
--- /dev/null
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Audit
+ *
+ * Copyright © 2024 Microsoft Corporation
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/landlock.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "audit.h"
+#include "common.h"
+
+static int matches_log_umount(struct __test_metadata *const _metadata,
+			      struct audit_state *const state)
+{
+	// TODO: return -errno with AUDIT_SYSCALL
+	return !audit_match_record(state, AUDIT_LANDLOCK_DENY,
+				   REGEX_LANDLOCK_PREFIX " blockers=.*");
+}
+
+FIXTURE(audit)
+{
+	struct audit_state state;
+};
+
+FIXTURE_VARIANT(audit)
+{
+	const int restrict_flags;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit, default) {};
+/* clang-format on */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit, logless) {
+	/* clang-format on */
+	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOGLESS,
+};
+
+FIXTURE_SETUP(audit)
+{
+	int err;
+
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	err = audit_init(&self->state);
+	EXPECT_EQ(0, err)
+	{
+		const char *error_msg;
+
+		if (err == -EEXIST)
+			error_msg = "socket already in use (e.g. auditd)";
+			/* kill "$(auditctl -s | sed -ne 's/^pid \([0-9]\+\)$/\1/p')" */
+		else
+			error_msg = strerror(-err);
+		TH_LOG("Failed to initialize audit: %s", error_msg);
+	}
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+FIXTURE_TEARDOWN(audit)
+{
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_cleanup(&self->state));
+}
+
+TEST_F(audit, fs_deny)
+{
+	int status, ret;
+	pid_t child;
+	struct audit_records records;
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
+		};
+		int ruleset_fd;
+
+		/* Add filesystem restrictions. */
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd,
+						    variant->restrict_flags));
+		EXPECT_EQ(0, close(ruleset_fd));
+
+		/* First umount checks to test log entries. */
+		set_cap(_metadata, CAP_SYS_ADMIN);
+		EXPECT_EQ(-1, umount("/"));
+		EXPECT_EQ(EPERM, errno);
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+
+		if (variant->restrict_flags & LANDLOCK_RESTRICT_SELF_LOGLESS) {
+			EXPECT_EQ(0,
+				  matches_log_umount(_metadata, &self->state));
+		} else {
+			EXPECT_EQ(1,
+				  matches_log_umount(_metadata, &self->state));
+
+			/* Checks domain information records. */
+			ret = audit_match_record(
+				&self->state, AUDIT_LANDLOCK_DOM_INFO,
+				REGEX_LANDLOCK_PREFIX
+				" creation=[0-9.]\\+ pid=[0-9]\\+ uid=[0-9]\\+ exe=\"[^\"]\\+\" comm=\"audit_test\"$");
+			EXPECT_EQ(0, ret);
+		}
+
+		/* Second umount checks to test audit_count_records(). */
+		set_cap(_metadata, CAP_SYS_ADMIN);
+		EXPECT_EQ(-1, umount("/"));
+		EXPECT_EQ(EPERM, errno);
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+
+		/* Makes sure there is no superfluous logged records. */
+		audit_count_records(&self->state, &records);
+		if (variant->restrict_flags & LANDLOCK_RESTRICT_SELF_LOGLESS) {
+			EXPECT_EQ(0, records.deny);
+		} else {
+			EXPECT_EQ(1, records.deny);
+		}
+		EXPECT_EQ(0, records.info);
+		EXPECT_EQ(0, records.drop);
+
+		/* Updates filter rules to match the drop record. */
+		set_cap(_metadata, CAP_AUDIT_CONTROL);
+		EXPECT_EQ(0, audit_filter_drop(&self->state, AUDIT_ADD_RULE));
+		EXPECT_EQ(0, audit_filter_exe(&self->state, AUDIT_DEL_RULE));
+		clear_cap(_metadata, CAP_AUDIT_CONTROL);
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+
+	/* FIXME: How to match the domain drop without race condition? */
+#if 0
+	ret = audit_match_record(&self->state, AUDIT_LANDLOCK_DOM_DROP,
+				 REGEX_LANDLOCK_PREFIX "$");
+	if (variant->restrict_flags & LANDLOCK_RESTRICT_SELF_LOGLESS) {
+		EXPECT_EQ(-EAGAIN, ret);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+
+	/* Makes sure there is no superfluous logged records. */
+	audit_count_records(&self->state, &records);
+	EXPECT_EQ(0, records.deny);
+	EXPECT_EQ(0, records.info);
+	EXPECT_EQ(0, records.drop);
+#endif
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 61056fa074bb..07770c3eb190 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -12,6 +12,7 @@
 #include <linux/landlock.h>
 #include <linux/securebits.h>
 #include <sys/capability.h>
+#include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -64,6 +65,7 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 	/* Only these three capabilities are useful for the tests. */
 	const cap_value_t caps[] = {
 		/* clang-format off */
+		CAP_AUDIT_CONTROL,
 		CAP_DAC_OVERRIDE,
 		CAP_MKNOD,
 		CAP_NET_ADMIN,
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 29af19c4e9f9..3d4eb994d62b 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -1,3 +1,4 @@
+CONFIG_AUDIT=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_INET=y
-- 
2.47.0

