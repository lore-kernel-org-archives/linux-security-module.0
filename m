Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1834750D;
	Wed,  1 Jul 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942427; cv=none; b=B3yAL9uFP5p6YKFB88vh2CBC+fmx7L0Ewbx6RmEcK/jx7AFGyxXS0pg4V5vHpNfB2XsHYaTouDodt/5hzFUPFn7Yv8o+DYfXqULInF4JaVcEzzewk/XG84BeH5D5lM1dChWXxzqPsmPO8fdJnUJSCVtsJ+AXNAyzVyHge5/gKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942427; c=relaxed/simple;
	bh=sYqET8iBnZ9CzC1EMtZSzdgfCWgPui5wQiV209F/tTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXfx6Hpw6QjqgD1z1i0DjaQkPPkOg2GVzRHdssZaPMkcLwbjhMVI/UWI3hJGjmI6hh0MWmcNReZLF0835h+pu9tIbBKX7JG6N4oJcVZU9jYQNUqKIz+gySN5HV0TuNrBpeS/frDMsmWxolan2or5HcGCFVxGatBXkS8D1mPjBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=H6wlb5P+; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="H6wlb5P+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1782942422; bh=sYqET8iBnZ9CzC1EMtZSzdgfCWgPui5wQiV209F/tTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6wlb5P+3g0jcY7bcAfMzHMteJK9MOkfZT/WaMcFYqdiiOrFiN7uZhNz2zLhEKxI3
	 S2XPQd/RLba+9/bfG24f6z973eQnUBFu1DD0Kc0ik7578ItIdvO6d+iGovlKcpRSvF
	 H3eZoII7RijXHc6/++yG0n+T9c24T6tzuiSOVKsbjp4HK3a2kzEEaIljlC1zryrUbG
	 9MXauw+G/mzkDZgTkh2sKeC0hIz1LUAXTCCkVl9j3TbJcMqGd2+vtGKP+bYFaPmcd0
	 +gRL/P6MiX+xUyRNIm/Su/DzJnobZKvsjDbMi+rjZOQ/6jcv4Nu0hgXj6M81rHV9ef
	 IxF1RwETjRPqg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id DFA0112667B;
	Wed,  1 Jul 2026 23:47:02 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 2/2] selftests/landlock: Add test for TCP fast open
Date: Wed,  1 Jul 2026 23:46:28 +0200
Message-ID: <20260701214628.33319-2-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701214628.33319-1-matthieu@buffet.re>
References: <c21cf4f3-6c21-4170-b578-13c1bfd48b87@buffet.re>
 <20260701214628.33319-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enforce that TCP Fast Open is controlled by
LANDLOCK_ACCESS_NET_CONNECT_TCP. Semantics of connect() and
sendmsg(MSG_FASTOPEN) should be identical from Landlock's perspective.
Also enforce error code consistency, since UDP sockets ignore
the MSG_FASTOPEN flag while Unix sockets reject it.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/net_test.c | 94 +++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 2ed1f76b7a8b..2e4dc5025b04 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1281,6 +1281,100 @@ TEST_F(protocol, connect_unspec)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+TEST_F(protocol, tcp_fastopen)
+{
+	const bool restricted = variant->sandbox == TCP_SANDBOX &&
+		variant->prot.type == SOCK_STREAM &&
+		(variant->prot.protocol == IPPROTO_TCP || variant->prot.protocol == IPPROTO_IP) &&
+		(variant->prot.domain == AF_INET || variant->prot.domain == AF_INET6);
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	int bind_fd, client_fd, status;
+	char buf;
+	pid_t child;
+
+	bind_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, bind_fd);
+	EXPECT_EQ(0, bind_variant(bind_fd, &self->srv0));
+	if (self->srv0.protocol.type == SOCK_STREAM)
+		EXPECT_EQ(0, listen(bind_fd, backlog));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int connect_fd, ret;
+
+		/* Closes listening socket for the child. */
+		EXPECT_EQ(0, close(bind_fd));
+
+		connect_fd = socket_variant(&self->srv0);
+		ASSERT_LE(0, connect_fd);
+
+		if (variant->sandbox == TCP_SANDBOX) {
+			const int ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			ASSERT_LE(0, ruleset_fd);
+
+			enforce_ruleset(_metadata, ruleset_fd);
+			EXPECT_EQ(0, close(ruleset_fd));
+		}
+
+		/* Fast Open with no address. */
+		ret = sendto_variant(connect_fd, NULL, NULL, 0, MSG_FASTOPEN);
+		if (self->srv0.protocol.domain == AF_UNIX) {
+			EXPECT_EQ(-ENOTCONN, ret);
+		} else if (self->srv0.protocol.type == SOCK_DGRAM) {
+			EXPECT_EQ(-EDESTADDRREQ, ret);
+		} else {
+			EXPECT_EQ(-EINVAL, ret);
+		}
+
+		/* Fast Open to a denied address. */
+		ret = sendto_variant(connect_fd, &self->srv0, "A", 1, MSG_FASTOPEN);
+		if (restricted) {
+			EXPECT_EQ(-EACCES, ret);
+		} else if (self->srv0.protocol.domain == AF_UNIX &&
+			   self->srv0.protocol.type == SOCK_STREAM) {
+			EXPECT_EQ(-EOPNOTSUPP, ret);
+		} else {
+			EXPECT_EQ(0, ret);
+		}
+
+		EXPECT_EQ(0, close(connect_fd));
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	client_fd = bind_fd;
+	if (!restricted && self->srv0.protocol.type == SOCK_STREAM &&
+	    self->srv0.protocol.domain != AF_UNIX) {
+		client_fd = accept(bind_fd, NULL, 0);
+		ASSERT_LE(0, client_fd);
+	}
+
+	if (restricted) {
+		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		EXPECT_EQ(ENOTCONN, errno);
+	} else if (self->srv0.protocol.domain == AF_UNIX &&
+		   self->srv0.protocol.type == SOCK_STREAM) {
+		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		EXPECT_EQ(EINVAL, errno);
+	} else {
+		EXPECT_EQ(1, read(client_fd, &buf, 1));
+		EXPECT_EQ('A', buf);
+	}
+
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	if (client_fd != bind_fd)
+		EXPECT_LE(0, close(client_fd));
+
+	EXPECT_EQ(0, close(bind_fd));
+}
+
 TEST_F(protocol, sendmsg_stream)
 {
 	int srv0_fd, tmp_fd, client_fd, res;
-- 
2.47.3

