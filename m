Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FB361DC9
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264697; cv=none; b=QdFKul6W2oH33aYTZikh4rpdtXc5A2oO0s59eRM0NqkM8z7/9H4PRAKAl2X6SB3ud1HLZouF0iKFRPAGGLfg7CRHm0l1ltqwsC5Z85keRi2kWXxWnPRdLg7Hxs10TzVPNSftLXsQ0ysvcVccKidizEKKa7gQmk7XWVnrcHPsl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264697; c=relaxed/simple;
	bh=B986+q0EPyEQDvxqJ//qZ7hW3q9zmixUG/Y18ImATFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhjXsJBa+LvbVEXHVxCZpFbDPmQjp1op4pqYWVB2IWXDWNCODDWtqe73N+yykobHrvza+qLi2iyAosBxaqTkOJQ2P4UhT7CEz2VNJh7t6u1CiLiBd58Y0o7nMS5lsBwVUpzxs+FFjZXZJgcqkPxNx0PfKzD8QaTF9OgrC0UHvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N3g3PA0N; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N3g3PA0N"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40429b1d8baso181250fac.0
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773264691; x=1773869491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tthSI5YwBPQg2S9IxaV+bU7gsd9dh2H/s6cG0iD4L0E=;
        b=N3g3PA0NvgIS8AEBI5hqU5WyfQL2hU2jygUqQxqAReQk1Ig6TnyqS+QPUCr4quJvCh
         uY3X/ALSuUCLmyBAgNXZX7vK92UvVeJ4pBLtNNJg1SsnXyUMJZBhCcOp2csMAkl1BF7l
         8ZL2IPMq8Xk7gS2jwaj8Nc1F5D79LgO2VgYFewcVL1cZ+ZMJk21BWFuBPEEMwa7W8Ufx
         cp8eWhoPzf8YlTl/hui83+HyEcLJ6MkCOiuwwHo7MRgdidMBsZA6PJEzQ7O/fg5lQlTA
         ETW0ANocyg4MiNtAS4QMWrmDgKCJGM9xcio3WFlfJuvoLwCTWPziy1j/u7Ta+GFwUO8T
         dd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773264691; x=1773869491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tthSI5YwBPQg2S9IxaV+bU7gsd9dh2H/s6cG0iD4L0E=;
        b=kKxNYqc4dpiJixc+jk6u4xkjT7nJsoLi2pIe+AxY4NO/ifAsIAN8RzIQq1JWEBrrN1
         bPcaCTTFNJ86H5JNpkwrz3FA1LbSBWmqEOGPZdAzbpgNvyGa5v09ds3l/pFEnEgE04ij
         mPcA+un+STG16IG8wvtzfm6zDN8EV5t1NXd3yC0VSzduNZBbIAxnaacNzbA6jDWIAKuC
         kViUYU9N4p/bW0bOtfPUMhcRB0vWnoHfGhj2RE7v6LmlKC+KTGXwWxNplsHnkoAB/HvT
         3cFChZ0mZnt/zdoms5FJEImzl8izUiaPrsgdAKmWVtzlCJQXfj0HLrFJER1V6gFsZSla
         3Aog==
X-Forwarded-Encrypted: i=1; AJvYcCV7LRx+R9bsVKFmliAKWWyDDX13cqhTl+FT4JHUQUQ3Yu5rgZilVKaWn7ftat2IP9spL5qSjHz64rlx3pA7IL5cVO1Ww2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKsHJqHzA63f1sxoGOGwLUioJ6FSBEZk/Kk0EAK7Ho15YqKQI
	kysp6lTF4++RQwHpFrvV8lKFWDKbqy5BJPcWpNcQ1DRIJ3BcaxUBapjaWsxSP4P6now=
X-Gm-Gg: ATEYQzxh77VT7X3jVtB/qU2/CV2NShJhRAs5QmmH6p46dNHBjqkuOUfQNofXMhiyfbf
	kZHNb4cop1sdUPbKZ4u49ONMOIbg5CBQDK9ry1p8axxAQtxWqgodyeARIsZ6NBe4yVdDzxFQhy6
	8Le7P0CyguI4r3NM7HR2or3H/Erz34ZeDidII02l9pr/ZTMihrKP7I0U0aYLtZxSkP2bEi7Yw5X
	KUcnIQBTjJd/A0QqS60D5BWAXFU1/l4XLWwuTdCVqW6dCg5uV5r7w7Smf0Wg09imlLw8lL+gkBP
	dsh6vqUKjq9H/CN3R2Cn4bRxG9/pbh6Y4VdtaKx/RzXx1W0XweIm59oaNYGEN/VZ7MxBP3vqmRA
	P4fDxxNvIT9iVFqZnu2fkyavc3zbekJjctae3fL0HpV9Kp8cJHhGPU3atZ7Jmd8ddZ7k3J/1ieO
	v/pUAgBYI=
X-Received: by 2002:a05:6870:b0ce:b0:417:3bef:8964 with SMTP id 586e51a60fabf-4177c60a84cmr2552985fac.2.1773264691153;
        Wed, 11 Mar 2026 14:31:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:82])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb90csm3530413fac.4.2026.03.11.14.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:31:30 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Wed, 11 Mar 2026 16:31:20 -0500
Subject: [PATCH RFC bpf-next 4/4] selftests/bpf: Add lsm_audit_kfuncs tests
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bpf-auditd-send-message-v1-4-10a62db5c92f@cloudflare.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=22647; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=B986+q0EPyEQDvxqJ//qZ7hW3q9zmixUG/Y18ImATFE=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpsd8ox7VoA9tHygH6CdWnV5yXxCKCXYsthDZcm
 zaAQBG5hfWJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCabHfKAAKCRCrJbR2A5LT
 bSQ2D/4saIy2ZXQv1HF99uhbehkV7IRPcjBS9V9Xt+dosdvExoSYyqjUn0xk3ijXA4OZkfEYb5h
 8Gre4xk+Q7VGn3Miht9uAiJJdNtJlZw7sJNJd1MyHXCv1Swb5wLxFOXG0QkabUYyu5G20ea6zYO
 KuJtTQLZN9YKJi/zWU/znZxwUNTHG6E4oLP0VbzdtL4WrSgMXNWzvYQXOIxF56M/SffERpRQkwa
 w+llPjdQRzpy6guEjAhpw4hy/m8rnD6d0d5T4oeL0kNMq6x0+WN3rzDNdkCWyYlrWaMHI9iE1IV
 WLMPk6cg5HYVhrb1F4DwDxgjWKQZAUr3hlZEikDOXuLGTjJ28pSsTWktfCYB5n1uCmfGJNZXAuA
 PTmJyXU+9L6ae/tNQXUByEIxNaJJMa8+BVZ5GETk7aS1Xy82ZWRySspyaiZ/wZ+SVbGjBowYVSE
 68QhCrWrDjbgtgnaanRb4voF8KK25DqaOq/nJF5uXVciVLq7fMhlC6as5zvt0GtHj0offiJxKSL
 4E/ncYWuKa4cbA1azHiyW+LmIM1x+G4RhsIbAVwfW9DB7TAzEM/2PzhEOTix2dtx68Sh0QMftge
 ufMiElHIbEbcXbfh3x3/XKXT/Lxu91HZZe4sOnrNnrZsjWSIG3Xl+IifdE+hEQjRWprzqtFc5Jv
 PBPmakjl+HSaGhw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Add selftests for the audit kfunc BPF LSM functionality including
both the test program and BPF progs.

Assisted-by: Claude:claude-4.5-opus
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 .../selftests/bpf/prog_tests/lsm_audit_kfuncs.c    | 598 +++++++++++++++++++++
 .../selftests/bpf/progs/test_lsm_audit_kfuncs.c    | 263 +++++++++
 2 files changed, 861 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_audit_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/lsm_audit_kfuncs.c
new file mode 100644
index 0000000000000000000000000000000000000000..de18e1a3c79578d4151a12a029f2a9e6cc7648e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_audit_kfuncs.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cloudflare */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
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
+#include "test_lsm_audit_kfuncs.skel.h"
+#include "test_progs.h"
+
+#ifndef AUDIT_BPF_LSM_ACCESS
+#define AUDIT_BPF_LSM_ACCESS 1427
+#endif
+
+static inline struct sockaddr_in addr4(void)
+{
+	return (struct sockaddr_in){
+		.sin_family = AF_INET,
+		.sin_port = htons(1234),
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+}
+
+static inline struct sockaddr_in6 addr6(void)
+{
+	return (struct sockaddr_in6){
+		.sin6_family = AF_INET6,
+		.sin6_port = htons(1234),
+		.sin6_addr = in6addr_loopback,
+	};
+}
+
+static int bind_connect(const struct sockaddr *addr, int addrlen)
+{
+	int err;
+	int sock;
+	int opt = 1;
+	socklen_t optlen = sizeof(opt);
+
+	sock = socket(addr->sa_family, SOCK_STREAM, 0);
+	if (!ASSERT_OK_FD(sock, "socket"))
+		return 1;
+
+	err = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &opt, optlen);
+	if (!ASSERT_OK(err, "setsockopt"))
+		goto done;
+
+	err = bind(sock, addr, addrlen);
+	if (!ASSERT_OK(err, "bind"))
+		goto done;
+
+	err = connect(sock, addr, addrlen);
+	ASSERT_OK(err, "connect");
+
+	err = getsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &opt, &optlen);
+	ASSERT_OK(err, "getsockopt");
+
+done:
+	close(sock);
+	return err;
+}
+
+static void test_audit_log_sockaddr_src(struct audit_observer *obs,
+					struct test_lsm_audit_kfuncs *skel)
+{
+	struct sockaddr_in sin = addr4();
+	struct sockaddr_in6 sin6 = addr6();
+	struct bpf_link *link;
+
+	link = bpf_program__attach_lsm(skel->progs.test_sockaddr_src);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"bind4\" saddr=127.0.0.1 src=1234 netif=lo",
+			      1);
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"bind6\" saddr=::1 src=1234 netif=lo", 1);
+
+	if (bind_connect((const struct sockaddr *)&sin, sizeof(sin)))
+		goto done;
+
+	if (bind_connect((const struct sockaddr *)&sin6, sizeof(sin6)))
+		goto done;
+
+	ASSERT_OK(audit_observer_wait(obs), "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+done:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_sockaddr_dest(struct audit_observer *obs,
+					 struct test_lsm_audit_kfuncs *skel)
+{
+	struct sockaddr_in sin = addr4();
+	struct sockaddr_in6 sin6 = addr6();
+	struct bpf_link *link;
+
+	link = bpf_program__attach_lsm(skel->progs.test_sockaddr_dest);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"connect4\" daddr=127.0.0.1 dest=1234 netif=lo",
+			      1);
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"connect6\" daddr=::1 dest=1234 netif=lo",
+			      1);
+
+	if (bind_connect((const struct sockaddr *)&sin, sizeof(sin)))
+		goto out;
+
+	if (bind_connect((const struct sockaddr *)&sin6, sizeof(sin6)))
+		goto out;
+
+	ASSERT_OK(audit_observer_wait(obs), "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_sock(struct audit_observer *obs,
+				struct test_lsm_audit_kfuncs *skel)
+{
+	struct sockaddr_in sin = addr4();
+	struct sockaddr_in6 sin6 = addr6();
+	struct bpf_link *link;
+
+	link = bpf_program__attach_lsm(skel->progs.test_sock);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"sock4\" laddr=127.0.0.1 lport=1234 faddr=127.0.0.1 fport=1234 netif=lo",
+			1);
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"sock6\" laddr=::1 lport=1234 faddr=::1 fport=1234 netif=lo",
+			1);
+
+	if (bind_connect((const struct sockaddr *)&sin, sizeof(sin)))
+		goto out;
+
+	if (bind_connect((const struct sockaddr *)&sin6, sizeof(sin6)))
+		goto out;
+
+	ASSERT_OK(audit_observer_wait(obs), "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_sock_unix(struct audit_observer *obs,
+				     struct test_lsm_audit_kfuncs *skel)
+{
+	struct sockaddr_un addr;
+	struct bpf_link *link;
+	char expected[256];
+	char sun_path[108];
+	int server_fd = -1;
+	int opt = 1;
+	socklen_t optlen = sizeof(opt);
+	int err;
+
+	snprintf(sun_path, sizeof(sun_path), "/root/tmp/bpf_audit_test_%d.sock",
+		 getpid());
+
+	/* Ensure directory exists */
+	mkdir("/root/tmp", 0755);
+	unlink(sun_path);
+
+	link = bpf_program__attach_lsm(skel->progs.test_sock_unix);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	snprintf(expected, sizeof(expected), "cause=\"sock_unix\" path=\"%s\"",
+		 sun_path);
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS, expected, 1);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, sun_path, sizeof(addr.sun_path) - 1);
+
+	server_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (!ASSERT_OK_FD(server_fd, "socket"))
+		goto out;
+
+	err = bind(server_fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (!ASSERT_OK(err, "bind"))
+		goto out;
+
+	err = getsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &opt, &optlen);
+	ASSERT_OK(err, "getsockopt");
+
+	ASSERT_OK(audit_observer_wait(obs), "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	if (server_fd >= 0)
+		close(server_fd);
+	unlink(sun_path);
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_file(struct audit_observer *obs,
+				struct test_lsm_audit_kfuncs *skel)
+{
+	struct bpf_link *link;
+	int err;
+	int fd;
+
+	link = bpf_program__attach_lsm(skel->progs.test_file);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"file\" path=\"/dev/null\" dev=\"devtmpfs\" ino=4",
+			1);
+
+	fd = open("/dev/null", O_RDONLY);
+	close(fd);
+	if (!ASSERT_OK_FD(fd, "open(/dev/null)"))
+		goto out;
+
+	err = audit_observer_wait(obs);
+	ASSERT_OK(err, "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_path(struct audit_observer *obs,
+				struct test_lsm_audit_kfuncs *skel)
+{
+	struct bpf_link *link;
+	int err;
+	int fd;
+
+	link = bpf_program__attach_lsm(skel->progs.test_file_path);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"path\" path=\"/dev/null\" dev=\"devtmpfs\" ino=4",
+			      1);
+
+	fd = open("/dev/null", O_RDONLY);
+	close(fd);
+	if (!ASSERT_OK_FD(fd, "open(/dev/null)"))
+		goto out;
+
+	err = audit_observer_wait(obs);
+	ASSERT_OK(err, "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_dentry(struct audit_observer *obs,
+				  struct test_lsm_audit_kfuncs *skel)
+{
+	struct bpf_link *link;
+	char expected[128];
+	char buf[64];
+	int err;
+
+	link = bpf_program__attach_lsm(skel->progs.test_dentry);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	snprintf(expected, sizeof(expected),
+		 "cause=\"dentry\" name=\"exe\" dev=");
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS, expected, 1);
+
+	/* readlink triggers inode_readlink hook */
+	err = readlink("/proc/self/exe", buf, sizeof(buf));
+	if (!ASSERT_GT(err, 0, "readlink(/proc/self/exe)"))
+		goto out;
+
+	err = audit_observer_wait(obs);
+	ASSERT_OK(err, "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_inode(struct audit_observer *obs,
+				 struct test_lsm_audit_kfuncs *skel)
+{
+	struct bpf_link *link;
+	char expected[128];
+	struct stat st;
+	int err;
+	int fd;
+
+	if (!ASSERT_OK(stat("/dev/null", &st), "stat(/dev/null)"))
+		return;
+
+	link = bpf_program__attach_lsm(skel->progs.test_inode);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	snprintf(expected, sizeof(expected),
+		 "cause=\"inode\" name=\"null\" dev=\"devtmpfs\" ino=%lu",
+		 st.st_ino);
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS, expected, 1);
+
+	fd = open("/dev/null", O_RDONLY);
+	close(fd);
+	if (!ASSERT_OK_FD(fd, "open(/dev/null)"))
+		goto out;
+
+	err = audit_observer_wait(obs);
+	ASSERT_OK(err, "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_task(struct audit_observer *obs,
+				struct test_lsm_audit_kfuncs *skel)
+{
+	struct bpf_link *link;
+	char expected[128];
+	pid_t pid;
+	int err;
+
+	pid = getpid();
+
+	link = bpf_program__attach_lsm(skel->progs.test_task);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	snprintf(expected, sizeof(expected),
+		 "cause=\"task\" opid=%d ocomm=\"test_progs\"", pid);
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS, expected, 1);
+
+	err = getpgid(pid);
+	if (!ASSERT_GT(err, -1, "pid pgid match"))
+		goto out;
+
+	err = audit_observer_wait(obs);
+	ASSERT_OK(err, "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_cap(struct audit_observer *obs,
+			       struct test_lsm_audit_kfuncs *skel)
+{
+	struct bpf_link *link;
+	int err;
+	int fd;
+
+	link = bpf_program__attach_lsm(skel->progs.test_cap);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"cap\" capability=", 1);
+
+	fd = open("/proc/kallsyms", O_RDONLY);
+	close(fd);
+	if (!ASSERT_OK_FD(fd, "open(/proc/kallsyms)"))
+		goto out;
+
+	err = audit_observer_wait(obs);
+	ASSERT_OK(err, "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_ioctl_op(struct audit_observer *obs,
+				    struct test_lsm_audit_kfuncs *skel)
+{
+	struct bpf_link *link;
+	char expected[128];
+	struct stat st;
+	int err;
+	int fd;
+
+	if (!ASSERT_OK(stat("/dev/null", &st), "stat(/dev/null)"))
+		return;
+
+	link = bpf_program__attach_lsm(skel->progs.test_ioctl_op);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	snprintf(expected, sizeof(expected),
+		 "cause=\"ioctl_op\" path=\"/dev/null\" dev=\"devtmpfs\" ino=%lu ioctlcmd=0x%x",
+		st.st_ino, TCGETS);
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS, expected, 1);
+
+	fd = open("/dev/null", O_RDONLY);
+	if (!ASSERT_OK_FD(fd, "open(/dev/null)"))
+		goto out;
+
+	/* ioctl will fail with ENOTTY but the LSM hook fires regardless */
+	ioctl(fd, TCGETS, NULL);
+	close(fd);
+
+	err = audit_observer_wait(obs);
+	ASSERT_OK(err, "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_audit_log_sleepable(struct audit_observer *obs,
+				     struct test_lsm_audit_kfuncs *skel)
+{
+	struct bpf_link *link;
+	int err;
+	int fd;
+
+	link = bpf_program__attach_lsm(skel->progs.test_sleepable);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"sleepable\" path=\"/dev/null\" dev=\"devtmpfs\" ino=4",
+		1);
+
+	fd = open("/dev/null", O_RDONLY);
+	close(fd);
+	if (!ASSERT_OK_FD(fd, "open(/dev/null)"))
+		goto out;
+
+	err = audit_observer_wait(obs);
+	ASSERT_OK(err, "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void
+test_audit_log_sockaddr_both_null(struct audit_observer *obs,
+				  struct test_lsm_audit_kfuncs *skel)
+{
+	struct sockaddr_in sin = addr4();
+	struct bpf_link *link;
+
+	link = bpf_program__attach_lsm(skel->progs.test_sockaddr_both_null);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	/* Should see cause but no saddr/daddr since both were NULL */
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"sockaddr_both_null\"", 1);
+
+	bind_connect((const struct sockaddr *)&sin, sizeof(sin));
+
+	ASSERT_OK(audit_observer_wait(obs), "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+	bpf_link__destroy(link);
+}
+
+static void
+test_audit_log_sockaddr_small_addrlen(struct audit_observer *obs,
+				      struct test_lsm_audit_kfuncs *skel)
+{
+	struct sockaddr_in sin = addr4();
+	struct bpf_link *link;
+
+	link = bpf_program__attach_lsm(skel->progs.test_sockaddr_small_addrlen);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+
+	audit_observer_reset(obs);
+
+	/* Should see cause but no saddr since addrlen was too small */
+	audit_observer_expect(obs, AUDIT_BPF_LSM_ACCESS,
+			      "cause=\"sockaddr_small_addrlen\"", 1);
+
+	bind_connect((const struct sockaddr *)&sin, sizeof(sin));
+
+	ASSERT_OK(audit_observer_wait(obs), "audit_observer_wait");
+	ASSERT_TRUE(audit_observer_check_satisfied(obs),
+		    "all expectations met");
+
+	bpf_link__destroy(link);
+}
+
+void test_lsm_audit_kfuncs(void)
+{
+	struct test_lsm_audit_kfuncs *skel = NULL;
+	struct audit_observer obs;
+	FILE *log = NULL;
+	int audit_fd;
+
+	audit_fd = audit_init();
+	if (!ASSERT_GE(audit_fd, 0, "audit_init"))
+		return;
+
+	if (env.verbosity > VERBOSE_NONE)
+		log = env.stdout_saved;
+
+	audit_observer_init(&obs, audit_fd, log, 500);
+
+	skel = test_lsm_audit_kfuncs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel load"))
+		goto close_prog;
+
+	if (test__start_subtest("net")) {
+		test_audit_log_sockaddr_src(&obs, skel);
+		test_audit_log_sockaddr_dest(&obs, skel);
+		test_audit_log_sockaddr_both_null(&obs, skel);
+		test_audit_log_sockaddr_small_addrlen(&obs, skel);
+		test_audit_log_sock(&obs, skel);
+		test_audit_log_sock_unix(&obs, skel);
+	}
+
+	if (test__start_subtest("file")) {
+		test_audit_log_file(&obs, skel);
+		test_audit_log_path(&obs, skel);
+		test_audit_log_dentry(&obs, skel);
+		test_audit_log_inode(&obs, skel);
+	}
+
+	if (test__start_subtest("task")) {
+		test_audit_log_task(&obs, skel);
+		test_audit_log_cap(&obs, skel);
+	}
+
+	if (test__start_subtest("ioctl"))
+		test_audit_log_ioctl_op(&obs, skel);
+
+	if (test__start_subtest("sleepable"))
+		test_audit_log_sleepable(&obs, skel);
+
+close_prog:
+	test_lsm_audit_kfuncs__destroy(skel);
+	audit_cleanup(audit_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lsm_audit_kfuncs.c b/tools/testing/selftests/bpf/progs/test_lsm_audit_kfuncs.c
new file mode 100644
index 0000000000000000000000000000000000000000..952ba09fce638f3bd14c18060a5baa3ccaec19ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lsm_audit_kfuncs.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cloudflare */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <errno.h>
+
+#define AF_UNIX 1
+#define AF_INET 2
+#define AF_INET6 10
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm/socket_bind")
+int BPF_PROG(test_sockaddr_src, struct socket *sock, struct sockaddr *address,
+	     int addrlen)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	switch (address->sa_family) {
+	case AF_INET:
+		bpf_audit_log_cause(ac, "bind4");
+		break;
+	case AF_INET6:
+		bpf_audit_log_cause(ac, "bind6");
+	}
+
+	bpf_audit_log_net_sockaddr(ac, 1, address, NULL, addrlen);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/socket_connect")
+int BPF_PROG(test_sockaddr_dest, struct socket *sock, struct sockaddr *address,
+	     int addrlen)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	switch (address->sa_family) {
+	case AF_INET:
+		bpf_audit_log_cause(ac, "connect4");
+		break;
+	case AF_INET6:
+		bpf_audit_log_cause(ac, "connect6");
+	}
+
+	bpf_audit_log_net_sockaddr(ac, 1, NULL, address, addrlen);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/socket_bind")
+int BPF_PROG(test_sockaddr_both_null, struct socket *sock,
+	     struct sockaddr *address, int addrlen)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "sockaddr_both_null");
+	bpf_audit_log_net_sockaddr(ac, 1, NULL, NULL, addrlen);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/socket_bind")
+int BPF_PROG(test_sockaddr_small_addrlen, struct socket *sock,
+	     struct sockaddr *address, int addrlen)
+{
+	struct bpf_audit_context *ac;
+
+	if (address->sa_family != AF_INET)
+		return -EINVAL;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "sockaddr_small_addrlen");
+	bpf_audit_log_net_sockaddr(ac, 1, address, NULL, 1);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/socket_getsockopt")
+int BPF_PROG(test_sock, struct socket *sock, int level, int optname)
+{
+	struct bpf_audit_context *ac;
+	struct sock *sk = sock->sk;
+
+	if (!sk)
+		return -EINVAL;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	switch (sk->__sk_common.skc_family) {
+	case AF_INET:
+		bpf_audit_log_cause(ac, "sock4");
+		break;
+	case AF_INET6:
+		bpf_audit_log_cause(ac, "sock6");
+	}
+
+	bpf_audit_log_net_sock(ac, 1, sock);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/socket_getsockopt")
+int BPF_PROG(test_sock_unix, struct socket *sock, int level, int optname)
+{
+	struct bpf_audit_context *ac;
+	struct sock *sk = sock->sk;
+
+	if (!sk || sk->__sk_common.skc_family != AF_UNIX)
+		return -EINVAL;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "sock_unix");
+	bpf_audit_log_net_sock(ac, 0, sock);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/file_open")
+int BPF_PROG(test_file, struct file *file)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "file");
+	bpf_audit_log_file(ac, file);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/file_open")
+int BPF_PROG(test_file_path, struct file *file)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "path");
+	bpf_audit_log_path(ac, &file->f_path);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/inode_readlink")
+int BPF_PROG(test_dentry, struct dentry *dentry)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "dentry");
+	bpf_audit_log_dentry(ac, dentry);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/file_open")
+int BPF_PROG(test_inode, struct file *file)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "inode");
+	bpf_audit_log_inode(ac, file->f_inode);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/task_getpgid")
+int BPF_PROG(test_task, struct task_struct *task)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "task");
+	bpf_audit_log_task(ac, task);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/capable")
+int BPF_PROG(test_cap, const struct cred *cred, struct user_namespace *ns,
+	     int cap, unsigned int opts)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "cap");
+	bpf_audit_log_cap(ac, cap);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm/file_ioctl")
+int BPF_PROG(test_ioctl_op, struct file *file, unsigned int cmd,
+	     unsigned long arg)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "ioctl_op");
+	bpf_audit_log_ioctl_op(ac, file, cmd);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_sleepable, struct file *file)
+{
+	struct bpf_audit_context *ac;
+
+	ac = bpf_audit_log_start();
+	if (!ac)
+		return -ENOMEM;
+
+	bpf_audit_log_cause(ac, "sleepable");
+	bpf_audit_log_file(ac, file);
+	bpf_audit_log_end(ac);
+	return 0;
+}
+

-- 
2.43.0

