Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C01EF084
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341085; cv=none; b=PLQLeouZOdzCKmvDY8l5xCbv6gquPeGg//K0aErRFK0t2h2V8dMtN3VmdAWp5vwiJBJOssl/0AMSws+hEEDxu88uElt0DG+qS4gGMMvHG+fjzJNoPKUDNGtLouFVbPzg5PMQ/3gKU7eOD9uHGYsGzZtajsUZR1tl4AfFQK8u7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341085; c=relaxed/simple;
	bh=UDR5ufk1gTD0xYNZhNyVFSeKj+m6D5RyalPNID+IjhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXIJs7bqd5Kk9/CSghW/iRVaepFPxth0ydzSmL9KhbEJFtQGoJcAOSHDiK52tQbPlZWQ4NTV4lQfN1kDIgb10W5D9NUeZWVEsttphTYCtVpF1EzXYzIKQgfz9L7fjyaX/y3TJewIy/9JTJ1KrxdZyZn2bnnKpHBuROO2Hk1UieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MSMPgu3q; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MSMPgu3q"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1c83pfjzBK9;
	Fri, 31 Jan 2025 17:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341080;
	bh=S8NFUxULJq6e3vN5cqn78mzntMjXF1IyDvj5Qk5QTl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSMPgu3qdxu+OBJ/sx+AcDWzi7ynbhUgJc+o/9b8Pn1Qcyf9n2jt5E4Rb5f463LJE
	 MpGFj1BE94T3gtam+EQqwLT+hDkQ+npUV0WKdx0BtmiDcUTC5i0rN5uGroCDxwZWNp
	 Qy4PiVDBh5NcLqy2n34Pz/TsufohiQWncVeakqW8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1c74Z1LzYg3;
	Fri, 31 Jan 2025 17:31:19 +0100 (CET)
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
Subject: [PATCH v5 05/24] landlock: Prepare to use credential instead of domain for network
Date: Fri, 31 Jan 2025 17:30:40 +0100
Message-ID: <20250131163059.1139617-6-mic@digikod.net>
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

This cosmetic change that is needed for audit support, specifically to
be able to filter according to cross-execution boundaries.

Optimize current_check_access_socket() to only handle the access
request.

Remove explicit domain->num_layers check which is now part of the
landlock_get_applicable_subject() call.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-6-mic@digikod.net
---

Changes since v4:
- New patch.
---
 security/landlock/net.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index d5dcc4407a19..53dc9d94a5c2 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -39,10 +39,6 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	return err;
 }
 
-static const struct access_masks any_net = {
-	.net = ~0,
-};
-
 static int current_check_access_socket(struct socket *const sock,
 				       struct sockaddr *const address,
 				       const int addrlen,
@@ -54,14 +50,14 @@ static int current_check_access_socket(struct socket *const sock,
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
-	const struct landlock_ruleset *const dom =
-		landlock_get_applicable_domain(landlock_get_current_domain(),
-					       any_net);
+	const struct access_masks masks = {
+		.net = access_request,
+	};
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), masks, NULL);
 
-	if (!dom)
+	if (!subject)
 		return 0;
-	if (WARN_ON_ONCE(dom->num_layers < 1))
-		return -EACCES;
 
 	/* Checks if it's a (potential) TCP socket. */
 	if (sock->type != SOCK_STREAM)
@@ -146,9 +142,10 @@ static int current_check_access_socket(struct socket *const sock,
 	id.key.data = (__force uintptr_t)port;
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
-	rule = landlock_find_rule(dom, id);
-	access_request = landlock_init_layer_masks(
-		dom, access_request, &layer_masks, LANDLOCK_KEY_NET_PORT);
+	rule = landlock_find_rule(subject->domain, id);
+	access_request = landlock_init_layer_masks(subject->domain,
+						   access_request, &layer_masks,
+						   LANDLOCK_KEY_NET_PORT);
 	if (landlock_unmask_layers(rule, access_request, &layer_masks,
 				   ARRAY_SIZE(layer_masks)))
 		return 0;
-- 
2.48.1

