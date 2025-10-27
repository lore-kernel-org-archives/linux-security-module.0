Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1830ACE3
	for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588521; cv=none; b=NzjpEiQ/NeUz8gs9CwrGweoPRMaXbr7YLvxJGYTM9ahTrtY0EHEEQM2MuiFMInEcbEOOIz7k1lc7bH10Gw7liau0J+WM6qt6F7z/m6P3ROwdDuRlAzY/nVG/tmf/BtdL1vWonwJJmm7SOcqaNS82O+o3kVzfaYAzBp6n8pr8Iw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588521; c=relaxed/simple;
	bh=ejb8gPTKRfISaqqUVRzbsU24G5GLKSF3gU1cKCrR3AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+WPvJMy+8SvVyMB4ieSXAirq4zZbUfZXElFVS1jHicj0fWiXYMw5594CmZeS0JjDVbkcWQ1nXTYrIv5eJWlQG1P5ly5hqMMf+d4FYBMs+kabjtmIJR6T0CLYd45+oQ/7nilGxTlOkjRlxnzUa8AE9R5umuC/aE07rBSf4Z8k+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=i2O/1jSL; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="i2O/1jSL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1761588517; bh=ejb8gPTKRfISaqqUVRzbsU24G5GLKSF3gU1cKCrR3AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2O/1jSLSJtG04tukVwQMi+oPk25qsbd7utdtnGTUpW2KzggZYJLWZqnT5xcOOV1d
	 boBdG5d+6x9WvSbVH8TCZVnkPsi72ObevHHJP13O2Rtkw3+G6MhHKs9xcAzdddzvo5
	 t3x/YN/Y8F/iCrK2b2SL8OB8OSILoWaL8JSllEJNdBaV7xNl2UrDh5RAzqMt/11AoW
	 vq9lJiMEwsXNkTF8zxb6fezMyHbgXKgO2pvhd9xNUDWqsR6dk6bTXYVGRqC7DgTxl2
	 +Km6JJ40WH+kn7oTzfl6hfGvC5OS45gcVnvVKKnFXnxuQl2ciTx0x+LRO4zAe5vCNG
	 6YbF8V2rxeytA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id C37A0125405;
	Mon, 27 Oct 2025 19:08:36 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v1 3/3] landlock: Fix TCP handling of short AF_UNSPEC addresses
Date: Mon, 27 Oct 2025 20:07:26 +0100
Message-Id: <20251027190726.626244-4-matthieu@buffet.re>
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

current_check_access_socket() treats AF_UNSPEC addresses as
AF_INET ones, and only later adds special case handling to
allow connect(AF_UNSPEC), and on IPv4 sockets
bind(AF_UNSPEC+INADDR_ANY).
This would be fine except AF_UNSPEC addresses can be as
short as a bare AF_UNSPEC sa_family_t field, and nothing
more. The AF_INET code path incorrectly enforces a length of
sizeof(struct sockaddr_in) instead.

Move AF_UNSPEC edge case handling up inside the switch-case,
before the address is (potentially incorrectly) treated as
AF_INET.

Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 security/landlock/net.c | 118 +++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 51 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index 1f3915a90a80..e6367e30e5b0 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -71,6 +71,61 @@ static int current_check_access_socket(struct socket *const sock,
 
 	switch (address->sa_family) {
 	case AF_UNSPEC:
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+			/*
+			 * Connecting to an address with AF_UNSPEC dissolves
+			 * the TCP association, which have the same effect as
+			 * closing the connection while retaining the socket
+			 * object (i.e., the file descriptor).  As for dropping
+			 * privileges, closing connections is always allowed.
+			 *
+			 * For a TCP access control system, this request is
+			 * legitimate. Let the network stack handle potential
+			 * inconsistencies and return -EINVAL if needed.
+			 */
+			return 0;
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+			/*
+			 * Binding to an AF_UNSPEC address is treated
+			 * differently by IPv4 and IPv6 sockets. The socket's
+			 * family may change under our feet due to
+			 * setsockopt(IPV6_ADDRFORM), but that's ok: we either
+			 * reject entirely or require
+			 * %LANDLOCK_ACCESS_NET_BIND_TCP for the given port, so
+			 * it cannot be used to bypass the policy.
+			 *
+			 * IPv4 sockets map AF_UNSPEC to AF_INET for
+			 * retrocompatibility for bind accesses, only if the
+			 * address is INADDR_ANY (cf. __inet_bind). IPv6
+			 * sockets always reject it.
+			 *
+			 * Checking the address is required to not wrongfully
+			 * return -EACCES instead of -EAFNOSUPPORT or -EINVAL.
+			 * We could return 0 and let the network stack handle
+			 * these checks, but it is safer to return a proper
+			 * error and test consistency thanks to kselftest.
+			 */
+			if (sock->sk->__sk_common.skc_family == AF_INET) {
+				const struct sockaddr_in *const sockaddr =
+					(struct sockaddr_in *)address;
+
+				if (addrlen < sizeof(struct sockaddr_in))
+					return -EINVAL;
+
+				if (sockaddr->sin_addr.s_addr !=
+				    htonl(INADDR_ANY))
+					return -EAFNOSUPPORT;
+			} else {
+				if (addrlen < SIN6_LEN_RFC2133)
+					return -EINVAL;
+				else
+					return -EAFNOSUPPORT;
+			}
+		} else {
+			WARN_ON_ONCE(1);
+		}
+		/* Only for bind(AF_UNSPEC+INADDR_ANY) on IPv4 socket. */
+		fallthrough;
 	case AF_INET: {
 		const struct sockaddr_in *addr4;
 
@@ -119,57 +174,18 @@ static int current_check_access_socket(struct socket *const sock,
 		return 0;
 	}
 
-	/* Specific AF_UNSPEC handling. */
-	if (address->sa_family == AF_UNSPEC) {
-		/*
-		 * Connecting to an address with AF_UNSPEC dissolves the TCP
-		 * association, which have the same effect as closing the
-		 * connection while retaining the socket object (i.e., the file
-		 * descriptor).  As for dropping privileges, closing
-		 * connections is always allowed.
-		 *
-		 * For a TCP access control system, this request is legitimate.
-		 * Let the network stack handle potential inconsistencies and
-		 * return -EINVAL if needed.
-		 */
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP)
-			return 0;
-
-		/*
-		 * For compatibility reason, accept AF_UNSPEC for bind
-		 * accesses (mapped to AF_INET) only if the address is
-		 * INADDR_ANY (cf. __inet_bind).  Checking the address is
-		 * required to not wrongfully return -EACCES instead of
-		 * -EAFNOSUPPORT.
-		 *
-		 * We could return 0 and let the network stack handle these
-		 * checks, but it is safer to return a proper error and test
-		 * consistency thanks to kselftest.
-		 */
-		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
-			/* addrlen has already been checked for AF_UNSPEC. */
-			const struct sockaddr_in *const sockaddr =
-				(struct sockaddr_in *)address;
-
-			if (sock->sk->__sk_common.skc_family != AF_INET)
-				return -EINVAL;
-
-			if (sockaddr->sin_addr.s_addr != htonl(INADDR_ANY))
-				return -EAFNOSUPPORT;
-		}
-	} else {
-		/*
-		 * Checks sa_family consistency to not wrongfully return
-		 * -EACCES instead of -EINVAL.  Valid sa_family changes are
-		 * only (from AF_INET or AF_INET6) to AF_UNSPEC.
-		 *
-		 * We could return 0 and let the network stack handle this
-		 * check, but it is safer to return a proper error and test
-		 * consistency thanks to kselftest.
-		 */
-		if (address->sa_family != sock->sk->__sk_common.skc_family)
-			return -EINVAL;
-	}
+	/*
+	 * Checks sa_family consistency to not wrongfully return
+	 * -EACCES instead of -EINVAL.  Valid sa_family changes are
+	 * only (from AF_INET or AF_INET6) to AF_UNSPEC.
+	 *
+	 * We could return 0 and let the network stack handle this
+	 * check, but it is safer to return a proper error and test
+	 * consistency thanks to kselftest.
+	 */
+	if (address->sa_family != sock->sk->__sk_common.skc_family &&
+	    address->sa_family != AF_UNSPEC)
+		return -EINVAL;
 
 	id.key.data = (__force uintptr_t)port;
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
-- 
2.47.2

