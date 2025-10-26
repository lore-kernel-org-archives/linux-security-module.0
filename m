Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093D21D3F8
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511541; cv=none; b=ugIoy50ZrMKlbgM7ErrIvZzbnOzkTDD3SfG41wUMZAhNzIb3ILnY1MSO/OhpMuoRbWO9CqGmhvcSw3sUf0/b6MbZBlYTwg0GPokScdQYVTt4eFjAHvPl+oR0vVLhS6WPpctC+F5Um4ykkFXJ7vhy66QNZVDuXCmpLo7U1s/yv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511541; c=relaxed/simple;
	bh=szT0S/55ordSGL0SgUjhxgZmBI4oYcAZYnuXZPw067Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBkEfxjDjLWaM8UGGGXp71qL86SFFIlO75dxPxaupT5xal3xjCLfaOmfxvsYYK1aFUdW3HLuPo1ywtIwgznXWO/8iFu75gQn5440zUsedcR6WRZ5L0eGGjz8XJfrhKgKvwEGrXeR9LkQmyaODeARgGCQf+pPe/dEbKBf8WuueK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=X9UGwQKo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gnlp/9Qh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="X9UGwQKo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gnlp/9Qh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 19259EC027B;
	Sun, 26 Oct 2025 16:45:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Oct 2025 16:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761511539; x=
	1761597939; bh=bfm9LrvVSF3Cb/kBCjigJCqm9nx1huxFYyu3Y62F30Q=; b=X
	9UGwQKotDMx61pjxhMNXvsaoZjVHsZWl/JxUzs6DyMrkao47FJNT6q9GN8H/ZyLf
	3u2oWfSXLyzbMpCp8QPqJAUOF+dsUjfGK0cQQBbam1lY3Wy5Jz1RiQhdJuT3A83n
	5Wtgyhs5ZQVOzQ52usW4fNPnFfamcQmJXflrwouuxew71ti/BTjcOy1WwLZQGIRU
	97xohvE6Qjhio6gLwaPUvZAWVsboC2bcozIliLxVybh9N4OfXtacbsQqR+STU7Rb
	UmWmdDqnkULG8X3Q4femyqkTYIy388ArCRQoDHw48i/EwAjbhDrfQM+4KxhixiKz
	pXuPe3H5WVqCMsSw/Qk7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761511539; x=1761597939; bh=b
	fm9LrvVSF3Cb/kBCjigJCqm9nx1huxFYyu3Y62F30Q=; b=Gnlp/9QhSDUEYpzLc
	aj3sOy2lEcyy8Nic+GJJHv45prRg59R8ppc4v4SLIICYgLy0Ng92YYzLupWAw3fh
	V1x0THJC72fqV4WzpQ/yuBZaT/SwCDRjXpAEsYp7mCOTeYiRWPg6Hb5nFUs2D882
	Bd/RMc01IwQKcE5Rgbr6OI5bD8XeFLgJ/MXw7nJskM+bn46/wICBGz3hlqWGE7fn
	Io5GH3A7KH3h36w+uzeCbdf39WZeO5b0odiFyObGqOd9CNLUAgTFfeMO9dDXa+Dn
	WDWI1KhMkHLYXE+mOXe4TP0+51L8VaGVKP0M7eudlyOfY2ziofz7TW0BYSMrsWiz
	YHDyg==
X-ME-Sender: <xms:coj-aElA7lc0kg1Lt6cwI5peRXpTXr17VT-EyKSmF7a9O2GVBhzp6w>
    <xme:coj-aHg28AZoDPziKEplFBQg6561NLeNHdZtOaIy7J8RvrBtCXJp_-apMi8-9EsTk
    EE8QZ3cHTSbIbG0dpV-B67pxDGPmZvEC5AzLbZUElsl6twvn04Nv6Yy>
X-ME-Received: <xmr:coj-aMdbmlSltj0DtX34U62r6vlwWl_v2K8Ut87RKt8mdFuq_CwL0bYQqGtuyrO6aDkg7GazGmNk6IVDEqDusm-vfKidCIbmZM3oj7D9ubIJp4Rkge19aaojEDAT4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    jhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:coj-aHhNj8Um3LIbkVW6Sv5j6KI6fs0hxcU2GJA3MqQYz_kkVfe3bw>
    <xmx:coj-aEybs77d_o6YxfUEa--JF86DVN26PSZjPB9Nfkf8R4_B07OFPg>
    <xmx:coj-aDOGPzHxRGvSTZUvsA-3uhTlP1GK6txZhKEYx3B8Q6gBLvLEmQ>
    <xmx:coj-aFVsqglvH7pLaaruO26NSxlvxQdl47fCo0EatRFwMDvNS6mJlQ>
    <xmx:c4j-aPso_iAcRRNY-mxEvzcFgIGVvZcwTGtS3C855Q5EVi645VTji_OP>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:45:37 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 6/8] selftests/landlock: Replace hard-coded 16 with a constant
Date: Sun, 26 Oct 2025 20:44:21 +0000
Message-ID: <2c6f642ccd6f30a196a183cfc4d6b62621fed713.1761511023.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1761511023.git.m@maowtm.org>
References: <cover.1761511023.git.m@maowtm.org>
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

Changes since v2:
- New patch

 tools/testing/selftests/landlock/audit_test.c | 2 +-
 tools/testing/selftests/landlock/common.h     | 2 ++
 tools/testing/selftests/landlock/fs_test.c    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 46d02d49835a..4417cdedeadd 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -76,7 +76,7 @@ TEST_F(audit, layers)
 		.scoped = LANDLOCK_SCOPE_SIGNAL,
 	};
 	int status, ruleset_fd, i;
-	__u64(*domain_stack)[16];
+	__u64(*domain_stack)[LANDLOCK_MAX_NUM_LAYERS];
 	__u64 prev_dom = 3;
 	pid_t child;
 
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 230b75f6015b..719326f9e8f0 100644
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
index 21dd95aaf5e4..943b6e2ac53d 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1497,7 +1497,7 @@ TEST_F_FORK(layout0, max_layers)
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
 	ASSERT_LE(0, ruleset_fd);
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
 		enforce_ruleset(_metadata, ruleset_fd);
 
 	for (i = 0; i < 2; i++) {
-- 
2.51.1
