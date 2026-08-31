Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046B3DAAB1
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173948; cv=none; b=XYVdEdZZXZIpCmvBDLg5xLM5NspqYpvP3JUuL9AABdArVEPSLziXIjJbtweWEB4z/tmwrOW+gkIsrXe0le4qNJfNh2AmIgW6PiVI4nUZqS+ecm4PAqovmzD8gXJrE37qwU6CB0S+KKfgsgnY23qbatal5nPx8EAJiwTKq9WKBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173948; c=relaxed/simple;
	bh=Rg/P8mir4cpirVWiGay0UkON5tKN0JlDXEdLEYzxPK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8IvOK8eUY1J6CU+XdWvjj4jiJJhz0fB+B5bi+GEUdjuhYAB48w6TEx5WMUixuVY2SKPlKett+ekJAb9UphaRuzlOaYzt4+IrXPi6nkubEL38OXlzW5ijzu7+W4x/JwzY06K3pWJc774S/cvaOtNZBq28/8kZ8MX2kV756kRcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnwCOwx1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnwCOwx1"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482e257a23aso1807564f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173944; x=1788778744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RabuXIdiwJmtHqraR0jP+2z6AyCz7IHVfjNPgcy0mfQ=;
        b=XnwCOwx15sM6PXwUm6nUYs85UxiflMnUfvU/Febf+fv6mk/MxX5VgYCeraL0gwkVSE
         w5Y/maOWiPQswAVOEvUNzGB9T8liFMlK6BKCo4yyONr2/VJI6MYON6xM/Ph80o5Ab/hF
         abxXwL02Gge+K1M7p/LjnCLG20GhwD/zfm5I8IvrQ8UxBK0xxca7Lq9h9N1k905v/ZMH
         RH6KXuK76sDqjjYAmZwyJhuqk715zfE2IgPwU2vdgUgq4fcTvRTT/K4pbek9hz+D/pHu
         RjS1IHKQGP5dvOTw4Q8EZCTul17Y9M1FJAJFGjkEsEsGmjlqqBNIqHUEgiRbYgoyO1DH
         LOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173944; x=1788778744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RabuXIdiwJmtHqraR0jP+2z6AyCz7IHVfjNPgcy0mfQ=;
        b=bdDQEzwC+LPrzDYprnDuw96wzrBrneJm4Sbppk3H1OuSui0JQSCHUvh4pvswZp9q1z
         TKDqQsNplDo64u6XHWU7ZA75luylVVis+lYlZRa2Sv2FUj98LkycqdcRUMkV33u45slV
         Vryk6wP4ghX3Ws9CsxkZvi6jAFZduk/eVt5uJm4htYq065IMHzr0SYYajhdiSgAsiuHk
         USUx8utzashlYvakJ1v/1g3rYik289ZK+jFWAalWDnYMS5zIHQ5xxI1x12MIjL/QDqOJ
         KHtwZfxiRrLG+JozkSIORkuLwqScKjdpawyDboilSI6A7+nvPTt8JWnt/PhkO2H8GL7Y
         IGkw==
X-Forwarded-Encrypted: i=1; AKwUvBx4WLAWnMZJHfuD1CoObyG4fhUPugPR1mVPn8fDqKq/n38PRsd/48h8xC9XUf1amdK0KckdeEXhCLJ6SEqrGhSM7NyH8Zc=@vger.kernel.org
X-Gm-Message-State: AFuF++nGk6fhqSb+we70Ery/HKMCImHHlsgTxVbPkDLpcjVOKRE6Fi3u
	y/CrEYt5Qg+kB4oep6THVRJGuAgvzefiH13AMeU7L7I06/fv4AvuzTWF
X-Gm-Gg: AYBFou3vKsoLVnAwYidLm7MYId1FGySj8AppWCMZV0tZTskAASHFLdyY4bv7aeMEgym
	zkVE2fZ3vNhzAZ7oMtuUNA1Rzy2ySJVu2vrJei5kV1ge3vXkGB8CejWH80CryE3DUnpDjJuXfDK
	PiwjGjrFQxuovY9BWkfHRBdB7MRACcdAaOYnY/+NUOUID1U5b7eqv/Sb4U4PWDgJ6f/ZxlEnYd8
	t9qWZzcVchI4fz9jvw9Kq7sHoTODE89JxtmrJgGn2v59QT630Di8d8F/yQJn1e5MaxdJHdV4Sp+
	avFXpQb0sNLgAD+piT/gBM4cMWE6XncH5S9TVmWCckmuu7YOt3lc85Id7LqopS7B0L3pIwJeAMP
	C3MjOWvmSdg8GjQrwrCV64lVBaH28u0tUqMX1pOT7NMrKSV+Vz5L5iZu2l1FtfgVLauCfuQHWzo
	2P7CtFuTC7lE75pCxrFS6ZCsF/ZGd2rebjySXbjQAWPddg2SL9Yyqym2QE7UmwWhXWnc8VrsDeY
	dPYow==
X-Received: by 2002:a05:6000:470b:b0:474:530:9d with SMTP id ffacd0b85a97d-482f79b0048mr40480965f8f.13.1788173944200;
        Mon, 31 Aug 2026 03:59:04 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:59:03 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/7] selftests/bpf: Extract some helpers from tests to the netlink library
Date: Mon, 31 Aug 2026 11:09:29 +0000
Message-ID: <20260831110934.241898-5-a.s.protopopov@gmail.com>
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

Extract and generalize, a bit, generic netlink code used in the
bpf_smc test to the netlink_helpers.{c,h} library such that it
can be reused by other tests.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/netlink_helpers.c | 176 ++++++++++++++++++
 tools/testing/selftests/bpf/netlink_helpers.h |  12 ++
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 160 ++++------------
 3 files changed, 226 insertions(+), 122 deletions(-)

diff --git a/tools/testing/selftests/bpf/netlink_helpers.c b/tools/testing/selftests/bpf/netlink_helpers.c
index caf36eb1d032..ff0ec10cc3a1 100644
--- a/tools/testing/selftests/bpf/netlink_helpers.c
+++ b/tools/testing/selftests/bpf/netlink_helpers.c
@@ -8,11 +8,187 @@
 #include <errno.h>
 #include <time.h>
 #include <sys/socket.h>
+#include <sys/time.h>
 
 #include "netlink_helpers.h"
 
 static int rcvbuf = 1024 * 1024;
 
+int genl_open(__u32 pid)
+{
+	struct sockaddr_nl local = {
+		.nl_family = AF_NETLINK,
+		.nl_pid = pid,
+	};
+	struct timeval timeout = {
+		.tv_sec = 1
+	};
+	int ret;
+	int fd;
+
+	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_GENERIC);
+	if (fd < 0)
+		return -1;
+
+	if (bind(fd, (void *)&local, sizeof(local)))
+		goto err_close;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout)))
+		goto err_close;
+
+	return fd;
+
+err_close:
+	ret = -errno;
+	close(fd);
+	return ret;
+}
+
+int genl_send(int fd, const struct nlmsghdr *nlh)
+{
+	struct sockaddr_nl kernel = {
+		.nl_family = AF_NETLINK
+	};
+	ssize_t sent;
+
+	sent = sendto(fd, nlh, nlh->nlmsg_len, 0, (void *)&kernel, sizeof(kernel));
+	if (sent < 0)
+		return -errno;
+	if (sent != nlh->nlmsg_len)
+		return -EIO;
+
+	return 0;
+}
+
+int genl_recv(int fd, __u32 seq, __u16 family_id, bool dump)
+{
+	char buf[64 * 1024];
+
+	for (;;) {
+		struct nlmsghdr *nlh;
+		int remaining;
+		ssize_t len;
+
+		len = recv(fd, buf, sizeof(buf), 0);
+		if (len < 0)
+			return -errno;
+		if (!len)
+			return -ENODATA;
+
+		remaining = len;
+		for (nlh = (struct nlmsghdr *)buf;
+		     NLMSG_OK(nlh, remaining);
+		     nlh = NLMSG_NEXT(nlh, remaining)) {
+			if (nlh->nlmsg_seq != seq)
+				continue;
+
+			if (nlh->nlmsg_type == NLMSG_ERROR) {
+				const struct nlmsgerr *nlerr = NLMSG_DATA(nlh);
+
+				if (NLMSG_PAYLOAD(nlh, 0) < sizeof(*nlerr))
+					return -EBADMSG;
+				if (nlerr->error || !dump)
+					return nlerr->error;
+				continue;
+			}
+
+			if (nlh->nlmsg_type == NLMSG_DONE) {
+				int done_err = 0;
+
+				if (NLMSG_PAYLOAD(nlh, 0) >= sizeof(done_err))
+					memcpy(&done_err, NLMSG_DATA(nlh),
+					       sizeof(done_err));
+				if (done_err)
+					return done_err;
+				return 0;
+			}
+
+			if (nlh->nlmsg_type == family_id) {
+				if (!dump)
+					return 0;
+			}
+		}
+		if (remaining)
+			return -EBADMSG;
+	}
+}
+
+int genl_resolve_family(int fd, const char *name)
+{
+	struct genl_req req = {};
+	char buf[4096];
+	struct nlmsghdr *nlh;
+	int remaining;
+	ssize_t len;
+	int err;
+
+	req.nlh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	req.nlh.nlmsg_type = GENL_ID_CTRL;
+	req.nlh.nlmsg_flags = NLM_F_REQUEST;
+	req.nlh.nlmsg_seq = 1;
+	req.genl.cmd = CTRL_CMD_GETFAMILY;
+	req.genl.version = 2;
+	if (addattrstrz(&req.nlh, sizeof(req), CTRL_ATTR_FAMILY_NAME, name))
+		return -EMSGSIZE;
+
+	err = genl_send(fd, &req.nlh);
+	if (err)
+		return err;
+
+	len = recv(fd, buf, sizeof(buf), 0);
+	if (len < 0)
+		return -errno;
+	if (!len)
+		return -ENODATA;
+
+	remaining = len;
+	for (nlh = (struct nlmsghdr *)buf;
+	     NLMSG_OK(nlh, remaining);
+	     nlh = NLMSG_NEXT(nlh, remaining)) {
+		struct nlattr *attr;
+		int attr_len;
+
+		if (nlh->nlmsg_seq != req.nlh.nlmsg_seq)
+			continue;
+
+		if (nlh->nlmsg_type == NLMSG_ERROR) {
+			const struct nlmsgerr *nlerr = NLMSG_DATA(nlh);
+
+			if (NLMSG_PAYLOAD(nlh, 0) < sizeof(*nlerr))
+				return -EBADMSG;
+			return nlerr->error ?: -ENOENT;
+		}
+		if (nlh->nlmsg_type != GENL_ID_CTRL)
+			continue;
+		if (NLMSG_PAYLOAD(nlh, 0) < GENL_HDRLEN)
+			return -EBADMSG;
+
+		attr = (struct nlattr *)((char *)NLMSG_DATA(nlh) +
+					 GENL_HDRLEN);
+		attr_len = NLMSG_PAYLOAD(nlh, GENL_HDRLEN);
+		while (attr_len >= (int)sizeof(*attr) &&
+		       attr->nla_len >= sizeof(*attr) &&
+		       attr->nla_len <= attr_len) {
+			__u16 family_id;
+			int step;
+
+			if ((attr->nla_type & NLA_TYPE_MASK) ==
+			    CTRL_ATTR_FAMILY_ID &&
+			    attr->nla_len >= NLA_HDRLEN + sizeof(family_id)) {
+				memcpy(&family_id, (char *)attr + NLA_HDRLEN,
+				       sizeof(family_id));
+				return family_id;
+			}
+
+			step = NLA_ALIGN(attr->nla_len);
+			attr_len -= step;
+			attr = (struct nlattr *)((char *)attr + step);
+		}
+	}
+
+	return remaining ? -EBADMSG : -ENOENT;
+}
+
 void rtnl_close(struct rtnl_handle *rth)
 {
 	if (rth->fd >= 0) {
diff --git a/tools/testing/selftests/bpf/netlink_helpers.h b/tools/testing/selftests/bpf/netlink_helpers.h
index 68116818a47e..964e8ad94a1f 100644
--- a/tools/testing/selftests/bpf/netlink_helpers.h
+++ b/tools/testing/selftests/bpf/netlink_helpers.h
@@ -3,9 +3,21 @@
 #define NETLINK_HELPERS_H
 
 #include <string.h>
+#include <linux/genetlink.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
 
+struct genl_req {
+	struct nlmsghdr nlh;
+	struct genlmsghdr genl;
+	char attrs[256];
+};
+
+int genl_open(__u32 pid);
+int genl_send(int fd, const struct nlmsghdr *nlh);
+int genl_recv(int fd, __u32 seq, __u16 family_id, bool dump);
+int genl_resolve_family(int fd, const char *name);
+
 struct rtnl_handle {
 	int			fd;
 	struct sockaddr_nl	local;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
index 40d38280c091..45e479a649c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <linux/genetlink.h>
+#include "netlink_helpers.h"
 #include "network_helpers.h"
 #include "bpf_smc.skel.h"
 
@@ -44,105 +45,28 @@ enum {
 	SMC_NLA_EID_TABLE_ENTRY,    /* string */
 };
 
-struct msgtemplate {
-	struct nlmsghdr n;
-	struct genlmsghdr g;
-	char buf[1024];
-};
-
-#define GENLMSG_DATA(glh)	((void *)(NLMSG_DATA(glh) + GENL_HDRLEN))
-#define GENLMSG_PAYLOAD(glh)	(NLMSG_PAYLOAD(glh, 0) - GENL_HDRLEN)
-#define NLA_DATA(na)		((void *)((char *)(na) + NLA_HDRLEN))
-#define NLA_PAYLOAD(len)	((len) - NLA_HDRLEN)
-
 #define SMC_GENL_FAMILY_NAME	"SMC_GEN_NETLINK"
+#define SMC_GENL_FAMILY_VERSION	1
 #define SMC_BPFTEST_UEID	"SMC-BPFTEST-UEID"
+#define SMC_BPFTEST_UEID_LEN	32
 
-static uint16_t smc_nl_family_id = -1;
-
-static int send_cmd(int fd, __u16 nlmsg_type, __u32 nlmsg_pid,
-		    __u16 nlmsg_flags, __u8 genl_cmd, __u16 nla_type,
-		    void *nla_data, int nla_len)
-{
-	struct nlattr *na;
-	struct sockaddr_nl nladdr;
-	int r, buflen;
-	char *buf;
-
-	struct msgtemplate msg = {0};
-
-	msg.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
-	msg.n.nlmsg_type = nlmsg_type;
-	msg.n.nlmsg_flags = nlmsg_flags;
-	msg.n.nlmsg_seq = 0;
-	msg.n.nlmsg_pid = nlmsg_pid;
-	msg.g.cmd = genl_cmd;
-	msg.g.version = 1;
-	na = (struct nlattr *)GENLMSG_DATA(&msg);
-	na->nla_type = nla_type;
-	na->nla_len = nla_len + 1 + NLA_HDRLEN;
-	memcpy(NLA_DATA(na), nla_data, nla_len);
-	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
-
-	buf = (char *)&msg;
-	buflen = msg.n.nlmsg_len;
-	memset(&nladdr, 0, sizeof(nladdr));
-	nladdr.nl_family = AF_NETLINK;
-
-	while ((r = sendto(fd, buf, buflen, 0, (struct sockaddr *)&nladdr,
-			   sizeof(nladdr))) < buflen) {
-		if (r > 0) {
-			buf += r;
-			buflen -= r;
-		} else if (errno != EAGAIN) {
-			return -1;
-		}
-	}
-	return 0;
-}
+static __u16 smc_nl_family_id;
 
 static bool get_smc_nl_family_id(void)
 {
-	struct sockaddr_nl nl_src;
-	struct msgtemplate msg;
-	struct nlattr *nl;
 	int fd, ret;
 	pid_t pid;
 
-	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	pid = getpid();
+	fd = genl_open(pid);
 	if (!ASSERT_OK_FD(fd, "nl_family socket"))
 		return false;
 
-	pid = getpid();
-
-	memset(&nl_src, 0, sizeof(nl_src));
-	nl_src.nl_family = AF_NETLINK;
-	nl_src.nl_pid = pid;
-
-	ret = bind(fd, (struct sockaddr *)&nl_src, sizeof(nl_src));
-	if (!ASSERT_OK(ret, "nl_family bind"))
-		goto fail;
-
-	ret = send_cmd(fd, GENL_ID_CTRL, pid,
-		       NLM_F_REQUEST, CTRL_CMD_GETFAMILY,
-		       CTRL_ATTR_FAMILY_NAME, (void *)SMC_GENL_FAMILY_NAME,
-		       strlen(SMC_GENL_FAMILY_NAME));
-	if (!ASSERT_OK(ret, "nl_family query"))
-		goto fail;
-
-	ret = recv(fd, &msg, sizeof(msg), 0);
-	if (msg.n.nlmsg_type == NLMSG_ERROR)
-		goto fail;
-	if (!ASSERT_FALSE(ret < 0 || !NLMSG_OK(&msg.n, ret),
-			  "nl_family response"))
-		goto fail;
-
-	nl = (struct nlattr *)GENLMSG_DATA(&msg);
-	nl = (struct nlattr *)((char *)nl + NLA_ALIGN(nl->nla_len));
-	if (!ASSERT_EQ(nl->nla_type, CTRL_ATTR_FAMILY_ID, "nl_family nla type"))
+	ret = genl_resolve_family(fd, SMC_GENL_FAMILY_NAME);
+	if (!ASSERT_GT(ret, 0, "nl_family query"))
 		goto fail;
 
-	smc_nl_family_id = *(uint16_t *)NLA_DATA(nl);
+	smc_nl_family_id = ret;
 	close(fd);
 	return true;
 fail:
@@ -152,56 +76,48 @@ static bool get_smc_nl_family_id(void)
 
 static bool smc_ueid(int op)
 {
-	struct sockaddr_nl nl_src;
-	struct msgtemplate msg;
-	struct nlmsgerr *err;
-	char test_ueid[32];
+	char test_ueid[SMC_BPFTEST_UEID_LEN + 1] = {};
+	struct genl_req req = {};
 	int fd, ret;
 	pid_t pid;
 
 	/* UEID required */
-	memset(test_ueid, '\x20', sizeof(test_ueid));
-	memcpy(test_ueid, SMC_BPFTEST_UEID, strlen(SMC_BPFTEST_UEID));
-	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	memset(test_ueid, ' ', SMC_BPFTEST_UEID_LEN);
+	memcpy(test_ueid, SMC_BPFTEST_UEID, sizeof(SMC_BPFTEST_UEID) - 1);
+	pid = getpid();
+	fd = genl_open(pid);
 	if (!ASSERT_OK_FD(fd, "ueid socket"))
 		return false;
 
-	pid = getpid();
-	memset(&nl_src, 0, sizeof(nl_src));
-	nl_src.nl_family = AF_NETLINK;
-	nl_src.nl_pid = pid;
-
-	ret = bind(fd, (struct sockaddr *)&nl_src, sizeof(nl_src));
-	if (!ASSERT_OK(ret, "ueid bind"))
+	req.nlh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	req.nlh.nlmsg_type = smc_nl_family_id;
+	req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+	req.nlh.nlmsg_pid = pid;
+	req.genl.cmd = op;
+	req.genl.version = SMC_GENL_FAMILY_VERSION;
+	ret = addattrstrz(&req.nlh, sizeof(req), SMC_NLA_EID_TABLE_ENTRY,
+			  test_ueid);
+	if (!ASSERT_OK(ret, "ueid attribute"))
 		goto fail;
 
-	ret = send_cmd(fd, smc_nl_family_id, pid,
-		       NLM_F_REQUEST | NLM_F_ACK, op, SMC_NLA_EID_TABLE_ENTRY,
-		       (void *)test_ueid, sizeof(test_ueid));
+	ret = genl_send(fd, &req.nlh);
 	if (!ASSERT_OK(ret, "ueid cmd"))
 		goto fail;
 
-	ret = recv(fd, &msg, sizeof(msg), 0);
-	if (!ASSERT_FALSE(ret < 0 ||
-			  !NLMSG_OK(&msg.n, ret), "ueid response"))
-		goto fail;
-
-	if (msg.n.nlmsg_type == NLMSG_ERROR) {
-		err = NLMSG_DATA(&msg);
-		switch (op) {
-		case SMC_NETLINK_REMOVE_UEID:
-			if (!ASSERT_FALSE((err->error && err->error != -ENOENT),
-					  "ueid remove"))
-				goto fail;
-			break;
-		case SMC_NETLINK_ADD_UEID:
-			if (!ASSERT_OK(err->error, "ueid add"))
-				goto fail;
-			break;
-		default:
-			break;
-		}
+	ret = genl_recv(fd, req.nlh.nlmsg_seq, smc_nl_family_id, false);
+	switch (op) {
+	case SMC_NETLINK_REMOVE_UEID:
+		if (!ASSERT_FALSE(ret && ret != -ENOENT, "ueid remove"))
+			goto fail;
+		break;
+	case SMC_NETLINK_ADD_UEID:
+		if (!ASSERT_OK(ret, "ueid add"))
+			goto fail;
+		break;
+	default:
+		break;
 	}
+
 	close(fd);
 	return true;
 fail:
-- 
2.43.0

