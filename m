Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299427145F
	for <linux-security-module@vger.kernel.org>; Sun, 16 Nov 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763330558; cv=none; b=UGt665lI1KWCigm5cP7woNOmV7wrhoTi6pB0Z6GxQtBTUKws4dOlww29L4Q4K4CRkkucHOKeLbDu7FfA8C/dKDRu+3orH0z/a0kRD6TN7cOhfl+al/scO/eYVn4isZq7WXMkMvJMrSmILJbdMIZv9WcCGDaP670aJyPe37CZ0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763330558; c=relaxed/simple;
	bh=QZpTC86ITCfCjlPi8XoGR783RKIVbpyMh7C8a8IqDFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbTXMZRSblcWPK/m/g3NQBKZwIInpQ/TKHYaLxBVxyBfhaeBVLDt3bWj9ipwLN2ETbqWmZFDczVDyWCiSNU+AuXFC+f8GhLudUalGBAR6VAvId+oKQLjFv58gYekM7P79wWwgUo5/8xdYRqrqN5jeZG+ScTzIXGPs9rxTj0d9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=KfxHE4oT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uutf3KdZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="KfxHE4oT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uutf3KdZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E99537A0085;
	Sun, 16 Nov 2025 17:02:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Nov 2025 17:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763330555; x=
	1763416955; bh=H91OA4ZYKxj7l2LoGz640GinsIsnktvUsR9FQKIDBX8=; b=K
	fxHE4oT5GKTdVmBesyKecxmuqzjVmiWbX+7Z4/SmpWB4SWqPkoNGFId/onyvRdOI
	sUUIqF3AZ5TYTIs3t0bJRtehdh+Wp3Qc71vFq18WKMaNXEyJLRarkkUJUFOKLJsM
	aoWb11J3xAD5oochR96lCW3DvWZ5aM2DZAPLnxJ2/QxAoIjlnWMvVYF4wcbCAwYv
	TIAVAZp1B8Ct3Zq8yHaUWiJziFUKtKHAKXuLXk/eRsk22Eu1p5PH9Db8/33CV3Wg
	OJgXrgRyheKA0sBW/MyK9Iwz45ho5tjsO0w2zORSuxwcZLLO5Dul18gHMjUYYP0o
	CM6EcaxyZyo90JUaHowdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763330555; x=1763416955; bh=H
	91OA4ZYKxj7l2LoGz640GinsIsnktvUsR9FQKIDBX8=; b=Uutf3KdZBDOtqptIc
	Xg6aHV1SLjWeLt8PkbDTSc2iM5s8OZCch6LIfN4g5AKsNpCE5Lofg6LhhI0GS0eh
	BnIZ57cTTQONFE7nNLyC5sspwi7BqwaUC30HN8q47LhDTqji4qdZa93SCLd8UdnS
	VVfhAGUhJhprwd4gTLlXqKfy+aYSeDv1kLKjWvXE9XEtpAC33AjEc9/kPRHZoy3e
	UBgXyDvw1R0TcdFbm97AJsYrpbQFuvYWqa4Yxr6knm0dr15LUuT9Hg6660/hZmWZ
	gDcTb4T2i5oLsov8TI39OhH2x0JjwKjmADHuT0+9fQJtOU0uJ26+XanVTpvaiaG9
	jCPPA==
X-ME-Sender: <xms:-0kaacJAxB_Qo5kjOwAqPRwAaDkPanupWy_tED2aOO8brGqdN1xSOA>
    <xme:-0kaaebiY8a3fYO9Ed97jiiLws29ImJgue2_OeAxxk78h6V89OTgfmvZyqCs_LdmS
    7DNMSG5bZnmar33SVLX4cL2s-5ndmtMPxoJrU9_ICKRpmTizzOh_nk>
X-ME-Received: <xmr:-0kaae8brsEkn0EBfyecF0h0S0xr0cmY8cFBxj223F9Lpz-ggaGU0ynBU3ztAA-p3oSXB_oeDbP-mqPuHcTqIfxcFlARL9YdaxBC8CmXcTpODDHbW-asVlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkh
    esshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-0kaafYMPnXEqQ478mNPYAKuKH6_rOjua1Nj1cFXCfj2Frk7cfWOeg>
    <xmx:-0kaaSNdjTnyL-uVxzX9WnbyIXy3QZxdYoqPIhb8xzE2fXy_yCt4Yw>
    <xmx:-0kaabB5bwsm2qqnZ75whWh9SuyU3cNnTjLkss5que4Xlbxwk-cbSQ>
    <xmx:-0kaaZJL5Ufoq-APLMIOdyUBSU0FHsFQhbVzemtRM-IQ0SQoIeTpBg>
    <xmx:-0kaaUrqvKyXUQiNauB42gjjZRow_Kt1IedTYO0yOOu1w_IiLTWocvwl>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 17:02:34 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 06/10] selftests/landlock: Replace hard-coded 16 with a constant
Date: Sun, 16 Nov 2025 21:59:36 +0000
Message-ID: <f7f2c9d07be79b5d7cd0a8ffac6e982f50782c68.1763330228.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763330228.git.m@maowtm.org>
References: <cover.1763330228.git.m@maowtm.org>
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
2.51.2
