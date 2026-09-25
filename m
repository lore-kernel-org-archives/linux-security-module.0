Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876F4F30E3;
	Fri, 25 Sep 2026 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369731; cv=none; b=F5ZDSNHTJ4XrKYYl2fqVT/lfwHndgX7iwHiYsvtOb5D97A6bo5HLSZ1AIbcugcEP0+WSzWEg8KCc4BAOfET94USGZMNv4IVz7uRhvsowiaUTlnofsJLHrBE/Z7orAMHLwbcUgk0SLtO4Jy6oXPVfFA4Gd0ZBlxS7+Vw8ndIVJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369731; c=relaxed/simple;
	bh=oFtS72/2r+V/cbE3jqXoH0hs5S7CWd1R6CFgYwJPcM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+9i626U99xOUB2qU5fwOBv+4DJ4Pt4N09uVIP4Rr9F6sWLCbh+4JtBiwDWQhamLrcLbobC1xoY6wPkgq2bKi0QoOshjwZM3VIT6XUS0nlr40IFqfjEfaVvvisHqhKswBLuqyy2SB32UlPW3A2rYOwW4P97QBrmHIzhTglxO8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=MH0kjnrD; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="MH0kjnrD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=P4SfM0J+AFamH6peJlRr9KeQjbqE2JrOJ9NkO0X38n8=; b=MH0kjnrD38pYgtUOeB2HKbCsE5
	D9SeBLdKUPyNZu4BhsSzTiVTVXb7zGo3oKi6hwj34bWp9PLVbPXh7jF4+YIW4l+LSfbimgygwh8Rn
	BndfRr5HoeuBzNUH8gXF9+coKK3VPVHZNQvQnKSnoggXxrdwlfjqQJcMgRbom559UCSui7o+Pj9ZZ
	TFWmMJJ0qlVg632jjZKpYS1EbDCyXMud205wsiq8Ifk6qzYPqPeGrw1SxJFUP98/3vET4AP9ZxXqN
	uTAgiMZgoGe4QChkj7CQO3YUVeUkfgKG+75HDwISnZgk3GGCvtQ6KRmciT5uvSeqRuNEzCFsi2n2n
	f1M9CyRQ==;
Received: from [151.115.150.205] (port=51460 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xACx7-0000000Bapv-209B;
	Fri, 25 Sep 2026 22:55:28 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 2/2] tests: add SCTP connect mediation regression test
Date: Fri, 25 Sep 2026 20:54:50 +0000
Message-ID: <20260925205447.1244190-6-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925205447.1244190-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260925205447.1244190-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Exercise SCTP connect(), sendto(), sendmsg() and all three CONNECTX
interfaces over IPv4 and IPv6. Check that connections succeed when
allowed and return EACCES when connect permission is omitted or denied.

Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 tests/regression/apparmor/Makefile         |   2 +
 tests/regression/apparmor/net_inet_sctp.c  | 115 +++++++++++++++++++++
 tests/regression/apparmor/net_inet_sctp.sh |  56 ++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 tests/regression/apparmor/net_inet_sctp.c
 create mode 100755 tests/regression/apparmor/net_inet_sctp.sh

diff --git a/tests/regression/apparmor/Makefile b/tests/regression/apparmor/Makefile
index 18e408f5cd88..c90865f94fe7 100644
--- a/tests/regression/apparmor/Makefile
+++ b/tests/regression/apparmor/Makefile
@@ -150,6 +150,7 @@ SRC=access.c \
     mount.c \
     named_pipe.c \
     net_inet_rcv.c \
+    net_inet_sctp.c \
     net_inet_snd.c \
     net_inet_tcp_fastopen.c \
     net_raw.c \
@@ -326,6 +327,7 @@ TESTS=aa_exec \
       namespaces \
       net_iface \
       net_inet \
+      net_inet_sctp \
       net_inet_tcp_fastopen \
       net_raw \
       overlayfs_kernel \
diff --git a/tests/regression/apparmor/net_inet_sctp.c b/tests/regression/apparmor/net_inet_sctp.c
new file mode 100644
index 000000000000..3e6cf4067527
--- /dev/null
+++ b/tests/regression/apparmor/net_inet_sctp.c
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <sys/uio.h>
+#include <linux/sctp.h>
+
+static void check(int ok, const char *operation)
+{
+	if (!ok) {
+		printf("FAIL: %s (errno %d)\n", operation, errno);
+		exit(1); /* Setup errors must not satisfy an expected EACCES. */
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_in in = {
+		.sin_family = AF_INET, .sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	struct sockaddr_in6 in6 = {
+		.sin6_family = AF_INET6, .sin6_addr = IN6ADDR_LOOPBACK_INIT,
+	};
+	struct sockaddr *addr;
+	socklen_t addrlen;
+	const char *mode;
+	int family, client, listener;
+	ssize_t ret;
+	char payload = 'x', buffer[2];
+
+	check(argc == 3, "usage: net_inet_sctp inet|inet6 MODE");
+	check(!strcmp(argv[1], "inet") || !strcmp(argv[1], "inet6"), "family");
+	mode = argv[2];
+	family = strcmp(argv[1], "inet") == 0 ? AF_INET : AF_INET6;
+	alarm(15);
+
+	client = socket(family, SOCK_SEQPACKET, IPPROTO_SCTP);
+	if (client == -1 && !strcmp(mode, "probe") &&
+	    (errno == EPROTONOSUPPORT || errno == ESOCKTNOSUPPORT ||
+	     errno == EAFNOSUPPORT))
+		return 77;
+	check(client >= 0, "client socket");
+	if (!strcmp(mode, "probe")) {
+		close(client);
+		return 0;
+	}
+
+	/* Let the kernel choose a free loopback port for each test. */
+	addr = family == AF_INET ? (struct sockaddr *)&in : (struct sockaddr *)&in6;
+	addrlen = family == AF_INET ? sizeof(in) : sizeof(in6);
+	listener = socket(family, SOCK_SEQPACKET, IPPROTO_SCTP);
+	check(listener >= 0, "listener socket");
+	check(bind(listener, addr, addrlen) == 0, "bind");
+	check(getsockname(listener, addr, &addrlen) == 0, "getsockname");
+	check(listen(listener, 1) == 0, "listen");
+
+	if (!strcmp(mode, "connect")) {
+		ret = connect(client, addr, addrlen);
+	} else if (!strcmp(mode, "sendto")) {
+		ret = sendto(client, &payload, 1, MSG_NOSIGNAL,
+			     addr, addrlen);
+	} else if (!strcmp(mode, "sendmsg")) {
+		struct iovec iov = { .iov_base = &payload, .iov_len = 1 };
+		struct msghdr msg = {
+			.msg_name = addr,
+			.msg_namelen = addrlen,
+			.msg_iov = &iov,
+			.msg_iovlen = 1,
+		};
+
+		ret = sendmsg(client, &msg, MSG_NOSIGNAL);
+	} else if (!strcmp(mode, "connectx3")) {
+		struct sctp_getaddrs_old args = {
+			/* This ABI takes the address length in bytes. */
+			.addr_num = addrlen,
+			.addrs = addr,
+		};
+		socklen_t optlen = sizeof(args);
+
+		ret = getsockopt(client, IPPROTO_SCTP, SCTP_SOCKOPT_CONNECTX3,
+				 &args, &optlen);
+	} else if (!strcmp(mode, "connectx_old") || !strcmp(mode, "connectx")) {
+		int opt = !strcmp(mode, "connectx_old") ?
+			SCTP_SOCKOPT_CONNECTX_OLD : SCTP_SOCKOPT_CONNECTX;
+
+		/* CONNECTX can return a positive association ID on success. */
+		ret = setsockopt(client, IPPROTO_SCTP, opt, addr, addrlen);
+	} else {
+		printf("FAIL: unknown operation %s\n", mode);
+		return 1;
+	}
+
+	if (ret == -1) {
+		int error = errno;
+
+		printf("FAIL: %s: %s\n", mode, strerror(error));
+		return error; /* Checked by runchecktest_errno. */
+	}
+	if (strcmp(mode, "sendto") && strcmp(mode, "sendmsg"))
+		ret = sendto(client, &payload, 1, MSG_NOSIGNAL, addr, addrlen);
+	check(ret == 1, "send payload");
+	check(recv(listener, buffer, sizeof(buffer), 0) == 1 &&
+	      buffer[0] == payload, "receive payload");
+
+	close(client);
+	close(listener);
+	printf("PASS\n");
+	return 0;
+}
diff --git a/tests/regression/apparmor/net_inet_sctp.sh b/tests/regression/apparmor/net_inet_sctp.sh
new file mode 100755
index 000000000000..e3c81e2ee814
--- /dev/null
+++ b/tests/regression/apparmor/net_inet_sctp.sh
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2026 Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
+
+#=NAME net_inet_sctp
+#=DESCRIPTION
+# SCTP association creation must require connect permission, including
+# implicit connections through sendto/sendmsg and the CONNECTX socket options.
+#=END
+
+bin=$(cd "$(dirname "$0")" && pwd)
+. "$bin/prologue.inc"
+
+requires_any_of_kernel_features network/af_mask network_v8/af_mask network_v9/af_mask
+# Probe the same ABI that genprofile selects with "abi <kernel>".
+requires_parser_support --policy-features=/sys/kernel/security/apparmor/features \
+	--warn=rule-downgraded --Werror=rule-downgraded \
+	--warn=rule-not-enforced --Werror=rule-not-enforced -- \
+	"network (create,bind,listen,send,receive,setopt,getopt,getattr) inet seqpacket," \
+	"deny network connect inet seqpacket,"
+
+run_modes()
+{
+	local description=$1 expected=$2 error=$3 mode
+
+	for mode in connect sendto sendmsg connectx_old connectx connectx3; do
+		runchecktest_errno "$error" "SCTP $family $mode ($description)" \
+			"$expected" "$family" "$mode"
+	done
+}
+
+for family in inet inet6; do
+	# Probe without a profile so policy denials cannot cause a skip.
+	probe_rc=0
+	"$test" "$family" probe || probe_rc=$?
+	if [ "$probe_rc" -eq 77 ]; then
+		echo "    SCTP $family not available. Skipping tests ..."
+		continue
+	fi
+	[ "$probe_rc" -eq 0 ] || fatalerror "SCTP $family probe failed"
+
+	run_modes unconfined pass 0
+
+	genprofile "network;$family;seqpacket"
+	run_modes "connect allowed" pass 0
+
+	# Grant all the other permissions used by the client and listener.
+	genprofile "network;(create,bind,listen,send,receive,setopt,getopt,getattr);$family;seqpacket"
+	run_modes "connect omitted" fail EACCES
+
+	genprofile "network;$family;seqpacket" \
+		"qual=deny:network;connect;$family;seqpacket"
+	run_modes "connect denied" fail EACCES
+
+	removeprofile
+done
-- 
2.47.3

