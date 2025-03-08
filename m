Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3C1DC99E
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459509; cv=none; b=MOvwV4nphohNVtwZG8A4Pifr/tsw1/7qTRHEGNBMWnTpsiFXdRoRTDjEg4k1md3V3YXyD2blx4rW9jMNBqYK/9gfP+dAPNZCBwIgOWeJ2wjO9ExTs3k0Cb4T58Ke7of0JC+HoprbSrqVKHHlt+GRw/JkatAnRt+X3HwZgYjz9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459509; c=relaxed/simple;
	bh=7cpt9k1ZLpaoZVPQS1W5YzD18ADWhCuTc32JA0fb3Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUWr+d+mVGsyCaOHgHztqAy4K568GRIVZf7Wrh+oJywtbqVJMX4cXsQgHBX6TC4BpvAkLbWLWfCQtEluJeN73buSMUgtDca8pHQxfGH9BKXE3rQrxskbsEPXdkrjAiubtYSeRtwckRNLUaW3bbkPkour9BTtkUK8fiUvcicKI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JwinksjP; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JwinksjP"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsr59R8zS5n;
	Sat,  8 Mar 2025 19:45:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459504;
	bh=Fldv1rn6sHfI9yybhspBhN5Y364HcxA84Nrn3knPH98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwinksjPwsH+yBtvX0UpO6KmKi+0zQ/+BZ2yLZNrluySswCbyykLQ6tjx6bVYLcFx
	 tMHXZpqtRczv0gyNMIAnuYCGEkc0uME3E8OGOnYWmrjdtTUtmuFSCzBKNlMUgCXKva
	 2yP3p0Bf0Rd1QNAWlBpimYtK/9GnrtXt1Nfbx/wE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsq6pgVzqrM;
	Sat,  8 Mar 2025 19:45:03 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
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
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 21/26] selftests/landlock: Add tests for audit flags and domain IDs
Date: Sat,  8 Mar 2025 19:44:17 +0100
Message-ID: <20250308184422.2159360-22-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit_test.c to check with and without LANDLOCK_RESTRICT_SELF_*
flags against the two Landlock audit record types:
AUDIT_LANDLOCK_ACCESS and AUDIT_LANDLOCK_DOMAIN.

Check consistency of domain IDs in AUDIT_LANDLOCK_ACCESS and
AUDIT_LANDLOCK_DOMAIN messages: denied access, domain allocation, and
domain deallocation.

Tests are run with audit filters to ensure the audit records come from
the test program.  Moreover, because there can only be one audit
process, tests would failed if run in parallel.  Because of audit
limitations, tests can only be run in the initial namespace.

The audit test helpers were inspired by libaudit and
tools/testing/selftests/net/netfilter/audit_logread.c

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Phil Sutter <phil@nwl.cc>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-22-mic@digikod.net
---

There is a race condition when checking the "domain drop" event on some
systems.

Changes since v5:
- Enhance audit_match_record() with an __u64 *domain_id argument set
  according to the audit logs.
- Rename audit_fork.flags to audit_flags.signal .
- Rename variants according to new flags.
- Check consistency of domain IDs.

Changes since v4:
- Update with the new landlock_restrict_self()'s flags, the new audit
  rule types, and message fields.
- Simplify audit_filter_exe() and audit_init_filter_exe().
- Test with kill() instead of umount().
- Test domain deallocation events.

Changes since v3:
- Improve audit_request() to check Netlink errors and handle multiple
  replies.
- Make audit_filter_exe() more generic to handle several audit rule
  lists.
- Merge audit_init_state() into audit_init() and create
  audit_init_with_exe_filter() to handle AUDIT_EXE_LANDLOCK_DENY with an
  arbitrary path.
- Add matches_log_dom_info().

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/audit.h      | 386 ++++++++++++++++++
 tools/testing/selftests/landlock/audit_test.c | 238 +++++++++++
 tools/testing/selftests/landlock/common.h     |   2 +
 tools/testing/selftests/landlock/config       |   1 +
 4 files changed, 627 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/audit.h
 create mode 100644 tools/testing/selftests/landlock/audit_test.c

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
new file mode 100644
index 000000000000..b3b3e52e8256
--- /dev/null
+++ b/tools/testing/selftests/landlock/audit.h
@@ -0,0 +1,386 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock audit helpers
+ *
+ * Copyright © 2024-2025 Microsoft Corporation
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
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+
+#define REGEX_LANDLOCK_PREFIX "^audit([0-9.:]\\+): domain=\\([0-9a-f]\\+\\)"
+
+struct audit_filter {
+	__u32 record_type;
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
+static int audit_recv(const int fd, struct audit_message *msg)
+{
+	struct sockaddr_nl addr;
+	socklen_t addrlen = sizeof(addr);
+	struct audit_message msg_tmp;
+	int err;
+
+	if (!msg)
+		msg = &msg_tmp;
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
+	/* Checks Netlink error or end of messages. */
+	if (msg->header.nlmsg_type == NLMSG_ERROR)
+		return msg->err.error;
+
+	return 0;
+}
+
+static int audit_request(const int fd,
+			 const struct audit_message *const request,
+			 struct audit_message *reply)
+{
+	struct audit_message msg_tmp;
+	bool first_reply = true;
+	int err;
+
+	err = audit_send(fd, request);
+	if (err)
+		return err;
+
+	if (!reply)
+		reply = &msg_tmp;
+
+	do {
+		if (first_reply)
+			first_reply = false;
+		else
+			reply = &msg_tmp;
+
+		err = audit_recv(fd, reply);
+		if (err)
+			return err;
+	} while (reply->header.nlmsg_type != NLMSG_ERROR &&
+		 reply->err.msg.nlmsg_type != request->header.nlmsg_type);
+
+	return reply->err.error;
+}
+
+static int audit_filter_exe(const int audit_fd,
+			    const struct audit_filter *const filter,
+			    const __u16 type)
+{
+	struct audit_message msg = {
+		.header = {
+			.nlmsg_len = NLMSG_SPACE(sizeof(msg.rule)) +
+				     NLMSG_ALIGN(filter->exe_len),
+			.nlmsg_type = type,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.rule = {
+			.flags = AUDIT_FILTER_EXCLUDE,
+			.action = AUDIT_NEVER,
+			.field_count = 1,
+			.fields[0] = filter->record_type,
+			.fieldflags[0] = AUDIT_NOT_EQUAL,
+			.values[0] = filter->exe_len,
+			.buflen = filter->exe_len,
+		}
+	};
+
+	if (filter->record_type != AUDIT_EXE)
+		return -EINVAL;
+
+	memcpy(msg.rule.buf, filter->exe, filter->exe_len);
+	return audit_request(audit_fd, &msg, NULL);
+}
+
+static int audit_filter_drop(const int audit_fd, const __u16 type)
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
+			.values[0] = AUDIT_LANDLOCK_DOMAIN,
+		}
+	};
+
+	return audit_request(audit_fd, &msg, NULL);
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
+/*
+ * @domain_id: The domain ID extracted from the audit message (if the first part
+ * of @pattern is REGEX_LANDLOCK_PREFIX).  It is set to 0 if the domain ID is
+ * not found.
+ */
+static int audit_match_record(int audit_fd, const __u16 type,
+			      const char *const pattern, __u64 *domain_id)
+{
+	struct audit_message msg;
+	int ret, err = 0;
+	bool matches_record = !type;
+	regmatch_t matches[2];
+	regex_t regex;
+
+	ret = regcomp(&regex, pattern, 0);
+	if (ret)
+		return -EINVAL;
+
+	do {
+		memset(&msg, 0, sizeof(msg));
+		err = audit_recv(audit_fd, &msg);
+		if (err)
+			goto out;
+
+		if (msg.header.nlmsg_type == type)
+			matches_record = true;
+	} while (!matches_record);
+
+	ret = regexec(&regex, msg.data, ARRAY_SIZE(matches), matches, 0);
+	if (ret) {
+		printf("DATA: %s\n", msg.data);
+		printf("ERROR: no match for pattern: %s\n", pattern);
+		err = -ENOENT;
+	}
+
+	if (domain_id) {
+		*domain_id = 0;
+		if (matches[1].rm_so != -1) {
+			int match_len = matches[1].rm_eo - matches[1].rm_so;
+			/* The maximal characters of a 2^64 hexadecimal number is 17. */
+			char dom_id[18];
+
+			if (match_len > 0 && match_len < sizeof(dom_id)) {
+				memcpy(dom_id, msg.data + matches[1].rm_so,
+				       match_len);
+				dom_id[match_len] = '\0';
+				if (domain_id)
+					*domain_id = strtoull(dom_id, NULL, 16);
+			}
+		}
+	}
+
+out:
+	regfree(&regex);
+	return err;
+}
+
+struct audit_records {
+	size_t access;
+	size_t domain;
+};
+
+// TODO: check that audit_fd is valid
+static void audit_count_records(int audit_fd, struct audit_records *records)
+{
+	struct audit_message msg;
+
+	records->access = 0;
+	records->domain = 0;
+
+	do {
+		memset(&msg, 0, sizeof(msg));
+		if (audit_recv(audit_fd, &msg))
+			return;
+
+		switch (msg.header.nlmsg_type) {
+		case AUDIT_LANDLOCK_ACCESS:
+			records->access++;
+			break;
+		case AUDIT_LANDLOCK_DOMAIN:
+			records->domain++;
+			break;
+		}
+	} while (true);
+}
+
+static int audit_init(void)
+{
+	const struct timeval tv = {
+		.tv_usec = 1,
+	};
+	int fd, err;
+
+	fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_AUDIT);
+	if (fd < 0)
+		return -errno;
+
+	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
+	if (err)
+		return err;
+
+	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
+	if (err)
+		return err;
+
+	/* Sets a timeout for negative tests. */
+	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (err)
+		return -errno;
+
+	return fd;
+}
+
+static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
+{
+	char *absolute_path = NULL;
+
+	// TODO: Make sure there is no rule already filtering.
+
+	filter->record_type = AUDIT_EXE;
+
+	if (!path) {
+		filter->exe_len = readlink("/proc/self/exe", filter->exe,
+					   sizeof(filter->exe) - 1);
+		if (filter->exe_len < 0)
+			return -errno;
+
+		return 0;
+	}
+
+	absolute_path = realpath(path, NULL);
+	if (!absolute_path)
+		return -errno;
+
+	/* No need for the terminating NULL byte. */
+	filter->exe_len = strlen(absolute_path);
+	if (filter->exe_len > sizeof(filter->exe))
+		return -E2BIG;
+
+	memcpy(filter->exe, absolute_path, filter->exe_len);
+	free(absolute_path);
+	return 0;
+}
+
+static int audit_cleanup(int audit_fd, struct audit_filter *filter)
+{
+	struct audit_filter new_filter;
+
+	if (audit_fd < 0 || !filter) {
+		int err;
+
+		/*
+		 * Simulates audit_init_with_exe_filter() when called from
+		 * FIXTURE_TEARDOWN_PARENT().
+		 */
+		audit_fd = audit_init();
+		if (audit_fd < 0)
+			return audit_fd;
+
+		filter = &new_filter;
+		err = audit_init_filter_exe(filter, NULL);
+		if (err)
+			return err;
+	}
+
+	/* Filters might not be in place. */
+	audit_filter_exe(audit_fd, filter, AUDIT_DEL_RULE);
+	audit_filter_drop(audit_fd, AUDIT_DEL_RULE);
+
+	/*
+	 * Because audit_cleanup() might not be called by the test auditd
+	 * process, it might not be possible to explicitly set it.  Anyway,
+	 * AUDIT_STATUS_ENABLED will implicitly be set to 0 when the auditd
+	 * process will exit.
+	 */
+	return close(audit_fd);
+}
+
+static int audit_init_with_exe_filter(struct audit_filter *filter)
+{
+	int fd, err;
+
+	fd = audit_init();
+	if (fd < 0)
+		return fd;
+
+	err = audit_init_filter_exe(filter, NULL);
+	if (err)
+		return err;
+
+	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
+	if (err)
+		return err;
+
+	return fd;
+}
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
new file mode 100644
index 000000000000..09bf74749aeb
--- /dev/null
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Audit
+ *
+ * Copyright © 2024-2025 Microsoft Corporation
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
+static int matches_log_domain_allocated(struct __test_metadata *const _metadata,
+					int audit_fd, __u64 *domain_id)
+{
+	return audit_match_record(
+		audit_fd, AUDIT_LANDLOCK_DOMAIN,
+		REGEX_LANDLOCK_PREFIX
+		" status=allocated mode=enforcing pid=[0-9]\\+ uid=[0-9]\\+"
+		" exe=\"[^\"]\\+\" comm=\"audit_test\"$",
+		domain_id);
+}
+
+static int
+matches_log_domain_deallocated(struct __test_metadata *const _metadata,
+			       int audit_fd, unsigned int num_denials,
+			       __u64 *domain_id)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" status=deallocated denials=%u$";
+	char log_match[sizeof(log_template) + 10];
+	int log_match_len;
+
+	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
+				 num_denials);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
+				  domain_id);
+}
+
+static int matches_log_signal(struct __test_metadata *const _metadata,
+			      int audit_fd, const pid_t opid, __u64 *domain_id)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=scope\\.signal opid=%d ocomm=\"audit_test\"$";
+	char log_match[sizeof(log_template) + 10];
+	int log_match_len;
+
+	log_match_len =
+		snprintf(log_match, sizeof(log_match), log_template, opid);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  domain_id);
+}
+
+FIXTURE(audit_flags)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+	__u64 *domain_id;
+};
+
+FIXTURE_VARIANT(audit_flags)
+{
+	const int restrict_flags;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_flags, default) {
+	/* clang-format on */
+	.restrict_flags = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_flags, same_exec_off) {
+	/* clang-format on */
+	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_flags, subdomains_off) {
+	/* clang-format on */
+	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_flags, cross_exec_on) {
+	/* clang-format on */
+	.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON,
+};
+
+FIXTURE_SETUP(audit_flags)
+{
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd)
+	{
+		const char *error_msg;
+
+		/* kill "$(auditctl -s | sed -ne 's/^pid \([0-9]\+\)$/\1/p')" */
+		if (self->audit_fd == -EEXIST)
+			error_msg = "socket already in use (e.g. auditd)";
+		else
+			error_msg = strerror(-self->audit_fd);
+		TH_LOG("Failed to initialize audit: %s", error_msg);
+	}
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+
+	self->domain_id = mmap(NULL, sizeof(*self->domain_id),
+			       PROT_READ | PROT_WRITE,
+			       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, self->domain_id);
+	/* Domain IDs are greater or equal to 2^32. */
+	*self->domain_id = 1;
+}
+
+FIXTURE_TEARDOWN(audit_flags)
+{
+	EXPECT_EQ(0, munmap(self->domain_id, sizeof(*self->domain_id)));
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_cleanup(self->audit_fd, &self->audit_filter));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+TEST_F(audit_flags, signal)
+{
+	int status;
+	pid_t child;
+	struct audit_records records;
+	__u64 domain_id_deallocated = 2;
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.scoped = LANDLOCK_SCOPE_SIGNAL,
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
+		/* First signal checks to test log entries. */
+		EXPECT_EQ(-1, kill(getppid(), 0));
+		EXPECT_EQ(EPERM, errno);
+
+		if (variant->restrict_flags &
+		    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+			EXPECT_EQ(-EAGAIN, matches_log_signal(
+						   _metadata, self->audit_fd,
+						   getppid(), self->domain_id));
+			EXPECT_EQ(*self->domain_id, 1);
+		} else {
+			__u64 domain_id_allocated;
+
+			EXPECT_EQ(0, matches_log_signal(
+					     _metadata, self->audit_fd,
+					     getppid(), self->domain_id));
+
+			/* Checks domain information records. */
+			EXPECT_EQ(0, matches_log_domain_allocated(
+					     _metadata, self->audit_fd,
+					     &domain_id_allocated));
+			EXPECT_NE(*self->domain_id, 1);
+			EXPECT_NE(*self->domain_id, 0);
+			EXPECT_EQ(*self->domain_id, domain_id_allocated);
+		}
+
+		/* Second signal checks to test audit_count_records(). */
+		EXPECT_EQ(-1, kill(getppid(), 0));
+		EXPECT_EQ(EPERM, errno);
+
+		/* Makes sure there is no superfluous logged records. */
+		audit_count_records(self->audit_fd, &records);
+		if (variant->restrict_flags &
+		    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+			EXPECT_EQ(0, records.access);
+		} else {
+			EXPECT_EQ(1, records.access);
+		}
+		EXPECT_EQ(0, records.domain);
+
+		/* Updates filter rules to match the drop record. */
+		set_cap(_metadata, CAP_AUDIT_CONTROL);
+		EXPECT_EQ(0, audit_filter_drop(self->audit_fd, AUDIT_ADD_RULE));
+		EXPECT_EQ(0,
+			  audit_filter_exe(self->audit_fd, &self->audit_filter,
+					   AUDIT_DEL_RULE));
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
+	if (variant->restrict_flags &
+	    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF) {
+		EXPECT_EQ(-EAGAIN, matches_log_domain_deallocated(
+					   _metadata, self->audit_fd, 0,
+					   &domain_id_deallocated));
+		EXPECT_EQ(domain_id_deallocated, 2);
+	} else {
+		// FIXME: Even if we waited for the child, the following call always
+		// return -EAGAIN on some environments unless we call sleep(1).
+		// Any idea how to avoid that?
+		EXPECT_EQ(0, matches_log_domain_deallocated(
+				     _metadata, self->audit_fd, 2,
+				     &domain_id_deallocated));
+		EXPECT_NE(domain_id_deallocated, 2);
+		EXPECT_NE(domain_id_deallocated, 0);
+		EXPECT_EQ(domain_id_deallocated, *self->domain_id);
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 6064c9ac0532..fe6ada2c2518 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <linux/securebits.h>
 #include <sys/capability.h>
+#include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/wait.h>
@@ -37,6 +38,7 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 	/* Only these three capabilities are useful for the tests. */
 	const cap_value_t caps[] = {
 		/* clang-format off */
+		CAP_AUDIT_CONTROL,
 		CAP_DAC_OVERRIDE,
 		CAP_MKNOD,
 		CAP_NET_ADMIN,
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 425de4c20271..8fe9b461b1fd 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -1,4 +1,5 @@
 CONFIG_AF_UNIX_OOB=y
+CONFIG_AUDIT=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_INET=y
-- 
2.48.1

