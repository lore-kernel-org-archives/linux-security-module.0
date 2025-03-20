Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859422B8D2
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497672; cv=none; b=Hg6i2qEPY3RE3Lmhy7RnhAx+c2bWhcF4aOOE0C1t8PxGQ18G6bHFuNzOWZYgArTGKFA+JlEdh6dValUvUhrUsVA13+VcVAwwmR32KC/pNDktZjqnw7gGOSds7Jc8pd0W/o5AqI74x//BSW3Mr0H0MgBJSN798W6CPK23reUU37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497672; c=relaxed/simple;
	bh=UZgrTKwwnpZMru3hFB6cWmjZEpSfr1aJxv1aOn5i/co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wn0ouUAyaDqRhTqDy/USL4J/rvgkgA+F8pME7jH97NCC9f+rZ2hefjaEXEeji7TDQ8vUVQcPkvfO61BCCFdCd7KopaOcSERsrl0gIw5047jDFRVhOwORWXA9r6e6AsTEsnU7B0R/b1TPaXcpN3Pp1Ls8KmvfIh+plLC4xn/ZOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jFWadMAE; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jFWadMAE"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpX25T2zxvJ;
	Thu, 20 Mar 2025 20:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497668;
	bh=YrYB2X4cLWgBwHHGFEMnc1idqQl0CQlMHetQ1DDbagU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFWadMAEhoz++Vg1hEdpI1tZ2fINFjdb/vP9zn5mmN80gGb0yMAnn1CONY++rc1TW
	 p58kA156gaEbRKhdCPHljQlLbqviICTVZwDzvxerTX+5izZy5BHiYYD6vnl8ewlFu1
	 XGLCrGFxoCdf49NbW+muPCadhgbMPUuW6OtyDyvs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpW3hd4zFMr;
	Thu, 20 Mar 2025 20:07:47 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 15/28] landlock: Log TCP bind and connect denials
Date: Thu, 20 Mar 2025 20:07:04 +0100
Message-ID: <20250320190717.2287696-16-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit support to socket_bind and socket_connect hooks.

The related blockers are:
- net.bind_tcp
- net.connect_tcp

Audit event sample:

  type=LANDLOCK_DENY msg=audit(1729738800.349:44): domain=195ba459b blockers=net.connect_tcp daddr=127.0.0.1 dest=80

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v5:
- Move request declaration in the landlock_log_denial() call to
  not impact allowed requests with audit.

Changes since v4:
- Rebase on top of the landlock_log_denial() and subject type changes.

Changes since v3:
- Rename blockers from net_* to net.*

Changes since v2:
- Remove potentially superfluous IPv6 saddr log, spotted by Francis
  Laniel.
- Cosmetic improvements.
---
 security/landlock/audit.c | 12 +++++++++
 security/landlock/audit.h |  1 +
 security/landlock/net.c   | 51 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index f50ce677e3a0..66ff9a5d9866 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -41,6 +41,13 @@ static const char *const fs_access_strings[] = {
 
 static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
 
+static const char *const net_access_strings[] = {
+	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_TCP)] = "net.bind_tcp",
+	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_TCP)] = "net.connect_tcp",
+};
+
+static_assert(ARRAY_SIZE(net_access_strings) == LANDLOCK_NUM_ACCESS_NET);
+
 static __attribute_const__ const char *
 get_blocker(const enum landlock_request_type type,
 	    const unsigned long access_bit)
@@ -58,6 +65,11 @@ get_blocker(const enum landlock_request_type type,
 		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(fs_access_strings)))
 			return "unknown";
 		return fs_access_strings[access_bit];
+
+	case LANDLOCK_REQUEST_NET_ACCESS:
+		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(net_access_strings)))
+			return "unknown";
+		return net_access_strings[access_bit];
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 8130a6fcad07..486b4e7050d3 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -18,6 +18,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
 	LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
 	LANDLOCK_REQUEST_FS_ACCESS,
+	LANDLOCK_REQUEST_NET_ACCESS,
 };
 
 /*
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 6fb3e60bc5ff..f4478e6a2c0b 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -7,10 +7,12 @@
  */
 
 #include <linux/in.h>
+#include <linux/lsm_audit.h>
 #include <linux/net.h>
 #include <linux/socket.h>
 #include <net/ipv6.h>
 
+#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "limits.h"
@@ -55,6 +57,7 @@ static int current_check_access_socket(struct socket *const sock,
 	};
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
+	struct lsm_network_audit audit_net = {};
 
 	if (!subject)
 		return 0;
@@ -68,18 +71,48 @@ static int current_check_access_socket(struct socket *const sock,
 
 	switch (address->sa_family) {
 	case AF_UNSPEC:
-	case AF_INET:
+	case AF_INET: {
+		const struct sockaddr_in *addr4;
+
 		if (addrlen < sizeof(struct sockaddr_in))
 			return -EINVAL;
-		port = ((struct sockaddr_in *)address)->sin_port;
+
+		addr4 = (struct sockaddr_in *)address;
+		port = addr4->sin_port;
+
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+			audit_net.dport = port;
+			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+			audit_net.sport = port;
+			audit_net.v4info.saddr = addr4->sin_addr.s_addr;
+		} else {
+			WARN_ON_ONCE(1);
+		}
 		break;
+	}
 
 #if IS_ENABLED(CONFIG_IPV6)
-	case AF_INET6:
+	case AF_INET6: {
+		const struct sockaddr_in6 *addr6;
+
 		if (addrlen < SIN6_LEN_RFC2133)
 			return -EINVAL;
-		port = ((struct sockaddr_in6 *)address)->sin6_port;
+
+		addr6 = (struct sockaddr_in6 *)address;
+		port = addr6->sin6_port;
+
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+			audit_net.dport = port;
+			audit_net.v6info.daddr = addr6->sin6_addr;
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+			audit_net.sport = port;
+			audit_net.v6info.saddr = addr6->sin6_addr;
+		} else {
+			WARN_ON_ONCE(1);
+		}
 		break;
+	}
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 
 	default:
@@ -149,6 +182,16 @@ static int current_check_access_socket(struct socket *const sock,
 				   ARRAY_SIZE(layer_masks)))
 		return 0;
 
+	audit_net.family = address->sa_family;
+	landlock_log_denial(subject,
+			    &(struct landlock_request){
+				    .type = LANDLOCK_REQUEST_NET_ACCESS,
+				    .audit.type = LSM_AUDIT_DATA_NET,
+				    .audit.u.net = &audit_net,
+				    .access = access_request,
+				    .layer_masks = &layer_masks,
+				    .layer_masks_size = ARRAY_SIZE(layer_masks),
+			    });
 	return -EACCES;
 }
 
-- 
2.49.0

