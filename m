Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074B18DB33
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459814; cv=none; b=ooDpRhIil1a/wxbwI8DSqN0q3oD7cogD4+n+uUyzjMDhqTR1fk5a8EzN1EZjz+DdK+RNl52qMSt1DxORAmhXzDXFWC9xox1Jn3KHQOOJOPiW+r1qyXAmZg/GqWrDz1cujm8b9yS3CGvJJgFH9tl7xx/5W89a73Ci06fpQh5dQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459814; c=relaxed/simple;
	bh=MXaLO2V6ZjDmrW7A119TF5SuxXeQ2/ryPO4zhKxu70o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZ9QmViZzFz4BljBzL3YXBYKmsyl0JuiG4tExIbqDyL8oSpbwURpZCSMRMJB2BNoIcVHzdlZjj2D0kkyTRbhQlxhTxQJxWKG6fu0rrchAIKB6TaSCqMJxMX16QqZwROsI9ycRDMcBnjS1lt/w+9vahryEAvVcK7q6uWspUAXUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=b0ge4cY6; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="b0ge4cY6"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsN55G7zNql;
	Sat,  8 Mar 2025 19:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459480;
	bh=61Lm58nZn5dPCvFx6teXyXEqJvov75x4EeQ4yxThK7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0ge4cY6XNXkWXmPBw59WUF26NKXcf08yreHSar6bee8tiZH/P9Zw3aiATkxZbuGf
	 yxaVII3gCC5Kj8+Y4oqz5ESzCzAxin90HA1Trk1NO9N8m7vobmSQEfoQQqO9x5n0h9
	 /fkUFFEYXXNdSUQhb6CkWb56zNa875KVNKEym9pU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsM6GVnzhtB;
	Sat,  8 Mar 2025 19:44:39 +0100 (CET)
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
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 05/26] landlock: Prepare to use credential instead of domain for network
Date: Sat,  8 Mar 2025 19:44:01 +0100
Message-ID: <20250308184422.2159360-6-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250308184422.2159360-6-mic@digikod.net
---

Changes since v4:
- New patch.
---
 security/landlock/net.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index 104b6c01fe50..6fb3e60bc5ff 100644
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
 
 	if (!sk_is_tcp(sock->sk))
 		return 0;
@@ -145,9 +141,10 @@ static int current_check_access_socket(struct socket *const sock,
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

