Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE034FF45;
	Tue, 15 Sep 2026 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503043; cv=none; b=rP4suOsaLVAfIuBomjyaiD75dC/mybNHjm7UQpPhsM/JXGhgXopO1AKKldahHw1btB7/Z0LYtgHucpU8Mpep7Y/hfHezPUMCdx/G7ZEjJFkIZQh339s2EAeuT10QVT79KqqBjSSB6ZxjAj+lyhbyXJy+qYxamHzR87xN8Spg3yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503043; c=relaxed/simple;
	bh=6XYkumIhHEIyNZ2u1bT13wM/863vuIbXI2ZE8MHjCkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BF7kH3b3tAKoHi4JIXyqUVoYVGTsZSdSURiVagJI6Z8K4z5b1rLiWjriEua8M4Tgc6XlPTXnYa9gxqjlT8pDQFqpOdzo2Nurr0tOJMRxp+YO9DZVu9j/eaf9qbSmg52ChnlQDAL5tb44DXC/R90Qfs2a+0QY5G8h39QFVEikfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kko+GjaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kko+GjaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FB51F000FF;
	Tue, 15 Sep 2026 20:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789503042;
	bh=UwYxnLuySY+xicIABJVAisL4S5E1oHsvqVA0Vf18rAE=;
	h=From:To:Cc:Subject:Date;
	b=kko+GjaWcok3kceRrsfw785GR5hSBgmyFyN7ffjRIQG+KlUtvtIGHJzmYEYXsCTYa
	 +2E2Co4AkM8YcIMF8mkCYu3Ch6F3kQwG+6GfLkTe789tMA+y1l6UEp750GxiF4KQTX
	 TNcI9piOPwl1fn8EeCIMFc8RQ+z8q/I2uFFK/Z18aRWBLoJHO1ika7/uuK6SNkdDWi
	 6qAlIyYs7FuRIgQTkanZoY7GghfbtQojzhPkdZbshMn6bdfJwL3wgZ4uwHS/cyutBk
	 fUx4hlOIeFZtxmd7cVXn3qcy4/opaZl27OLTXTdZxhlYLIxR7IlZzQL1IlHMpVRPme
	 7fP7yheT/QLqw==
From: Arnd Bergmann <arnd@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] landlock: work around gcc-16 -Wuninitialized warning
Date: Tue, 15 Sep 2026 22:10:30 +0200
Message-ID: <20260915201036.3527935-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
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
Link: https://lore.kernel.org/all/20260619082133.3504146-1-arnd@kernel.org/
Fixes: a260c0055665 ("landlock: Add a place for flags to layer rules")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rebased to linux-next-20260914

I originally sent this in June, but got no reply and this still
happens with gcc-16.2, which is the latest stable release.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/landlock/access.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index bbbb41f41147..f41ac3fc6476 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -81,6 +81,9 @@ struct layer_mask {
 	 */
 	access_mask_t quiet : 1;
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+	access_mask_t __pad : ((sizeof(access_mask_t) * 8) -
+				LANDLOCK_NUM_ACCESS_MAX -
+				IS_ENABLED(CONFIG_SECURITY_LANDLOCK_LOG));
 } __packed __aligned(sizeof(access_mask_t));
 
 /*
-- 
2.53.0

