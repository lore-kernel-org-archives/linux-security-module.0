Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB823BCEE
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931767; cv=none; b=Sulxx3dncFVkv1lY9W76PSU8lGQaO0555vdteRspRuxTVsHUHLdF09SSvzGkAAoRdoKzWVMzB1zoObFPsiXWXo8y9bZA6NwWXa3BGQloCIle5HU1P69YAVruL3zcYRK7Lkydp88+I8i9SFm+tJ/+8CVd1RqxqlaFjapRDndMguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931767; c=relaxed/simple;
	bh=RFQcu8QsagwCaZ7k7ZelXaeOpcDHcluEvpfSyseTb04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoqbFR/+utbMvSsHyDC7LzL0+25cTtJsLWC3zFFY3+7KPYn04RE2UbIBOruIwuckBO16PwWUVVeGyXkadY60CeoZJ4N+vafYOi5VHvEdt6zTqhHvxP+jBnxd3JDv0hB82CQscZzwHTVfjul1uCGlcZvHX4Qh7/g6pebqaEBDj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=CVXU473P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1c6+Xn1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="CVXU473P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1c6+Xn1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D106EEC01D7;
	Sun, 23 Nov 2025 16:02:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 16:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763931764; x=
	1764018164; bh=r8NWZx7MssWyrJlQ9yuFv2r5DK/sgbypv87/a6Ji/aQ=; b=C
	VXU473P3V/Rhr2VWhyISQuy0zlDTTnt+a2+5LoDTz/alUovw1Ipg0AMzEDODBtk7
	sJe2VR18ipN0HRXSa1/NYFxuBZT9AEeyhwiw8ygV/TekD49qK9Ug60Oo/nsxjzpb
	lEIuGbfufdn/v1pFCGer9jQGgAzbmlE0w5PBQ6Kj4Gv5Ozq2NyVXh5kp8ek+hGzy
	Rh70fBe1ytHiKdY0CvVKVOlGA3Dk50WSNRhtgm11/ArzVNxpZb5+y6ZvRhVpORNw
	ZXq4V0889W8m1XtsrFRGiB3uP9CP4UAOWmOlHxTxk8mikkaFCrObhOc/q16IYsDS
	9/3zvC4zZjuvk87N1HkGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763931764; x=1764018164; bh=r
	8NWZx7MssWyrJlQ9yuFv2r5DK/sgbypv87/a6Ji/aQ=; b=Q1c6+Xn1alMyrA7xK
	WdVwsHavuYGkPmjKSl6KJBrV5bjdC/UluUoD/ovj9T0evhOzYb6RGlyqq8o8e/9a
	hePYQR/iz9UXlu1RS2ZgkBZC2je3a1o8J3BJmfu4s6z6+9oe0O3I277M9ty+FmBA
	huKfZovJdd/y10Z5fXtwVaItsPCQUriwC4mv98qYiyqQWzhfN0gWJ5TvcfkC5Rdw
	S444yb/Tg0a0EzdhDhMIpW11Imba4Fxa92AS2m0+qBYeZ4QUz/0baB0UPE9hGcCf
	lzmc/P9Pj3j4X68AHuNzK+ntGI0q0GL51hcd9nl86+QE2hLrBPIskisLmzOT9gmY
	5r65A==
X-ME-Sender: <xms:dHYjafofJ9vqkPfpRUciFOSa0FuWoPagBYgKHY-uLyAJ2mtRQyMb0w>
    <xme:dHYjab49qbsaddmDlSHDgDB1vXug_Zzq31dj0lgu1DnaKoTsh2h_Rsyiehholw-s1
    BAtxLVCl-z2DzieQ5OXRTEzKUezeUmJsZd9CSupEUNy_sYJD2oj62s>
X-ME-Received: <xmr:dHYjaefZ844xy7d5CAWWzBM5_2XkkWy4dhTsZIaC4y16BpE3kHbbj0CFYE8hgqc4MHyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:dHYjaY6_PLUPsSGY2HqLZe7rHqf7gDgf7PJ2qmINjmGPDdwMhy8i6g>
    <xmx:dHYjadv3k8EyITBWY9Mx-txUVDA_CrCvZYuNWUnPWqX6ivvdhJlqsw>
    <xmx:dHYjaQiq4BYe-Mapifh4gg_RPrco5WwRc3GXIgXSf6OLhq1nriy40w>
    <xmx:dHYjaQrxpblVny3UQ9VWQIeTc97aQwfniv-kcE4Bii6wezuUiJRSAA>
    <xmx:dHYjaaJxOs4cpTavk6FF3mdvRMlVwYVmuHFFjdlsGv_XS6jKo81Wuo5O>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:02:43 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 06/10] selftests/landlock: Replace hard-coded 16 with a constant
Date: Sun, 23 Nov 2025 20:57:42 +0000
Message-ID: <4b52aa5fbb98df5cbf68d56afbebec3a7ca17065.1763931318.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763931318.git.m@maowtm.org>
References: <cover.1763931318.git.m@maowtm.org>
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
2.52.0
