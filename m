Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54578F3A
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766330481; cv=none; b=mkc/09ZWOy0C+6eKS88TpoCl5YWLixyPat2ox14dbyAuHTo2DiNb/9DLe2UZZ+3bczUQLurVLviqXg3Vn8FvjxpeDVWUNCxl4T/XIi7+J2Gfzh6/GMaTdZANDnBcImj3YqH7aIfQHciFJ/jXUz+jvMg9XC7QQmVDjWLmnq5zO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766330481; c=relaxed/simple;
	bh=JJ1bEGgdgKnSChXavaq4WEXU8NS49K4cY5Iw2JS2qmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBmnaFX3wXGemLiuSBjZWwkzTziBRynoQtbqTBxZKtBeSUJH5T2p9tMZH5KJxTNUEWUHEaEFCh38CxQB/qO6JP400wzqNfDfQZa/qr42mDSiVsOwHftJicl7WI0z9wCyVsMbCtYRQtx5V5BvZg811lodttAaJ68EOPDAj5SjW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=aEsTxylQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X9B0i2vQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="aEsTxylQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9B0i2vQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED069140001B;
	Sun, 21 Dec 2025 10:21:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 21 Dec 2025 10:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766330478; x=
	1766416878; bh=R6CA3TqCcSZ4FbtHaE6ecBmREjO8UCDwrN8t/Jqgrxo=; b=a
	EsTxylQQ/whx6GiOe/0SaUHlE5addWqP2CUzx4b8zU3v4UMbMTLCMG3bR31oQNGU
	jx7AdKWLps/RH4kHM1qTqw+EHHRBHvvI5tdp/shKkm73ZV/z3FEx459jy90E9IY6
	6yUDSZhjavEAfPwIdJWbP7ONSISKb03F7ojWOT5+LY7s6QH6vyuXlOhb5TnVPvfa
	quCuMIutw3uD18RObmhCYJIK/EydPsQYl5+zOU8fFm+OAJ3Mqm6Jqwv8YGcTaVnq
	dIVb54Ufbc2XP6Fxy8czcYce+YVczbmbcYxmu8pVWXZobYQBw0UIBoMSenJKFzCk
	gMo3Z2P0t1beqcuViIoAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766330478; x=1766416878; bh=R
	6CA3TqCcSZ4FbtHaE6ecBmREjO8UCDwrN8t/Jqgrxo=; b=X9B0i2vQ3QeE1BZJ6
	THeq5DxRKHvCLlqu+XAqVTGUuBklOdIv04b6pp5lnBTuwQ+yWkGOVhK4r4FZowMb
	sklWF22WbtGTz0kz5xgqR2aTbzK/pkbKQU4UAZPJO309PjSRBAco4Au52Thvbpna
	HdtDnxCaFVoCzOidIvC3JoxgA1epy+gr4csZcDzeI/cGsO5Hko0fNVnWuX8akbtG
	Qgonyejvr2MIijTXHd9+c/4DlM2TfTV3/rcZOwH1OAASipzTgWAnjuO9Z1moDboN
	FlN14yLh0oT3Z7z9cuy4RLXk27VrHROzX03rKbuzK90UzbuoWcNLRgEXKmpaGeRf
	UyO7Q==
X-ME-Sender: <xms:bhBIaTpxmAbMb1Sssws3JK_ZDoxECuUMDnpULDTTG6Lx4POlhsuXJA>
    <xme:bhBIaf5V6HBkdhp2ed4gi4UIxzL-XqG7PAgjkcv6lr9QMLJaGeQiJIcJGnDhDgdNL
    wpAsRkvXMN4Otz5ThFx-PfZXLAWNHqvAmc_eLhQ1oW3KP8u-r6EV6s>
X-ME-Received: <xmr:bhBIaSetmkWgGwQM_L2a-ZHyXA8AwsN5K6CCSoS4ccWckyo26dhV32QZ6JxvIiqHUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehu
    thhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bhBIac4xEJt2Ky6-d-siJUAmiRZTZeI6aqtUW77NP2nrtsjre8t5yw>
    <xmx:bhBIaRsdQWhKRWnK74mxRUM3GXezu1lRprCpOf-nn6MJXGKh5qtJTQ>
    <xmx:bhBIaUgGEXVmMx1WR3RcBUhQIP65CUYhRPM2CfeEDEwasiPCAdirHw>
    <xmx:bhBIaUq4HtIZWUuK5wM28htawA1W7m4EhCDlkx6c9CsY1P9zYGQWHA>
    <xmx:bhBIaeJ15-ISePWmPjLEAYksOak59GuTuZZn1QXSjip-8jXAjXxweBTy>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 10:21:17 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 5/9] selftests/landlock: Replace hard-coded 16 with a constant
Date: Sun, 21 Dec 2025 15:20:37 +0000
Message-ID: <57a1f8afe72bc82c2d6350e24ee270a867d48fd4.1766330134.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766330134.git.m@maowtm.org>
References: <cover.1766330134.git.m@maowtm.org>
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
index 76491ba54dce..f04f7bd0b45e 100644
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
2.52.0
