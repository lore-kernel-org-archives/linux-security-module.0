Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB6136E02
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541293; cv=none; b=iQWMg6AvrJNTw5VEWWwVR9cepA0yEEYibFBa+vIcz+QzL/m486mSvqZfeR9z30eceKXPurvzuxgCgJWCRD7X6IIKP2saVXSQP0VbNmV6WrnuF880z1+2uDtxLjl+Jq2WZ/UZhMUj0SLJtSzEehNkCPHuSgpKUabio7BOlQ2ZZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541293; c=relaxed/simple;
	bh=amdXCZoqj2z7s46MEj+Fcv8Tjjs58JdD4tUlu13JbKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBjzzWs3/W6fjVPz+Km81+kzfXizSrrNYtPR+BEIZV49eJ4dLngVCLLatdJ1lQQwfDK3d6oD9+B6s9MX3d1SZVdgqqYjIjvCxdsPbXsi3WO66QCX9e47tFMur3qXxSVhqLsX8Zg60yeTOQB+eSa839dkU7ibEiAhup9Qzop8lBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bYVWGxp/; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bYVWGxp/"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V4QGz5HCCzC90;
	Wed, 27 Mar 2024 13:00:43 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V4QGz2KgCz3d;
	Wed, 27 Mar 2024 13:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711540843;
	bh=amdXCZoqj2z7s46MEj+Fcv8Tjjs58JdD4tUlu13JbKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYVWGxp/o3FfD53NBkQhGzibdQJ9oi+Y+2oU1Lnl5r3xA1bR8f9ECKufh3+EEOAKw
	 BO3ef5tTZj8ED8woDIKpmODifwsNG1dJJ4Mfk98gywE6+NkrutfBTWtgrpRbYlWsD/
	 AAuy9OBo87QDRD66LWhAVc6lnAmxBcjs3nsmt+6w=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH v1 2/2] selftests/landlock: Improve AF_UNSPEC tests
Date: Wed, 27 Mar 2024 13:00:34 +0100
Message-ID: <20240327120036.233641-2-mic@digikod.net>
In-Reply-To: <20240327120036.233641-1-mic@digikod.net>
References: <20240327120036.233641-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Test that an IPv6 socket requested to be binded with AF_UNSPEC returns
-EAFNOSUPPORT if the sockaddr length is valid.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Günther Noack <gnoack@google.com>
Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/net_test.c | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index f21cfbbc3638..f15cf565f856 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -673,6 +673,7 @@ TEST_F(protocol, bind_unspec)
 		.port = self->srv0.port,
 	};
 	int bind_fd, ret;
+	socklen_t inet_len, inet6_len, unix_len;
 
 	if (variant->sandbox == TCP_SANDBOX) {
 		const int ruleset_fd = landlock_create_ruleset(
@@ -736,12 +737,48 @@ TEST_F(protocol, bind_unspec)
 	if (variant->prot.domain == AF_INET) {
 		EXPECT_EQ(-EAFNOSUPPORT, ret);
 	} else {
+		/* The sockaddr length is less than SIN6_LEN_RFC2133. */
 		EXPECT_EQ(-EINVAL, ret)
 		{
 			TH_LOG("Wrong bind error: %s", strerror(errno));
 		}
 	}
 	EXPECT_EQ(0, close(bind_fd));
+
+	/* Stores the minimal sockaddr lengths per family. */
+	self->unspec_srv0.protocol.domain = AF_INET;
+	inet_len = get_addrlen(&self->unspec_srv0, true);
+	self->unspec_srv0.protocol.domain = AF_INET6;
+	inet6_len = get_addrlen(&self->unspec_srv0, true);
+	self->unspec_srv0.protocol.domain = AF_UNIX;
+	unix_len = get_addrlen(&self->unspec_srv0, true);
+	self->unspec_srv0.protocol.domain = AF_UNSPEC;
+
+	/* Checks bind with AF_UNSPEC and less than IPv4 sockaddr length. */
+	bind_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, bind_fd);
+	ret = bind_variant_addrlen(bind_fd, &self->unspec_srv0, inet_len - 1);
+	EXPECT_EQ(-EINVAL, ret);
+	EXPECT_EQ(0, close(bind_fd));
+
+	/* Checks bind with AF_UNSPEC and IPv6 sockaddr length. */
+	bind_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, bind_fd);
+	ret = bind_variant_addrlen(bind_fd, &self->unspec_srv0, inet6_len);
+	if (variant->prot.domain == AF_INET ||
+	    variant->prot.domain == AF_INET6) {
+		EXPECT_EQ(-EAFNOSUPPORT, ret);
+	} else {
+		EXPECT_EQ(-EINVAL, ret);
+	}
+	EXPECT_EQ(0, close(bind_fd));
+
+	/* Checks bind with AF_UNSPEC and unix sockaddr length. */
+	bind_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, bind_fd);
+	ret = bind_variant_addrlen(bind_fd, &self->unspec_srv0, unix_len);
+	EXPECT_EQ(-EINVAL, ret);
+	EXPECT_EQ(0, close(bind_fd));
 }
 
 TEST_F(protocol, connect_unspec)
-- 
2.44.0

