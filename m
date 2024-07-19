Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD671459F9
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jul 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401616; cv=none; b=GBXR3Jj22j/3d4NQAgmEF09GnCFgYRbZQTldo4kctso2EaawEoV4V5Z1HW4I3wst0DI+H/JnIzaSsZwnu0y6+sYB7WySOsT9hOhi0nEeCBjruo//XabzdMn8/bvL1ux2WlMPBnBdyE/ytTyzNBgIf+C3LyUAgN+XAnKJ/7GUvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401616; c=relaxed/simple;
	bh=PcyCIGOY6B9EKh/dirdA/OiOx2pplkP5HcNfj4y1MNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGX3E1vq3Ew/HgZ9T+4P7XmQCBT6xjzQHN+B+fm1JAsX4sWsIUe/j9WFTrJCYWYeorw2cjcGkg4QqiMIlmvhDsKvhX9wWWVzXbQOyG/Yd6HYbsLfvRV73Ev/t1lGjLKautyBXn6pvX+FQqVK/uplKcwBuAQFkXvm16iNQf7kMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IOdqrYHk; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IOdqrYHk"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQY123KLczhNp;
	Fri, 19 Jul 2024 17:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721401606;
	bh=C4QufuQSQWKLaXnsSOFxYv1MHT16Z/NZ1G5g6Fkr0f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOdqrYHkIcVtfZw6cakd92SDVMHoLd/gtP1EKw1esgZm9PC2TV1YpEujcP8Q9JAvL
	 fY4YcrXe+5v+eM1qmf9TYlGNDR5MfiURvQCIiyVi+Bzx7yBX5RrbzJzace/ifSPe6p
	 Y0GlTdPeNN1UhZy+Zmq39xWoDq3RMyYTMjD/GM08=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQY116SdDzssk;
	Fri, 19 Jul 2024 17:06:45 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH v1 2/3] selftests/landlock: Add test for socket's domain
Date: Fri, 19 Jul 2024 17:06:17 +0200
Message-ID: <20240719150618.197991-3-mic@digikod.net>
In-Reply-To: <20240719150618.197991-1-mic@digikod.net>
References: <20240719150618.197991-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This new ipv4_tcp.socket_domain test checks that the restrictions are
tied to the socket at creation time, but not tied to the thread
requesting a bind action.

Properly close file descriptor in ipv4.with_fs test.

Cc: Günther Noack <gnoack@google.com>
Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Cc: stable@vger.kernel.org
Fixes: a549d055a22e ("selftests/landlock: Add network tests")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240719150618.197991-3-mic@digikod.net
---
 tools/testing/selftests/landlock/net_test.c | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index f21cfbbc3638..79251e27d26d 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1579,6 +1579,35 @@ TEST_F(ipv4_tcp, with_fs)
 	bind_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
 	ASSERT_LE(0, bind_fd);
 	EXPECT_EQ(-EACCES, bind_variant(bind_fd, &self->srv1));
+	EXPECT_EQ(0, close(bind_fd));
+}
+
+TEST_F(ipv4_tcp, socket_domain)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	int ruleset_fd, bind_fd;
+
+	/* Creates socket before sandboxing. */
+	bind_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	ASSERT_LE(0, bind_fd);
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Tests port binding with unsandboxed socket. */
+	EXPECT_EQ(0, bind_variant(bind_fd, &self->srv1));
+	EXPECT_EQ(0, close(bind_fd));
+
+	/* Tests port binding with new sandboxed socket. */
+	bind_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	ASSERT_LE(0, bind_fd);
+	EXPECT_EQ(-EACCES, bind_variant(bind_fd, &self->srv1));
+	EXPECT_EQ(0, close(bind_fd));
 }
 
 FIXTURE(port_specific)
-- 
2.45.2

