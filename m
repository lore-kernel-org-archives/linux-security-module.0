Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAB2E3FE
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272073; cv=none; b=VOTpOJi5s0bECqblUQNKp+KInGLa+pLNL0UZZntR4hipZMwKjfUsH7AXKY4Dfb88oUBvXJfzMApJU6zGsFH8HoRWGo7wPWkXRXebngW32JLgHsS13Ma2LQV+9wCuLWLFFKPiYua1WOBCKjMahryQv4DoMZIamqm2B8tBlvwt18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272073; c=relaxed/simple;
	bh=9N6zzB9mXk16GtjpBV816jTS8lEv9EPIHfNYHFoiQ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyKayHuK/CJ8RJrikXSIrMWGnqdTq2Sdk4ZgJ4ru6ZSfrubHEE+8JCxSp5eAeX5Y1L5S7vePE886WHeftF1IfTwZF7dg9DB9Bf6R5xemqVTWv/ZRMqpcv80nZjqNDyfpp+9sW0s6c57zdCXSpVd0INZAPeuSEfSkVdVq8HTaUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=cV4vILAX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kx3Qsgyl; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="cV4vILAX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kx3Qsgyl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 375837A008F;
	Sun, 31 May 2026 20:01:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 31 May 2026 20:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780272071; x=
	1780358471; bh=pN0biZiDBPffyN9eoonbLnxlt+UVNV3ujcYIXXqhR14=; b=c
	V4vILAXwlO0orrUqweLpfR4bV+eXqXqCoh26922ix/IPEweifElxfsPhcbzSeImS
	jP59N18l5uiYdAc07hKZrXheG28rbtSmUO20ePr9VmkZnxNgcNq8AEFg1lQof/d3
	G6/O35McJRI+r2gq7+Dsf21vykRN8cJPFfOdibQVWJBRclV/G+5+1+eHN1HzyKx4
	VGDj6yL4kZ3AlFa1ztse6Go5NIkwZkUty9F7aoaZbRrIzYW9uWK8m1qN9TnKC6t7
	ZDbcEL/9PSG10L0whz9z7QqBXDM02yEPQkEVnMItLTwWDV9qT+mhrZZkQuFnTmgB
	syffhqeMCKuwxgvFslIDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1780272071; x=1780358471; bh=p
	N0biZiDBPffyN9eoonbLnxlt+UVNV3ujcYIXXqhR14=; b=kx3Qsgylmwxb2InX9
	bRrTB9sRXuRKlhZdHuEWN/1ZGVdeTe6qx3NZGx+cAXIcu6YW/+D0tPfKxkyybcrA
	JD78LL0592uK2HfJUwFiqsSffaY+donNC1gr7jBCmz67LBMmYHRr8QnyV/MwH9wP
	dncGycY0dwch/ax0FYX4aR1yLdj66PSb6lqnOXY+Te+goktRpiUqZhUd4p1BCmN2
	gBVpkdbxV/5qLFYJsutpEDKQ5wbjjg8ULOf1Q1zVcu0w8rgG2tUq43JTy98NKSk+
	WrEDaEI0Qtml7/KnmXwp5BVcHP1381ouJY5Ea1+ScanS/HBXA0OVD/OIgU/naCwG
	nHUtA==
X-ME-Sender: <xms:x8scamUwahAZj-sttBCeoPlRwLl9FXuYJSgnS5zHk5em7m8PzsatAg>
    <xme:x8scak1dm5b0IkDk2U0hin1h7u3_x2ZzQz_9oglucn6IMFiZ3jqWDEqM69xnkB8bC
    atJha2j2rKdJG6qA3J4jD8MTJvO2iXX47K8dYQE95S_lH1gaGsr3cg>
X-ME-Received: <xmr:x8scasrDOWrSv8Q_i2S6EpqyyirJq5nWS4qV7Rpa0nkXnF3WDbK6FFays6b2AFHkdWM>
X-ME-Proxy-Cause: dmFkZTFdvInY70kURnUCfKLYaCaykxu4LL1YtluT4AUkIC4NABNzVKhsvUmfXMXCQVB1Od
    SIsDxPE7K4hcNAjitVx+OxpJplumsMZEK/XMin0zATGGpQYE+onMtG+HalOLgNxkKgJsW3
    F4k7bntDUXB7q//Vc9n+PSMzuliqSvna9VOTWR4jEso6YSxtj79EeHk2RYI3ZFvwpwNMB4
    w5Zv51hC3apNjHa0By5pzX9z3J2+nVr8013d7XNZDDBiKfeftChOTXc5fDDwr919RhizQ6
    d0AGUZ8DxQanjVjYBTu26hK+38ZdNQDSe9/IiqilLy/Zcn0mX2lNmWlUIeEci41ZeiXSEK
    gQ2QDRIAEpdEmii767O6cV3F/R/wV3+GcgdZ/62x/9ik9ys2g5PfpX/0idsHH4zkn7Wwm1
    VRVWD6nxVTo5UmgrtGF9Ab5/0Vkk7Fc9GL0C3LyortLs9i++VH+mnkcQKx+t0aO+Ij0asJ
    Pavg0vVcyjUwOnM5oVEbPAGbUiYiPM6gfoRxF5RcprGPA3EnFUMSo4srEqRhV0gb5TOuTS
    /KbjzNOVq9ogQl6Hwa9dN6UwN++qJXXrhPVE0Vgkb5rpXS0GFLcoxPyqCgjhIH/4Pw/4qw
    gW0fRa+vfRPM51tQmE8ifP/oTxlM0wNsdHH/nAhqADMUNIhE+1U9xw6xFeMw
X-ME-Proxy: <xmx:x8scajVHZ1mpIwSxFo90GiSzuAA5vJX21f55fTs9oj5KBSitwQcNTg>
    <xmx:x8scavbDg73UfsA5XAKKU3hdNJ1znQSWEfeXOc0B1EhZG9g2I8Q39g>
    <xmx:x8scaofTPmD9XsGM8WHSwECE8pfZLDdqSGR12zzQItnnIpgpa3Zh-Q>
    <xmx:x8scah22GfPY2LE6xG6OoH24Ah8eO8xrjCuHG2oqns2iuemiMKB6qA>
    <xmx:x8scahBYggM6Iso6WBArA98ZgYjFJJeAElMQGxNaizr1m0z4cZ3NwaVk>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:01:09 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v10 9/9] selftests/landlock: Add tests for invalid use of quiet flag
Date: Mon,  1 Jun 2026 01:00:43 +0100
Message-ID: <99587e6f737a425d18fda31649edf304f74f3567.1780272022.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780272022.git.m@maowtm.org>
References: <cover.1780272022.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that these calls return EINVAL.

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
2.54.0
