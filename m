Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B911662E7
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765041124; cv=none; b=GW/YZlkwpqJp+oWY5DZ2j5F6jTTNul1LQ5KMXojtf9YRNXbQlNN+/jNhOCCrkGSJoADPVlaAv5CBCcq88CN7OFluvuiJxFKIuORk0wtOXwx+9q6z0WRRQ2rDDZtjc5RrRoG5RMjBXbbZUQPtEiQNh8bB3kULE6iLX262NtE6AhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765041124; c=relaxed/simple;
	bh=24P3VkS7Nf0b+9oZ6vrVjqJCemLZncWE3kDN6P0m+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtWw0/qts96yyQN46WxJ/vvelBx6L2LfnYVUhhoXrnTsOclC3PNFWw7wITJEJKMMDs7JwRXLU+zLjqGoA6RxpgTc7MAzxTFN0YNOOI4TCcz709fr36+54cL+SCnPGDmWJiAHo1GrPks2xpRSEqA10rpUNGvR9F2ReDLzylHOJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=EfU7PjIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rXi224JG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="EfU7PjIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rXi224JG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D68E1D000E5;
	Sat,  6 Dec 2025 12:12:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 06 Dec 2025 12:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765041122; x=
	1765127522; bh=ULUNovb3ypAGtF0YUTzHEbGYDi6V5fXrNjgpUrNVg9o=; b=E
	fU7PjIBi5xEb1fGMURvRq2EAIN24jWCGILeSaWqMxOJ3C7ELqdhhvRKB5ddBOaMn
	bcdg+xIgmgf2UpOB3NzZnuitZB3vZnoK/LefchIc65EqPeUTsKYNLXXZlaDY25fB
	2HfZajC1/qD2Zn2fgTusdscdEzSdZ8WoVCE3JOEbdhahndnRIul3Xvsb3nDWFBaa
	kgSqNFoDEWUnbkfuoq8yA0+BeQ4QJ3F2XdkISmzONI11vXLuKsNzbvCohO1epngI
	tl/8uvLs1zTNagSdh7P5NeK7uAL9JrLNpf1QDv6Ap4AmG8ctcdoBzVYIDh3/ywka
	FT7znHhzgVilUTMJTp+FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765041122; x=1765127522; bh=U
	LUNovb3ypAGtF0YUTzHEbGYDi6V5fXrNjgpUrNVg9o=; b=rXi224JGFZ2Gauu/1
	o9OCOqig984Yc5xooyqigyhx07bcRLOftj8M19O5BJu23pgWKspYnD/y5pQLyKML
	TaBM7q7CZplPexNeWxh6ofL23ny4phcJFMbXxlXIjrwLiIQ4aY3zXk1tthyySrHz
	fkzSxE/QNM57jh1+ACqYmODQKkpEyIRjvQKDldl6zJAQxP2jlEbZVe5PS0QFIdua
	tD9INNGNBMDe2Vw27iums9L0qsDeYG6BtowkiIbIYmyFE8JzsgWh2DK8tAYsAYrg
	9Q2MTSPCixV4FkRQIOKa/T1hZQUxBMxd/FabLsAKtJ/EIyUHHmMNyXY4wuGyBuc7
	vc7NQ==
X-ME-Sender: <xms:4mM0aYo66hTOEJHeumj2vxQwb5CQejb_gJo2-0WR_QSGCav7jbmrrg>
    <xme:4mM0acPEzubkfkWauYeKf06IUwAdbwUlacC64_kvFv7JnitLu4iEvqJOyMVx6BjHp
    TtdHt8Mb870DLMLe1HP9VXSMRmcvYHlNV5-EoIIgiv_MGRlwrVzNII>
X-ME-Received: <xmr:4mM0aTpnRBdL8HAUKfhuIXZ2kWpNPCH5yBMNoC6eKjlbY4xMgNbGc2j5GUMc6kJmoqMDag9gP3qWngSrlHC1guRKU-8uefoz1liD6_YTS3beFUfJbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehu
    thhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4mM0aRfkChqFHDsd9KgO5ixGgnIGX2WAnSxvN8eUa4UZqRs7gcVYRA>
    <xmx:4mM0aZQnEWkN0fKKG01CVe6t4EO39b8XeQYRT8LFl-dAAOcbCCJcUg>
    <xmx:4mM0aaYtJ258d4PqjmzGk1xw-8MFcpJGIdJu2hDe92lDCc14yURnZw>
    <xmx:4mM0aceOIrG8UP2el4Hhu5dPrlmV9YTWVwax5bgqwRQv87OCNTMCUA>
    <xmx:4mM0aSTjsJ4i_SYCUArFjP0wtAENfe5ugA-fBFL0Jp4NtrCXoC8XJIje>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 12:12:00 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 10/10] selftests/landlock: Add tests for invalid use of quiet flag
Date: Sat,  6 Dec 2025 17:11:12 +0000
Message-ID: <c9ed524b2060ad69679ce9d5f474418808036567.1765040503.git.m@maowtm.org>
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
