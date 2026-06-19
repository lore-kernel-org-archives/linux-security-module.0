Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF9330666;
	Fri, 19 Jun 2026 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857300; cv=none; b=nTy0tAP+kCXOhcL2GX3siQnRssKAeBk9UaOXVt+DB2gMKmfnNQITDaYwX/EcnIVGd+ETQURe9rGqU7vLUjiELgRJvcYj3Zi2un12eQv6Dycdmu+qkHQk0vyZgOhIN/UA3jwfS4KQnfBeRAMnFj+ieOrXW4E7ZQ2GXj1Hrn51Wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857300; c=relaxed/simple;
	bh=yEZXnBOygzZTsO1oEezaEArAu1JeL5GVJEjxFMQkoek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fb04ynHLxrpqUtMQBslTXIYJdUVuqwiHSnFzVudvBMMr0wbJX2ORO7y1SfO65eEMLG1XPfjtQyShdOQ+XWTAAovw3Gqp6f/XvbOre3dHe1QRwtvuXRfmDKPtGO8bYtXNTIUI0z2zWaEczil8Q+wXp96ZfEDEGmUmhfnAcL8M7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzdX0WKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzdX0WKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C741E1F000E9;
	Fri, 19 Jun 2026 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781857298;
	bh=YfPbTOrWv05eX0Y9Fi5QOnH9uKkPpun6iMLTsu4OXGU=;
	h=From:To:Cc:Subject:Date;
	b=JzdX0WKNvKRQbZcSpLVbs+h7M/Kv9ylVyovVo3QRJOs7JKRaRL2P4CYFsNIDpBZp5
	 wVn1Zuud6fq1yKa9mP7Z/ui0WUVWh/h94maUf2Mre8AC/qXyokp70np0AT0yPNrcGu
	 X5KIyiwI7RP6HlC17TRc4qxYtI2thl1RuvoHH/qzVpJ7x3yublFOpMdRggKqgeCtHI
	 hKSBW7A16QSqrFxhzc07vBoDg9vZmfVCp2h6GKMt4cJti6A6NtAwy0xPn53re5921C
	 n9cf+RxNDa0gEvH6+VgX+1GI6UPM+7a9ork6fQwVpmDHgBkVpEkhFJFfQbjle3EA+p
	 OY9xPHnZPWv0A==
From: Arnd Bergmann <arnd@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] landlock: work around gcc-16 -Wuninitialized warning
Date: Fri, 19 Jun 2026 10:21:14 +0200
Message-Id: <20260619082133.3504146-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc has a bug with -ftrivial-auto-var-init=pattern that produces a
warning for correct code that uses sparse bitfields:

security/landlock/fs.c: In function 'is_access_to_paths_allowed.isra':
security/landlock/fs.c:767:28: error: '_layer_masks_child1' is used uninitialized [-Werror=uninitialized]
  767 |         struct layer_masks _layer_masks_child1, _layer_masks_child2;
      |                            ^~~~~~~~~~~~~~~~~~~
security/landlock/fs.c:767:28: note: '_layer_masks_child1' declared here
  767 |         struct layer_masks _layer_masks_child1, _layer_masks_child2;
      |                            ^~~~~~~~~~~~~~~~~~~
security/landlock/fs.c: In function 'hook_unix_find':
security/landlock/fs.c:1649:28: error: 'layer_masks' is used uninitialized [-Werror=uninitialized]
 1649 |         struct layer_masks layer_masks;
      |                            ^~~~~~~~~~~
security/landlock/fs.c:1649:28: note: 'layer_masks' declared here
 1649 |         struct layer_masks layer_masks;
      |                            ^~~~~~~~~~~

To work around this, change the definition of struct layer_mask to
use an explictit padding field. This also avoids the extra attributes
for aligning the structure.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110743
Fixes: a260c0055665 ("landlock: Add a place for flags to layer rules")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/landlock/access.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index d926078bf0a5..89ab9fbcebe4 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -81,7 +81,10 @@ struct layer_mask {
 	 */
 	access_mask_t quiet : 1;
 #endif /* CONFIG_AUDIT */
-} __packed __aligned(sizeof(access_mask_t));
+	access_mask_t __pad : ((sizeof(access_mask_t) * 8) -
+				LANDLOCK_NUM_ACCESS_MAX -
+				IS_ENABLED(CONFIG_AUDIT));
+};
 
 /*
  * Make sure that we don't increase the size of struct layer_mask when storing
-- 
2.39.5

