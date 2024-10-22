Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE7413D899
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611014; cv=none; b=QSutJ0S2ZZXHZQePRIbhJY6m8gk7SUc9eC6DGlBw0xecQmtGeuk/iQmj17LhF6dUthb6sDRtWPYul2lQtfyhXBAIB4duSxHGNk3Kd8qdpAObPJ06Pwy9WIBkhmw2fY/M549MhAVqyQpF4CLQoHebYCP8yCjSeQoNNxuNTtyW2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611014; c=relaxed/simple;
	bh=0Dc1m+lG6pycl27Az+47ItWqMS5cOYe8AJIqFm9UKyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcOLoWX6ddC4WPkidaFUCgQZ+4JWCZO/cmAIyMf5+CrkqP+VBwfydNnAFa1qbsat6BBp2CgV2B+w453qLdhkJaxMvkGNwbDuTgMtP1nVLIBdG2Me2m7I+Wn9i8j28buc/tUV47oSf1kogwoLreY40QQagltuvsku/WRGBTCeUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eR9ump77; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eR9ump77"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXwd52VLVz15Ph;
	Tue, 22 Oct 2024 17:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729609913;
	bh=y9J7tS7x7YCy77ZIH7z7Duwn/bj6/ALGZPPWFsPleYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eR9ump7781eZOwy980RXwTbplweu32EBZktMTpXKSIHUs9CWxT8KrLe/0WsLL/Ue2
	 5KWYu/i4ASbIE6D+MMt+6zwmh8EOZcOemD9op1GfpAdCGIvlZwoJvBvRH09MeoslNH
	 /eJXE2Ul4sv4hbwDruDtKerneOYXQv1V30biVuFI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXwd46Ytpzjdq;
	Tue, 22 Oct 2024 17:11:52 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 2/3] landlock: Refactor network access mask management
Date: Tue, 22 Oct 2024 17:11:43 +0200
Message-ID: <20241022151144.872797-3-mic@digikod.net>
In-Reply-To: <20241022151144.872797-1-mic@digikod.net>
References: <20241022151144.872797-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Replace get_raw_handled_net_accesses() and get_current_net_domain() with
a call to landlock_match_ruleset().

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022151144.872797-3-mic@digikod.net
---

Changes since v2:
* Replace get_current_net_domain() with explicit call to
  landlock_match_ruleset().

Changes since v1:
* Rename the all_net mask to any_net.
---
 security/landlock/net.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index c8bcd29bde09..27872d0f7e11 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -39,27 +39,9 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
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
-static const struct landlock_ruleset *get_current_net_domain(void)
-{
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
-
-	if (!dom || !get_raw_handled_net_accesses(dom))
-		return NULL;
-
-	return dom;
-}
+static const struct access_masks any_net = {
+	.net = ~0,
+};
 
 static int current_check_access_socket(struct socket *const sock,
 				       struct sockaddr *const address,
@@ -72,7 +54,8 @@ static int current_check_access_socket(struct socket *const sock,
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
-	const struct landlock_ruleset *const dom = get_current_net_domain();
+	const struct landlock_ruleset *const dom =
+		landlock_match_ruleset(landlock_get_current_domain(), any_net);
 
 	if (!dom)
 		return 0;
-- 
2.47.0

