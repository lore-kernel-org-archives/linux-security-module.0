Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A82282880
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804391; cv=none; b=ozXQfTQBBJLd7Bm7bINq3R6L54DpX7T4oxAuAeIjgxb5aDF+e5T+irv7lMz5xWzQjFzwoln7tCO1n1tm9+N1Y0omOhKes69W4kllfWXmvy6UyBqL6KXmnVfRpl8U2g7zgeQGHgxYAVPWRv/swlzg+SMWy8iw4KxbeQVsVVWQI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804391; c=relaxed/simple;
	bh=jw8uTCF83h4SFGpVfkkE0QZ+LL/OBW6abrCDpV0C0og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f9d6yvGBcihvB+Kr/rQGlSut62+jceyK3ggc6d3qIf/itpbNKrt/7qDEFYXYXdkpxQUPIAWd2Z0+B+k8nwImHdoZCGuanxhhokD/nONzN74IRDWHlYF4Fw8TxIWtxFERUptJqWDWXvSzjoXthc100uQobZZVvk4gtD98vxSI0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wLwZKtz9; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wLwZKtz9"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tr45Q2l9kzMqT72;
	Thu,  7 Mar 2024 10:39:38 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tr45P3Pc8zMppN4;
	Thu,  7 Mar 2024 10:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709804378;
	bh=jw8uTCF83h4SFGpVfkkE0QZ+LL/OBW6abrCDpV0C0og=;
	h=From:To:Cc:Subject:Date:From;
	b=wLwZKtz9hpaEsOwvB/VuLmZPPyfizfrLdHPyroJeoeq6HDMIh7yxoVrq6H533RMvv
	 Et0sCaT7I87QSx5nLU4izGlc/I75YnL4rEj7ybvyEKIDHaGn7sRuMKblPYWJdW/t4U
	 Ww5wimCjn7s/BVZLGgg2pNELbqtgqcQzcrj0pJYY=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] landlock: Simplify current_check_access_socket()
Date: Thu,  7 Mar 2024 10:39:22 +0100
Message-ID: <20240307093923.1466071-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Remove the handled_access variable in current_check_access_socket() and
update access_request instead.  One up-to-date variable avoids picking
the wrong one.

Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/net.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index efa1b644a4af..c8bcd29bde09 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -64,12 +64,11 @@ static const struct landlock_ruleset *get_current_net_domain(void)
 static int current_check_access_socket(struct socket *const sock,
 				       struct sockaddr *const address,
 				       const int addrlen,
-				       const access_mask_t access_request)
+				       access_mask_t access_request)
 {
 	__be16 port;
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
 	const struct landlock_rule *rule;
-	access_mask_t handled_access;
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
@@ -164,9 +163,9 @@ static int current_check_access_socket(struct socket *const sock,
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
 	rule = landlock_find_rule(dom, id);
-	handled_access = landlock_init_layer_masks(
+	access_request = landlock_init_layer_masks(
 		dom, access_request, &layer_masks, LANDLOCK_KEY_NET_PORT);
-	if (landlock_unmask_layers(rule, handled_access, &layer_masks,
+	if (landlock_unmask_layers(rule, access_request, &layer_masks,
 				   ARRAY_SIZE(layer_masks)))
 		return 0;
 
-- 
2.44.0

