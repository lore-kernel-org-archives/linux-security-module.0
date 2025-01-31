Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04181F3D2B
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341104; cv=none; b=MxMrx8mI6RLkf99wVvbiak5KBh+W94eaQsYf4jBow4/KABwXGE0x7iPxlLa7Prep3XnSsA04adgj3CxnL1feSCKM1/FgRJxbTTLf1ken1p57Y0XMkbIfs1z4ju6V3UevjaYc5Ux7uh2dPahjuRBzUrTmQqMeOfhTSlK3TgauLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341104; c=relaxed/simple;
	bh=brwtFa0YPuxT8obx9if/Rd1hfPfqP49c4g+GRIMs9+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=am+D/fobKd/VAyjWZPiL4IOfeUkSywT0/CgMY7xQxbAOd4RdZvoUoz/71M6eSCzzbkElLiaURd/A9L4B9dJUQNfpAIlFkcTpesiRxn8ZPDGkVcLonTltaRjxrLbhayIgSapu8x9N4mUNFkjChqSA6OVr0lihjC6OWfFbNWA+Co0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pIHlQmxW; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pIHlQmxW"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cY25VtzQpW;
	Fri, 31 Jan 2025 17:31:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341101;
	bh=S6/k9lM0kMYCCuiR8eF0rMjss9IyPVc9vBRzSQGM+EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIHlQmxWSc4F2EfN35ThkZQtAPXyalKk3VP5GEAuw0kJQ2o4PoeUBVSopIXkKcFPh
	 Evi3lFVbNS2w8fVugEomAjoLAcy+7tVr/I6eHBEqcuUwdAyLxd9nY5VlQKjRMr9xvy
	 n5PrZ5DkZTb3j38ygCa6IO9tWOFa5FYuTA1h/INA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1cX3SFrzdf9;
	Fri, 31 Jan 2025 17:31:40 +0100 (CET)
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
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 14/24] landlock: Log TCP bind and connect denials
Date: Fri, 31 Jan 2025 17:30:49 +0100
Message-ID: <20250131163059.1139617-15-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250131163059.1139617-15-mic@digikod.net
---

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
index 194c99fac133..9c856b31f9f6 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -42,6 +42,13 @@ static const char *const fs_access_strings[] = {
 
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
@@ -59,6 +66,11 @@ get_blocker(const enum landlock_request_type type,
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
index 6765a419001d..eeff2c5bfa4f 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -19,6 +19,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
 	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
 	LANDLOCK_REQUEST_FS_ACCESS,
+	LANDLOCK_REQUEST_NET_ACCESS,
 };
 
 /*
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 53dc9d94a5c2..a8e94562f2b1 100644
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
@@ -55,6 +57,10 @@ static int current_check_access_socket(struct socket *const sock,
 	};
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
+	struct lsm_network_audit audit_net = {};
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_NET_ACCESS,
+	};
 
 	if (!subject)
 		return 0;
@@ -69,18 +75,48 @@ static int current_check_access_socket(struct socket *const sock,
 
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
@@ -150,6 +186,13 @@ static int current_check_access_socket(struct socket *const sock,
 				   ARRAY_SIZE(layer_masks)))
 		return 0;
 
+	audit_net.family = address->sa_family;
+	request.audit.type = LSM_AUDIT_DATA_NET;
+	request.audit.u.net = &audit_net;
+	request.access = access_request;
+	request.layer_masks = &layer_masks;
+	request.layer_masks_size = ARRAY_SIZE(layer_masks);
+	landlock_log_denial(subject, &request);
 	return -EACCES;
 }
 
-- 
2.48.1

