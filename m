Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6126F2A0
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843697; cv=none; b=gXc4otYtTmQ66bQPVWq63ZlhSfuSR4Qsxt29WnDaq6kl9Y3LMMzgYVp4K3gX0cKqoUS3wZVbQ+rncGw+xiExfmrAoFNo5BXkWer0FgIg8/H651CTiVGCQB5klYjFmMAm/jGA+WzgPu+cbvOeAqiNWIxN+BuoG9xZ1Vc4Q7HTZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843697; c=relaxed/simple;
	bh=cUhv65Nn1WWcYgngADsl6N9ARMwd14CNSvmcI0iRDpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXyw+5m0oQqST9/OV0ubzwBds2Z0OvkklcbrST4cjjaDj6LelcqOBfoJcESNYsPPCqLihb4vHF6HmG6bUsH3M0i1A04zO9ealnFohDpk4upEAISd5yqbz9QuOPBqXWVpYcm/GqvCHkx3rpxBqWQWYHcuvXvaxR0qaZArgpy31YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=mTjHprDG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fjx2OO/r; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="mTjHprDG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjx2OO/r"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BBB9140005E;
	Tue, 26 May 2026 21:01:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 26 May 2026 21:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779843695; x=
	1779930095; bh=b13pEkIfIiiSJ6xPQK2ZRzTYTz5AXB6jDcLQcP8HpD0=; b=m
	TjHprDGE4Ty5mTXFuvKXeOiiaNjIs2coVVQSFGVpS0peXpIRBaRsXG/SVRkvHnq9
	oFUtwBPXjlBhqtCp4m09SZm45WdjE+kdwhvcI5kM7GVE/gqmaw7SHaxVs/bfc56h
	2382e3oBcaZxM3PsGEoD7uJzh1fj5uDGNjMmUJluRTdXdRkV5wVMFSRW3le3r9qV
	gQg4qE/S5xwD7CbO9oysnm5mDqSmcv0P4bw8i03IRbex1/0dCJ3sVZ+udE8CurVk
	OpsFyHoEx6xAF3Iy1AskuWqFC31fj3KHQjw6cPlhs8WMJlmJOE5iknhhIgG56NPp
	ShLtErX3N0VeTg2//7iGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779843695; x=1779930095; bh=b
	13pEkIfIiiSJ6xPQK2ZRzTYTz5AXB6jDcLQcP8HpD0=; b=fjx2OO/rDdNQk3Uqs
	OG3PHMqx8mD2Ac17vT2DY6NyEYcL1tTd9PcE0Gwp16ScVAR1r5E9QEn8ACmAE1N+
	PPJ5RL+GMTlleXjscl24aocLy94s4JOhSKBp/8Xh4xT7z0YMDJ0T3H54Ec0PYODn
	u+srdCdFco8SYFA/3D6w/rfqkkcLzuUaknHa/58YMxRH11BrxH3dEVArOtfEx9uE
	AUEmhkXozqqTB23W32hywKmBaxCdKD6E1kLcoBcXNYowc3cbdRVN/PrEPPr097Q1
	s45Spnxs4EUZmWc5AIcOOauZUt2f9qaI2p0HL3TU42Y5Ea/Mi1vsbnc0kT5BpQIy
	rCdfw==
X-ME-Sender: <xms:b0IWaufCuwFYk6zLMneWY2owtIDVUEY_1SXwwMzZ7XgrlYsCLSFc-w>
    <xme:b0IWaqeKz2tRNvuRlN0QWv42Tnef3rf_RKB1fXySSrSIy-MIN5OUIPFx0jXhkJ6w6
    9knDXpv73F2Zj3RmP8CzlrCXX3W0ykQxzgUQ-fAqdWH73fR2f4QS2A>
X-ME-Received: <xmr:b0IWahzvJ-1Xy8v94R7QZqzQgqF7ZtU_CqMVTZCVf4fUMmgSvLGtUXmMwyhltIpG758>
X-ME-Proxy-Cause: dmFkZTFUre9sXwItw/D32/LRha63U+D2MMre5R4tNoZC3GZT1kninLOZYHQGUdW/3lBBAr
    rH7WEN1NA0Icq7iWzjSibRmCazO7v8ipojfNsqLogvqpKcgpSkktdCK74u1Yx2bEapFKlN
    S0WIZUEX4JR1fUCKvttN8BxAYAt7dVO6aFHlXili/G3YRmDCCBAzY7r9QgnkuQv0FMn/dy
    NAgD25l8Vnwfwc1HnabyZvWY5OmQC4xgsVYFabzy+Dg3mXYfFbgr+O2AYzjg4pZKiA5CQC
    cooAMlaj6Mhx9kTeOxwXV/N6k5f1c0HpAIGUHCT4okSDNym5kyoKxbD0WxnwKa6hKew0NM
    7ymdOiAOl4+E5b0iKf99a4v4Ha+ov9m8S8wTVnVJu0CuAgOHh/duqzZ1BUCwn5qyb1Mak4
    7hzGGSaMx5cXYgyeRSXg01qKyjYHswGJ3rjYsZDLI9TM7ng8iGrvUfwSuEiupqIdOgv8bf
    VweUqhmd6D/7LdoPU7WFYQW7ZBAAQfT8fOJgZTU2GRXbL94A38oTw8ThvXznV73HudTsxb
    NZ++ICeoW4E3ZT0VvBv0s0XqZfKKa5tGhYQ8YitchfUNk4iKNKwkwJAhsMBIuPgamngqOD
    Lr+RoCYYaYvMRAXGBWL2vMOz/vew+uFTtS0IDb0kADUQc064fA8TD/6zl5eA
X-ME-Proxy: <xmx:b0IWah9lUx-4ZjTiNoS4x9KU-VK4RhZ8hZOCRPqUqZUdOqqqUoY51g>
    <xmx:b0IWapi8pKXQ8rZk5q59P_tWwd9KpwxsRM_x8zOGJmJ4t_kK7O9igQ>
    <xmx:b0IWaoE8AofvCeOwq1XsDd9rvqt1WH_KtTI6GfvS_c1TxQW2WE9SxA>
    <xmx:b0IWao8EFpdNeozHr8Piz2dMcInbXAuzMVm9CUclieoHgoK-tPw9gQ>
    <xmx:b0IWaprROzoG4i-j12XhcYOiQj3w_s4FDFxSjuO7dVcP06s22T7u517q>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:01:33 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 5/9] selftests/landlock: Replace hard-coded 16 with a constant
Date: Wed, 27 May 2026 02:01:15 +0100
Message-ID: <60b9426d96c0955a70449ae4d3fa1235fabc8766.1779843375.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779843375.git.m@maowtm.org>
References: <cover.1779843375.git.m@maowtm.org>
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
index 132c18006d07..7044781357c0 100644
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
