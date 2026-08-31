Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC63DD525
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173949; cv=none; b=XSHl5HhljbWUTS45/sBs5xCE1Zgw4mWAcDU0EOOb8PRgN6O9EcTn7UaEXtsgZ5lVbxPjaE2zlreVOoaH5CxtRX3+DPoquYokd+eBkbMGYpJdOlwn7bGK3tM1wKh2pOiSmGNHp3HgO09B961OTeV9g7rmCziS+QxZPhldC6N34p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173949; c=relaxed/simple;
	bh=pIjdgBZ1taPA1iv3/c0vNRhJC7x+oF6SGlubjJ1Aonc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1FaNDkDsjQTcQxhX9OjsT+1saSz85k7APn4OWz82U/b1aa1ms8N7DgE5V3+P1bPmHY/++HytuIV/h8jj1DB3V8fj2NoJyOQd57kr09RdOGa+WgzMOq5pyV0RIquxXymCxD0EUJVv5rIcgmLh7yFrJdOD+aRa29YfwQEKLfHBO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r49JdCy+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r49JdCy+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48436251906so1356975f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173945; x=1788778745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3mmMU4xxW8TePa1Rfu9/t+dY+HYu/mATT18pxovI3c=;
        b=r49JdCy+4lJmpzh4BXsMtQcrB8b6CpF4avde58ipYFRaJcPPIEWYPq+3pQeqSSkzX/
         vk9Ovh47Iaj92qVZL4bcHEbPa5qDGk65k48732xCtsQrKr89nxBuppKUx/KJpTDc/j3B
         3FhdFJGAEoYoLbpZOIb9quXRhzYozGRtPD0dpppOIKym7LTkYs8haGrjENeerRSq7zNo
         TykxzZqOewkZhphFBtnS1uzp7oQ09oyr36qf1WWHwENrAgIfsnYLyPhfF3LI66iTMrhp
         AskTJjBXOoJuqE4PMyo0d9m/goZSoBkpfXQ2/nfKcbY5nCnl+cGmIt5GUHsjnrQsvbal
         WfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173945; x=1788778745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t3mmMU4xxW8TePa1Rfu9/t+dY+HYu/mATT18pxovI3c=;
        b=AjEQCtL2XjCb58lfmc6+WMdDCVJYMa+/ptfgkxeFyjNiMGrlHQZ/sLQoh7gtM2Yx5/
         Rr0EVLPQCnBDZ08hngcu3nk4mj66T6XGjcPT/pt1cSsFCVDQ32w7Mh/ZLBcxVJzQRl5f
         OwlqKdLThCGqWJ74tKmzSvQ3KJeCKTIDA2rNywpUwHG1FWUcyybuPNfU1MLpiV/WxAL5
         owYmL7d/2FCB+/JS5Q8vF04I6xTsfQTVx1JQLmkGuFpAs3fGa8aDaHp6qJzQi0sX1W7+
         Kxl1eVLTJZ/FO57LjZGLXARvyw2hLdC0Yr07IjPcgIm/3pDFvJaLuKU0UVQvCbaOmFL/
         Z/DA==
X-Forwarded-Encrypted: i=1; AKwUvBwxJtbqWrXtjo3gXpKD/I84mw1xCXcDpTDlH0QR6XbNWr0v83L/7zz4vnPAnfYPjr/EXECyntrG1+UVAcPAemNSIE0xQWI=@vger.kernel.org
X-Gm-Message-State: AFuF++ktTc6Sf1raxlxaI3tFrugA/EGK4oYW9XGpu2RfN86tcpiNzuCx
	XayJjz2eGZA5OmzlCQRJ213Ga7N2sPYf4tjrUODu+SHnic62QgjsJvtM
X-Gm-Gg: AYBFou2dzys9U5GDXFBLdVEB7OJnQv2fFTkn1mgUUaN+Enr000wlX6H2H0sWIb58EOG
	yg44isiLjhlgDwQ8ewLXFe34fMJ+Vo7SZsXGnM9pE4ROYe4VVWOya7dQAtpwx9mdJ8adz3qyZuu
	eUvdkBE9VI1ySKEQ0Vx8W3/dMn9F2w2iZ0PqKotzpVoGb7tb873bxCqJNuddSnwr6nfJCZh3G7V
	4tF5kcPqHu1BrqSh/HY+Fzw6UQjRM84elH9qrjOzS5B3Xj70MC/6uct5oa8Q13aOfOg/wYtJLde
	fHQ+zm4fqI9VrbQ5TMSjaK9iMjV1pHyECDz9MqHyVHN5kFZexljcbDFWpQyQBuZIMBHBWi2TTt6
	yfq93lOvdpwhqOTJS589MzFOu2zApJyYGTKqnlfxS8vMe9F7LmjjtcULMfyzAduY3pkqL8L8tVQ
	UTcPjUqtkptqrPFWH3D9vRaG5fH/YTyus2crRaXhXxYXcMOJTgS6yiVyYtnh9Fzr5FdCKllqYi4
	UJoeg==
X-Received: by 2002:a05:6000:40dc:b0:484:3314:eff6 with SMTP id ffacd0b85a97d-4843f014695mr4274773f8f.28.1788173945184;
        Mon, 31 Aug 2026 03:59:05 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:59:04 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/7] selftests/bpf: Add netdevsim helper library
Date: Mon, 31 Aug 2026 11:09:30 +0000
Message-ID: <20260831110934.241898-6-a.s.protopopov@gmail.com>
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

Add a minimal netdevsim helper library for the BPF selftests.  This
covers basics: netdevsim creation with one port and one queue, which
we need for the upcoming BPF selftests.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../testing/selftests/bpf/netdevsim_helpers.c | 176 ++++++++++++++++++
 .../testing/selftests/bpf/netdevsim_helpers.h |   9 +
 3 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/netdevsim_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netdevsim_helpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b481b867f372..c21f89dbe70c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -862,6 +862,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 unpriv_helpers.c 	\
 			 sysctl_helpers.c	\
 			 netlink_helpers.c	\
+			 netdevsim_helpers.c	\
 			 jit_disasm_helpers.c	\
 			 io_helpers.c		\
 			 test_loader.c		\
diff --git a/tools/testing/selftests/bpf/netdevsim_helpers.c b/tools/testing/selftests/bpf/netdevsim_helpers.c
new file mode 100644
index 000000000000..fbed7442b2e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/netdevsim_helpers.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/rtnetlink.h>
+#include <poll.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "netdevsim_helpers.h"
+
+static int echo(const char *path, const char *fmt, ...)
+{
+	char buf[64];
+	va_list ap;
+	int fd, len, err = 0;
+
+	va_start(ap, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+	if (write(fd, buf, len) != len)
+		err = -errno;
+	close(fd);
+
+	return err;
+}
+
+void netdevsim_destroy(unsigned int id)
+{
+	echo("/sys/bus/netdevsim/del_device", "%u", id);
+}
+
+static int create_new_device(void)
+{
+	unsigned int id;
+	int err;
+
+	/* if 10K is not enough, then something is clearly not right */
+	for (id = 0; id < 10000; id++) {
+		err = echo("/sys/bus/netdevsim/new_device", "%u", id);
+		if (!err)
+			return id;
+		if (err != -ENOSPC)
+			return err;
+	}
+
+	return -ENOSPC;
+}
+
+static int open_link_socket(void)
+{
+	struct sockaddr_nl addr = {
+		.nl_family = AF_NETLINK,
+		.nl_groups = RTMGRP_LINK,
+	};
+	int fd;
+
+	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
+	if (fd < 0)
+		return -errno;
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
+		int err = -errno;
+
+		close(fd);
+		return err;
+	}
+
+	return fd;
+}
+
+static int remaining_timeout_ms(const struct timespec *deadline)
+{
+	struct timespec now;
+	long long remaining;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &now))
+		return -errno;
+
+	remaining = (deadline->tv_sec - now.tv_sec) * 1000 +
+		    (deadline->tv_nsec - now.tv_nsec) / 1000000;
+
+	return remaining > 0 ? remaining : 0;
+}
+
+static int recv_device_ifindex(int fd, unsigned int id, unsigned int *ifindex)
+{
+	char parent_name[32], buf[16 * 1024];
+	struct pollfd pfd = {
+		.fd = fd,
+		.events = POLLIN,
+	};
+	struct timespec deadline;
+	struct nlmsghdr *nlh;
+	int len, ret, timeout;
+
+	snprintf(parent_name, sizeof(parent_name), "netdevsim%u", id);
+	if (clock_gettime(CLOCK_MONOTONIC, &deadline))
+		return -errno;
+	deadline.tv_sec += 5;
+
+	for (timeout = remaining_timeout_ms(&deadline); timeout > 0;
+	     timeout = remaining_timeout_ms(&deadline)) {
+		ret = poll(&pfd, 1, timeout);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+		if (!ret)
+			return -ETIMEDOUT;
+		if (!(pfd.revents & POLLIN))
+			return -EIO;
+
+		len = recv(fd, buf, sizeof(buf), 0);
+		if (len < 0)
+			return -errno;
+
+		for (nlh = (struct nlmsghdr *)buf; NLMSG_OK(nlh, len);
+		     nlh = NLMSG_NEXT(nlh, len)) {
+			struct ifinfomsg *ifm;
+			struct rtattr *attr;
+			int attr_len;
+
+			if (nlh->nlmsg_type != RTM_NEWLINK)
+				continue;
+
+			ifm = NLMSG_DATA(nlh);
+			attr = IFLA_RTA(ifm);
+			attr_len = IFLA_PAYLOAD(nlh);
+			for (; RTA_OK(attr, attr_len);
+			     attr = RTA_NEXT(attr, attr_len)) {
+				if (attr->rta_type != IFLA_PARENT_DEV_NAME)
+					continue;
+				if (strcmp(RTA_DATA(attr), parent_name))
+					continue;
+
+				*ifindex = ifm->ifi_index;
+				return 0;
+			}
+		}
+	}
+
+	return timeout < 0 ? timeout : -ETIMEDOUT;
+}
+
+int netdevsim_create(unsigned int *ifindex)
+{
+	int fd, id, err;
+
+	fd = open_link_socket();
+	if (fd < 0)
+		return fd;
+
+	id = create_new_device();
+	if (id < 0) {
+		close(fd);
+		return id;
+	}
+
+	err = recv_device_ifindex(fd, id, ifindex);
+	close(fd);
+	if (err) {
+		netdevsim_destroy(id);
+		return err;
+	}
+
+	return id;
+}
diff --git a/tools/testing/selftests/bpf/netdevsim_helpers.h b/tools/testing/selftests/bpf/netdevsim_helpers.h
new file mode 100644
index 000000000000..0a37d564a2c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/netdevsim_helpers.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef NETDEVSIM_HELPERS_H
+#define NETDEVSIM_HELPERS_H
+
+int netdevsim_create(unsigned int *ifindex);
+void netdevsim_destroy(unsigned int id);
+
+#endif /* NETDEVSIM_HELPERS_H */
-- 
2.43.0

