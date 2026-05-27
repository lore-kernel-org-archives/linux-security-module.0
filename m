Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80D2236EE
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843702; cv=none; b=WKbpCIqCfqz7ZUGVgzmuOggkw9iochVXCylNPq09rippZyWLOPcorzfxwoSdWCTk6JkEmcufpTvcATev6zzn6EbkwVpodrBXAwd3CX77eUP3E9onK/Jcn/57jerI8Y2ByrkT938ArWORtH2uVpqzvA7/IfyFZj2kGg0LDiD6G/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843702; c=relaxed/simple;
	bh=9N6zzB9mXk16GtjpBV816jTS8lEv9EPIHfNYHFoiQ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKW9SySs68qhdNmMYdRUA6tMAJnq9IgZzrTActf03WLfVBa5StERR0lB9fsJjda5kk2ovZVBgHq0I01FFY6XKXJ/PQlxNCeQJv5nbtBq7ZgA+okgTMCGKRnr8DzFLYcBprgQp/s2fWFquYyosPOoSm2TorySVfPLuo8cp1vdazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ey0owoP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOZN5c87; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ey0owoP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOZN5c87"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0F581400082;
	Tue, 26 May 2026 21:01:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 21:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779843700; x=
	1779930100; bh=pN0biZiDBPffyN9eoonbLnxlt+UVNV3ujcYIXXqhR14=; b=e
	y0owoP2kogVBeJGM2mm676JhpGoskXqav1ythWr53TsbGNIyIhLmgny3DWBVZlTz
	mFfM/Gf95iJl2Ew2cIPnAnwh3irL/Rqr6C7PJtaf0S1j8KqDVDaZ2YuoNe/8wSVS
	r0kMcnZfVVTi7FD6QNGMI3uh3oYN6p5K5qgFEmm3UxFtYsdEy2LF2sllyZAY0iMr
	czpY1+iqnr06AMiqIY8uwUylYWc1rcOqJ0jajzEczAh/JS2m8s1Dp30U9ivlpUNo
	Te/I/Y9XJyorUXTNjndkOn7sikL+Y99YHqZZYg4kZsf6lmB8Pb/Nn4XndgRcQrnU
	qic2HgEAqqY83XsOyEHKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779843700; x=1779930100; bh=p
	N0biZiDBPffyN9eoonbLnxlt+UVNV3ujcYIXXqhR14=; b=iOZN5c87T6B3jnaxV
	mQr2t5fPAbz9TYwgNl0byZgDMiwtKpRQiut91A6EoZDF53rNHiUHuaKUDc2+nc4S
	zhAb/JmtGtm/PtPiDtUzIykvsPfjaASFkXSdcnRqNPycLOTE7aOymosvY6Jk3EoU
	uedIUcqVVkEyia5TsZJpxq8LWvRHc88CqsCdWDtb+/Ze09wPb0XuHYLmuv7FNeK2
	OVQYqSXvmeIEyhzEE9qYS0zRZmAfxYkVqbe+jQOlz1D2R3AzsjQKGOCNAoPoMAY/
	ECWcl4rnxq510x+tXTIEEYBn30N018ho2rnypXOsx0s93PYgUSNyg6s+NdHOSgD8
	bJ6mw==
X-ME-Sender: <xms:dEIWasfngNEAUck6oz7rxOFDrR8pTTdZa0n1fTZJk2H6Est3jRFOfA>
    <xme:dEIWagd-YUCNHi1eBpdy3ZqNE6Aw1QppCtkW14o0nGakTW3VgKraUt0Fopad-VM_W
    8z1rZSQmd0JH6elhy-aBOkjKDsLB_WKhYYZQfrLquwYWuxM4-ruxUQ>
X-ME-Received: <xmr:dEIWavzOdCz83RsC40UZrDyqirFzcPo1HZ4Q5RHHAVHykxAlL_7k8z67yG6fwgsO2_E>
X-ME-Proxy-Cause: dmFkZTFUre9sXwItw/D32/LRha63U+D2MMre5R4tNoZC3GZT1kninLOZYHQGUdW/3lBBAr
    rH7WEN1NA0Icq7iWzjSibRmCazO7v8ipojfNsqLogvqpKcgpSkktdCK74u1Yx2bEapFKlN
    S0WIZUEX4JR1fUCKvttN8BxAYAt7dVO6aFHlXili/G3YRmDCCBAzY7r9QgnkuQv0FMn/dy
    NAgD25l8Vnwfwc1HnabyZvWY5OmQC4xgsVYFabzy+Dg3mXYfFbgr+O2AYzjg4pZKiA5CQC
    cooAMlaj6Mhx9kTeOxwXV/N6k5f1c0HpAIGUHCT4okSDNym5kyoKxbD0WxnwKa6hKew0Qb
    ZD48cS0WHfLEaHl6h8U8b8R3qDkEjNQg6qjzrkxo4xQbTZ4n+C1NkojtN0Ymn8UzsVFEhj
    ium7UHXYwlFdFaJQ+blJZVRCNRoaosh7eRJRphMKQftIU7ejzJQwaI1h6aXd/sj0zqpzz8
    5WZYvqM8lW53FWWzvoNXr1k1XEty4Bq2BL35TcXC6uFaOTtvPZ36Ufk/TwGn+VZW04PLMR
    df0y/bj55SgVyrVO/tNHAgvKUdNJ2rFX5E6LU2d3fc2gow2QGEqQ5Boi6P9WgKJTKpRBye
    QqRZN0sVd3IfSdUHSx7OGTBIVPIzh77ZVg3kWiZAO4N2rBS/uDBuvXEEk7VA
X-ME-Proxy: <xmx:dEIWan_3scYtnmN0QE9bXLUBVbPLZPLr0RiOpdCSytBJVoEACaSdQw>
    <xmx:dEIWanhP6xDZANnxiKEsBSVa334jRIiW6N0rJtq33GNdIgriFeHSCw>
    <xmx:dEIWauEFhEIm52yb-7IwTa4cjYLqhGJsmJ_bWS9JqXj9_LG6VTc0mg>
    <xmx:dEIWam8CxezFpy8-e8WRAb_Zjiy94KUyPI5z0F9DvJT6mkYDFxY6MA>
    <xmx:dEIWavo5eEgcWTA2iN1fBLk5q70lIFwI_0r2YEfMcosuBGS6zpG1a05L>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:01:39 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 9/9] selftests/landlock: Add tests for invalid use of quiet flag
Date: Wed, 27 May 2026 02:01:19 +0100
Message-ID: <9e0787b1825b6e701bce32d991aeb26bca347089.1779843375.git.m@maowtm.org>
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
