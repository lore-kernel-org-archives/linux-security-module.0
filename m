Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0E46B8
	for <linux-security-module@vger.kernel.org>; Sat,  3 May 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746257380; cv=none; b=PKq9uLGQmaxXYu8baTQ0GW6HdMhaChQ1S7xFppqcQaDw55Hskrtcj2Pa3sXMMa1QjD+Wd6aMxUhZF3iJbhPO6o6oDvxQPeWM7ND0NK/+1dlmcRLSydvkubBG/imMY2nMlbM+x2LBYxZQNO6yXLzZ5lGNPR8w4LlNA8BBwI+8Mjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746257380; c=relaxed/simple;
	bh=oXLwX4lJb903Mk+1fuvLt50uPVxc/EonvBjxYpAeovM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ppGgEPZPdY1PRG9yoMSKY2KLSmjtFxe1UDKZXB7JujDmLWRPgacVsZorVBCSjWeon2SXkHrQJZcjkHLqY/o0BKTLtcoYf8HdSGsKIGD0ILD8AZK7ajYblmGbRLg61w3v9ZKtWUGI9088pdP0L0wCWrfAd9Z3TkiFy7Li6+rxDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1vpW8WNk; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1vpW8WNk"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZqJRY6hmRzcR3;
	Sat,  3 May 2025 08:54:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746255241;
	bh=clEd5/KA6zdrhFJ6zP9whsmyvWx+HEI6XfTZ9vIbZ1Q=;
	h=From:To:Cc:Subject:Date:From;
	b=1vpW8WNko8H11llSfVq4D0Mlwcr8DnP3YUYRP7/McjZA4VXc0Kb249YXDXdKVxmhQ
	 RWYR3+sMujQ2+m6KdA/yQTeRrbsmJrHZ5+xLm3bIKF2BCPK0g79B7G7B+EJrPI5AVL
	 xWCy2vwIv+coyqZQwDll9ceQSRRT2Gt5TYeVRJGc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZqJRY1XGSzTML;
	Sat,  3 May 2025 08:54:01 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Alessandro Carminati <acarmina@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v1] landlock: Remove KUnit test that triggers a warning
Date: Sat,  3 May 2025 08:53:58 +0200
Message-ID: <20250503065359.3625407-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

A KUnit test checking boundaries triggers a canary warning, which may be
disturbing.  Let's remove this test for now.  Hopefully, KUnit will soon
get support for suppressing warning backtraces [1].

Cc: Alessandro Carminati <acarmina@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Günther Noack <gnoack@google.com>
Reported-by: Tingmao Wang <m@maowtm.org>
Closes: https://lore.kernel.org/r/20250327213807.12964-1-m@maowtm.org
Link: https://lore.kernel.org/r/20250425193249.78b45d2589575c15f483c3d8@linux-foundation.org [1]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 7e5e0ed0e4e5..58d5c40d4d0e 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -175,7 +175,7 @@ static void test_get_hierarchy(struct kunit *const test)
 	KUNIT_EXPECT_EQ(test, 10, get_hierarchy(&dom2, 0)->id);
 	KUNIT_EXPECT_EQ(test, 20, get_hierarchy(&dom2, 1)->id);
 	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, 2)->id);
-	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, -1)->id);
+	/* KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, -1)->id); */
 }
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
-- 
2.49.0

