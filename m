Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1832EBB98
	for <linux-security-module@vger.kernel.org>; Wed, 18 Jun 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256728; cv=none; b=e/1xybNfVu/OQjWU3SdwQcuiYyFK9aepN03hjYjhfeJW1fT+zrkjAk+jmMowdY3iPYgjewUKjLxAq1DtI9YYqhn7uLUqiaY0y8bknTexkfo+XO6tZbznujcrRBgkQJ7NsQ/xS0Pe+PP59EYnfBRoK43AH6Nr5Arwq5NfkSG/os0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256728; c=relaxed/simple;
	bh=qsO9QEFv3X0E/kp4/O7W+bMyzbB9P5rAiR48dsfwYRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BquwV3A5YRL5AcKAsIwcmlF4W19h44hOHX0fnuKZLIcEXIepYGZLssDYjd5StdCDIUdFZ05ga9N3LJrqZMK/bRffJFyjUA6kADNMlmBBy/0D1BUiohseHjl8FBHhN6BKECircohq36QTsfgFrg5Zxh/bCAIisKqe4UHrtseBZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XAfRjLUZ; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XAfRjLUZ"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bMlRc4MPKzPCy;
	Wed, 18 Jun 2025 15:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750254460;
	bh=Bo8pMzboHVWjN/JAI0mC7sxdBEHdw0gPvbb+H1ENCe4=;
	h=From:To:Cc:Subject:Date:From;
	b=XAfRjLUZeE2Es1fN7Wjw3izR5b1cl2AYm15Xmn4UExhMLVipTEkGKdLwdVbd19sss
	 lIy/h+FWEtaGaeiBf1ig/e9/LKYv1q/Z0PAN1oiNAH+BBmXfNj75kg9PnnLkKjlF1u
	 rJ5qnJSrDSKagDuKFUMjY0fa7rsDc8FSTyW1nxY8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bMlRc05xtzX9N;
	Wed, 18 Jun 2025 15:47:39 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v1] landlock: Remove warning in collect_domain_accesses()
Date: Wed, 18 Jun 2025 15:47:31 +0200
Message-ID: <20250618134734.1673254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

As in is_access_to_paths_allowed(), it is also possible to reach
disconnected root directories in collect_domain_accesses().

Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
fix comment.  Using an unlikely() annotation doesn't seem appropriate
here.  A following patch from Tingmao tests this case [1].

Cc: Günther Noack <gnoack@google.com>
Reported-by: Tingmao Wang <m@maowtm.org>
Link: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org [1]
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..1d6c4e728f92 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1061,8 +1061,8 @@ static bool collect_domain_accesses(
 			break;
 		}
 
-		/* We should not reach a root other than @mnt_root. */
-		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
+		/* Stops at the mount point or disconnected root directories. */
+		if (dir == mnt_root || IS_ROOT(dir))
 			break;
 
 		parent_dentry = dget_parent(dir);
-- 
2.49.0

