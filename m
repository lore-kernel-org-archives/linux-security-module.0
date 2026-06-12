Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E072C3255
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228960; cv=none; b=kyRuic6ui/4/kd+cqgd0dZQ/N1jvkTImYOQcrI40UNjgU1kZDFrlF9OMsjwFvexhuSqIKG2T9+96GZ962XiwjlP/QNTKN9S8o1reIu0RL6Qp2kDb2TxL0MdMIYzX+szMOaKwVz41C/m9Ni9bYJcgycMdItgvYTehHrSq/TEjjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228960; c=relaxed/simple;
	bh=7xsrfzKRGdO+rhyAUhEWe9iKMYQ5raV8L8BZN2OuIaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRF3hau5C2+o+HknT6W2CHWvNL8G4u5Y6mHxMcJKfF+tvRmUVoGWXeu+pHuxBJBnECitInNaBMojU2pxB2IyXmusHayuPYwdAXOMBdkn3vCHjPEde0lIkaNtn25jGBO1YZMZlV6U3/SEhi5yihV0852/wYHqRwtKb1BEm+DCmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hhE4Y1Fk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bRLXTX+Y; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hhE4Y1Fk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bRLXTX+Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECAED7A00F6;
	Thu, 11 Jun 2026 21:49:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 21:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781228957; x=
	1781315357; bh=joYU0zsdtBQwtwDwsiIHjqp9S4Gtq4ZTJB4E6RCOJd8=; b=h
	hE4Y1Fkbw7pVUuZPuBReE7kfS8h908qn/Rdh6S89wVcwchMPaORMSeJziOxaacDF
	Fo027DGevSl5LU2HSvEHaz+OgENfSyGLwhCzISuicfxJsD3o+qiAZePnIsjXccKh
	W4bIau76k0G2R88UZAfJOPkqWpnzU43lXPRVFRNkW2g1+wbw9SNt2Ei8kci8Fj9X
	kf8/fcCgn1WQ6VX3wWlPaHaznFz0aUK0ZvmGN0Wqzduy1eJlAZtQdWu+hgrpCLYv
	P7+J7SUNzYPXQI4L+WyWIc8PpzK4OWeqo/ENSIOi9fzt2lQQknsqyRLkOfY7toiN
	JTMlr5HvkRs6Vb26e08Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781228957; x=1781315357; bh=j
	oYU0zsdtBQwtwDwsiIHjqp9S4Gtq4ZTJB4E6RCOJd8=; b=bRLXTX+YtHlcqukSD
	zRF7s5pQMgcmlBPmmz8NjLzgM4nS+Bl/APBiqZfzKqOvgb8xW0swExXeXf8/leVl
	FI2bEwA9GdVDqW0V340pobee8TytEqEoyD2f5DL92qHMEDoqCUA13jSFKGZNFq8M
	kc39OdtfnDd7J7fGPxp0qUOtSPXm6Qf64nQL3sfKJ2nrVXbn2BNlJZVMYvKmNqH0
	N/hwYwcmh+U85JjHlie5H/p5+LNp+AdPiGGiDHFrsjsAHxvfT3a/oMjpjbD+FoAP
	wRO5apmVAHoztt4/CzpwBx7wY+KTc4SrHnHmZbDVa0lHCiMnbmPSzYdieFpD45Zz
	iB7OA==
X-ME-Sender: <xms:nWUraqPWH5EFj-III-FS9lyk5eeN3V6GaeIZdB-mRQqZI9N6Ykhe3w>
    <xme:nWUrarPZdpzcTeSWbh68BKZQjQ-WLEjiMiJzD_xszntzi4RFaQN4mfufaiYWO8Qr_
    0op9O9mWNa2q9799nakhsF6DQj7Lq5zo1ouwyq9IhWQBG1PeWaEIX0>
X-ME-Received: <xmr:nWUrajhfeTwuuGY8S9WaqTflDIN88YqWtuchaEhgdHZF3itv9xurkBTYzBWeZL4st1-Dp7J_6kFvEs0MpkYmeChPWcfB_Fb56ctEGzC6Ay730ZndmYb68nA14Oo>
X-ME-Proxy-Cause: dmFkZTErrYj+6BPPVz1/IV8jcji/YbJf7tNmbzKUklDVBw37Mo5r82nPd5buxFHV4OrxKd
    +00SDQV9sSVg4R4yvs2QLHos0drG5qYNr6GNhg9D8ngYxfJUcCtRRhPXhE6kz5yGXnYKMY
    oJHiB0gAaPzyeGZH5d5BTyheBut4xCTujqDHaTful/fQaUhKYSKVr/XYUjihn5pTjMkS8X
    sKVE+fTH1iGH2FWO/9EBeuJFKXH3xovFqufQzUi7llGvIp9TU54IXL348v2qQAgPhg5ZW1
    SUBEtCpHKVb2aYxBd3Ta7zLOiViueqFsE4VHkel083qbKxQFVcQ42U+V55ljlncHcKp7X9
    Dd36Fd1JlOEAoQOGEuRJcXpulliW68O7hgXkMqj4h8TDp4cHpxw92dPB2b99M0FQuF4E58
    zFmFKtQLQOx5Q1xBBIqEZ5Yh7nTPLfkRrR6ub85nFSXN8ngRSQcs/qk4dmtErX/2AbdlnW
    khsbkINIGE+EKVlBN/qeVLheqNg5xo6bi4kTvQ+9LTB6mc4zdBJe0xBaVQGX7sHKpDPEyN
    R2/+pzWDQNc9hg0VfjfFvMmj65XwzzAM5aNSB763oL2yxsh3a3wTbzU7J4tg5A3U6E9YBq
    UM0oEZuDJlRfgPYlvEd4ruAuC7y1Sz+d30rdg7LH3s33xiUyGMkEM3p/EgJA
X-ME-Proxy: <xmx:nWUragtJibHZtyYfaameMWrMqrQ5HA4B0TT21yTNAki_XCqu7rpLZw>
    <xmx:nWUrahTQ7BbpxyhyJnokl9btiXhLMUg_OKfBClrZ7RT-vsFjGHNDRg>
    <xmx:nWUrak3wgwKRPu8gsJ1w84-EP8wXZHMX1pucmUcQ8MLbpFIKmBbflg>
    <xmx:nWUramva6FyhX9_NONxqG5bhCE6Wo6hDdSM8FUn8r9_9a05Iio27vg>
    <xmx:nWUrakbam6wvLtpIdbeBWgOuf81MB2L4BCrBoKIxoqft9YufHlG_hAHN>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:49:16 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v11 5/9] selftests/landlock: Replace hard-coded 16 with a constant
Date: Fri, 12 Jun 2026 02:48:51 +0100
Message-ID: <eff35caa9b4ac51aa83a88d67c4dd67f4f8b3a4a.1781228815.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781228815.git.m@maowtm.org>
References: <cover.1781228815.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will reuse this number.  Make it a shared constant to
future-proof changes.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v3:
- New patch

 tools/testing/selftests/landlock/audit_test.c | 2 +-
 tools/testing/selftests/landlock/common.h     | 2 ++
 tools/testing/selftests/landlock/fs_test.c    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 376931511629..d55fe4c5b531 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -79,7 +79,7 @@ TEST_F(audit, layers)
 		.scoped = LANDLOCK_SCOPE_SIGNAL,
 	};
 	int status, ruleset_fd, i;
-	__u64(*domain_stack)[16];
+	__u64(*domain_stack)[LANDLOCK_MAX_NUM_LAYERS];
 	__u64 prev_dom = 3;
 	pid_t child;
 
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 90551650299c..7206d5105d66 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -25,6 +25,8 @@
 /* TEST_F_FORK() should not be used for new tests. */
 #define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
 
+#define LANDLOCK_MAX_NUM_LAYERS 16
+
 static const char bin_sandbox_and_launch[] = "./sandbox-and-launch";
 static const char bin_wait_pipe[] = "./wait-pipe";
 static const char bin_wait_pipe_sandbox[] = "./wait-pipe-sandbox";
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cdb47fc1fc0a..10d9355ade5f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1441,7 +1441,7 @@ TEST_F_FORK(layout0, max_layers)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
 		enforce_ruleset(_metadata, ruleset_fd);
 
 	for (i = 0; i < 2; i++) {
-- 
2.54.0
