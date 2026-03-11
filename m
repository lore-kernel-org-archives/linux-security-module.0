Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163D35F169
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264693; cv=none; b=N4htCCGDtuJUnYyCcaAOPkji6X2zqKLgmT+ZceXeVK7tqeLI6VZF5zc1li9m0JcS7SUwLeMyfn0G3N+doeASkJWmOb+P7TwmOWC59mEbfsrpbcOzZVagrJOO8+EYu9vJ+iIlnYNVeoex+8HPIgVTBksKSnMViHk0zINOqXsf750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264693; c=relaxed/simple;
	bh=DGC/mnZQhpz5il2Tzb09RQpPXoCNmn0gakwBC8UxatM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rujgnHZu4Cj8EP5e0NaZwKmmNVCC40kb/gJr4MfIPFRKqU6Uky5/+tcJnJHnzCFJPAcsMoAwQXWn442vn6eH/0okh/ogQp36nhkGxAwyPE8uqBp5cZ8pyxZ204P44vZG/9WUC5fgz4F4O/W0Vf1u0m/xGo56UI8H6Ym17KGOT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NJQJuuSc; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NJQJuuSc"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d74a59262fso359446a34.0
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773264689; x=1773869489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7OoBOcJoXPvGUFfb7j19iEOnfHgf2KamFxcvgKSJ7g=;
        b=NJQJuuScGbvRVrQxFkZGCJwKD2zrtapQOpU1M0BfgzC2ugBUUBX14Tkj79swyAPfLK
         7bHkBHCir6ninelOfUWOGXPiwfIxJFTE66smcg+7gbCGO17t0ACbac/p4msP/AjsSXTp
         GthjlRE9jVX8tmCp4xrnh50igeB35pyNd03bC0L6tGZ7Vk/FN1CmTO2COxtKNf/Uc3HU
         Jj/UjZJKPegrMbiOm/Bu/Rg+GUiROCCVAl3gKirxv7/vs0ii4VPf2i1tNht+GfDliHYj
         gn28/YlKRSCQ7LUY6YzY+plb9TPDaA5x4/+2Cazwi6TZBeoIVJJaoZQGRUE7eAFRqPwl
         /dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773264689; x=1773869489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7OoBOcJoXPvGUFfb7j19iEOnfHgf2KamFxcvgKSJ7g=;
        b=ZyeS6ckj0wfrEs5k/JNvb9Y5gprAg2KiIh8ZFNCZza4pdkNvTrTWFL2mdzk60x5Lr/
         W+2FrCTNpH2H4sL1csumNKWGeY9YGrYwXMBfMKgfBW/hM/RKQvrj/V9nNxkt4hNcQM5b
         nNmlTAXHKWzxnFjQxHQw3nv2K135dljtVxP7KYh6gvwCJREUV/73IWFSYu/1gXfIPMfC
         Vu4+tOWWmdmwyLo4OTiSPhdfOr4/IUoOzEvwGLU/tZhUGlCxeAIX9g5y3w0zFNtEPLWj
         EmG7j8hfEAg3oKAxuxvOaPjrZjvpOilLOYu63PM+q1nGraeiK/jYeyKinVNmn0Lw4ysT
         MnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN6nM4UKTkMdTpA8NncrnExl8ipuCHRPgoLzdOGq2qSrLzydNQPnS5XrXHgU8QBnDiZYcOspF4dGfDPJkhKFv0b5z7rpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzaAlDg4btjzIuJlYXZoH3cRbaL+XV5Df13TE2mCEz2Ic1oa8o
	tdQ0BSHDoRpsTsKoo1ZxVfZDkDeKpjpxGoRCyH3aRBKexMyenWY4qnVWpcZnQTzQV/A=
X-Gm-Gg: ATEYQzygI4xpNcmTmnDlKl7BLZGDYMX7IPMUpczDKVSBKUOprUDUYXmTP1yY1ks69kV
	Dro15+SYQC0Bl6XdVVeZU2CUufjL1aqkK+K2CgAvMcUKXvWNzfMThHOyaOat+JC1JK41SfaiVLm
	qKWTRWmk7cepWWv78Lq2WCVNpDlTfwXakwSy/SfoLNC3oMFXeXR77FMJTBv1GD03BThNJ7P8ZDh
	hC7+UVW4vF4EN3dvYLO0n3M/8RBFicsJ5J28f5b4SwxS66KRNaY0nl5xi68WD/+TWrqNy0RoPgm
	JUbMQSwcGg4/K8NGtNpeE3uATf/JTnJqgocKfv3mAzwzrR5p0g5/c4ViC0YMLseL9qtDBfOL/Xc
	ZNFFZprvVWbb2BMsJ6I7w9Y4clKkWHZDNI26HTz6mGWj8LpLQFAJpQDGA8NrQpljZLWtDRELZfm
	7eXje62c3qDxVeIN2jMQ==
X-Received: by 2002:a05:6820:1c95:b0:67b:c02e:beaf with SMTP id 006d021491bc7-67bc899efb5mr2873342eaf.46.1773264689029;
        Wed, 11 Mar 2026 14:31:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:82])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb90csm3530413fac.4.2026.03.11.14.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:31:28 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Wed, 11 Mar 2026 16:31:19 -0500
Subject: [PATCH RFC bpf-next 3/4] selftests/bpf: Add audit helpers for BPF
 tests
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bpf-auditd-send-message-v1-3-10a62db5c92f@cloudflare.com>
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
In-Reply-To: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 audit@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9858; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=DGC/mnZQhpz5il2Tzb09RQpPXoCNmn0gakwBC8UxatM=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpsd8oz+Df/5XjCq+ZqxcHfOCD1Tz7FPfL9FGSK
 aztPlKvqGyJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCabHfKAAKCRCrJbR2A5LT
 bWdXD/9vtXXedAlWtmww8GfZdgRYhjIz9pZJd7DgiG8RavUkAGh6cWGHsxcEo+39V6DpKjypgWj
 9cL5rtup8mDIDik5tyDmsuNghbnLXN9iSoJ+Rt5ybo3/oxlKK669C2x3KfnZl9+/ITXvCxoX+Nf
 ZFC6X6CTSuq0ofTCegcbu/chrwUjMPAV5ep0Kg51x18OuRYBhrVPz6GEO0nWzLATHAk+Jl42jAP
 AYpgaArcehazglHhfUBgHOXVpMRcvhjEtOR15BNDCZULPeW6ECCWN2uoDJ/wkXPhiQWCCRHDMjB
 4fWMpbt0sdHGylOY4NhnSsyUU7h1TXCP88E9vwPKRmwWIXG4tPUY/3TPaASNeC7b5eN70yCtoq/
 a6Y/FI7a+Q5W3ev/2M+zBes8hyUxIK49iHlYzdeNnsypAekKmuWWVdacu1TQxDaXHf59nSTesfp
 MdzwW7NbRWkZE173ramzq/oqdWleDtSSl0TBAKqJUiLj8AUeoNy8c45DqNTDUeepHZTeEz4wI/H
 kIwPm+VVc8m/kiqIZAUTYjEhAzw/tj3Bc7hCTsbLsfb53we89I7uG5KVLE/MCvBt5LdiUBVb2xc
 xgXirYZ5Uz0Hai5LsoI0XKXjyCi7eoG/aIf+Cbm2QdTP+R6V//yfCivd3NirSZxwx9qjG5+qtnf
 OVi4HMH5iNFbhPw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Add audit helper utilities for reading and parsing audit messages
in BPF selftests.

Assisted-by: Claude:claude-4.5-opus
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 tools/testing/selftests/bpf/Makefile        |   3 +-
 tools/testing/selftests/bpf/audit_helpers.c | 281 ++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/audit_helpers.h |  55 ++++++
 3 files changed, 338 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 869b582b1d1ff496fb07736597708487be3438ed..76a428539add5e03fe3811b41c55005c22f5cead 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -754,7 +754,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h	\
 			 bpftool_helpers.c	\
-			 usdt_1.c usdt_2.c
+			 usdt_1.c usdt_2.c	\
+			 audit_helpers.c
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
diff --git a/tools/testing/selftests/bpf/audit_helpers.c b/tools/testing/selftests/bpf/audit_helpers.c
new file mode 100644
index 0000000000000000000000000000000000000000..a105136a581f92a1af73b9456b1e85dc88176678
--- /dev/null
+++ b/tools/testing/selftests/bpf/audit_helpers.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF audit helpers
+ *
+ * Borrowed code from tools/selftests/landlock/audit.h
+ *
+ * Copyright (C) 2024-2025 Microsoft Corporation
+ * Copyright (c) 2026 Cloudflare
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/audit.h>
+#include <linux/netlink.h>
+#include <netinet/in.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/un.h>
+
+#include "audit_helpers.h"
+
+static __u32 seq;
+
+int audit_init(void)
+{
+	int bufsize = 1024 * 1024; /* 1MB receive buffer */
+	struct audit_message msg;
+	int fd, err;
+
+	fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_AUDIT);
+	if (fd < 0)
+		return -errno;
+
+	/*
+	 * Increase receive buffer to reduce kernel-side queueing.
+	 * When the socket buffer fills up, audit records get queued in
+	 * the kernel's hold/retry queues and delivered on subsequent runs.
+	 */
+	setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &bufsize, sizeof(bufsize));
+
+	seq = 0;
+	err = audit_send(fd, AUDIT_SET, AUDIT_STATUS_ENABLED, 1);
+	if (err)
+		goto out_close;
+
+	do {
+		err = audit_recv(fd, &msg, 0);
+		if (err < 0)
+			goto out_close;
+	} while (msg.nlh.nlmsg_type != NLMSG_ERROR);
+
+	if (msg.err.error)
+		goto out_close;
+
+	err = audit_send(fd, AUDIT_SET, AUDIT_STATUS_PID, getpid());
+	if (err)
+		goto out_close;
+
+	do {
+		err = audit_recv(fd, &msg, 0);
+		if (err < 0)
+			goto out_close;
+	} while (msg.nlh.nlmsg_type != NLMSG_ERROR);
+
+	if (msg.err.error)
+		goto out_close;
+
+	return fd;
+
+out_close:
+	close(fd);
+	return err;
+}
+
+void audit_cleanup(int fd)
+{
+	if (fd > 0)
+		close(fd);
+}
+
+int audit_send(int fd, __u16 type, __u32 key, __u32 val)
+{
+	struct audit_message msg = {
+		.nlh = {
+			.nlmsg_len = NLMSG_SPACE(sizeof(msg.status)),
+			.nlmsg_type = type,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+			.nlmsg_seq = ++seq,
+		},
+		.status = {
+			.mask = key,
+			.enabled = key == AUDIT_STATUS_ENABLED ? val : 0,
+			.pid = key == AUDIT_STATUS_PID ? val : 0,
+		},
+	};
+	struct sockaddr_nl addr = { .nl_family = AF_NETLINK };
+	int ret;
+
+	do {
+		ret = sendto(fd, &msg, msg.nlh.nlmsg_len, 0,
+			     (struct sockaddr *)&addr, sizeof(addr));
+	} while (ret < 0 && errno == EINTR);
+
+	return ret == msg.nlh.nlmsg_len ? 0 : -errno;
+}
+
+/*
+ * Receive an audit message from the netlink socket.
+ * Returns:
+ *   > 0: message type on success
+ *   0: ACK received (NLMSG_ERROR with error=0)
+ *   < 0: negative errno on error
+ */
+int audit_recv(int fd, struct audit_message *msg, int flags)
+{
+	struct sockaddr_nl addr;
+	socklen_t addrlen = sizeof(addr);
+	int ret;
+
+	do {
+		ret = recvfrom(fd, msg, sizeof(*msg), flags,
+			       (struct sockaddr *)&addr, &addrlen);
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 0)
+		return -errno;
+
+	/* Must be from kernel (pid 0) */
+	if (addrlen != sizeof(addr) || addr.nl_pid != 0)
+		return -EINVAL;
+
+	/*
+	 * NLMSG_ERROR with error=0 is an ACK. The kernel sends this in
+	 * response to messages with NLM_F_ACK flag set.
+	 */
+	if (msg->nlh.nlmsg_type == NLMSG_ERROR) {
+		if (msg->err.error == 0)
+			return 0; /* ACK */
+		return msg->err.error;
+	}
+
+	return msg->nlh.nlmsg_type;
+}
+
+__printf(2, 3) static inline void
+debug(struct audit_observer *obs, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!obs || !obs->log)
+		return;
+
+	va_start(args, fmt);
+	vfprintf(obs->log, fmt, args);
+	va_end(args);
+}
+
+void audit_observer_init(struct audit_observer *obs, int audit_fd, FILE *log,
+			 int wait_timeout_ms)
+{
+	obs->audit_fd = audit_fd;
+	obs->wait_timeout = wait_timeout_ms;
+
+	if (log)
+		obs->log = log;
+
+	audit_observer_reset(obs);
+}
+
+void audit_observer_reset(struct audit_observer *obs)
+{
+	memset(obs->expects, 0, sizeof(obs->expects));
+	obs->num_expects = 0;
+}
+
+int audit_observer_expect(struct audit_observer *obs, int audit_type,
+			  const char *pattern, int count)
+{
+	struct audit_expectation *exp;
+
+	if (obs->num_expects >= AUDIT_EXPECT_MAX)
+		return -EINVAL;
+
+	exp = &obs->expects[obs->num_expects++];
+	exp->type = audit_type;
+	exp->pattern = pattern;
+	exp->expected_count = count;
+	exp->matched_count = 0;
+	return 0;
+}
+
+/*
+ * Check if a message matches any pending expectation.
+ * Returns 1 if all expectations are satisfied, 0 otherwise.
+ */
+static int audit_observer_match(struct audit_observer *obs,
+				struct audit_message *msg)
+{
+	int all_satisfied = 1;
+
+	for (int i = 0; i < obs->num_expects; i++) {
+		struct audit_expectation *exp = &obs->expects[i];
+
+		if (exp->matched_count >= exp->expected_count)
+			continue;
+
+		/* Check if this message matches */
+		if (exp->type && msg->nlh.nlmsg_type != exp->type)
+			goto check_satisfied;
+
+		if (strstr(msg->data, exp->pattern)) {
+			exp->matched_count++;
+			debug(obs, "%s: matched [%d/%d] %s\n", __func__,
+			      exp->matched_count, exp->expected_count,
+			      exp->pattern);
+		}
+
+check_satisfied:
+		if (exp->matched_count < exp->expected_count)
+			all_satisfied = 0;
+	}
+
+	return all_satisfied;
+}
+
+/*
+ * Wait for all expected audit messages to arrive.
+ * Returns 0 on success (all expectations met), -ETIMEDOUT on timeout.
+ */
+int audit_observer_wait(struct audit_observer *obs)
+{
+	struct pollfd pfd = { .fd = obs->audit_fd, .events = POLLIN };
+	struct audit_message msg;
+	int ret;
+
+	while (1) {
+		ret = poll(&pfd, 1, obs->wait_timeout);
+		if (ret < 0)
+			return -errno;
+		if (ret == 0)
+			return -ETIMEDOUT;
+
+		memset(&msg, 0, sizeof(msg));
+		ret = audit_recv(obs->audit_fd, &msg, MSG_DONTWAIT);
+
+		if (ret == -EAGAIN || ret == -EWOULDBLOCK)
+			continue;
+
+		if (ret <= 0)
+			continue;
+
+		debug(obs, "%s: recv type=%d %s\n", __func__,
+		      msg.nlh.nlmsg_type, msg.data);
+
+		if (audit_observer_match(obs, &msg))
+			return 0;
+	}
+}
+
+int audit_observer_check_satisfied(struct audit_observer *obs)
+{
+	for (int i = 0; i < obs->num_expects; i++) {
+		struct audit_expectation *exp = &obs->expects[i];
+
+		if (exp->matched_count < exp->expected_count) {
+			debug(obs, "%s: FAILED pattern '%s' got %d/%d\n",
+			      __func__, exp->pattern, exp->matched_count,
+			      exp->expected_count);
+			return 0;
+		}
+	}
+
+	return 1;
+}
diff --git a/tools/testing/selftests/bpf/audit_helpers.h b/tools/testing/selftests/bpf/audit_helpers.h
new file mode 100644
index 0000000000000000000000000000000000000000..40f3d20635bb25c305067756897593f34d54531e
--- /dev/null
+++ b/tools/testing/selftests/bpf/audit_helpers.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Cloudflare */
+#pragma once
+
+#include <linux/audit.h>
+#include <linux/netlink.h>
+#include <stdio.h>
+
+#define MAX_AUDIT_MESSAGE_LENGTH 8970
+
+struct audit_message {
+	struct nlmsghdr nlh;
+	union {
+		struct audit_status status;
+		struct nlmsgerr err;
+		char data[MAX_AUDIT_MESSAGE_LENGTH];
+	};
+};
+
+/*
+ * Observer-based audit message matching.
+ * Tests register expected patterns before triggering events, then
+ * wait for matches. Messages that don't match any pattern are skipped.
+ */
+#define AUDIT_EXPECT_MAX 32
+
+struct audit_expectation {
+	__u16 type;
+	const char *pattern;
+	int expected_count;
+	int matched_count;
+};
+
+struct audit_observer {
+	struct audit_expectation expects[AUDIT_EXPECT_MAX];
+	int num_expects;
+	FILE *log;
+	int wait_timeout;
+	int audit_fd;
+};
+
+int audit_init(void);
+void audit_cleanup(int fd);
+int audit_wait_ack(int fd);
+int audit_send(int fd, __u16 type, __u32 key, __u32 val);
+int audit_recv(int fd, struct audit_message *msg, int flags);
+int audit_wait_ack(int fd);
+
+void audit_observer_init(struct audit_observer *obs, int audit_fd, FILE *log,
+			 int wait_timeout);
+void audit_observer_reset(struct audit_observer *obs);
+int audit_observer_expect(struct audit_observer *obs, int audit_type,
+			  const char *pattern, int count);
+int audit_observer_wait(struct audit_observer *obs);
+int audit_observer_check_satisfied(struct audit_observer *obs);

-- 
2.43.0

