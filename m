Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4D1CB318
	for <linux-security-module@vger.kernel.org>; Tue,  1 Oct 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792376; cv=none; b=C5MsWWM+a2aPm6nRhRbBd2xW1BZoZCz3snnDOUdyFABh0OLHJAPcikA92lB7Cjv8cDeywSon0NIY45gzeEyCkE30DENSf4C1jlVjWIFELmYVIVz7fI+d3HOeC/BsZRvc0VLvJItSgqRpc5xM3NDW5IogQ6sXUAxaW1stm/CGyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792376; c=relaxed/simple;
	bh=uHbKwYqqKXkPA7jjIXOCVVcyiqToNnGB+5UWWhQeVxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPj60eEZglfazcNLMAnf4x1eXkEJQ2QcMmKS9QmD/Nv1cnWGDcm3VIhbPJ6HLYWMt2XOYxLGxJR+XG6Kcwyw9ieOC/ZUze6HJPFes2hyTS0ib9E+cdcaNtQ4QmBP0anQIyBETq+HLi/J/WhA11YznBJ5tzv5jKZJXu8p6KVHta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZBVof4Aq; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZBVof4Aq"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XJ0JX6JdMz2k5;
	Tue,  1 Oct 2024 16:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1727791964;
	bh=IrIkK2fNdyjcGD+ubjmwgC6LWOg8OIHYVEbiJtZfSdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBVof4AqrKjLYk/G4KB1HLHx0G8ysiz5pht95WrAbpWEK9z3wQYcU1MNW+v7Yvx2g
	 YELL5lLgaHISI20jaQTdTl7Jr0Ef3vZ80XPaNbI9tkGplrFV+7R8a163FJMqLF7/65
	 nw9TMKm1KIyrnM8R06rtE7KSpiNCUCmI3UETqqVA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XJ0JX0xz6zZDn;
	Tue,  1 Oct 2024 16:12:44 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/3] landlock: Refactor network access mask management
Date: Tue,  1 Oct 2024 16:12:33 +0200
Message-ID: <20241001141234.397649-3-mic@digikod.net>
In-Reply-To: <20241001141234.397649-1-mic@digikod.net>
References: <20241001141234.397649-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Replace the get_raw_handled_net_accesses() implementation with a call to
landlock_filter_access_masks().

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241001141234.397649-3-mic@digikod.net
---
 security/landlock/net.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index c8bcd29bde09..bc3d943a7118 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -39,26 +39,14 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	return err;
 }
 
-static access_mask_t
-get_raw_handled_net_accesses(const struct landlock_ruleset *const domain)
-{
-	access_mask_t access_dom = 0;
-	size_t layer_level;
-
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
-		access_dom |= landlock_get_net_access_mask(domain, layer_level);
-	return access_dom;
-}
-
 static const struct landlock_ruleset *get_current_net_domain(void)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
-
-	if (!dom || !get_raw_handled_net_accesses(dom))
-		return NULL;
+	const union access_masks all_net = {
+		.net = ~0,
+	};
 
-	return dom;
+	return landlock_filter_access_masks(landlock_get_current_domain(),
+					    all_net);
 }
 
 static int current_check_access_socket(struct socket *const sock,
-- 
2.46.1

