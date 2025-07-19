Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376661C84BD
	for <linux-security-module@vger.kernel.org>; Sat, 19 Jul 2025 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752921735; cv=none; b=lIflIxLSaBC00kD4WKsrak/GnUEE/B4ULqrqzdkGFE68/nptMZKgHR9KSVgF2ZPxNXuzH53IkQ+5L2RACrep02uWDUaPaqtLpHkC/YKGGo4BB31SWOdPBDHovn4vEJmOz1yfBvlNcTaHmpexDChUNkV8NMp7TTYrLS9iZlMMt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752921735; c=relaxed/simple;
	bh=wRToebOgD2Bcn86y6mE+jFiOMl5OVz4jY+xI67fswZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1tZMeTElzI36uQ1HlFe33Ozm3HAB+NosjmpvhMurxJTlXTiFMNdLU+cPLIMwxrSroDNMFVguRfz9QEfOQLndWO1odJ1ArPImAy7/0Qxg2HkYLZEnLcoYfKYUc+ddYaFkTUQKXI5AaoEK1Sh0ZtEvPuJ8f/JtDZ2mF9CE+lQmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nDX41oT9; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nDX41oT9"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bkjsF25f9zbwj;
	Sat, 19 Jul 2025 12:42:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752921729;
	bh=UZjiRjH49PYgy3qE+zlhOgQ/NjKjfYpX267/9XpQles=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDX41oT9eMWV/Ukc3xq/OL+Gf+xGZCHW2wj+/yIb7k7AWMjCtwfqIZYrFHht6H65t
	 J296jPBuRXEPGYhdZk6gl/juz6CniRSNKyfJdL+gvbEZqlmjKvWrwj5xTKF0Y3jDmz
	 qWwsnE23+JrSgA3CYRTwJ96oGARhdTo2m8BwN4Bs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bkjsD1RQczbgx;
	Sat, 19 Jul 2025 12:42:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	NeilBrown <neil@brown.name>,
	Paul Moore <paul@paul-moore.com>,
	Ryan Sullivan <rysulliv@redhat.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: [PATCH v3 1/4] landlock: Fix cosmetic change
Date: Sat, 19 Jul 2025 12:42:00 +0200
Message-ID: <20250719104204.545188-2-mic@digikod.net>
In-Reply-To: <20250719104204.545188-1-mic@digikod.net>
References: <20250719104204.545188-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This line removal should not be there and it makes it more difficult to
backport the following patch.

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Fixes: 7a11275c3787 ("landlock: Refactor layer helpers")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- New patch.
---
 security/landlock/fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..c04f8879ad03 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -895,6 +895,7 @@ static bool is_access_to_paths_allowed(
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
 			break;
+
 jump_up:
 		if (walker_path.dentry == walker_path.mnt->mnt_root) {
 			if (follow_up(&walker_path)) {
-- 
2.50.1

