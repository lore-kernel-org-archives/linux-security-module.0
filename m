Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7603314B7
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490825; cv=none; b=UH+aTvBDKg8bE+L8K6Po+JPMy/3ebdYJuvQIUDhAxtSwe1DLv6guaAHwfvyTtkzLyR0I4sXAHLgZpFto7eTbsZlu64cI8+hm3lfCvlgKLax7xh792YfFYqn+wTSwGXULfZ69Cfoz8DTlFLKiMdogu665W//QPmuQJcYTl/ONJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490825; c=relaxed/simple;
	bh=bxdxkNda+BnttryEBQFYVixCre3bIAMFFYkgvDf9KXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlPwW8GWSZK27QiGjMNCx0OdgjY+4g8BvvRwYBFGJT6SymAfyEEyQ117MKJvbFsFjxAKSc9lMO/sKGZn0AZvgZsdakGT2pbUAhr4gr1Ax/DoLRwAmlMpCctcq+jCuq7SGUF7BvbqhxexkpXkmGm84DCVcMlHKgykQEenf/Tmry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Ialda22/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TdilRO4z; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Ialda22/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TdilRO4z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AD437A0038;
	Mon,  6 Apr 2026 11:53:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 11:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775490823; x=
	1775577223; bh=jFTBGfGrULD77kR0Ddf9WQiATiBJ/akERp6Fg+TBq78=; b=I
	alda22/1u7I9FZ2lIQE43TEGf+0eU8PF8RhnJ79wz0/+flJch9Jli5ldshejRtqv
	IozU/2g20GBKZNet1MtfrX51EcyeITra4OtulEubhiZhZee6tkob4Jwi7Fuq0mxC
	qON4Ojb+tVx72kuD9Hv6jMOzFPMwTuUuYzX7EqE6+1k1TPqi0IKa4HP5/xNYWVdT
	7Du6Gpvuo1QcZ6Erv/OmwN+LuiT6ydbcVXlVyRaTpi2dUZA/y8dz8ovH2xzGg0nM
	DvWb6CUbEuuD9zsLs9azRq+65Ff/uEHwOmcqq2xm96Fxh2IpOihsFG6eAfolc6s/
	YajdWnpTPTRIADsbaIc1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775490823; x=1775577223; bh=j
	FTBGfGrULD77kR0Ddf9WQiATiBJ/akERp6Fg+TBq78=; b=TdilRO4zXcwouz6Jv
	mG4oXtQkTnGUGN8ZAA7Q3LfFhSkjDvaJe5bO9t3fNvL1fyMVZTdxbTqYMKtWxTub
	cNFu5d6E3xAIODx7PhAFb4OExOLenbiaLFJ36hjH48ddmZDNmy9Ey/E5PrrIykag
	Nq8oKsXxfkDxZ302CoKRpkd5KNXxrvcwQiCyid2qIf1q1EJ2R9I5fM9brJu6B4lS
	3zNVGyW9BCAPQlRX9jFtXsPnEcZnfTmvhTcdaQxbMC1P7ZYBYtkbojccF0PKZ+8J
	OlIckBT0OH4gbiHdsCSX1mHGK11vpnWVV1qZRH8GFFhKACjtsbM9KVmjQDwrKWWG
	7apZw==
X-ME-Sender: <xms:B9fTaURunvQjgoWJMKeAh35ygKp1HMi9roKKXbxWsQxYkomwDP49FA>
    <xme:B9fTaUAPBBw186CMeunySvjE9IwMZhCSA8B3MYYPicoNMWll8XkRC6oPhRx52HlYf
    x5W-irnyz9p_aOEYS2PKGpRY4Nxebu43X9h_s1oNiYA40Tw8c2GMMtY>
X-ME-Received: <xmr:B9fTaUHasQ3paB-ToqZPhvk6YdzgdJKdzGnP3xLRhPpoFhXuWlej97O7zSCo35r0ze_ft2Rzna8HwAmFdv1EBb1c8wBKFVp1g-MplUGiauHvlK9VmeNPtns2ipGWAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B9fTaeDBa7_osY5ldtzwTfXRX9RrYJDeBEak6fPREwo4c-TnWakt2w>
    <xmx:B9fTacWgRZNVqkA-Xj6aOKOyec3dybi8flo-UPCb_8ENz5x5_DmnTg>
    <xmx:B9fTaarR_6CqDcF927numhuaD95ERwi1087ADfFAadESgM2mTt0uig>
    <xmx:B9fTaQRd3YuMuhuCcc5oGb5cn7KWEuIBxd278y-GCKkGj-T1qC1agA>
    <xmx:B9fTaesOEhwlop5l80XR3OnKeFAzPbVQwmnCFRdXgwls-E1z1WNoHMfb>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:53:42 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 9/9] selftests/landlock: Add tests for invalid use of quiet flag
Date: Mon,  6 Apr 2026 16:52:22 +0100
Message-ID: <d2d43411a68f830c39eb937443b51b591c72c296.1775490344.git.m@maowtm.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775490344.git.m@maowtm.org>
References: <cover.1775490344.git.m@maowtm.org>
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
index 84e91fcaa1b2..af9ad822a444 100644
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
2.53.0
