Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631792E0926
	for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588513; cv=none; b=QRwwXa/ra9Cio5ay1jZDz/3qmC2g5q3lOxcZyeDoBY8Indiaw3ynFne+N00lNKxacAEHZOZA2X2FdE2AQqrEjEbPdDbHG+vAq+BLPkozQXL4qsuUosWJwh7G4VEUpQGwRl7Aq1A5tx508En90Gf94kyWgIbdZxMlFsnKbgHBUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588513; c=relaxed/simple;
	bh=fSfwjh31rKlY+qA6rI1HmNdD3SucRmTOIFEX9Vx8qlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lo4AdDucY/+M+on+VPKLwa81TI14DEZ9DIjOevH1jrWMHoVPrnIos5ywBlsKuCljJ473/gza/WDpEPAp+VkG8PUNUXbr9GYlYUSIacmjm+jJE+yQvaw0bC/M+sgvyZgovnPDmr7kgpICtklCnqV45eA6RSZdsGGmus6xtmi2gCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=SUbR0u1D; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="SUbR0u1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1761588508; bh=fSfwjh31rKlY+qA6rI1HmNdD3SucRmTOIFEX9Vx8qlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUbR0u1DZO1cpt4r0BFOA8Mma2iHfHWVVLkN4GPiXa5SWSz0ye7yav51n84u6I6Lp
	 WoLbGtK2Xq/qs2pu9hNLwa9KgT0kQSOKgpaWB5v0LwrSROUPAO9vt2FIxpYUb71i3j
	 f7e3G2WQuhgunB21PIl7Xqqe8HlfbElV0U4A89fGj7kkphF4P7S5TjBWO3N5V8b0ff
	 yS/1WhkdQcIGCQBVjVySzEYhsYgmcFjs8m/3LddPqIGJv3l5SwuJGvEVbwFyFfrcNF
	 9cSZ6d67lIQJ4h0vVPi3xODGdWIuNY7kkns4ywKERd+Lp0jpNwvnQkc8dfkitgsJDS
	 EqQgnCSNdwmSg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 11759125405;
	Mon, 27 Oct 2025 19:08:28 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v1 1/3] selftests/landlock: Fix TCP bind(AF_UNSPEC) test case
Date: Mon, 27 Oct 2025 20:07:24 +0100
Message-Id: <20251027190726.626244-2-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027190726.626244-1-matthieu@buffet.re>
References: <20251027190726.626244-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nominal error code for bind(AF_UNSPEC) on an IPv6 socket
is -EAFNOSUPPORT, not -EINVAL. -EINVAL is only returned when
the supplied address struct is too short, which happens to be
the case in current selftests because they treat AF_UNSPEC
like IPv4 sockets do: as an alias for AF_INET (which is a
16-byte struct instead of the 24 bytes required by IPv6
sockets).

Make the union large enough for any address (by adding struct
sockaddr_storage to the union), and make AF_UNSPEC addresses
large enough for any family.

Test for -EAFNOSUPPORT instead, and add a dedicated test case
for truncated inputs with -EINVAL.

Fixes: a549d055a22e ("selftests/landlock: Add network tests")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/common.h   |  1 +
 tools/testing/selftests/landlock/net_test.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 88a3c78f5d98..9a295b5b90e3 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -241,6 +241,7 @@ struct service_fixture {
 			struct sockaddr_un unix_addr;
 			socklen_t unix_addr_len;
 		};
+		struct sockaddr_storage _largest;
 	};
 };
 
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 2a45208551e6..3bbc0508420b 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -121,6 +121,10 @@ static socklen_t get_addrlen(const struct service_fixture *const srv,
 {
 	switch (srv->protocol.domain) {
 	case AF_UNSPEC:
+		if (minimal)
+			return sizeof(sa_family_t);
+		return sizeof(struct sockaddr_storage);
+
 	case AF_INET:
 		return sizeof(srv->ipv4_addr);
 
@@ -758,6 +762,11 @@ TEST_F(protocol, bind_unspec)
 	bind_fd = socket_variant(&self->srv0);
 	ASSERT_LE(0, bind_fd);
 
+	/* Tries to bind with too small addrlen. */
+	EXPECT_EQ(-EINVAL, bind_variant_addrlen(
+				   bind_fd, &self->unspec_any0,
+				   get_addrlen(&self->unspec_any0, true) - 1));
+
 	/* Allowed bind on AF_UNSPEC/INADDR_ANY. */
 	ret = bind_variant(bind_fd, &self->unspec_any0);
 	if (variant->prot.domain == AF_INET) {
@@ -766,6 +775,8 @@ TEST_F(protocol, bind_unspec)
 			TH_LOG("Failed to bind to unspec/any socket: %s",
 			       strerror(errno));
 		}
+	} else if (variant->prot.domain == AF_INET6) {
+		EXPECT_EQ(-EAFNOSUPPORT, ret);
 	} else {
 		EXPECT_EQ(-EINVAL, ret);
 	}
@@ -792,6 +803,8 @@ TEST_F(protocol, bind_unspec)
 		} else {
 			EXPECT_EQ(0, ret);
 		}
+	} else if (variant->prot.domain == AF_INET6) {
+		EXPECT_EQ(-EAFNOSUPPORT, ret);
 	} else {
 		EXPECT_EQ(-EINVAL, ret);
 	}
@@ -801,7 +814,8 @@ TEST_F(protocol, bind_unspec)
 	bind_fd = socket_variant(&self->srv0);
 	ASSERT_LE(0, bind_fd);
 	ret = bind_variant(bind_fd, &self->unspec_srv0);
-	if (variant->prot.domain == AF_INET) {
+	if (variant->prot.domain == AF_INET ||
+	    variant->prot.domain == AF_INET6) {
 		EXPECT_EQ(-EAFNOSUPPORT, ret);
 	} else {
 		EXPECT_EQ(-EINVAL, ret)
-- 
2.47.2

