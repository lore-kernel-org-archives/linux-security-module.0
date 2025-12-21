Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353B78F3A
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766330488; cv=none; b=V05E2Yoy98FRNbDxGl+tNaXHSIJzz2IWyoyUDMwZJ4NRRD30P5G0Vl4zkCQbJC8UDSEPgpLpPULYjrkt5pF/FFNGSpOi0XbmMJwhLKURAF4j+YKa4GyE+6hlZnxRLxPdrsCCuhNMdGD9emPkCs7W4tNjVT1dodK8CTVFo8fgGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766330488; c=relaxed/simple;
	bh=24P3VkS7Nf0b+9oZ6vrVjqJCemLZncWE3kDN6P0m+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1gsxrXBwE83C0sMgYOfYDKnGY+bdc3ICUDpuylF2bgvMukIoEW8VKRBi3iGlObatMex1llwjRENh6IoZXJtHTLsuD56ry2hw+sg08H5Xxf2oyX4l8UOt9hmuF3c54YhcisbKJ//hC+J2m4Dn1m4Bz73KYcFRlLAGTokMFEsJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=on3794Q5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jqpOvnZs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="on3794Q5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jqpOvnZs"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69BD6140001B;
	Sun, 21 Dec 2025 10:21:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 21 Dec 2025 10:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766330484; x=
	1766416884; bh=ULUNovb3ypAGtF0YUTzHEbGYDi6V5fXrNjgpUrNVg9o=; b=o
	n3794Q5DXYAUrRyj7qwZBNcblp36KU3Tu9dRGPEt4moukPZtXojIHuVdVgjFOxcg
	yVZOTxPJg760xnwBdnhABTozaSyTjsgDmZLz16g2LaDwRjyHll9CCH6lnzpadtZC
	J68mHoXi5jbDI4Q780szhyguiv6L+5x853O4DDQkBbRuPgwSM9iHgGryhCSM+H5i
	WhT8FieLiezCt8Tg8p9hoSgRnnqVGvV44bzed5xSIA7UCKOeUv5tuK2CK8LiuFKH
	scz7FGkb6sBPlbobwUNJcJp5WOxluPlWWywi69oC5h+aKRpN0IrTlRdk60cAoG6B
	8VDut7lkGZQcgDFPf+K0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766330484; x=1766416884; bh=U
	LUNovb3ypAGtF0YUTzHEbGYDi6V5fXrNjgpUrNVg9o=; b=jqpOvnZss+evMZeq4
	nl4tcxN+HK9/8GP7jJunvyGgXY08uIBoQm8giPm0OUWMrYCgyiiIVZPqGeyzBvfH
	4jxAXJMh2MZ1wyzeH6ukfkyqRiZQ2jJ7aYAlqtS9PgBMgb3zwyVK/9NT4zIaIJjt
	gwPVHSpCutU53+0We8aD/xN1k015jfQQ4mk22968NTITMWbqp2iPSegqMhl1lFtv
	4bZlahsYQhHq+c9+lKk4LwHaIDoBU2ycefd1QIiGAY5feX73CMYEahB5yf4BjSTK
	434ZF7bTzaH3Yjs6G4PRdvGFdCCzipAUvs8toU/maBtxvNZYqdzPUE33feNwa9/J
	/BzLQ==
X-ME-Sender: <xms:dBBIaU68PP-wghzwa9NZaf_XgvvzAmBZIHoGbtz0SxPUiJ7YToHU8A>
    <xme:dBBIaYJFwHhOyJE7aSXr1jE8khh1QDoSS1ZQiBWhTPT80_CX61pG9QhyIajlXn_7z
    Hqp4KXkYoBLuc0IR8s9OFjgRfc0szC7yJu5_fm5oSbLMzJ_bReUl4Y3>
X-ME-Received: <xmr:dBBIaVtAbOOGO5ri5jFikvQlCz2SvD3Z653CSZxR97zxTk71BYJ0hDpztoIX1lZQHg>
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
X-ME-Proxy: <xmx:dBBIafKWfONDkAoROwiJywihR7PUVQZcPkvwQRdkMajEHcz4LM1-2w>
    <xmx:dBBIaW-Fdhbz9Vr4UHewx9ShgoWYtyxkFWMup5W69pEYMrAMNy080w>
    <xmx:dBBIaQzq-aKkcsTo-iFxrE-Iqv54v_kvo6NDKZQ8pC4A9IDBuR5z-g>
    <xmx:dBBIab7KmYs4dqGoSmPPTam50sXnIO_M420hVY5tHs-J_6K42K1toA>
    <xmx:dBBIaSbkyhYGTH_uk1B9It46siA2JfIOoZKjzDknKnO48agNYNxSwTJR>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 10:21:23 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 9/9] selftests/landlock: Add tests for invalid use of quiet flag
Date: Sun, 21 Dec 2025 15:20:41 +0000
Message-ID: <5fc6d4c1f61e5d7ecd217245f6712031432f9a88.1766330134.git.m@maowtm.org>
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

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v4:
- New patch

 tools/testing/selftests/landlock/base_test.c | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index b34b340c52a5..055d416508a0 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -526,4 +526,61 @@ TEST(cred_transfer)
 	EXPECT_EQ(EACCES, errno);
 }
 
+TEST(useless_quiet_rule)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		.quiet_access_fs = 0,
+	};
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	int ruleset_fd, root_fd;
+
+	drop_caps(_metadata);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	root_fd = open("/", O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, root_fd);
+	path_beneath_attr.parent_fd = root_fd;
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath_attr,
+					LANDLOCK_ADD_RULE_QUIET));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Check that the rule had not been added. */
+	ASSERT_EQ(0, close(root_fd));
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST(invalid_quiet_bits_1)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		.quiet_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	};
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+					      sizeof(ruleset_attr), 0));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST(invalid_quiet_bits_2)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		.quiet_access_fs = 1ULL << 63,
+	};
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+					      sizeof(ruleset_attr), 0));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0
