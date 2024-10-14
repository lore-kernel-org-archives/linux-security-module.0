Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DC1AA7B9
	for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910135; cv=none; b=jKpyDQBhGmCsBHM/TRQamDL/ot+gs+7nK6LgiJKOo3EIWjtzci5pn3Tyo0EgkQJmzTbGYkjrH72mNruHHDa1lszWywentM4lkdZeJIx3O0No7Oh5B5JnaY1CE4k1KKtYcVw8OLd2SFZLfLNXvWej+6/28VnT0W+m2crtPt5tX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910135; c=relaxed/simple;
	bh=u+Frg8K6dfoEQO/pJOtxl1TEyBhn/WOcmEL2VttDlNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Btju3u1zcLwYzEqDYWOBSvryszEYZ6ihUE1VYS/kR3Ys4uIjfvLyqWVt5ATJnLR4WHoyRaJKGwScKPK6ExhRnlJauJFQN5hkl68cFPgedzIpOWwCv/10fxDD3wZSiVduGGf3h3U6zpveFtM9Gb+SBHvx2kXcPtx9e3Am09U6BoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=X5EW+cpF; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="X5EW+cpF"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRxqc2zSLz110;
	Mon, 14 Oct 2024 14:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728910124;
	bh=c1uqC+Kh4xD6yGA0+mYQyWZVTBTYgQOzGdoFdJKZEdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5EW+cpFBchBKXn1BQNPgP0v99NIYuvQgQJujWlDz6u2IGoFcHSlf1Ja3k+mhaMRy
	 aS0aQZr9T39BZC/HHM2Kq0eQusR9hu/dqXDQCjtvjxnToV0aux1ZQmhnc/87g5uFVb
	 QT5h/VgsrFDNyFCTZdHOX6h/UTMCTj0o7ap9ZQnc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRxqb5ntNzBPj;
	Mon, 14 Oct 2024 14:48:43 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/3] landlock: Refactor network access mask management
Date: Mon, 14 Oct 2024 14:48:34 +0200
Message-ID: <20241014124835.1152246-3-mic@digikod.net>
In-Reply-To: <20241014124835.1152246-1-mic@digikod.net>
References: <20241014124835.1152246-1-mic@digikod.net>
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
landlock_match_ruleset().

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241014124835.1152246-3-mic@digikod.net
---

Changes since v1:
* Rename the all_net mask to any_net.
---
 security/landlock/net.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index c8bcd29bde09..fdc1bb0a9c5d 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -39,26 +39,13 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
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
+	const union access_masks any_net = {
+		.net = ~0,
+	};
 
-	return dom;
+	return landlock_match_ruleset(landlock_get_current_domain(), any_net);
 }
 
 static int current_check_access_socket(struct socket *const sock,
-- 
2.47.0

