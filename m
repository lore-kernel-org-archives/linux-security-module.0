Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FED255E43
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765041116; cv=none; b=Q9NmYHCSZPYSrsVDWPuVghpGmxTmop5DFIGso2lCzhSNNzUW2qIbYbURkRLGqwYL5bKgG3MhCAPQPjexoDIYOsm0AM3llNsTTtdYPcxYhdv/mW3mIY95Tv7kXzuytARf0u6PzKv2XtN/ZKQ2qwnkcuoQOSHBDzpePMyilHHPKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765041116; c=relaxed/simple;
	bh=kmVHkFNbHoGQPWtXaCBmZiZUFX6IDpbzPzWvFRH+3Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDnxUvUNv1YQPAUyxkc5Y1k5e1O3LbHzy0O/46FtkXqSIECzsQ8qR4/hXKY6c+lP0RraDU4twuSq67nVKuBmplBJ3Mbed/53cjJd1aFOfQ9UxNGQ592rlNDijx3jTj6E1YOFKu8d0SN9oLKl78Exei9Ze3RkwrJFeJ1FnnuU6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=KP8QLuzC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DAF4MWrd; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="KP8QLuzC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DAF4MWrd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 116631D000C7;
	Sat,  6 Dec 2025 12:11:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 06 Dec 2025 12:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765041113; x=
	1765127513; bh=5/UNY4lVSpwOPpsRlcAVML56bKguWzQB6NXKmtyxHbU=; b=K
	P8QLuzCvCjsQfsUoDCvvFiqjagMIgdrWzIdhnGZNiy1bbGgNRWJEHVdhNdCAktRG
	rH94vjp+muzJ4biUj1133pwWeU+sWstc2vqNGKIOssNSTNJKwiRcqEkROUV05J1N
	1+qdaUsI/1DWAIlCxeAiD2cKdpp2euWgMVRdJuo3r+NptriiiXZ04RC433kmritO
	SXPNSLIlfdo2YPAO5xab+d4FzLhtAoKpq0DRfYL5OvkcYNSZjWIk110GbCYH+hXq
	bPTCKltnHzD6Gnfuw28zKLwQeieoEmq95IxmeuOOa7SzhvJsp15De3pQ2H3YFRkj
	qq/BsUFa85iXRT6imBe1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765041113; x=1765127513; bh=5
	/UNY4lVSpwOPpsRlcAVML56bKguWzQB6NXKmtyxHbU=; b=DAF4MWrdEPvoivZFu
	HGGDoHtdSn3/8qPWdHvKoTM3ewGsvY2xwmiHRDn0shEc0nrfpL2Nx1nMs+C0gAbW
	OYSNtvuUDTQKZxUGTmIC6npqGw8EsZuJXP9XOmaEb+DTWZiNDv2CNktAVGy+QaDq
	H1QQgbZuea8ytG6xrdQPCEuHXlrhxi5WCzSW9X19ja/BZ7TFZkD1Bk2EITkw77he
	pDbt4wXNCUQH0gofzX1LMY2uhU2BKG1+E81jcW73G3LxGNqEQhz+FNAyqZBr8Vva
	UfvYqCYdspdUb23cr9baXz+Ter7hcTYJ6Jvv1PppBdo9QBfWZ8DQoN0Uua31zbye
	5VsFA==
X-ME-Sender: <xms:2WM0aYLkLPfeZiF24fyIiOhG3kgL6GaoyvGd-TM5dUcJtK6hG4a4RA>
    <xme:2WM0aaYbEPa80giBoNd43VSo7Z88RBMYfNXaXjarX7Aq26ZX-9IcmxPwQtGLjYhfQ
    4NEpxA1J-Qp8L3vT8ImVwixqjxfIb1u0CE8UpsUEO6htkj_mSgW5eo>
X-ME-Received: <xmr:2WM0aa_F_pldbf0W21REyTGhPZaUA2kwSd4s31kJlX-n_4sGOjZlGeTTgwjalNHfAntNPYPEzvpojeOgcLSpxsK8CZGZ9bH-fv2jTpL7kVe4k3rCmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:2WM0abbTGAUZ7Bqz7Z1SYeFYmn48m_9biwmBqHPLUBR5jP2xlwJpAg>
    <xmx:2WM0aeN8RME3JY2vbVFfoYxtd4oh7ggzSrIwGHLL1Eg7i2tmRq-ISg>
    <xmx:2WM0aXB-7h-_jtdEcv6WTjIwfnYXyec8_tesRi61h-qrk2jSESd9Hw>
    <xmx:2WM0aVLRPgHwagp5NfuSeLaEfew_3HkSiDhAd47ZBqJwAt8_GTU9zA>
    <xmx:2WM0aQrnpwQEQt1UQJVtom38tHXgWxQ_00X1fvlANtoXntBVXHY67kuf>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 12:11:52 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 06/10] selftests/landlock: Replace hard-coded 16 with a constant
Date: Sat,  6 Dec 2025 17:11:08 +0000
Message-ID: <aa7e8cc18c15023d22d3fd1607b31fe8a6c7c498.1765040503.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765040503.git.m@maowtm.org>
References: <cover.1765040503.git.m@maowtm.org>
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
index 9acecae36f51..c7ce92342e7c 100644
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
index eee814e09dd7..418a66ffcefe 100644
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
